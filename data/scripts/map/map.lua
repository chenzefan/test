require "class"


Map = Class(function(self, width, height, args)
	
	if args.nodes ~= nil then
		--print("Map() got nodes .. resetting extents")
		local extents = self:ResetExtents(args.nodes)
		width = math.floor(extents.xmax-extents.xmin+15)
		height = math.floor(extents.ymax-extents.ymin+15)
	end
	assert(width>0 and height>0, "Map: ".. width.." by "..height)
	
	--dumptable(genFunction.args)
	self.size = {width=width, height=height}
	self.width = width
	self.height = height

    -- Data
    self.map = self:GenValueMap()
    
    -- Once the data is converted it is stored as discrete tiles
    self.tiles = self:GenTiles(args.defaultTile)
    self.visited = self:GenVisited()
    
    if args.leaveBlank == nil or args.leaveBlank == false then
    	if args.genFunction then 
    		assert(args.genFunction.fn)
    		assert(type(args.genFunction.fn) == "function")
    		args.genFunction.fn(self, args.genFunction.args)
		end
    end

	--print(self:RenderToString())
    
end)

function Map:DrawDebug(draw)
	draw:Box(-self.width*2,-self.height*2,	self.width*TILE_SCALE,self.height*TILE_SCALE, 	255, 255, 255, 255)
end

function Map:GenValueMap(defaultValue)
	local map = {}

	if defaultValue == nil then
		defaultValue = 0
	end
	
	map[self.width] = {}
	for x = 1, self.width do
		map[x] = {}
		map[x][self.height] = {}
        for y = 1, self.height do
        	map[x][y] = defaultValue
        end
    end
    return map
end

function Map:GenVisited()
	local visited = {}
	visited[self.width] = {}
	for x = 1, self.width do
		visited[x] = {}
		visited[x][self.height] = {}
        for y = 1, self.height do
        	visited[x][y] = false
        end
    end
    return visited
end

function Map:GenTiles(defaultTile)
	if defaultTile == nil then
		defaultTile = GROUND.IMPASSABLE
	end
	local tiles = {}
	tiles[self.width] = {}
	for x = 1, self.width do
		tiles[x] = {}
		tiles[x][self.height] = {}
        for y = 1, self.height do
        	tiles[x][y] = defaultTile
        end
    end
    return tiles
end
function Map:SetValue(x,y, value)
	if not (x>=1 and y>=1 and x<=self.width and y<=self.height) then
		print("Map:SetValue assert!! ",x..","..y, value)
	end
	
	assert(x>=1 and y>=1 and x<=self.width and y<=self.height)
   	self.map[x][y] = value
end

function Map:SetPointValue(point, value)
	return self:SetValue(math.floor(point.x), math.floor(point.y), value)
end

function Map:SetTile(x,y, tile)
--	if not (x>=1 and y>=1 and x<=self.width and y<=self.height) then
--		print("Map:SetTile",x..","..y, tile)
--	end
	
	assert(x>=1 and y>=1 and x<=self.width and y<=self.height)
   	self.tiles[x][y] = tile
end

function Map:Set(point, tile)
	return self:SetTile(math.floor(point.x), math.floor(point.y), tile)
end

function Map:GetTile(x,y)
--	if not (x>=1 and y>=1 and x<=self.width and y<=self.height) then
--		print("Map:GetTile",x..","..y, tile)
--	end
	if x>=1 and y>=1 and x<=self.width and y<=self.height then
   		return self.tiles[x][y]
   	end
   	
   	-- we are outsde the map
   	return GROUND.IMPASSABLE
end

function Map:GetTiles(center, radius)
	local points = get_circle(center, radius)
	local tiles = {}
	for i,k in pairs(points) do
		local point = {x = math.floor(k.x), y = math.floor(k.y)}
		if point.x>=1 and point.y>=1 and point.x<=self.width and point.y<=self.height then
			local tile = self:GetTile(point.x, point.y)
			if tiles[tile] == nil then
				tiles[tile] = {}
			end
			table.insert(tiles[tile], point)
		end
	end
	return tiles
end

function Map:Get(point)
	return self:GetTile(math.floor(point.x), math.floor(point.y))
end

