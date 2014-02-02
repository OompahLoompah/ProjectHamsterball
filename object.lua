--[[
	Function for keeping track of a given entity's data.
This object contains its 2d sprite, position, speed, etc.
--]]

object = {}
object.__index = object

local image = nil
local x = 0
local y = 0
local xSpeed = 0
local ySpeed = 0
local topAcceleration = 0
local xAcceleration = 0
local yAcceleration = 0
local playable = false

local xDecelerate = false
local yDecelerate = false

local xTarget --Must initialize to spawn location
local yTarget --Must initialize to spawn location

function object.new(initImage, initX, initY, initXSpeed, initYSpeed, acceleration, initPlayable)
  local self = setmetatable({}, object)
	self.image = initImage
	self.x = initX
	self.y = initY
	self.xTarget = initX
	self.yTarget = initY
	self.xSpeed = initXSpeed
	self.ySpeed = initYSpeed
	self.topAcceleration = acceleration
	self.playable = initPlayable
  return self
end

function object:isPlayable()
	return self.playable
end

function object:setPlayable(setPlayable)
	self.playable = setPlayable
end

function object:getPosition()
	return {self.x,self.y}
end

function object:setPosition(xPos,yPos)
	self.x = xPos
	self.y = yPos
end

function object:getSpeed()
	return {self.xSpeed, self.ySpeed}
end

function object:setSpeed(speedX, speedY)
	self.xSpeed = speedX
	self.ySpeed = speedY
end

function object:setImage(v)
	self.image = v
end

function object:getImage()
	return self.image
end

function object:update(dt)

--[[
	I'm not 100% happy with this but it works enough to continue coding and testing.
		I really wish that the object would stop on the target point without
		oscillating back and forth instead. 	
]]--


	--movement algorithm
	
	--x and y diff are the difference in current position and target position
	local yDiff = self.y - self.yTarget
	local xDiff = self.x - self.xTarget

	--the point of the helpers is to dampen the velocity of the object when it nears the target
	--by projecting the target closer to the object than it really is
	local yHelper = 0
	local xhelper = 0

	--code for determining the quadrant of the target relative to the object and changing the
	--sign of the helper int accordingly
	if  yDiff > 0 then
		yHelper = - (self.ySpeed*self.ySpeed/10)
	else
		yHelper = (self.ySpeed*self.ySpeed/10)
	end

	if  xDiff > 0 then
		xHelper = - (self.xSpeed*self.xSpeed/10)
	else
		xHelper = (self.xSpeed*self.xSpeed/10)
	end
	
	--determine the angle to the target
	local angle = math.atan2(yDiff + yHelper, xDiff + xHelper)

	--determine the appropriate acceleration vector based on the angle to the target position
	self.xAcceleration = -math.cos(angle)*self.topAcceleration
	self.yAcceleration = -math.sin(angle)*self.topAcceleration

	--set the object's speed based on acceleration or speed and proximity to target
	if self.x - self.xTarget > 5.1 or self.x - self.xTarget < -5.1 then	--the point the object stops on isn't exact because of a number of factors. This allows some wiggle room in the final position.
		self.xSpeed = self.xSpeed + dt*self.xAcceleration
	elseif self.xSpeed < 0.35 and self.xSpeed > -0.35 and self.x - self.xTarget < 55 and self.x - self.xTarget > -55 then
		self.xSpeed = 0
	else
		self.xSpeed = self.xSpeed + dt*self.xAcceleration
	end

	--same as code above, just for the y axis this time
	if self.y - self.yTarget > 5.1 or self.y - self.yTarget < -5.1 then 
			self.ySpeed = self.ySpeed + dt*self.yAcceleration
	elseif self.ySpeed < 0.35 and self.ySpeed > -0.35 and self.y - self.yTarget < 55 and self.y - self.yTarget > -55 then
		self.ySpeed = 0
	else
		self.ySpeed = self.ySpeed + dt*self.yAcceleration
	end

	--update position
	self.x = self.x+(self.xSpeed*dt)

	self.y = self.y+(self.ySpeed*dt)

end

function object:moveTo(xTar, yTar)
	self.xTarget = xTar
	self.yTarget = yTar
end
