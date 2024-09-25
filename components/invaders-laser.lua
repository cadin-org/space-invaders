local game_screen = require 'libcadin.game-screen'
local sprites = require 'components.sprites'

local invaders_laser = {}

function invaders_laser.new(inv_x, inv_y, inv_ROW)
  return {
    x0 = inv_x + (sprites.width / 2),
    y0 = inv_y + sprites.height + (inv_ROW * sprites.height),
    width = 2,
    height = 20,
    speed = 5,
  }
end

function invaders_laser.move(self, spaceship, invader)
  self.y0 = self.y0 + self.speed

  if self.y0 > game_screen.pos_y1 then
    invader.laser = nil
  end

  if
    self.x0 + self.width >= spaceship.x
    and self.x0 <= spaceship.x + sprites.width
    and self.y0 <= spaceship.y + sprites.height
    and self.y0 + self.height >= spaceship.y -- is this line necessary?
  then
    invader.laser = nil
    spaceship.lives = spaceship.lives - 1
  end
end

function invaders_laser.draw(self)
  if self.y0 < game_screen.pos_y1 then
    love.graphics.rectangle('fill', self.x0, self.y0, self.width, self.height)
  end
end

return invaders_laser
