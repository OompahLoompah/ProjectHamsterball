local state = {}

function state.init()
	local menuCanvaser = canvaser
	local transparency = canvaser
	local transparent = love.graphics.newCanvas()

end

function state.update(dt)

end

function state.keypressed(key, unicode)
	if key == 'escape' then 
		love.graphics.setColor(255,255,255,255)
		director.loadLastState()
	end
end

function state.draw()

	--print the last state's graphics and then a transparent cover
	director.getLastState().draw()

	--reset any translation
	love.graphics.push()
	love.graphics.translate(0, 0)

	--finally print menu items
	love.graphics.setColor(0,0,0,220)
	love.graphics.rectangle('fill', 0, 0, 800, 600)
	love.graphics.setColor(255,255,255,255)
	love.graphics.pop()
	
end

return state
