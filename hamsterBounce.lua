require 'object'
require 'camera'
local player = require 'player'
local state = {}

local x
local y
local xSpeed
local ySpeed
local cam
local objects = {}
local i = 0
local runtest = false

function state.init()

	objects[1] = object.new(love.graphics.newImage('resources/imgs/hamster.png'), 0, 0, 0, 0, 10, true)
	i = 1

	bg = object.new(love.graphics.newImage('resources/imgs/test.jpg'), 0, 0, 0, 0, false)
	bgi = bg:getImage()
	
	cam = camera.new()
	cam:lockCamera(objects[1])

	player.setTarget(objects[1])
	player.setCamera(cam)
end

function state.update(dt)
	local position = player.getTarget():getPosition()
	x = position[1]
	y = position[2]

	local speed = player.getTarget():getSpeed()
	xSpeed = speed[1]
	ySpeed = speed[2]
	
	player.update(dt)
	cam:update(dt)

	for i = 1, #objects do
		objects[i]:update(dt)
	end

	if runtest then
		state.test()
	end
	
end

function state.keypressed(key, unicode)
	--[[
		Player controls handled by the state since the
			player shouldn't control their controls.
	--]]
	
	if key == 'escape' then
		director.loadState('menu')
	elseif key == 'c' then
		if cam:isLocked() then
			cam:unlock()
			print("Cam unlocked")
		else
			cam:lockCamera(player.getTarget())
			print("Cam locked")
		end
	elseif key == 't' then
		if runtest then
			runtest = false
		else
			runtest = true
		end
	end
end

function state.mousepressed(x, y, button)
	print("mouse pressed")
	print(button)
	if button == 'l' then
	print(x)
	print(y)
		for i = 1, #objects do
			local image = objects[i]:getImage()
			local position = objects[i]:getPosition()
			local camPos = cam:getPosition()
				if objects[i]:isPlayable() then
				if x + camPos[1] > position[1] and y + camPos[2] > position[2] and x + camPos[1] < position[1]+image:getWidth() and y + camPos[2] < position[2]+image:getHeight() then
					print("captured object")
					player.setTarget(objects[i])
					cam:lockCamera(objects[i])
					break
				end
			end
		end
	elseif button == 'r' then
		local camPos = cam:getPosition()
		print(x + camPos[1])
		print(y + camPos[2])
		player.getTarget():moveTo(x + camPos[1],y + camPos[2])
	end
end

function state.draw()
	love.graphics.push()
	cam:draw()
	position = bg:getPosition()
	love.graphics.draw(bgi, position[1], position[2])

	for i = 1, #objects do 
		local image = objects[i]:getImage()
		local position = objects[i]:getPosition()
		love.graphics.draw(image, position[1], position[2])
	end

	local image = objects[1]:getImage()
	local position = objects[1]:getPosition()
	love.graphics.draw(image, position[1], position[2])
	

	player.draw()
	love.graphics.pop()

end

function state.test()
	i = i + 1
	objects[i] = object.new(love.graphics.newImage('resources/imgs/hamster.png'), 0, 0, 100, 100, 1, true)
	print(i)
end

return state
