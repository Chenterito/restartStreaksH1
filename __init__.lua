streakuav = game:getdvarint( "scr_killstreak_kills_uav")
streakairstrike = game:getdvarint( "scr_killstreak_kills_airstrike")
streakheli = game:getdvarint( "scr_killstreak_kills_heli")

function player_connected(player)

    player:onnotify("spawned_player", function()  
        
        player.currentstreak = 0
                
    end)

    player:onnotify("killed_enemy", function() player:monitorkillerplayer()

    end)       
    
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