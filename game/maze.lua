local M = {}

local ROWS = {
  "#################",
  "#S....#.........#",
  "#####.#.#####.#.#",
  "#...#.#...#...#.#",
  "###.#.###.#.###.#",
  "#...#...#.#.#...#",
  "#.#####.###.#.###",
  "#...........#..E#",
  "#################",
}

local DIRECTIONS = {
  up = { row = -1, col = 0 },
  down = { row = 1, col = 0 },
  left = { row = 0, col = -1 },
  right = { row = 0, col = 1 },
}

local function copy_point(point)
  return { row = point.row, col = point.col }
end

local function scan()
  local start_position
  local exit_position
  for row, line in ipairs(ROWS) do
    for col = 1, #line do
      local cell = line:sub(col, col)
      if cell == "S" then
        start_position = { row = row, col = col }
      elseif cell == "E" then
        exit_position = { row = row, col = col }
      end
    end
  end
  return start_position, exit_position
end

local START, EXIT = scan()

function M.width()
  return #ROWS[1]
end

function M.height()
  return #ROWS
end

function M.rows()
  local copy = {}
  for i, row in ipairs(ROWS) do
    copy[i] = row
  end
  return copy
end

function M.cell(row, col)
  if row < 1 or row > M.height() or col < 1 or col > M.width() then
    return nil
  end
  return ROWS[row]:sub(col, col)
end

function M.is_walkable(row, col)
  local cell = M.cell(row, col)
  return cell == "." or cell == "S" or cell == "E"
end

function M.start_position()
  return copy_point(START)
end

function M.exit_position()
  return copy_point(EXIT)
end

function M.direction(name)
  local direction = DIRECTIONS[name]
  if not direction then
    return nil
  end
  return copy_point(direction)
end

function M.validate()
  local width = #ROWS[1]
  local starts = 0
  local exits = 0
  local allowed = { ["#"] = true, ["."] = true, S = true, E = true }

  assert(width > 2 and #ROWS > 2, "maze must be at least 3x3")
  for row, line in ipairs(ROWS) do
    assert(#line == width, "maze rows must have equal width")
    for col = 1, width do
      local cell = line:sub(col, col)
      assert(allowed[cell], "unknown maze cell: " .. cell)
      if cell == "S" then starts = starts + 1 end
      if cell == "E" then exits = exits + 1 end
      if row == 1 or row == #ROWS or col == 1 or col == width then
        assert(cell == "#", "maze boundary must be closed")
      end
    end
  end
  assert(starts == 1, "maze must contain exactly one start")
  assert(exits == 1, "maze must contain exactly one exit")

  local queue = { copy_point(START) }
  local head = 1
  local distance = { [START.row .. ":" .. START.col] = 0 }
  local dead_ends = 0
  while head <= #queue do
    local point = queue[head]
    head = head + 1
    local neighbours = 0
    for _, direction in pairs(DIRECTIONS) do
      local row = point.row + direction.row
      local col = point.col + direction.col
      if M.is_walkable(row, col) then
        neighbours = neighbours + 1
        local key = row .. ":" .. col
        if distance[key] == nil then
          distance[key] = distance[point.row .. ":" .. point.col] + 1
          queue[#queue + 1] = { row = row, col = col }
        end
      end
    end
    if neighbours == 1 then
      dead_ends = dead_ends + 1
    end
  end

  local shortest_path = distance[EXIT.row .. ":" .. EXIT.col]
  assert(shortest_path, "maze exit must be reachable")
  return {
    width = width,
    height = #ROWS,
    shortest_path = shortest_path,
    dead_ends = dead_ends,
  }
end

return M
