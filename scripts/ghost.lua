-- Define the Ghost class
Ghost = {}
Ghost.__index = Ghost

DIRECTION = {
    RIGHT = {1, 0},
    LEFT  = {-1, 0},
    UP    = {0, -1},
    DOWN  = {0, 1}
}

MODE = {
    CHASE = 0,
    SCATTER = 1,
    FIRGHTENED = 2,
    EATEN = 3
}

local FRAME_COUNT = 2

local ANIMATION_SPEED = 0.1

TILE_SIZE = 32

function Ghost:new(posX, posY)
    local obj = setmetatable({}, self)

    --General
    obj.textureBasicMods = self:LoadBMPTexture("resources/ghosts.bmp")
    obj.textureSpecialMods = self:LoadBMPTexture("resources/ghosts_special.bmp")

    obj.x = posX or 0
    obj.y = posY or 0

    obj.speed = 50
    obj.currentDirection = DIRECTION.UP

    obj.target = { 0, 0 }

    --Animations
    obj.currentFrame = 0
    obj.elapsedTime = 0
    obj.score = 0

    return obj
end

function Ghost:Tick(elapsedSec)
    self:UpdateAnimation(elapsedSec)
end

function Ghost:Paint()
    local rect = self:GetTextureRect()
    GameEngine:DrawBitmap(self.textureBasicMods, math.floor(self.x), math.floor(self.y), GameEngine:MakeRect(math.floor(rect.x), math.floor(rect.y), math.floor(rect.x + rect.width), math.floor(rect.y + rect.height)))
end

function Ghost:LoadBMPTexture(filename)
    local texture = Bitmap.new(filename, true)
	texture:SetTransparencyColor(GameEngine:MakeRGB(0, 0, 0))
	return texture
end

function Ghost:UpdateAnimation(elapsedSec)

    -- Update the elapsed time
    self.elapsedTime = self.elapsedTime + elapsedSec

    -- Check if it's time to switch to the next frame
    if self.elapsedTime > ANIMATION_SPEED then
        self.currentFrame = (self.currentFrame + 1) % FRAME_COUNT
        self.elapsedTime = 0
    end
end

-- Get RECT to render
function Ghost:GetTextureRect()
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

    local column = frame * 2 + self.currentFrame  -- Column is based on current frame

    -- Return a rectangle and the column value
    return {x = column * TILE_SIZE, y = 0, width = TILE_SIZE, height = TILE_SIZE}, column
end


return Ghost


