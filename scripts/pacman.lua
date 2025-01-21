local resourcePath = "resources/pacman.bmp"

local TILE_SIZE = 32  -- Size of each tile in the sprite sheet
local FRAME_COUNT = 2 -- Number of frames per direction
local ANIMATION_SPEED = 0.1 -- Time per frame (in seconds)

-- Directions
local DIRECTION = {
    RIGHT = {1, 0},
    LEFT = {-1, 0},
    UP = {0, -1},
    DOWN = {0, 1}
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
    obj.desiredDirection = DIRECTION.RIGHT
    --Animations
    obj.currentFrame = 0
    obj.elapsedTime = 0
    obj.score = 0

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
    GameEngine:DrawBitmap(self.texture, math.floor(self.x), math.floor(self.y), GameEngine:MakeRect(math.floor(rect.x), math.floor(rect.y), math.floor(rect.x + rect.width), math.floor(rect.y + rect.height)))
end

-- Update Pacman
function Pacman:Tick(elapsedSec, map)
    self:ScreenWrapping()
    -- Check intersection with pellet
    map:CheckIntersectionWithPellets(self)
    -- Check collision with desired direction
    if map:CheckCollision(self.x, self.y, self.desiredDirection[1], self.desiredDirection[2]) == 0 then
        self.currentDirection = self.desiredDirection
    end

    local cx, cy = self:GetCurrentDirectionComponents()
    --Check collision with current direction
    if map:CheckCollision(self.x, self.y, self.currentDirection[1], self.currentDirection[2]) == 0 then
        self.x = self.x +  cx * math.floor(self.speed * elapsedSec)
        self.y = self.y +  cy * math.floor(self.speed * elapsedSec)
        self:UpdateAnimation(elapsedSec)
    else
        self.x, self.y = map:SnapToTileBasedOnCurrentPosition(self.x, self.y)
    end
end



function Pacman:GetDesiredDirectionComponents()
    return self.desiredDirection[1], self.desiredDirection[2]
end

function Pacman:GetCurrentDirectionComponents()
    return self.currentDirection[1], self.currentDirection[2]
end

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

function Pacman:ScreenWrapping()
    if self.x > GameEngine:GetWidth() then
        self.x = -TILE_SIZE
    elseif self.x + TILE_SIZE < 0 then
        self.x = GameEngine:GetWidth()
    end
end

function Pacman:SnapToTile()
    self.x = math.floor((self.x) / TILE_SIZE) * TILE_SIZE 
    self.y = math.floor((self.y ) / TILE_SIZE) * TILE_SIZE
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
    local frame = 0
    if (self.currentDirection == DIRECTION.RIGHT) then
        frame = 0 
    elseif (self.currentDirection == DIRECTION.LEFT) then   
        frame = 1
    elseif (self.currentDirection == DIRECTION.UP) then   
        frame = 2
    elseif (self.currentDirection == DIRECTION.DOWN) then   
        frame = 3
    end

    local row = frame -- Row is based on direction
    local column = self.currentFrame  -- Column is based on current frame

    -- Calculate the rectangle
    local x = column * TILE_SIZE
    local y = row * TILE_SIZE

    return {x = x, y = y, width = TILE_SIZE, height = TILE_SIZE}
end

function Pacman:IncreaseScore(amount)
    self.score = self.score + amount
end

function Pacman:GetLocation()
    return self.x, self.y
end

-- Return the Pacman class for require
return Pacman


