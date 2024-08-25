local Spaceship = {}
Spaceship.__index = Spaceship

function Spaceship:new(x, y)
  local instance = setmetatable({}, Spaceship)
  instance.image = love.graphics.newImage 'assets/sprites/ship.png'
  instance.x = x
  instance.y = y
  instance.speed = 5
  return instance
end

function Spaceship:move(left, right)
  if love.keyboard.isDown(left) then
    self.x = self.x - self.speed
  elseif love.keyboard.isDown(right) then
    self.x = self.x + self.speed
  end
end

function Spaceship:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

return Spaceship
