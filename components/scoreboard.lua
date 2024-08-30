local window = require 'libcadin.window'
local score = {}

function score.draw(SCORE)
  local formatted_score = string.format('%05d', SCORE)
  love.graphics.print('Score: ' .. formatted_score, window.width - 380, window.height - 60)
end

return score
