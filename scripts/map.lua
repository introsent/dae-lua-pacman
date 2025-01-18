local resourcePath = "resources/map.bmp"

package.path = "./scripts/?.lua;"..package.path

local Pellet = require("pellet")

local TILE_SIZE = 16  -- Size of each tile in the sprite sheet

local OFFSET_X = 8
local OFFSET_Y = 48

local MAP_TILE_SET = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2},
        {2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        {1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}
    

-- Define the Map class
Map = {}
Map.__index = Map

function Map:new(posX, posY)
    print("Initializing Map... begin")
    local obj = setmetatable({}, self)

    obj.pellets = self:InstatiatePellets()


    obj.texture = self:LoadBMPTexture()
    obj.posX = posX or 0
    obj.posY = posY or 0
    print("Initializing Map... end")
    return obj
end

-- Load Map textrue
function Map:LoadBMPTexture()
    print("Load BMP... begin")
	local texture = Bitmap.new(resourcePath, true)
    print("Load BMP... end")
	texture:SetTransparencyColor(GameEngine:MakeRGB(0, 0, 0))
	return texture
end


function Map:InstatiatePellets()
    local pellets = {}
    for y, row in ipairs(MAP_TILE_SET) do
        if (y >= #MAP_TILE_SET)  then
            print("Number of pellets: " .. #pellets)
            return pellets
        end
        for x, tile in ipairs(row) do
            if (x >= #MAP_TILE_SET[1]) then
                print("Number of pellets: " .. #pellets)
                break 
            end    
            if (MAP_TILE_SET[y][x] == 0 and MAP_TILE_SET[y][x+1] == 0 and MAP_TILE_SET[y+1][x] == 0 and MAP_TILE_SET[y+1][x+1] == 0) then
                local pellet = Pellet:new(OFFSET_X + x * TILE_SIZE, OFFSET_Y + y * TILE_SIZE)
                   
                table.insert(pellets, pellet)

            
            end
        end
    end
    return pellets
end

function Map:GetMapTilesSet()
    return MAP_TILE_SET
end

-- Paint Map
function Map:Paint()
    GameEngine:DrawBitmap(self.texture, self.posX, self.posY)

    for _, pellet in ipairs(self.pellets) do
        print("Paint pellet")
        pellet:Paint()  -- Call the pellet function on each Pellet instance
    end
end

function Map:CheckCollision(x, y)
    -- Convert Pac-Man's world position to map grid position
    local tileX = math.floor((x - OFFSET_X) / TILE_SIZE) + 1
    local tileY = math.floor((y - OFFSET_Y) / TILE_SIZE) + 1

    -- Check if the tiles are within bounds
    if tileX < 1 or tileY < 1 or tileX + 1 > #MAP_TILE_SET[1] or tileY + 1 > #MAP_TILE_SET then
        return false  -- Out of bounds, no collision
    end

    -- Check if any of the 4 tiles in the 2x2 space are walls
    if MAP_TILE_SET[tileY][tileX] == 1 or 
       MAP_TILE_SET[tileY][tileX + 1] == 1 or 
       MAP_TILE_SET[tileY + 1][tileX] == 1 or 
       MAP_TILE_SET[tileY + 1][tileX + 1] == 1 then
        return true  -- Collision with a wall
    end

    return false  -- No collision
end

-- Return the Map class for require
return Map

