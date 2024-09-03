local catppuccin = require 'libcadin.catppuccin'
local fonts = require 'libcadin.fonts'
local game_screen = require 'libcadin.game-screen'
local menu = require 'libcadin.menu'
local splash = require 'libcadin.splash-screen'
local window = require 'libcadin.window'
local sprites = require 'components.sprites'
local Invaders = require 'components.invaders'
local Spaceship = require 'components.spaceship'
local laser = require 'components.laser'
local scoreboard = require 'components.scoreboard'

-- single_player
GAME_MODE = 'single_player'

-- title_screen, pause_screen, playing, gameover
GAME_STATE = 'title_screen'

local IMG = love.graphics.newImage 'assets/sprites/sprite_sheet.png'

local invaders_img = sprites.load_invaders(IMG)
local ship_img = sprites.load_ship(IMG)
local spaceship = Spaceship:load(ship_img, window.center.x - (sprites.width / 2), game_screen.pos_y1 - sprites.height - 10)
local invaders_table = Invaders:load_table(invaders_img, game_screen.pos_x0, game_screen.pos_y0)
local start_sound = love.audio.newSource('assets/sounds/365635__obxjohn__laser-gun-pew-pew.wav', 'static')

function NEW_GAME()
  spaceship = Spaceship:load(ship_img, window.center.x - (sprites.width / 2), game_screen.pos_y1 - sprites.height - 10)
  invaders_table = Invaders:load_table(invaders_img, game_screen.pos_x0, game_screen.pos_y0)
  Invaders.ROW = 0
  Invaders.SPD = 0.9
  sprites.current_frame = 1
  sprites.frame_duration = 1
  laser.cooldown = false

  SCORE = 0
  GAME_STATE = 'playing'
  start_sound:play()
end

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  MAIN_MENU = menu.single_player_options()
  PAUSE_MENU = menu.pause_options()

  love.graphics.setFont(fonts.ps2p_large)

  splash.load()
end

function love.update(dt)
  if GAME_STATE == 'playing' then
    sprites.update_frame(dt)
    sprites.frame_duration = sprites.frame_duration - dt * 0.02

    laser:move(invaders_table)

    for i = 1, #invaders_table do
      invaders_table[i]:move(dt, laser)
    end

    spaceship:move('left', 'right')
  end
end

function love.draw()
  local time = love.timer.getTime()
  -- splash.start(time)

  if time >= 0 then
    if GAME_STATE == 'title_screen' then
      menu.draw(MAIN_MENU)
    elseif GAME_STATE == 'pause_screen' then
      menu.draw(PAUSE_MENU)
    elseif GAME_STATE == 'playing' then
      game_screen.frame()
      love.graphics.printf('press P to pause the game', fonts.ps2p_small, 0, game_screen.pos_y1 + 20, window.width, 'center')
      for i = 1, #invaders_table do
        invaders_table[i]:draw(IMG, sprites.current_frame)
      end

      spaceship:draw(IMG)
      laser:draw()
      scoreboard.draw(SCORE)
    end
  end
end

function love.keypressed(key)
  if key == 'space' and GAME_STATE == 'playing' then
    laser:fire(spaceship)
  elseif key == 'p' and GAME_STATE == 'playing' then
    GAME_STATE = 'pause_screen'
  elseif GAME_STATE == 'title_screen' then
    menu.handle_input(MAIN_MENU, key)
  elseif GAME_STATE == 'pause_screen' then
    menu.handle_input(PAUSE_MENU, key)
  end
end
