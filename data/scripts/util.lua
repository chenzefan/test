function DumpTableXML(t, name)
    name = name or ""
    function dumpinternal(t, outstr, indent)
        for key, value in pairs(t) do
            if type(value) == "table" then
                table.insert(outstr,indent.."<table name='"..tostring(key).."'>\n")
                dumpinternal(value, outstr, indent.."\t")
                table.insert(outstr, indent.."</table>\n")
            else
                table.insert(outstr, indent.."<"..type(value).." name='"..tostring(key).."' val='"..tostring(value).."'/>\n")
            end
        end
    end
    outstr = {"<table name='"..name.."'>\n"}
    dumpinternal(t, outstr, "\t")
    table.insert(outstr, "</table>")
    return table.concat(outstr)
end

function DebugSpawn(prefab)
    if TheSim and TheInput then
        TheSim:LoadPrefabs({prefab})
        local inst = SpawnPrefab(prefab)
        if inst then
	        inst.Transform:SetPosition(TheInput:GetMouseWorldPos():Get())
	    end
	end
end


function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

function table.contains(table, element)
  if table == nil then
        return false
  end
  
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- RemoveByValue only applies to array-type tables
function RemoveByValue(t, value)
    if t then
        for i,v in ipairs(t) do 
            if v == value then
                table.remove(t, i)
            end
        end
    end
end

function GetTableSize(table)
	local numItems = 0
	if table ~= nil then
		for k,v in pairs(table) do
		    numItems = numItems + 1
		end
	end
	return numItems
end

function GetRandomItem(choices)
 	local choice = math.random(GetTableSize(choices)) -1
 	
 	local picked = nil
 	for k,v in pairs(choices) do
 		picked = v
 		if choice<= 0 then
 			break
 		end
 		choice = choice -1
 	end
 	assert(picked~=nil)
	return picked
end

-- Made to work with (And return) array-style tables
function PickSome(num, choices)
	local l_choices = choices
	local ret = {}
	for i=1,num do
		local choice = math.random(#l_choices)
		table.insert(ret, l_choices[choice])
		table.remove(l_choices, choice)
	end
	return ret
end

function GetRandomKey(choices)
 	local choice = math.random(GetTableSize(choices)) -1
 	
 	local picked = nil
 	for k,v in pairs(choices) do
 		picked = k
 		if choice<= 0 then
 			break
 		end
 		choice = choice -1
 	end
 	assert(picked)
	return picked
end

function GetRandomWithVariance(baseval, randomval)
    return baseval + (math.random()*2*randomval - randomval)
end

function GetRandomMinMax(min, max)
    return min + math.random()*(max - min)
end

function distsq(v1, v2)
    local dx = (v1.x or v1[1]) - (v2.x or v2[1])
    local dy = (v1.y or v1[2]) - (v2.y or v2[2])
    local dz = (v1.z or v1[3]) - (v2.z or v2[3])
    return dx*dx+dy*dy+dz*dz
end

-- look in package loaders to find the file from the root directories
-- this will look first in the mods and then in the data directory
function resolvefilepath( filepath )
    for path in string.gmatch(package.path, "([^;]+)") do
        local filename = string.gsub(path, "scripts\\%?%.lua", filepath)
        filename = string.gsub(filename, "\\", "/")
        --print("looking for: "..filename.." ("..filepath..")")
        if not kleifileexists or kleifileexists(filename) then
            --print("found it! "..filename)
            return filename
        end
    end
    return nil
end

-------------------------MEMREPORT

local global_type_table = nil

local function type_name(o)
	if global_type_table == nil then
		global_type_table = {}
		for k,v in pairs(_G) do
			global_type_table[v] = k
		end
		global_type_table[0] = "table"
	end
	local mt = getmetatable(o)
	if mt then
		return global_type_table[mt] or "table"
	else
		return type(o) --"Unknown"
	end
end


local function count_all(f)
	local seen = {}
	local count_table
	count_table = function(t)
		if seen[t] then return end
		f(t)
		seen[t] = true
		for k,v in pairs(t) do
			if type(v) == "table" then
				count_table(v)
			else
				f(v)
            end
		end
	end
	count_table(_G)
end

function isnan(x) return x ~= x end
math.inf = 1/0 
function isinf(x) return x == math.inf or x == -math.inf end
function isbadnumber(x) return isinf(x) or isnan(x) end

local function type_count()
	local counts = {}
	local enumerate = function (o)
		local t = type_name(o)
		counts[t] = (counts[t] or 0) + 1
	end
	count_all(enumerate)
	return counts
end
   
function mem_report()
    local tmp = {}
    
    for k,v in pairs(type_count()) do 
        table.insert(tmp, {num=v, name=k})
    end
    table.sort(tmp, function(a,b) return a.num > b.num end)
    local tmp2 = {"MEM REPORT:\n"}
    for k,v in ipairs(tmp) do
        table.insert(tmp2, tostring(v.num).."\t"..tostring(v.name))
    end
    
    print (table.concat(tmp2,"\n"))
end

-------------------------MEMREPORT



function weighted_random_choice(choices)

    local function weighted_total(choices)
        local total = 0
        for choice, weight in pairs(choices) do
            total = total + weight
        end
        return total
    end

    local threshold = math.random(0, weighted_total(choices))
    local last_choice
    for choice, weight in pairs(choices) do
        threshold = threshold - weight
        if threshold <= 0 then return choice end
        last_choice = choice
    end
    return last_choice
end
 

 
 function PrintTable(tab)
    local str = {}
    
    local function internal(tab, str, indent)
        for k,v in pairs(tab) do
            if type(v) == "table" then
                table.insert(str, indent..tostring(k)..":\n")
                internal(v, str, indent..' ')
            else
                table.insert(str, indent..tostring(k)..": "..tostring(v).."\n")
            end
        end
    end
    
    internal(tab, str, '')
    return table.concat(str, '')
end


-- make environment
local env = {} -- add functions you know are safe here

-- run code under environment [Lua 5.1]
function RunInSandbox(untrusted_code)
  if untrusted_code:byte(1) == 27 then return nil, "binary bytecode prohibited" end
  local untrusted_function, message = loadstring(untrusted_code)
  if not untrusted_function then return nil, message end
  setfenv(untrusted_function, env)
  return pcall(untrusted_function)
end


function GetTickForTime(target_time) 
	return math.floor( target_time/GetTickTime() )
end

function shuffleArray(array)
    local arrayCount = #array
    for i = arrayCount, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end

function shuffledKeys(dict)
	local keys = {}
	for k,v in pairs(dict) do
		table.insert(keys, k)
	end
	return shuffleArray(keys)
end

function TrackedAssert(tracking_data, function_ptr, function_data)
	--print("TrackedAssert", tracking_data, function_ptr, function_data)
	_G['tracked_assert'] = function(pass, reason)		
							--print("Tracked:Assert", tracking_data, pass, reason)	 								
			 				assert(pass, tracking_data.." --> "..reason)
			 			end
			 							
	local result = function_ptr( function_data )
					
	_G['tracked_assert'] = _G.assert
	
	return result
end

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- if next(table) == nil, then it is empty
--
-- function IsTableEmpty(t)
-- 	local empty = true
-- 	for k,v in pairs(t) do
-- 		return false
-- 	end
-- 	return true	
-- end

function math.clamp(input, min_val, max_val)
    if input < min_val then
        input = min_val
    elseif input > max_val then
        input = max_val
    end
    return input
end