function Map:VisitTile(x,y)
--	if not (x>=1 and y>=1 and x<=self.width and y<=self.height) then
--		print("Map:VisitTile",x..","..y)
--	end
	assert(x>=1 and y>=1 and x<=self.width and y<=self.height)
   	self.visited[x][y] = true
end

function Map:VisitTilePoint(point)
	return self:VisitTile(point.x, point.y)
end

function Map:TileVisited(x,y)
--	if not (x>=1 and y>=1 and x<=self.width and y<=self.height) then
--		print("Map:TileVisited",x..","..y)
--	end
	assert(x>=1 and y>=1 and x<=self.width and y<=self.height)
   	return self.visited[x][y]
end

function Map:TileVisitedPoint(point)
	return self:TileVisited(point.x, point.y)
end

function Map:ResetVisited()
	for x = 1, self.width do
        for y = 1, self.height do
        	self.visited[x][y] = false
        end
    end
end

function Map:Replace(src_tile, dst_tile)
	for x = 1, self.width do
        for y = 1, self.height do
        	if self.tiles[x][y] == src_tile then
        		self.tiles[x][y] = dst_tile
        	end
        end
    end
end

function GeneratePerlinXY(x,y, map, args)
    map.map[x][y] = perlin(args.noise_scale*(x/args.sz)+args.offx, args.noise_scale*(y/args.sz)+args.offy, 0)
end

function GeneratePerlin(map, args)
	--print("GeneratePerlin:", args.noise_scale, args.sz, args.offx, args.offy)
 	for x = 1, map.width do
        for y = 1, map.height do
        	GeneratePerlinXY(x,y,map, args)
        end
    end
end

local function FloodFill (in_map, filltile, PassableFn, starting_point)
	assert(type(PassableFn) == "function", "PassableFn is not of type function")
	assert(PassableFn(in_map, starting_point), "Starting position ("..starting_point.x..","..starting_point.y..") not passable")

	local out_map = Map(in_map.width, in_map.height, {})
	
	--print ("FloodFill",in_map, out_map, map_width, map_height, filltile, PassableFn, starting_point)
	local queue = {starting_point}
	local temp = GROUND.ROAD -- use ROAD for now since there are no roads
	
	in_map:ResetVisited()
	
	while #queue > 0 do
		local p = queue[1]
		table.remove(queue, 1)
		--print("P:"..p.x..","..p.y)
		if not in_map:TileVisitedPoint(p) then
			in_map:VisitTilePoint(p)
			
			--print ("FloodFill p:",p.x, p.y, "tile:", Get(in_map, p), "road:", temp, "impass:", GROUND.IMPASSABLE)
			
			if PassableFn(in_map, p) then -- and Get(out_map, p) ~= temp then
				out_map:Set(p, temp)
				--print ("FloodFill sep:",p.x, p.y,  "tile:", Get(in_map, p), "road:", temp, "impass:", GROUND.IMPASSABLE)
				
				if p.x > 1 then
					table.insert(queue, {x=p.x-1, y=p.y})
				end
				if p.x < in_map.width then
					table.insert(queue, {x=p.x+1, y=p.y})
				end
				if p.y > 1 then 
					table.insert(queue, {x=p.x, y=p.y-1})
				end
				if p.y < in_map.height then
					table.insert(queue, {x=p.x, y=p.y+1})
				end
			end
		end
	end
	
	out_map:Replace(temp, filltile)
	in_map.map = out_map.map
end

function Map:FloodFill(filltile, PassableFn, starting_point)
	--print ("FloodFill" ,filltile, PassableFn, "Start: "..starting_point.x..","..starting_point.y)
	FloodFill(self, filltile, PassableFn, starting_point)
end

function Map:RunNoiseFunction(tileFunctions, type, x,y, noise)
	if tileFunctions and tileFunctions[type] then
		tileFunctions[type](self.width, self.height, x,y, noise)
	end
end


