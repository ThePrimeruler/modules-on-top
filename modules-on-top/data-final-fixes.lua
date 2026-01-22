local mod_name = 'modules-on-top'
--Moves Modules To The Top Of The Crafting Tab

local do_debug = false
local function debug_log(message)
    if do_debug then
        log('[Debug]['..mod_name..']'..tostring(message))
    end
end

--- returns true if `the_list` contains `value`
---@param the_list any[]
---@param value any
---@return boolean
function list_contains(the_list,value)
    for _, list_item in ipairs(the_list) do
        if list_item == value then
            return true
        end
    end
    return false
end

local modules = data.raw["module"]

local subgroups_ids = {}

for k, module in pairs(modules) do
    local current_subgroup = module.subgroup
    if current_subgroup ~= nil and not list_contains(subgroups_ids, current_subgroup) then
        subgroups_ids[#subgroups_ids+1] = current_subgroup
    end
end


local start_sequence = '\t\t '

for i, subgroup_id in ipairs(subgroups_ids) do
    local subgroup = data.raw["item-subgroup"][subgroup_id]
    if subgroup ~= nil then
        local order = start_sequence .. (subgroup.order or ' ')
        subgroup.order = order
    end
end
