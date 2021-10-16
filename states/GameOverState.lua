GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.score = 0;
end

function GameOverState:enter(params)
    self.score = params.score;
end
function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play');
    end
end

function GameOverState:render()
    love.graphics.setFont(mediumFont);
    love.graphics.printf('Poor the bird', 0, 30, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(flappyFont);
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, 50, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(mediumFont);
    love.graphics.printf('Press Enter To Play Again', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center');
end
