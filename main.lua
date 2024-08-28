local catppuccin = require 'libcadin.catppuccin'
local game_screen = require 'libcadin.game-screen'
local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local sprites = require 'components.sprites'
local Invaders = require 'components.invaders'
local Spaceship = require 'components.spaceship'
local laser = require 'components.laser'
local scoreboard = require 'components.scoreboard'

local IMG = love.graphics.newImage 'assets/sprites/sprite_sheet.png'

local invaders_img = sprites.load_invaders(IMG)
local ship_img = sprites.load_ship(IMG)
local spaceship = Spaceship:load(ship_img, window.center.x - (sprites.width / 2), game_screen.pos_y1 - sprites.height - 10)
local invaders_table = Invaders:load_table(invaders_img, game_screen.pos_x0, game_screen.pos_y0)

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

  splash.load()
end

function love.update(dt)
  sprites.update_frame(dt)
  sprites.frame_duration = sprites.frame_duration - dt * 0.02

  laser:move(invaders_table)

  for i = 1, #invaders_table do
    invaders_table[i]:move(dt, laser)
  end

  spaceship:move('left', 'right')

  function love.keypressed(key)
    if key == 'space' then
      laser:fire(spaceship)
    end
  end
end

function love.draw()
  local time = love.timer.getTime()
  -- splash.start(time)

  if time >= 0 then
    game_screen.frame()

    for i = 1, #invaders_table do
      invaders_table[i]:draw(IMG, sprites.current_frame)
    end

    spaceship:draw(IMG)
    laser:draw()
    scoreboard.draw(spaceship)
  end
end
