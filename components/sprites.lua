local M = {}

--  sprite dimensions
M.width = 48 -- x
M.height = 36 -- y

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
      love.graphics.newQuad(0, 0, M.width, M.height, img),
      love.graphics.newQuad(M.width, 0, M.width, M.height, img),
    },
    {
      love.graphics.newQuad(0, M.height, M.width, M.height, img),
      love.graphics.newQuad(M.width, M.height, M.width, M.height, img),
    },
    {
      love.graphics.newQuad(0, (2 * M.height), M.width, M.height, img),
      love.graphics.newQuad(M.width, (2 * M.height), M.width, M.height, img),
    },
  }
end

function M.load_ship(img)
  return love.graphics.newQuad((M.width / 2), (4 * M.height), M.width, M.height, img)
end

return M
