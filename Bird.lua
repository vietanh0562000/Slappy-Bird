Bird = Class{}

function Bird:init(x, y)
    self.x = x;
    self.y = y;
    self.image = love.graphics.newImage('bird.png');
    self.width = self.image:getWidth();
    self.height = self.image:getHeight();
    self.dy = 0;
end

function Bird:update(dt)
    -- increase velocity to bird drop
    self.dy = self.dy + GRAVITY * dt;

    -- when player press velocity assign to JUMP_VELOCITY immediately
    if love.keyboard.wasPressed('space') then
        self.dy = JUMP_VELOCITY;
        sounds['jump']:play();
    end

    -- apply velocity to move bird
    self.y = self.y + self.dy;
end

-- detect if bird collides with obstacle
function Bird:collides(obstacle)
    if (self.y > obstacle.y - obstacle.distance / 2) and (self.y < obstacle.y + obstacle.distance / 2) then
        return false;
    end 

    if (self.x + self.width - 4 < obstacle.x - obstacle.pipeWidth / 2) or (self.x > obstacle.x + obstacle.pipeWidth / 2) then
        return false;
    end

    return true;
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y);
end