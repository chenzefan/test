
--this is shared between the inventory bar and containers. Yay duck typing!
function HandleContainerUIClick(character, inventory, container, slot_number)


    local container_item = container:GetItemInSlot(slot_number)
    local active_item = inventory:GetActiveItem()
    
	local inspect_mod = TheInput:IsKeyDown(KEY_SHIFT)
    local stack_mod = TheInput:IsKeyDown(KEY_CTRL)

	if inspect_mod and container_item then
        character.components.locomotor:PushAction(BufferedAction(character, container_item, ACTIONS.LOOKAT), true)
		return
    end
	
	local can_take_active_item = active_item and (not container.CanTakeItemInSlot or container:CanTakeItemInSlot(active_item, slot_number))
	
 
	if active_item and not container_item then
		
		if can_take_active_item then

			if active_item.components.stackable and active_item.components.stackable:StackSize() > 1 and (stack_mod or not container.acceptsstacks) then
				container:GiveItem( active_item.components.stackable:Get(), slot_number)
			else
				inventory:RemoveItem(active_item, true)
				container:GiveItem(active_item, slot_number)
			end
			
			character.SoundEmitter:PlaySound("dontstarve/HUD/click_object")    
			
		else
			character.SoundEmitter:PlaySound("dontstarve/HUD/click_negative")
		end
		
	elseif container_item and not active_item then
		
		if stack_mod and container_item.components.stackable and container_item.components.stackable:StackSize() > 1 then
			
			inventory:GiveActiveItem( container_item.components.stackable:Get(math.floor(container_item.components.stackable:StackSize() / 2)))
		else
			container:RemoveItemBySlot(slot_number)
			inventory:GiveActiveItem(container_item)
		end

		character.SoundEmitter:PlaySound("dontstarve/HUD/click_object")    
		
	elseif container_item and active_item then
		if can_take_active_item then
			local same_prefab = container_item and active_item and container_item.prefab == active_item.prefab
			local stacked = same_prefab and container_item.components.stackable and container.acceptsstacks
			
			if stacked then

				if stack_mod and active_item.components.stackable.stacksize > 1 and not container_item.components.stackable:IsFull() then
					
					
					active_item.components.stackable:SetStackSize(active_item.components.stackable.stacksize - 1)
					container_item.components.stackable:SetStackSize(container_item.components.stackable.stacksize + 1)
					
					if active_item.components.perishable then
						container_item.components.perishable:Dilute(1, container_item.components.perishable.perishremainingtime)
					end
					
					
				else
					local leftovers = container_item.components.stackable:Put(active_item)
					inventory:SetActiveItem(leftovers)
				end
				
			else
				local cant_trade_stack = not container.acceptsstacks and (active_item.components.stackable and active_item.components.stackable:StackSize() > 1)
				
				if not cant_trade_stack then
					inventory:RemoveItem(active_item, true)
					container:RemoveItemBySlot(slot_number)
					inventory:GiveActiveItem(container_item)
					container:GiveItem(active_item, slot_number)
				end
			end
			
			character.SoundEmitter:PlaySound("dontstarve/HUD/click_object")    
			
		else
			character.SoundEmitter:PlaySound("dontstarve/HUD/click_negative")
		end
	end    
end
