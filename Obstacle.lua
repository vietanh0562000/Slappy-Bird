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
end

function Obstacle:update(dt)
    self.x = self.x + self.dx * dt;
end

function Obstacle:render()
    love.graphics.draw(
        self.pipeUp, 
        self.x - self.pipeWidth / 2, 
        self.y - self.distance / 2,
        0, 1, -1
    );
    love.graphics.draw(self.pipeUp, self.x - self.pipeWidth / 2, self.y + self.distance / 2);
end