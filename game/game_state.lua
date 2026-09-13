local M = {}

local function snapshot(state)
  return {
    row = state.row,
    col = state.col,
    status = state.status,
    accepted_count = state.accepted_count,
    blocked_count = state.blocked_count,
    win_count = state.win_count,
  }
end

function M.new(maze)
  maze.validate()
  local start = maze.start_position()
  return {
    maze = maze,
    row = start.row,
    col = start.col,
    status = "playing",
    accepted_count = 0,
    blocked_count = 0,
    win_count = 0,
  }
end

function M.snapshot(state)
  return snapshot(state)
end

function M.reset(state)
  local start = state.maze.start_position()
  state.row = start.row
  state.col = start.col
  state.status = "playing"
  state.accepted_count = 0
  state.blocked_count = 0
  state.win_count = 0
  return snapshot(state)
end

function M.move(state, direction_name)
  if state.status == "won" then
    return { kind = "ignored", state = snapshot(state) }
  end

  local direction = state.maze.direction(direction_name)
  assert(direction, "unknown direction: " .. tostring(direction_name))
  local next_row = state.row + direction.row
  local next_col = state.col + direction.col
  if not state.maze.is_walkable(next_row, next_col) then
    state.blocked_count = state.blocked_count + 1
    return { kind = "blocked", state = snapshot(state) }
  end

  state.row = next_row
  state.col = next_col
  state.accepted_count = state.accepted_count + 1
  local exit = state.maze.exit_position()
  if state.row == exit.row and state.col == exit.col then
    state.status = "won"
    state.win_count = 1
    return { kind = "won", state = snapshot(state) }
  end
  return { kind = "moved", state = snapshot(state) }
end

return M