function Map:GenerateCaveTiles(tileFunctions)
	for x = 1, self.width do
        for y = 1, self.height do
            if x == 1 or y == 1 or y == self.height  or x == self.width  then
                self:SetTile(x,y, GROUND.IMPASSABLE)
            else
                local ground_type = nil
                
                --print("xy:",x,y,self.map[x][y])
                if type(self.map[x][y]) == "table" then
                	dumptable(self.map[x][y])
                end

                local noise = self.map[x][y]
                if noise <= GROUND_VALUES[GROUND.IMPASSABLE] then
                    ground_type = GROUND.IMPASSABLE
                elseif noise <= GROUND_VALUES[GROUND.ROAD] then
                    ground_type = GROUND.ROAD
                elseif noise <= GROUND_VALUES[GROUND.ROCKY] then
                    ground_type = GROUND.ROCKY
                elseif noise <= GROUND_VALUES[GROUND.DIRT] then
                    ground_type = GROUND.DIRT
                elseif noise <= GROUND_VALUES[GROUND.SAVANNA] then
                    ground_type = GROUND.SAVANNA
                elseif noise <= GROUND_VALUES[GROUND.GRASS] then                
                    ground_type = GROUND.GRASS
                elseif noise <= GROUND_VALUES[GROUND.FOREST] then                
                    ground_type = GROUND.FOREST
                else
                    ground_type = GROUND.MARSH
                end
                self:RunNoiseFunction(tileFunctions, ground_type, x, y, noise)
               
                self:SetTile(x, y, ground_type)
            end
        end
    end
end

local GROUND_STR=
{
    " ",
    "R",
    "O",
    "D",
	"S",
	"G",
	"F",
	"M",
}

function Map:RenderToString(trans)
	local out = "\n"
    for y = 1, self.height do
		for x = 1, self.width do
			if trans ~= nil then
				out = out..GROUND_STR[self.tiles[x][y]]
			else
        		out = out..self.tiles[x][y]
        	end
        end
        out = out.."\n"
        --print(out)
    end
    return out
end

function Map:RenderMapToString()
	local out = "\n"
    for y = 1, self.height do
		for x = 1, self.width do
			out = out..string.format("%.2f",self.map[x][y])
        end
        out = out.."\n"
    end
    return out
end

--function Map:RenderToMap(map)
--	assert(math.ceil(self.extents.xmax-self.extents.xmin) == self.width)
--	assert(math.ceil(self.extents.ymax-self.extents.ymin) == self.height)
--	
--	local w, h = map:GetSize()
--	assert(w == self.width)
--	assert(h == self.height) 
--	
--	for x = 1, self.width do
--        for y = 1, self.height do
--        	map:SetTile(x, y, self.tiles[x][y])
--        end
--    end
--end

function Map:DrawCircle(x, y, radius, isFilled, value)
	draw_circle(self, x, y, radius, isFilled, value)
end

function Map:DrawLine(x1, y1, x2, y2, value)
	draw_line(self, x1, y1, x2, y2, value) 
	--TheSim:RenderDebugLine(x1, y1, 10, x2, y2, 10)
end


function Map:UpdateExtents(node)
	if self.extents.xmin == nil or node.data.position.x-node.data.size<self.extents.xmin then
		self.extents.xmin = node.data.position.x-node.data.size
	end
	if self.extents.ymin == nil or node.data.position.y-node.data.size<self.extents.ymin then
		self.extents.ymin = node.data.position.y-node.data.size
	end
	if self.extents.xmax == nil or node.data.position.x+node.data.size>self.extents.xmax then
		self.extents.xmax = node.data.position.x+node.data.size
	end
	if self.extents.ymax == nil or node.data.position.y+node.data.size>self.extents.ymax then
		self.extents.ymax = node.data.position.y+node.data.size
	end
end

function Map:ResetExtents(nodes)
	self.extents = {xmin=nil,ymin=nil,xmax=nil,ymax=nil}	
	for k,node in pairs(nodes) do
		self:UpdateExtents(node)
	end
	
	return self.extents
end

function Map:FinalizeExtents()
	self.extents.xmin = self.extents.xmin - 10
	self.extents.ymin = self.extents.ymin - 10
	self.extents.xmax = self.extents.xmax + 10
	self.extents.ymax = self.extents.ymax + 10
	self.width = math.ceil(self.extents.xmax-self.extents.xmin)
	self.height = math.ceil(self.extents.ymax-self.extents.ymin)
	self.map = self:GenValueMap()
	self.tiles = self:GenTiles()
	self.visited = self:GenVisited()
	--print("Map:FinalizeExtents: "..self.width..","..self.height)
