player = {}

local target

--Change these once multiple objects are selectable
local position
local speed
local x
local y
local xSpeed
local ySpeed
local cam
----------------------------------------------------

function player.setCamera(Camera)
	cam = camera
end

function player.getCamera()
	return cam
end

function player.setTarget(playableUnit)

	if playableUnit:isPlayable() then
		target = playableUnit
		print("Player got playable object")
		return true
	else
		return false
	end
end

function player.getTarget()
	return target
end

function player.update(dt)
	position = target:getPosition()
	x = position[1]
	y = position[2]

	speed = target:getSpeed()
	xSpeed = speed[1]
	ySpeed = speed[2]

	--Change Player Speed
	if love.keyboard.isDown("right") then
		xSpeed = xSpeed + 1
	end
	
	if love.keyboard.isDown("left") then
		xSpeed = xSpeed - 1
	end

	if love.keyboard.isDown("down") then	
		ySpeed = ySpeed + 1
	end

	if love.keyboard.isDown("up") then	
		ySpeed = ySpeed - 1
	end


	target:setSpeed(xSpeed,ySpeed)
end

function player.draw()
	love.graphics.print("(x,y) = (" .. x .. ", " .. y .. ")", x+45,y)
	love.graphics.print("xSpeed: " .. xSpeed .. ", ySpeed: " .. ySpeed, x+45, y+14)

	love.graphics.print("fps =" .. love.timer.getFPS(), x+45, y+28)
end

function player.keypressed(key, unicode)

end

return player
