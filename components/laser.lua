local Laser = {}
Laser.__index = Laser

function Laser:new(x, y)
  local instance = setmetatable({}, Laser)
  instance.x = x
  instance.y = y - 15
  instance.speed = 5
  return instance
end

function Laser:move()
  self.y = self.y - self.speed
end

function Laser:draw()
  love.graphics.rectangle('fill', self.x, self.y, 2, 10)
end

return Laser
