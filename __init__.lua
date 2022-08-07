streakuav = game:getdvarint( "scr_killstreak_kills_uav")
streakairstrike = game:getdvarint( "scr_killstreak_kills_airstrike")
streakheli = game:getdvarint( "scr_killstreak_kills_heli")

function player_connected(player)

    player:onnotify("spawned_player", function()  
        
        player.currentstreak = 0
                
    end)
    player:onnotifyonce("spawned_player", function()
        player.valuecapture = player.pers["captures"] 
        local monitorCapture = game:oninterval(function() 
            if(player.valuecapture ~= player.pers["captures"]) then
                game:scriptcall("maps/mp/gametypes/_damage","incrementkillstreak", player ) -- Notify add 1 killstreak
                player.valuecapture = player.pers["captures"] 
            end
        end, 1000)
    
        monitorCapture:endon(player, "disconnect")
        monitorCapture:endon(level, "game_ended")
    end)

    player:onnotify("got_killstreak", function() player:monitorkillerplayer() end) -- Check cycle killstreak  
    
end

function entity:monitorkillerplayer()
    if self.pers["cur_kill_streak"] > streakheli then
        self.currentstreak = self.currentstreak + 1
        
    end

    if self.currentstreak ==  streakuav and self.pers["cur_kill_streak"] > streakheli then
        self:scriptcall("maps/mp/gametypes/_hardpoints", "givehardpoint", "radar_mp", streakuav)
    end

    if self.currentstreak ==  streakairstrike and self.pers["cur_kill_streak"] > streakheli then
        self:scriptcall("maps/mp/gametypes/_hardpoints", "givehardpoint", "airstrike_mp", streakairstrike)
    end

    if self.currentstreak ==  streakheli and self.pers["cur_kill_streak"] > streakheli then
        self:scriptcall("maps/mp/gametypes/_hardpoints", "givehardpoint", "helicopter_mp", streakheli)
    end

    if self.currentstreak == streakheli then
        self.currentstreak = 0
    end

end

----------

level:onnotify("connected", player_connected)
