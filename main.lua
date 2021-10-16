push = require('push');

Class = require('class');

require('Bird');

require('Obstacle');
require('StateMachine');
require('states/BaseState');
require('states/WelcomeState');
require('states/PlayState');
require('states/GameOverState');

-- physical screen dimensions
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- virtual resolution demensions
VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

-- location when loop background
POSITION_LOOP_BG = 413;
-- speed move background and obstacles - bird fly
BACKGROUND_MOVE_SPEED = 60;

-- gravity effect to bird
GRAVITY = 20;
-- velocity add to bird when press
JUMP_VELOCITY = -5;

-- image background and ground
local backgroundImage = love.graphics.newImage('background.png');
local groundImage = love.graphics.newImage('ground.png');

-- position of image background and ground
local backgroundPosition = 0;
local groundPosition = 0;


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest');

    love.window.setTitle('Slappy Bird');
    
    -- create all fonts for the game
    smallFont = love.graphics.newFont('flappy.ttf', 8);
    mediumFont = love.graphics.newFont('flappy.ttf', 14);
    flappyFont = love.graphics.newFont('flappy.ttf', 28);

    -- create all sounds
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    -- play background music
    sounds['music']:setLooping(true);
    sounds['music']:play();

    -- Init all state game
    gStateMachine = StateMachine({
        ['welcome'] = function() return WelcomeState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function () return GameOverState() end
    });

    -- Open welcome state
    gStateMachine:change('welcome');

    -- init our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    });

    love.keyboard.keyPressed = {};
end

-- call every frame
function love.update(dt)
    -- move positon background and ground
    backgroundPosition = (backgroundPosition + BACKGROUND_MOVE_SPEED * dt) % POSITION_LOOP_BG;
    groundPosition = (groundPosition + BACKGROUND_MOVE_SPEED * dt) % POSITION_LOOP_BG;

    gStateMachine:update(dt);

    love.keyboard.keyPressed = {};
end

-- save key pressed
function love.keypressed(key)
    love.keyboard.keyPressed[key] = true;
    if key == 'escape' then
        love.event.quit();
    end
end

-- get was key pressed ?
function love.keyboard.wasPressed(key)
    print(key);
    if love.keyboard.keyPressed[key] then
        return true;
    else
        return false;    
    end
end

-- call after all update every frame
function love.draw()
    push:apply('start');

    love.graphics.draw(backgroundImage, -backgroundPosition, 0);

    gStateMachine:render();
    love.graphics.draw(groundImage, -groundPosition, VIRTUAL_HEIGHT - 10);
    push:apply('end');
end

function love.conf(t)
    t.console = true;
end