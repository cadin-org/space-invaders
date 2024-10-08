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

function NEW_GAME()
  spaceship = Spaceship:load(ship_img, window.center.x - (sprites.width / 2), game_screen.pos_y1 - sprites.height - 10)
  invaders_table = Invaders:load_table(invaders_img, game_screen.pos_x0, game_screen.pos_y0)
  Invaders.RANK = 0
  Invaders.SPD = 0.9
  Invaders.VANGUARD_TABLE = Invaders:new_vanguard_table()
  sprites.current_frame = 1
  sprites.frame_duration = 1
  laser.cooldown = false

  SCORE = 0
  GAME_STATE = 'playing'
end

function love.load()
  love.graphics.setBackgroundColor(catppuccin.MANTLE)

  MAIN_MENU = menu.single_player_options()
  PAUSE_MENU = menu.pause_options()

  love.graphics.setFont(fonts.ps2p_large)

  splash.load()
  TIME = 0
end

function love.update(dt)
  if GAME_STATE == 'playing' then
    TIME = TIME + dt
    sprites.update_frame(dt)
    sprites.frame_duration = sprites.frame_duration - dt * 0.02
    local pick_invader = 0

    laser:move(invaders_table)

    for i = 1, #invaders_table do
      local invader = invaders_table[i]
      invader:move(spaceship)

      if math.ceil(TIME) > 1 then
        if invader.alive and invader.laser == nil and invader.row == Invaders.VANGUARD[invader.column] then
          pick_invader = math.random(1, 60)

          if pick_invader == 1 then
            invader:fire()
            TIME = 0
          end
        end
      end
    end

    spaceship:move('left', 'right')

    if spaceship.lives == 0 then
      GAME_STATE = 'gameover'
    end

    local vanguard_row_sum = 0
    for _, value in ipairs(Invaders.VANGUARD) do
      vanguard_row_sum = vanguard_row_sum + value
    end

    if vanguard_row_sum == 0 then
      -- TODO: IMPLEMENT VICTORY
      GAME_STATE = 'gameover'
    end
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
      -- TODO: display lives in a better way
      love.graphics.printf(spaceship.lives .. ' spaceship(s) left', fonts.ps2p_small, 0, game_screen.pos_y1 + 60, window.width, 'center')
      for i = 1, #invaders_table do
        invaders_table[i]:draw(IMG, sprites.current_frame)
      end

      spaceship:draw(IMG)
      laser:draw()
      scoreboard.draw(SCORE)
    elseif GAME_STATE == 'gameover' then
      love.graphics.printf('GAME OVER', fonts.ps2p_large, 0, window.center.y - 200, window.width, 'center')
      menu.draw(MAIN_MENU)
    end
  end
end

function love.keypressed(key)
  if key == 'space' and GAME_STATE == 'playing' then
    laser:fire(spaceship)
  elseif key == 'p' and GAME_STATE == 'playing' then
    GAME_STATE = 'pause_screen'
  elseif GAME_STATE == 'title_screen' or GAME_STATE == 'gameover' then
    menu.handle_input(MAIN_MENU, key)
  elseif GAME_STATE == 'pause_screen' then
    menu.handle_input(PAUSE_MENU, key)
  end
end
