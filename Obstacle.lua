-- One obstacle have three part: pipe up, safe zone, pipe bottom
-- two pipe make collision with bird
-- safe zone let bird fly through
Obstacle = Class{}

local PIPE_IMAGE = love.graphics.newImage('pipe.png'); 
function Obstacle:init(x, y)
    self.x = x;
    self.y = y;
    self.distance = 100;
    self.pipeUp = PIPE_IMAGE;
    self.pipeDown = PIPE_IMAGE;
    self.pipeHeight = self.pipeUp:getHeight();
    self.pipeWidth = self.pipeUp:getWidth();
    self.dx = -BACKGROUND_MOVE_SPEED;
    self.pointed = false;
end

function Obstacle:update(dt)
    -- move obstacle
    self.x = self.x + self.dx * dt;
end

function Obstacle:render()
    -- render pipe top
    love.graphics.draw(
        self.pipeUp, 
        self.x - self.pipeWidth / 2, 
        self.y - self.distance / 2,
        0, 1, -1
    );

    -- render pipe bottom
    love.graphics.draw(self.pipeUp, self.x - self.pipeWidth / 2, self.y + self.distance / 2);
end