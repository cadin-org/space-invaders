local game_screen = require 'libcadin.game-screen'
local sprites = require 'components.sprites'

local invaders_laser = {}

invaders_laser.cooldown = false
invaders_laser.x0 = 0
invaders_laser.y0 = 0
invaders_laser.width = 4
invaders_laser.height = 10
invaders_laser.speed = 5

function invaders_laser:fire(invaders_table)
  if not self.cooldown then
    for i = 1, #invaders_table do
      local inv = invaders_table[i]
      if inv.alive then
        if math.random(1, 20000) == 1 then
          self.x0 = (inv.x0 + sprites.width) + 15
          self.y0 = (inv.y0 + sprites.height + inv.ROW * sprites.height) + 35
          self.cooldown = true
          break
        end
      end
    end
  end
end

function invaders_laser:move(spaceship)
  if self.cooldown then
    self.y0 = self.y0 + self.speed

    if self.y0 > game_screen.pos_y1 then
      self.x0 = 0
      self.y0 = 0
      self.cooldown = false
      return
    end

    if
      self.x0 + invaders_laser.width >= spaceship.x
      and self.x0 <= spaceship.x + sprites.width
      and self.y0 <= spaceship.y + sprites.height
      and self.y0 + invaders_laser.height >= spaceship.y
    then
      self.x0 = 0
      self.y0 = 0
      self.cooldown = false
      spaceship.lives = spaceship.lives - 1
      print('Spaceship lives: ' .. spaceship.lives)
    end
  end
end

function invaders_laser:draw()
  if self.y0 < game_screen.pos_y1 and self.cooldown then
    love.graphics.rectangle('fill', self.x0, self.y0, self.width, self.height)
  end
end

return invaders_laser
