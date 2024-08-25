local catppuccin = require 'libcadin.catppuccin'
local game_screen = require 'libcadin.game-screen'
local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local sprites = require 'components.sprites'
local Spaceship = require 'components.spaceship'

local spaceship = Spaceship:new(window.center.x - (sprites.x / 2), game_screen.pos_y1 - sprites.y - 10)

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

  IMG = love.graphics.newImage 'assets/sprites/sprite_sheet.png'

  splash.load()
  invaders = sprites.load_invaders(IMG)
  -- ship = sprites.load_ship(IMG)
end

function love.update(dt)
  sprites.update_frame(dt)
  spaceship:move('left', 'right')
end

local margin = (game_screen.width - (11 * (sprites.x + 10))) / 2

function love.draw()
  local time = love.timer.getTime()
  -- splash.start(time)

  if time >= 0 then
    game_screen.frame()

    for i = 1, 11, 1 do
      love.graphics.draw(IMG, invaders[1][sprites.current_frame], game_screen.pos_x0 + i * sprites.x + margin, game_screen.pos_y0 + sprites.y * 1)
      love.graphics.draw(IMG, invaders[2][sprites.current_frame], game_screen.pos_x0 + i * sprites.x + margin, game_screen.pos_y0 + sprites.y * 2.3)
      love.graphics.draw(IMG, invaders[2][sprites.current_frame], game_screen.pos_x0 + i * sprites.x + margin, game_screen.pos_y0 + sprites.y * 3.5)
      love.graphics.draw(IMG, invaders[3][sprites.current_frame], game_screen.pos_x0 + i * sprites.x + margin, game_screen.pos_y0 + sprites.y * 4.8)
      love.graphics.draw(IMG, invaders[3][sprites.current_frame], game_screen.pos_x0 + i * sprites.x + margin, game_screen.pos_y0 + sprites.y * 6.1)
    end

    spaceship:draw()
  end
end
