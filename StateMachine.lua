StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        init = function() end,
        enter = function() end,
        update = function(dt) end,
        render = function() end,
        exit = function () end,
    }

    self.states = states or {};
    self.current = self.empty;
end

function StateMachine:change(stateName, params)
    assert(self.states[stateName]);
    self.current:exit();
    self.current = self.states[stateName]();
    self.current:enter(params);
end
function StateMachine:update(dt)
    self.current:update(dt);
end

function StateMachine:render()
    self.current:render();
end