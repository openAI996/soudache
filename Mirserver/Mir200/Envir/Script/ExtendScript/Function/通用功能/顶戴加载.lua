titleShow = {}

function titleShow.main(player)
    --local tb = {
    --    {0,1,2,3,4,5},
    --}
    --for i=1,#tb[1] do
    --    seticon(player, tb[1][i], -1)
    --end
    --
    --local title = lualib:GetVar(player,VarCfg["称号"])
    --
    --if title > 0 then
    --    seticon(player, 4, 1, titleUp.config[title].effect, -23,-30,1,0,0)
    --end
    ----VIP
    --local num = lualib:GetVar(player,VarCfg["赞助会员"])
    --if num > 0 then
    --    seticon(player, 5, 1, zanZhu.config[num].effect, 0,0,1,0,0)
    --end
    --if lualib:GetVar(player,VarCfg["一键毕业"]) == 1 then
    --    seticon(player, 1, 1, biye.config.basic.effect, 0,0,1,0,0)
    --end
    --local num = lualib:GetVar(player,VarCfg["魂环"])
    --if num > 0 then
    --    seticon(player, 2, 1, hunhuan.config[num].effect, -20,60,1,0,1)
    --    --playeffect(player,hunhuan.config[num].effect, 0, 0, 1,0,0)
    --end
    --if lualib:GetFlag(player,VarCfg["狂暴之力"]) == 1 then
    --    seticon(player, 1, 1,30044,0,0)
    --else
    --    seticon(player, 1, -1)
    --end




    --if lualib:GetFlag(player,VarCfg["冠名称号"]) == 1 then
    --    seticon(player, 2, 1,20217,0,0)
    --end

end

GameEvent.add(EventCfg.onTitleShow,titleShow.main,titleShow)
GameEvent.add(EventCfg.onLogin,titleShow.main,titleShow,4)

return titleShow
