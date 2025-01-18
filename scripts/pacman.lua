local resourcePath = "resources/pacman.bmp"

local TILE_SIZE = 32  -- Size of each tile in the sprite sheet
local FRAME_COUNT = 2 -- Number of frames per direction
local ANIMATION_SPEED = 0.1 -- Time per frame (in seconds)


local OFFSET_X = 8
local OFFSET_Y = 48
-- Directions
local DIRECTION = {
    RIGHT = 0,
    LEFT = 1,
    UP = 2,
    DOWN = 3
}

-- Define the Pacman class
Pacman = {}
Pacman.__index = Pacman

function Pacman:new(posX, posY)
    local obj = setmetatable({}, self)

    --General
    obj.texture = self:LoadBMPTexture()
    obj.x = posX or 0
    obj.y = posY or 0
    obj.speed = 100
    obj.currentDirection = DIRECTION.RIGHT
    obj.desiredDirection = nil 

    obj.isColliding = false
    --Animations
    obj.currentFrame = 0
    obj.elapsedTime = 0

    return obj
end

-- Load Pacman textrue
function Pacman:LoadBMPTexture()
	local texture = Bitmap.new(resourcePath, true)
	texture:SetTransparencyColor(GameEngine:MakeRGB(0, 0, 0))
	return texture
end


-- Paint Pacman
function Pacman:Paint()
    local rect = self:GetTextureRect()
    GameEngine:DrawBitmap(self.texture, self.x, self.y, GameEngine:MakeRect(rect.x, rect.y, rect.x + rect.width, rect.y + rect.height))
end

-- Update Pacman
function Pacman:Tick(elapsedSec, map)
    -- Check if Pacman is aligned to the grid
    local isAlignedX = (self.x - OFFSET_X) % TILE_SIZE == 0
    local isAlignedY = (self.y - OFFSET_Y) % TILE_SIZE == 0

    -- If aligned and a desired direction exists, attempt to turn
    if self.desiredDirection and isAlignedX and isAlignedY then
        if self:CanMoveInDirection(self.desiredDirection, map) then
            self.currentDirection = self.desiredDirection
            self.desiredDirection = nil -- Clear queued direction
        end
    end

    -- Determine movement vector based on current direction
    local movement = {x = 0, y = 0}
    if self.currentDirection == DIRECTION.RIGHT then
        movement.x = self.speed
    elseif self.currentDirection == DIRECTION.LEFT then
        movement.x = -self.speed
    elseif self.currentDirection == DIRECTION.DOWN then
        movement.y = self.speed
    elseif self.currentDirection == DIRECTION.UP then
        movement.y = -self.speed
    end

    -- Compute new position (rounded for grid alignment)
    local newX = self.x + (movement.x > 0 and math.ceil(movement.x * elapsedSec) or math.floor(movement.x * elapsedSec))
    local newY = self.y + (movement.y > 0 and math.ceil(movement.y * elapsedSec) or math.floor(movement.y * elapsedSec))

    -- Check for collision
    if self:CanMoveToPosition(newX, newY, map) then
        self.x = newX
        self.y = newY
        self.isColliding = false
        self:UpdateAnimation(elapsedSec)
    else
        self.isColliding = true
    end
end

-- Check if Pacman can turn in the desired direction
function Pacman:CanMoveInDirection(direction, map)
    local testX, testY = self.x, self.y

    if direction == DIRECTION.RIGHT then
        testX = testX + TILE_SIZE
    elseif direction == DIRECTION.LEFT then
        testX = testX - TILE_SIZE
    elseif direction == DIRECTION.DOWN then
        testY = testY + TILE_SIZE
    elseif direction == DIRECTION.UP then
        testY = testY - TILE_SIZE
    end

    return self:CanMoveToPosition(testX, testY, map)
end

-- Check if Pacman can move to the given position
function Pacman:CanMoveToPosition(x, y, map)
    local corners = {
        {x = x, y = y},                             -- Top-left corner
        {x = x + TILE_SIZE - 1, y = y},             -- Top-right corner
        {x = x, y = y + TILE_SIZE - 1},             -- Bottom-left corner
        {x = x + TILE_SIZE - 1, y = y + TILE_SIZE - 1} -- Bottom-right corner
    }

    for _, corner in ipairs(corners) do
        if map:CheckCollision(corner.x, corner.y) then
            return false
        end
    end

    return true -- No collision in the given position
end

function Pacman:KeyPressed(char)
    function Pacman:KeyPressed(char)
        if char == "D" then
            self.desiredDirection = DIRECTION.RIGHT
        elseif char == "A" then
            self.desiredDirection = DIRECTION.LEFT
        elseif char == "W" then
            self.desiredDirection = DIRECTION.UP
        elseif char == "S" then
            self.desiredDirection = DIRECTION.DOWN
        end
    end
end

-- Update animation of Pacman
function Pacman:UpdateAnimation(elapsedSec)
    -- Update the elapsed time
    self.elapsedTime = self.elapsedTime + elapsedSec

    -- Check if it's time to switch to the next frame
    if self.elapsedTime > ANIMATION_SPEED then
        self.currentFrame = (self.currentFrame + 1) % FRAME_COUNT
        self.elapsedTime = 0 -- Reset elapsed time
    end
end

-- Get RECT to render
function Pacman:GetTextureRect()
    local row = self.currentDirection -- Row is based on direction
    local column = self.currentFrame  -- Column is based on current frame

    -- Calculate the rectangle
    local x = column * TILE_SIZE
    local y = row * TILE_SIZE

    return {x = x, y = y, width = TILE_SIZE, height = TILE_SIZE}
end

function Pacman:CheckCollision(map)
    local didtHit = map:CheckCollision(self.x, self.y, self.currentDirection, DIRECTION)
    if didtHit then
        self.isColliding = true
    else
        self.isColliding = false
    end
end

-- Return the Pacman class for require
return Pacman


