local game_screen = require 'libcadin.game-screen'

local laser = {}

laser.laser_on = false
laser.x = nil
laser.y = nil
laser.speed = 10

function laser:move()
  if self.laser_on then
    self.y = self.y - self.speed
    if laser.y < game_screen.pos_y0 then
      laser.laser_on = false
    end
  end
end

function laser:draw(spaceship_x, spaceship_y)
  if not self.laser_on then
    self.x = spaceship_x + 22.5
    self.y = spaceship_y - 15
  end

  if self.y > game_screen.pos_y0 and self.laser_on == true then
    love.graphics.rectangle('fill', self.x, self.y, 4, 10)
  end
end

return laser
