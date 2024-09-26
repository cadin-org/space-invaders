local game_screen = require 'libcadin.game-screen'
local sprites = require 'components.sprites'

local Invaders = {}
Invaders.__index = Invaders

Invaders.ROW = 0
Invaders.SPD = 0.9

local function new_invader(sprite_img, kind, x, y)
  local instance = setmetatable({}, Invaders)
  instance.img = sprite_img
  instance.kind = kind
  instance.x0 = x
  instance.y0 = y
  instance.alive = true
  instance.laser = nil
  return instance
end

function Invaders:load_table(sprite_img, x0, y0)
  local invaders_table = {}
  local kind = 0

  for i = 1, 5 do
    if i == 1 then
      kind = 1
    elseif i > 1 and i < 4 then
      kind = 2
    else
      kind = 3
    end
    for j = 1, 11 do
      local x = x0 + (j - 1) * sprites.width + 130
      local y = y0 + (i - 1) * sprites.height * 1.2
      local add_invader = new_invader(sprite_img[kind], kind, x, y)
      table.insert(invaders_table, add_invader)
    end
  end

  return invaders_table
end

function Invaders:increase_speed(factor)
  Invaders.SPD = Invaders.SPD * factor
end

function Invaders:move(spaceship)
  if Invaders.ROW < 16 then
    if self.alive then
      if self.laser ~= nil then
        self.laser.y0 = self.laser.y0 + self.laser.speed

        if
          self.laser.x0 + self.laser.width >= spaceship.x
          and self.laser.x0 <= spaceship.x + sprites.width
          and self.laser.y0 <= spaceship.y + sprites.height
          and self.laser.y0 + self.laser.height >= spaceship.y -- is this line necessary?
        then
          self.laser = nil
          spaceship.lives = spaceship.lives - 1
        elseif self.laser.y0 + self.laser.height > game_screen.pos_y1 then
          self.laser = nil
        end
      end

      if (self.x0 < game_screen.pos_x1 - sprites.width - 4 and Invaders.SPD > 0) or (self.x0 > game_screen.pos_x0 + 4 and Invaders.SPD < 0) then
        self.x0 = self.x0 + Invaders.SPD
      else
        Invaders.ROW = Invaders.ROW + 1
        Invaders.SPD = -Invaders.SPD * 1.1
      end
    end
  else
    -- GAME OVER ?
  end
end

function Invaders:fire()
  self.laser = {
    x0 = self.x0 + (sprites.width / 2),
    y0 = self.y0 + sprites.height + (self.ROW * sprites.height),
    width = 2,
    height = 20,
    speed = 5,
  }
end

function Invaders:draw(sprite_img, frame)
  if self.alive then
    love.graphics.draw(sprite_img, self.img[frame], self.x0, self.y0 + Invaders.ROW * sprites.height)

    if self.laser ~= nil then
      love.graphics.rectangle('fill', self.laser.x0, self.laser.y0, self.laser.width, self.laser.height)
    end
  end
end

return Invaders
