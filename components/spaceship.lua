local game_screen = require 'libcadin.game-screen'

local Spaceship = {}
Spaceship.__index = Spaceship

function Spaceship:load(img, x, y)
  local instance = setmetatable({}, Spaceship)
  instance.img = img
  instance.x = x
  instance.y = y
  instance.speed = 5
  instance.score = 0
  return instance
end

function Spaceship:move(left, right)
  if love.keyboard.isDown(left) and self.x - 1 > game_screen.pos_x0 then
    self.x = self.x - self.speed
  elseif love.keyboard.isDown(right) and self.x + 49 < game_screen.pos_x1 then
    self.x = self.x + self.speed
  end
end

function Spaceship:draw(sprite_img)
  love.graphics.draw(sprite_img, self.img, self.x, self.y)
end

return Spaceship
