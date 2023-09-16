bs_match = {
	match_is_started = false,
	rounds = 5,
	current_rounds = 0,
	cbs = {
		SecondOnEndMatch = {},
		OnMatchStart = {},
		OnNewMatches = {},
		OnEndMatch = {}
	},
}

--
-- CORE
--

function bs_match.reset_rounds()
	bs_match.current_rounds = bs_match.rounds
end

function bs_match.finish_match(winner)
	if config.AnnouceWinner then
		annouce.winner(winner)
	end
	RunCallbacks(bs_match.cbs.OnEndMatch, winner)
	if bs_match.current_rounds - 1 >= 1 then
		bs_match.current_rounds = bs_match.current_rounds - 1
		bs_match.match_is_started = false
		for name in pairs(bs.team[winner].players) do
			bank.player_add_value(name, 50)
		end
		RunCallbacks(bs_match.cbs.SecondOnEndMatch)
	else
		bs_match.match_is_started = false
		maps.new_map()
		if config.ShowMenuToPlayerWhenEndedRounds.bool then
			for _, player in pairs(core.get_connected_players()) do
				bs.show_menu_and_expire(player)
				if config.ResetPlayerMoneyOnEndRounds then
					if bank.player[Name(player)].money then
						bank.player[Name(player)].money = 200 -- Reset his money
					end
				end
			end
		else
			config.ShowMenuToPlayerWhenEndedRounds.func() -- Call to the function if it are disabled.
		end
		RunCallbacks(bs_match.cbs.OnNewMatches)
		bs_match.reset_rounds()
	end
end

--
-- CALLBACKS
--

bs_match["register_SecondOnEndMatch"] = function(function_to_run) table.insert(bs_match.cbs.SecondOnEndMatch, function_to_run) end
bs_match["register_OnMatchStart"] = function(function_to_run) table.insert(bs_match.cbs.OnMatchStart, function_to_run) end
bs_match["register_OnNewMatches"] = function(function_to_run) table.insert(bs_match.cbs.SecondOnEndMatch, function_to_run) end
bs_match["register_OnEndMatch"] = function(function_to_run) table.insert(bs_match.cbs.OnEndMatch, function_to_run) end

--
-- FUNCTIONS CALL
--

core.register_on_mods_loaded(function()
	bs_match.reset_rounds()
	maps.new_map()
	bs_timer.reset()
end)
