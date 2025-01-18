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

-- Paint Pacman
function Map:Paint()
    GameEngine:DrawBitmap(self.texture, self.posX, self.posY)

    --print("Painting....")
    --print("Number of pellets: " .. #self.pellets)
    for _, pellet in ipairs(self.pellets) do
        print("Paint pellet")
        pellet:Paint()  -- Call the pellet function on each Pellet instance
    end
end

-- Return the Map class for require
return Map

