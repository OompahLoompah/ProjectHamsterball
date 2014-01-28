local director = {}
local states = {}

local currentState
local lastState


function director.addState(state, ident)
	states[ident] = state
end

function director.loadState(ident)
	if currentState then
		lastState = currentState
	end
	currentState = states[ident]
	currentState.init()
end

function director.loadLastState()
	currentState = lastState
end

function director.getLastState()
	return lastState
end

function director.update(dt) 
	currentState.update(dt)
end

function director.draw()
	currentState.draw()
end

function director.keypressed(key, unicode)
	currentState.keypressed(key, unicode)
end

function director.mousepressed(x,y,button)
	currentState.mousepressed(x, y, button)
end

return director
