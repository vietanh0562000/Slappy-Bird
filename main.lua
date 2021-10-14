push = require('push');

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

local backgroundImage = love.graphics.newImage('background.png');
local groundImage = love.graphics.newImage('ground.png');

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest');

    love.window.setTitle('Slappy Bird');
    
    -- init our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    });

end

-- call every frame
function love.update(dt)

end

-- call after all update every frame
function love.draw()
    push:apply('start');

    love.graphics.draw(backgroundImage, 0, 0);
    love.graphics.draw(groundImage, 0, VIRTUAL_HEIGHT - 10);

    push:apply('end');
end
