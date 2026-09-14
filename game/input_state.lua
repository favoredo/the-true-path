local M = {}
function M.new() return { sources = {}, serial = 0 } end
function M.press(s, id, direction)
    if s.sources[id] and s.sources[id].direction == direction then return end
    s.serial = s.serial + 1
    s.sources[id] = { direction = direction, serial = s.serial }
end
function M.release(s, id) s.sources[id] = nil end
function M.clear(s) s.sources = {} end
function M.direction(s)
    local latest
    for _, source in pairs(s.sources) do
        if not latest or source.serial > latest.serial then latest = source end
    end
    return latest and latest.direction
end
return M