end	

function Map:GetStringEncode()
	--print("Map:GetStringEncode()") 
	local out = ""
    for y = 1, self.height do
    	local row = ""
		for x = 1, self.width do
			row = row..self.tiles[x][y]
        end
        out = out..row
    end
	--print("Map:GetStringEncode() complete") 
    return out
end

local OUTER_BLUR = 0.75
local INNER_BLUR = 0.88
local PARTICLE_ITERATIONS = 500
local PARTICLE_LENGTH = 5
local EDGE_BIAS  = 12

function blurEdges(noise_map, map_width, map_height)
	for ix = 0, map_width-1 do
		for iy = 0, map_height-1 do
			-- Multiply the outer edge and the second outer edge by some constants to ensure the world does not touch the edges.
			if ix == 0 or ix == map_width -1 or iy == 0 or iy == map_height -1 then
				noise_map[ix][iy] = noise_map[ix][iy]*OUTER_BLUR
			else 
				if ix == 1 or ix == map_width -2 or iy == 1 or iy == map_height -2 then
					noise_map[ix][iy] = noise_map[ix][iy]* INNER_BLUR
				end
			end					
		end
	end
	
	return noise_map
end

function getNeighborhood(inx, iny, map_width, map_height)
	local result = {}
	for a = 0, inx-1 do
		for b = 0, iny-1 do
			if a or b then
				if inx + a >= 0 and  inx + a < map_width and iny + b >= 0 and iny + b < map_height then
					table.insert(result , {x=inx + a, y=iny + b})				
				end					
			end
		end
	end
	for i = #result, 2, -1 do -- backwards
	    local r = math.random(i) -- select a random number between 1 and i
	    result[i], result[r] = result[r], result[i] -- swap the randomly selected item to position i
	end
	return result
end

function round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end
function normalize(tiles)
	local smallest = 1000000--	// A large value, INT_MAX would work well here.
	local largest = 0
			
	-- Find the largest and smallest tiles
	for ix = 0, map_width-1 do
        for iy = 0, map_height-1 do
			if tiles[ix][iy] > largest then
				largest = tiles[ix][iy]
			end
			if tiles[ix][iy] < smallest then
				smallest = tiles[ix][iy]
			end
		end
	end
			
	-- Normalize
	for ix = 0, map_width-1 do
        for iy = 0, map_height-1 do
			local percent = (tiles[ix][iy] - smallest) / (largest-smallest)
			tiles[ix][iy] = percent--round(percent * 4)
		end
	end
	
	return tiles
end
	
function RollingParticleMap(noise_map, centerBias, map_width, map_height)
	for iterations = 0, PARTICLE_ITERATIONS-1 do
		-- Start nearer the center
		if centerBias then
			sourceX = math.random( (map_width-(EDGE_BIAS*2)) + EDGE_BIAS)
			sourceY = math.random( (map_height-(EDGE_BIAS*2)) + EDGE_BIAS)
			-- Random starting location
		else
			sourceX = math.random( map_width - 1)
			sourceY = math.random( map_height - 1)
		end
					
		for length = 0, PARTICLE_LENGTH-1 do
			sourceX = sourceX + round(math.random() * 2 - 1)
			sourceY = sourceY + round(math.random() * 2 - 1)
										
			if sourceX < 1 or sourceX > map_width -2 or sourceY < 1 or sourceY > map_height - 2 then
				break
			end
					
			hood = getNeighborhood(sourceX, sourceY, map_width, map_height)
					
			for i = 1, #hood do
--				print ("i",i,hood[i])
--				print ("hood[i].x,hood[i].y",hood[i].x,hood[i].y)
				if noise_map[hood[i].x][hood[i].y] < noise_map[sourceX][sourceY] then
					sourceX = hood[i].x
					sourceY = hood[i].y
					break
				end
			end
						
			noise_map[sourceX][sourceY] = noise_map[sourceX][sourceY]+1				
		end
	end
			
	if centerBias then
		blurEdges(noise_map, map_width, map_height)
	end
	
	normalize(noise_map)
end
--[[
local function ApplyNoisemapFilter(noise_map, iterations, FilterFn)
	for iteration = 0, iterations-1 do
	end
end
--]]
