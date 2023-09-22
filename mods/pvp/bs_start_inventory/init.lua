GiveToolsItems = {
	sword = "default:sword_steel",
	pistol = {weapon = "rangedweapons:glock17", ammo = "rangedweapons:9mm 90"}
}

bs.cbs.register_OnAssignTeam(function(player, team)
	if team ~= "" then
		if config.ClearPlayerInv.bool then
			Inv(player):set_list("main", {})
			if config.ClearPlayerInv.set_new_inventory_after_inventory_reset then
				if config.GiveDefaultTools.bool then
					if config.GiveDefaultTools.pistol then
						Inv(player):add_item("main", ItemStack(GiveToolsItems.pistol.weapon))
						Inv(player):add_item("main", ItemStack(GiveToolsItems.pistol.ammo))
					end
					if config.GiveDefaultTools.sword then
						Inv(player):add_item("main", ItemStack(GiveToolsItems.sword))
					end
				end
			end
		else
			if not config.ClearPlayerInv.maintain_last_inventory then
				if config.GiveDefaultTools.bool then
					if config.GiveDefaultTools.pistol then
						Inv(player):add_item("main", ItemStack(GiveToolsItems.pistol.weapon))
						Inv(player):add_item("main", ItemStack(GiveToolsItems.pistol.ammo))
					end
					if config.GiveDefaultTools.sword then
						Inv(player):add_item("main", ItemStack(GiveToolsItems.sword))
					end
				end
			end
		end
	end
end)