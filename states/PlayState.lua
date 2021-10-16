PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- an instance of Bird class main character in game
    self.bird = Bird(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2);
    -- time cooldown to spawn new obstacle
    self.spawnTimer = 4;
    -- list manage obstacles
    self.obstacles = {};
    -- point player
    self.point = 0;    
end
function PlayState:update(dt)
    -- call update function of bird
    self.bird:update(dt);
    -- Update cool down time if < 0 then spawn new obstacles and add to list obstacles
    self.spawnTimer = self.spawnTimer - dt;
    if self.spawnTimer <= 0 then
        -- Get a random y to place new obstacle. x is out of screen and move to screen slowly
        local posY = math.random( VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_HEIGHT / 2 + 50);
        local posX = VIRTUAL_WIDTH + 20;

        table.insert( self.obstacles, Obstacle(posX, posY));

        -- reset cool down timer
        self.spawnTimer = 2;
    end

    -- Loop all obstacle and update them
    for k, obstacle in pairs(self.obstacles) do
        obstacle:update(dt);

        if self.bird:collides(obstacle) then
            sounds['hurt']:play();
            gStateMachine:change('gameover', {score = self.point});
        end

        -- if an obstacle move to out of left of screen then remove it
        if obstacle.x < -obstacle.pipeWidth then
            table.remove( self.obstacles, k);
        end

        -- check to get point
        if (obstacle.x + obstacle.pipeWidth / 2 < self.bird.x) and (obstacle.pointed == false) then
            obstacle.pointed = true;
            self.point = self.point + 1;
            sounds['score']:play();
        end
    end    
end

function PlayState:render()
    self.bird:render();

    -- Loop all obstacles and render them
    for k, obstacle in pairs(self.obstacles) do
        obstacle:render();
    end

    -- Show score
    love.graphics.setFont(flappyFont);
    love.graphics.printf(tostring(self.point), 0, 30, VIRTUAL_WIDTH, 'center');

end
