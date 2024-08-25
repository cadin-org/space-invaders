local M = {}

--  sprite dimensions
M.x = 48
M.y = 36

-- sprite animation
M.current_frame = 1
M.frame_duration = 1
M.timer = 0

function M.update_frame(dt)
  M.timer = M.timer + dt
  if M.timer > M.frame_duration then
    M.timer = M.timer - M.frame_duration
    M.current_frame = 3 - M.current_frame
  end
end

function M.load_invaders(img)
  return {
    {
      love.graphics.newQuad(0, 0, M.x, M.y, img),
      love.graphics.newQuad(M.x, 0, M.x, M.y, img),
    },
    {
      love.graphics.newQuad(0, M.y, M.x, M.y, img),
      love.graphics.newQuad(M.x, M.y, M.x, M.y, img),
    },
    {
      love.graphics.newQuad(0, (2 * M.y), M.x, M.y, img),
      love.graphics.newQuad(M.x, (2 * M.y), M.x, M.y, img),
    },
  }
end

function M.load_ship(img)
  return love.graphics.newQuad((M.x / 2), (4 * M.y), M.x, M.y, img)
end

return M
