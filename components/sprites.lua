local M = {}

--  sprite dimensions
M.x = 48
M.y = 36

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
