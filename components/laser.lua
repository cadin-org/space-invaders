local game_screen = require 'libcadin.game-screen'
local sprites = require 'components.sprites'

local laser = {}

laser.cooldown = false
laser.x0 = 0
laser.y0 = 0
laser.width = 4
laser.height = 10
laser.speed = 11

function laser:move(invaders_table)
  if self.cooldown then
    self.y0 = self.y0 - self.speed

    if self.y0 < game_screen.pos_y0 then
      self.x0 = 0
      self.y0 = 0
      self.cooldown = false
      return
    end

    for i = 1, #invaders_table do
      local inv = invaders_table[i]
      if inv.alive then
        if
          self.x0 + laser.width >= inv.x0
          and self.x0 <= inv.x0 + sprites.width
          and self.y0 <= inv.y0 + sprites.height + inv.ROW * sprites.height
          and self.y0 + laser.height >= inv.y0 + inv.ROW * sprites.height
        then
          self.x0 = 0
          self.y0 = 0
          inv.alive = false
          self.cooldown = false
          break
        end
      end
    end
  end
end

function laser:fire(spaceship)
  if not self.cooldown then
    self.x0 = spaceship.x + 22.5
    self.y0 = spaceship.y - 15
    self.cooldown = true
  end
end

function laser:draw()
  if self.y0 > game_screen.pos_y0 and self.cooldown then
    love.graphics.rectangle('fill', self.x0, self.y0, self.width, self.height)
  end
end

return laser
