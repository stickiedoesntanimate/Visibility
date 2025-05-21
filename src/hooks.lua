---
--- Created by gunnablescum.
--- DateTime: 21.05.25 20:45
---
local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.visibility_rate = 10
    return ret
end
