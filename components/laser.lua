local game_screen = require 'libcadin.game-screen'

local laser = {}

laser.cooldown = false
laser.x = 0
laser.y = 0
laser.speed = 10

function laser:move()
  if self.cooldown then
    self.y = self.y - self.speed
    if laser.y < game_screen.pos_y0 then
      laser.cooldown = false
    end
  end
end

function laser:fire(spaceship)
  if not laser.cooldown then
    self.x = spaceship.x + 22.5
    self.y = spaceship.y - 15
    laser.cooldown = true
  end
end

function laser:draw()
  if self.y > game_screen.pos_y0 and self.cooldown then
    love.graphics.rectangle('fill', self.x, self.y, 4, 10)
  end
end

return laser
