push = require('push');

Class = require('class');

require('Bird');

require('Obstacle');

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

POSITION_LOOP_BG = 413;
BACKGROUND_MOVE_SPEED = 60;

GRAVITY = 20;
JUMP_VELOCITY = -5;

local backgroundImage = love.graphics.newImage('background.png');
local groundImage = love.graphics.newImage('ground.png');

local backgroundPosition = 0;
local groundPosition = 0;

local bird = Bird(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2);

local spawnTimer = 4;
local obstacles = {};

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest');

    love.window.setTitle('Slappy Bird');
    
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
    backgroundPosition = (backgroundPosition + BACKGROUND_MOVE_SPEED * dt) % POSITION_LOOP_BG;
    groundPosition = (groundPosition + BACKGROUND_MOVE_SPEED * dt) % POSITION_LOOP_BG;

    bird:update(dt);

    spawnTimer = spawnTimer - dt;
    if spawnTimer <= 0 then
        local posY = math.random( VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_HEIGHT / 2 + 50);
        local posX = VIRTUAL_WIDTH + 20;
        table.insert( obstacles, Obstacle(posX, posY));
        spawnTimer = 2;
    end

    for k, obstacle in pairs(obstacles) do
        obstacle:update(dt);

        if obstacle.x < -obstacle.pipeWidth then
            table.remove( obstacles, k);
        end
    end
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

    bird:render();
    for k, obstacle in pairs(obstacles) do
        obstacle:render();
    end

    love.graphics.draw(groundImage, -groundPosition, VIRTUAL_HEIGHT - 10);
    push:apply('end');
end

function love.conf(t)
    t.console = true;
end