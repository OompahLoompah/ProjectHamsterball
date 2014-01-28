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
local playable = false

function object.new(initImage, initX, initY, initXSpeed, initYSpeed, initPlayable)
  local self = setmetatable({}, object)
	self.image = initImage
	self.x = initX
	self.y = initY
	self.xSpeed = initXSpeed
	self.ySpeed = initYSpeed
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

	if self.y < 0 or self.y > 1080 then
		self.ySpeed = -self.ySpeed
	end

	if self.x < 0 or self.x > 1920 then
		self.xSpeed = -self.xSpeed
	end

end
