local fonts = require 'libcadin.fonts'
local game_screen = require 'libcadin.game-screen'
local window = require 'libcadin.window'

local score = {}

function score.draw(SCORE)
  local formatted_score = string.format('%05d', SCORE)
  local text = 'Score: ' .. formatted_score
  local text_width = fonts.ps2p_medium:getWidth(text)
  love.graphics.printf(text, fonts.ps2p_medium, window.center.x - (text_width / 2), game_screen.pos_y0 - 100, text_width, 'center')
end

return score
