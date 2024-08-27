local game_screen = require 'libcadin.game-screen'
local sprites = require 'components.sprites'

local Invaders = {}
Invaders.__index = Invaders

Invaders.ROW = 0
Invaders.SPD = 1

local function new_invader(sprite_img, kind, x, y, row)
  local instance = setmetatable({}, Invaders)
  instance.img = sprite_img
  instance.kind = kind
  instance.x = x
  instance.y = y
  -- instance.speed = 2
  -- instance.row = row -- not sure about the row logic yet
  instance.alive = true
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
      local x = x0 + (j - 1) * sprites.x + 130
      local y = y0 + (i - 1) * sprites.y * 1.2
      local add_invader = new_invader(sprite_img[kind], kind, x, y, i)
      table.insert(invaders_table, add_invader)
    end
  end

  return invaders_table
end

function Invaders:increase_speed(factor)
  Invaders.SPD = Invaders.SPD * factor
end

local delta = 0

function Invaders:move(dt)
  sprites.frame_duration = sprites.frame_duration - dt * 0.0005

  if Invaders.ROW < 16 then
    if self.x < game_screen.pos_x1 - sprites.y - 10 and Invaders.SPD > 0 then
      self.x = self.x + Invaders.SPD
    elseif self.x > game_screen.pos_x0 + 5 and Invaders.SPD < 0 then
      self.x = self.x + Invaders.SPD
    else
      Invaders.ROW = Invaders.ROW + 1
      Invaders.SPD = -Invaders.SPD * 1.1
    end
  else
    -- GAME OVER ?
  end
end

function Invaders:draw(sprite_img, frame)
  if self.alive then
    love.graphics.draw(sprite_img, self.img[frame], self.x, self.y + Invaders.ROW * sprites.y)
  end
end

return Invaders
