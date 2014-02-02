local states = {}
local currentState

function love.load()
	--require libs
	director = require 'stateDirector'

	--require/load states
	hamster = require 'hamsterBounce'
	menu = require 'menu'
	director.addState(hamster, 'bounce')
	director.addState(menu, 'menu')
	director.loadState('bounce')

end

function love.quit()
	print("Have a nice day!")
end


function love.update(dt) --Doesn't do anything itself. Just registers that Love is calling update and hands off to whatever is handling these calls.
	director.update(dt)
end

function love.mousepressed(x,y,button)
	director.mousepressed(x, y, button)
end

function love.draw()
	director.draw()
end

function love.keypressed(key, unicode)
	director.keypressed(key, unicode)
end
