local money_tb = {
    {variable = VarCfg["每日充值"],1},   --日冲
    {variable = VarCfg["总充值"],1},   --日冲
    ----{moenyid = 31,1},
    --{moenyid = 28,1},
}

function recharge(player,gold,id,moneyid)
    if gold > 0 then
        if moneyid == 23 then
            lualib:SetVar(player,VarCfg["累计充值"],lualib:GetVar(player,VarCfg["累计充值"])+gold)
            for i = 1, #money_tb do
                if money_tb[i].variable ~= nil then
                    lualib:SetVar(player,money_tb[i].variable,lualib:GetVar(player,money_tb[i].variable)+gold*money_tb[i][1])
                end

                --if money_tb[i].moenyid ~= nil and moneyid ~= 12 then
                --    changemoney(player,money_tb[i].moenyid,"+",gold*money_tb[i][1],"充值",true)
                --end
            end

            if globalinfo(3) > 0 then
                lualib:SetVar(player,VarCfg["合区累充"],lualib:GetVar(player,VarCfg["合区累充"])+gold)
            end
        end
        --恭喜老板XXX成功充值【xx】元，祝老板龙年福如东海、财源广进、阖家欢乐、万事如意！
        --lualib:SendMsgEx(player,0,"★恭喜老板"..getconst(player,"<$USERNAME>").."成功充值【"..gold.."】元，祝老板龙年福如东海、财源广进、阖家欢乐、万事如意！")
        --lualib:SendMsgEx(player,0,"★恭喜老板"..getconst(player,"<$USERNAME>").."成功充值【"..gold.."】元，祝老板龙年福如东海、财源广进、阖家欢乐、万事如意！")
        GameEvent.push(EventCfg.onRecharge, player,gold,id,moneyid)
    end
    return ""
end