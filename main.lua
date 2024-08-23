local catppuccin = require 'libcadin.catppuccin'
local game_screen = require 'libcadin.game-screen'
local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local sprites = require 'components.sprites'

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  local font_asset_path = 'assets/fonts/FiraMono-Medium.ttf'
  local fira_mono = love.graphics.newFont(font_asset_path, 48)
  love.graphics.setFont(fira_mono)

  IMG = love.graphics.newImage 'assets/sprites/sprite_sheet.png'

  splash.load()
  invaders = sprites.load_invaders(IMG)
  ship = sprites.load_ship(IMG)
end

function love.draw()
  local time = love.timer.getTime()

  -- splash.start(time)

  if time >= 0 then
    game_screen.frame()
    -- TODO: animate each alien
    --  the animation have only 2 frames [_][1] and [_][2]
    love.graphics.draw(IMG, invaders[1][1], window.center.x - (sprites.x / 2), game_screen.pos_y0 + sprites.y)
    love.graphics.draw(IMG, invaders[1][2], window.center.x + (sprites.x / 2), game_screen.pos_y0 + sprites.y)

    love.graphics.draw(IMG, invaders[2][1], window.center.x - (sprites.x / 2), game_screen.pos_y0 + sprites.y * 2)
    love.graphics.draw(IMG, invaders[2][2], window.center.x + (sprites.x / 2), game_screen.pos_y0 + sprites.y * 2)

    love.graphics.draw(IMG, invaders[3][1], window.center.x - (sprites.x / 2), game_screen.pos_y0 + sprites.y * 3)
    love.graphics.draw(IMG, invaders[3][2], window.center.x + (sprites.x / 2), game_screen.pos_y0 + sprites.y * 3)

    -- TODO: add ship movement
    love.graphics.draw(IMG, ship, window.center.x + (sprites.x / 2), game_screen.pos_y1 - sprites.y - 10)
  end
end
