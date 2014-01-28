camera = {}
camera.__index = camera

local camerax = 0
local cameray = 0
local target = nil
xCenter = love.graphics.getWidth()/2
yCenter = love.graphics.getHeight()/2
local locked = false


function camera.new()
	local self = setmetatable({}, camera)
	return self
end

function camera:lockCamera(targetObject)
	self.target = targetObject
	self.locked = true
end

function camera:unlock()
	self.target=nil
	self.locked = false
end

function camera:isLocked()
	return self.locked
end

function camera:update(dt)
	if self.target then
		local temp = self.target:getPosition()
		self.camerax = temp[1]
		self.cameray = temp[2]
	end  
end

function camera:draw()
	if not self.locked then
		local x, y = love.mouse.getPosition()
			if x <	20 then
				self.camerax = self.camerax - 5
			elseif x > 2*xCenter - 20 then
				self.camerax = 5 + self.camerax
			end
			if y < 20 then
				self.cameray = self.cameray - 5
			elseif y > 2*yCenter - 20 then
				self.cameray = 5 + self.cameray
			end
	end

	love.graphics.translate(xCenter - self.camerax, yCenter - self.cameray)
end

function camera:getPosition()
	return {self.camerax - xCenter, self.cameray - yCenter}
end
