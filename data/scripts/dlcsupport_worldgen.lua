MAIN_GAME = 0
REIGN_OF_GIANTS = 1

NO_DLC_TABLE = {REIGN_OF_GIANTS=false}
ALL_DLC_TABLE = {REIGN_OF_GIANTS=true}
DLC_LIST = {REIGN_OF_GIANTS}

local __DLCEnabledTable = {}

function IsDLCEnabled(index)
    return __DLCEnabledTable[i] or false
end

function SetDLCEnabled(tbl)
	tbl = tbl or {}
	__DLCEnabledTable = tbl
end
