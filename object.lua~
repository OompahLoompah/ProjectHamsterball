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
local playable = false

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

	if self.xSpeed > 0 or self.xSpeed < 0 then
		self.x = self.x+(self.xSpeed*dt)
	end

	if self.ySpeed > 0 or self.ySpeed < 0 then
		self.y = self.y+(self.ySpeed*dt)
	end

	if self.y > 1080 and self.ySpeed > 0 then
		self.ySpeed = -self.ySpeed
	end

	if self.y < 0 and self.ySpeed < 0 then
		self.ySpeed = -self.ySpeed
	end

	if self.x > 1920 and self.xSpeed > 0 then
		self.xSpeed = -self.xSpeed
	end

	if self.x < 0 and self.xSpeed < 0 then
		self.xSpeed = -self.xSpeed
	end
	
	if self.xTarget - self.x > 5 or self.xTarget - self.x < -5 then
		self.xSpeed = self.xSpeed + ((self.xTarget - self.x)*dt*self.topAcceleration)/(self.xTarget+self.yTarget)
	end

	if self.yTarget - self.y > 5 or self.yTarget - self.y < -5 then
		self.ySpeed = self.ySpeed + ((self.yTarget - self.y)*dt*self.topAcceleration)/(self.xTarget+self.yTarget)
	end
	

end

function object:moveTo(xTar, yTar)
	self.xTarget = xTar
	self.yTarget = yTar
end
