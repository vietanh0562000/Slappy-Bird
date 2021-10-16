WelcomeState = Class{__includes = BaseState}

function WelcomeState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play');
    end
end

function WelcomeState:render()
    love.graphics.setFont(flappyFont);
    love.graphics.printf('Slappy Bird', 0, 64, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(mediumFont);
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center');
end