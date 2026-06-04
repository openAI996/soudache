
yatools = {}

local gmbox_tb = {
	{
		name = "变量操作",
		{
			pageName = "A全局STR变量",
			tip = {
				"字符型全局变量.重启服务器保存.500个(A0 - A499)",
				"使用方法:"
			},
			input = { { "变量名", "输入变量名A0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 1, --全局变量
		},
		{
			pageName = "G全局INT变量",
			tip = {
				"数字型全局变量.重启服务器保存.500个(G0 - G499)",
			},
			input = { { "变量名", "输入变量名G0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 1, --全局变量
		},
		{
			pageName = "I全局INT变量",
			tip = {
				"数字型全局变量.重启服务器不保存.100个(I0 - I99)",
			},
			input = { { "变量名", "输入变量名I0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 1, --全局变量
		},
		{
			pageName = "S个人STR变量",
			tip = {
				"字符型个人变量.下线不保存.100个(S0 - S99)",
			},
			input = { { "变量名", "输入变量名S0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "P个人STR变量",
			tip = {
				"数字型个人变量.仅在当前NPC有效.",
				"当Close对话时.所有P变量归零.100个(P0 - P99)",
			},
			input = { { "变量名", "输入变量名P0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, ---玩家变量
		},
		{
			pageName = "D个人STR变量",
			tip = {
				"数字型个人变量.下线不保存.100个(D0 - D99)",
			},
			input = { { "变量名", "输入变量名D0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "N个人STR变量",
			tip = {
				"数字型个人变量.下线不保存.100个(N10 - N99)",
			},
			input = { { "变量名", "输入变量名N10", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "M个人STR变量",
			tip = {
				"数字型个人变量.下线不保存.100个(M0 - M99)",
				"切换地图清空（存放在SQL角色数据库）最大值21亿"
			},
			input = { { "变量名", "输入变量名M0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "U个人STR变量",
			tip = {
				"数字型个人变量.可保存.255个(U0 - U254)",
				"（存放在SQL角色数据库）最大值21亿"
			},
			input = { { "变量名", "输入变量名U0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "T个人STR变量",
			tip = {
				"字符型个人变量.可保存.255个(T0 - T254)",
				"（存放在SQL角色数据库）最大长度8000字符串以内"
			},
			input = { { "变量名", "输入变量名T0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "J个人INT天变量",
			tip = {
				"数字型个人变量.可保存.每晚自动12点重置500个(J0 - J499)",
				"合区或关停服务器请错开00:00点.（存放在SQL角色数据库）"
			},
			input = { { "变量名", "输入变量名J0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "Z个人STR变量",
			tip = {
				"字符型个人变量.可保存.每晚自动12点重置500个(Z0 - Z499)",
				"合区或关停服务器请错开00:00点.（存放在SQL角色数据库）"
			},
			input = { { "变量名", "输入变量名Z0", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "个人标记",
			tip = {
				"整数型个人变量可存储型,该变量只有0和1的两种状态",
			},
			input = { { "变量名", "输入标记名字0", inputType = 3 }, { "变量值", "输入变量值(初始化不填,0/1)", inputType = 3 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 3, --个人标记
		},
		{
			pageName = "自定义S变量",
			tip = {
				"扩展字符变量S",
			},
			input = { { "变量名", "输入变量名S$XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "自定义N变量",
			tip = {
				"扩展数字变量N",
			},
			input = { { "变量名", "输入变量名N$XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "名字", "输入玩家的名字", inputType = 0 } },
			type = 2, --玩家变量
		},
		{
			pageName = "个人自定义STR变量",
			tip = {
				"var string human 名字",
			},
			input = { { "变量名", "输入变量名XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入玩家的名字", inputType = 0 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 4, --自定义string变量
		},
		{
			pageName = "个人自定义INT变量",
			tip = {
				"var integer human 名字",
			},
			input = { { "变量名", "输入变量名XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "名字", "输入玩家的名字", inputType = 0 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 4, --自定义integer变量
		},
		{
			pageName = "自定义全局STR变量",
			tip = {
				"var string guild 名字",
			},
			input = { { "变量名", "输入变量名XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 5, --全局string变量
		},
		{
			pageName = "自定义全局INT变量",
			tip = {
				"var integer guild 名字",
			},
			input = { { "变量名", "输入变量名XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 3 }, { "保存", "是否保存数据库（0/1）", inputType = 0 } },
			type = 5, --全局integer变量
		},
		{
			pageName = "行会自定义变量",
			tip = {
				"字符型个人变量.下线不保存.100个(S0 - S99)",
			},
			input = { { "变量名", "输入变量名XXX", inputType = 0 }, { "变量值", "输入变量值(初始化不填)", inputType = 0 }, { "名字", "输入行会名字", inputType = 0 }, { "保存", "是否保存数据库（0/1）", inputType = 3 } },
			type = 6, --行会自定义变量
		},
	},
	{
		name = "货币操作",
		{
			pageName = "其他货币操作",
			tip = {
				"输入其他变量的ID,进行加减操作！",
			},
			input = { { "玩家名字", "输入玩家名字", inputType = 0 }, { "货币数量", "0", inputType = 3 }, { "货币数量", "直接设置货币数量", inputType = 3 }, { "货币ID", "输入需要操作的货币名字", inputType = 3 } },
		},
	},
	{
		name = "实用操作",
		{
			pageName = "角色操作",
			show = { --type:1=输入框，2=复选框  --info = 人物相关信息nID --inputType:输入框类型 0任何，3数字绝对值，--check：那个复选框选中 --read:0输入框不可输入，1输入框可输入
				{ "名字", "", type = 1, info = 1, inputType = 0, read = 1 }, { "等级", "", type = 1, info = 6, inputType = 3, read = 1 },
				{ "性别", { "男", "女", check = 1 }, type = 2, info = 8, inputType = 3, read = 1 }, { "转生", "0", type = 1, info = 39, inputType = 3, read = 1 },
				{ "职业", { "道", "战", "法", check = 1 }, type = 2, info = 7, inputType = 3, read = 1 }, { "生命", "", type = 1, info = 9, inputType = 3, read = 0 },
				{ "魔法", "0", type = 1, info = 11, inputType = 3, read = 0 }, { "pk值", "0", type = 1, info = 46, inputType = 3, read = 1 },
				{ "行会", "0", type = 1, info = 36, inputType = 3, read = 0 }, { "管理", { "GM", check = 1 }, type = 2, read = 1, info = 0, inputType = 3 },
			},
			btn = { "清空背包", "清理地面", "清除技能", "打开仓库", "开背包", "仓库全开", "游戏小退","清理怪物" },
			special = {
				"制造", { inputType = 0, "输入刷的道具" }, { inputType = 3, "输入数量" }
			}
		},
		{
			pageName = "BUFF操作",
			tip = {
				"对buff进行增删查！",
			},
			input = { { "名字", "请输入玩家名字", inputType = 0 }, { "增加", "输入BUFFID", inputType = 3 }, { "删除", "输入buffID", inputType = 3 }, { "查询", "输入BUFFID", inputType = 3 } },
		},
		{
			pageName = "地图跳转",
		},
		{
			pageName = "称号操作",
			tip = {
				"对称号进行增删查操作！",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "设置", "称号名称", inputType = 0 }, { "删除", "称号名称", inputType = 0 }, { "查询", "称号名称", inputType = 0 } }
		},
		{
			pageName = "顶戴花翎",
			tip = {
				"对称号进行增删查操作！",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "位置", "位置(0-9)", inputType = 3 }, { "效果", "(0图片,1特效,-1删除)", inputType = 0 }, { "名字", "图片名或者特效ID", inputType = 0 } }
		},
		{
			pageName = "播放特效",
			tip = {
				"在人物身上播放特效，或是删除特效！",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "特效ID", "特效ID(只填为删除)", inputType = 3 }, { "次数", "播放次数(0为循环)", inputType = 3 }, { "模式", "0-前面 1-后面", inputType = 3 } }
		},
		{
			pageName = "杀死玩家",
			tip = {
				"类型(1为不显示凶手信息、",
				"2为不掉物品.不显示凶手信息、",
				"3为显示凶手信息为NPC、",
				"4为不掉物品.显示凶手信息为NPC)"
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "类型", "(上方有详情)", inputType = 3 } }
		},
		{
			pageName = "技能操作",
			tip = {
				"对技能进行删除或是添加(默认显示自己的)",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "技能ID", "技能ID", inputType = 3 }, { "等级", "技能等级", inputType = 3 } }
		},
		{
			pageName = "模拟充值",{[23] = {{id=23,100},{id=24,100},{id=27,1},{id=28,1}},[30]={{id=30,1}}},
			tip = {
				"输入充值金额,模拟充值",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "充值", "充值金额", inputType = 3 }, { "货币ID", "需要充值的货币ID", inputType = 3 }}
		}
	},
	{
		name = "道具操作",
		{
			pageName = "显示背包道具",
			tip = {
				"输入玩家名字获得玩家背包道具(默认显示自己的)！",
			},
			input = { "玩家名", "输入玩家名字", inputType = 0 },
			constant = { --装备唯一ID常量（暂时没有使用）
				"<$DRESSID>", "<$DRESSID>", "<$WEAPONID>", "<$WEAPONID>", "<$RIGHTHANDID>", "<$NECKLACEID>", "<$HELMETID>",
				"<$ARMRING_RID>","<$ARMRING_LID>","<$RING_RID>","<$RING_LID>","<$BUJUKID>","<$BELTID>","<$BOOTSID>","<$CHARMID>","<$HATID>",
				"<$DRUMID>","<$HORSEID>","<$SHIELDID>","<$FTOWELID>", "<$SARMRING_RID>","<$SRING_LID>","<$SRING_RID>","<$GODBLESSITEM12ID>",
				"<$SDRESSID>","<$SDRESSID>","<$SWEAPONID>","<$SWEAPONID>","<$SHATID>","<$SNECKLACEID>","<$SHELMETID>","<$SARMRING_LID>",
				"<$SRIGHTHANDID>","<$SBELTID>","<$SBOOTSID>","<$SCHARMID>","<$SHORSEID>","<$GODBLESSITEM4ID>","<$GODBLESSITEM5ID>",
				"<$SBUJUKID>","<$SDRUMID>","<$SSHIELDID>","<$SFTOWELID>","<$GODBLESSITEM1ID>","<$GODBLESSITEM2ID>","<$GODBLESSITEM3ID>",
				"<$GODBLESSITEM6ID>","<$GODBLESSITEM7ID>","<$GODBLESSITEM8ID>","<$GODBLESSITEM9ID>","<$GODBLESSITEM10ID>","<$GODBLESSITEM11ID>",
			},
			btn = {{"复制"},{"拿走"},{"删除"},{"全部删除"},{"json造道具"}}
		},
		{
			pageName = "游戏功能",
			btn = {{"强制攻城"},{"开启阵营对抗"},{"强制关闭阵营对抗"},{"刷新魔王"},{"测试拖拽"}}
		},
		{
			pageName = "测试奖励",
			--btn = {{"货币兑换","/lua/货币兑换","@main",""},{"冠名成就","/lua/冠名成就","@main",""},{"爵位捐献","/lua/爵位捐献","@main",""},{"冠名称号","/lua/冠名称号","@main",""}}
		},
		{
			pageName = "发送邮件",
			tip = {
				"附件内容：",
				"物品1#数量#绑定标记&物品2#数量#绑定标记，&分组，#分隔！",

			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "标题", "邮件标题", inputType = 0 }, { "内容", "邮件内容", inputType = 0 },{ "内容", "附件内容", inputType = 0 } }

		},
		{
			pageName = "添加属性",
			tip = {
				"3#属性名#属性值|3#属性名#属性值...",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "属性名字", "属性组名字", inputType = 0 }, { "属性", "属性内容", inputType = 0 },{ "删除属性", "属性名字", inputType = 0 } }
			--btn = {{"货币兑换","/lua/货币兑换","@main",""},{"冠名成就","/lua/冠名成就","@main",""},{"爵位捐献","/lua/爵位捐献","@main",""},{"冠名称号","/lua/冠名称号","@main",""}}
		},
		{
			pageName = "封号",
			tip = {
				"输入封号名字------------",
			},
		},
		{
			pageName = "补日充",
			tip = {
				"名字#分钟数",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "补分钟", "补日充时间", inputType = 0 }, { "是否周卡", "不填不是周卡（1/空）",inputType = 0 }, { "周卡奖励", "是否补周卡奖励（1/空）" ,inputType = 0 }}
			--btn = {{"货币兑换","/lua/货币兑换","@main",""},{"冠名成就","/lua/冠名成就","@main",""},{"爵位捐献","/lua/爵位捐献","@main",""},{"冠名称号","/lua/冠名称号","@main",""}}
		},
		{
			pageName = "查属性",
			tip = {
				"名字   属性ID",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "属性ID", "属性表中的ID", inputType = 0 }}
			--btn = {{"货币兑换","/lua/货币兑换","@main",""},{"冠名成就","/lua/冠名成就","@main",""},{"爵位捐献","/lua/爵位捐献","@main",""},{"冠名称号","/lua/冠名称号","@main",""}}
		},
		{
			pageName = "回收身上装备",
			tip = {
				"装备名字",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "装备名字", "装备名字", inputType = 0 }}
		},
		{
			pageName = "给装备",
			tip = {
				"装备名字",
			},
			input = { { "玩家名", "请输入玩家名字", inputType = 0 }, { "装备名字", "装备名字", inputType = 0 }, { "绑定规则", "绑定规则", inputType = 0 }}
		},
	},
	GM = {
		--["39086704"] = 1,
		["35689105"] = 1,
		--["35602811"] = 1,
		--["2890535"] = 1
	},
}
local sign = 1  --列表按钮的位置（默认点击列表按钮的第一格）
local page = 3  --大按钮的位置（默认点击第一个大按钮）
local flag = 1  --是否展示大按钮下面的按钮列表（默认展示列表按钮）
local guid = ""
playerName = ""
mapinfo = {}
function yatools.main(player)
	--initexcel(player)
	--初始化货币table
	local account = getconst(player,"<$USERACCOUNT>")
	lualib:dbg("account = " ..account)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end
	local name = lualib:Name(player)
	playerName = name
	lualib:SetVar(player,"S$名字",name)
	lualib:SetVar(player,"S$角色",player)
	guid = player
	initCurrencyTable(player,1)
	if #mapinfo == 0 then
		mapinfo = lualib:GetMapInfo(player)
	end
	--初始化界面
	say(player,yatools.updateLayout(player,page,sign,flag))
end

--初始化gmbox_tb
function initCurrencyTable(player,param1)
	if guid == "" or guid == nil then
		guid = player
	end

	lualib:SetVar(player,"N10",1)
	if tonumber(param1) == 1 then
		--自动读取excle中的数据并插入table中
		local yes = 1
		--货币操作
		for i=1,100 do
			if cfg_item_tb[i] == nil then
				break
			end

			if cfg_item_tb[i].StdMode ~= 41 then
				break
			end
			--货币写入对应table中
			local newTable = {}
			newTable.pageName = cfg_item_tb[i].Name
			newTable.tip = {"输入其他变量的ID,进行加减操作！"}
			newTable.input = {{"玩家名字","输入玩家名字",inputType=0},{"货币数量","0",inputType=1},{"货币数量","直接设置货币数量",inputType=3}}
			table.insert(gmbox_tb[2],newTable)
		end
		--print(serialize(gmbox_tb[2]))
	end

	--角色基础信息初始化
	for i = 1,(#gmbox_tb[3][1].show) do
		if gmbox_tb[3][1].show[i].type == 1 then
			local flag = getbaseinfo(guid,gmbox_tb[3][1].show[i].info)
			if flag == "" then
				flag = "无"
			end
			gmbox_tb[3][1].show[i][2] = flag
		else
			if gmbox_tb[3][1].show[i].info ~= 0 then
				gmbox_tb[3][1].show[i][2].check = getbaseinfo(guid,gmbox_tb[3][1].show[i].info)
			else
				--lualib:MsgBox(player,tostring(getgmlevel(guid)))
				if tonumber(getgmlevel(guid)) < 10 then
					gmbox_tb[3][1].show[i][2].check = 1
				else
					gmbox_tb[3][1].show[i][2].check = 0
				end
			end
		end
	end

	--背包道具
	local newTable = {}
	local item_tb = {}
		local itemCount = getbaseinfo(guid,34)
		for i = 0, (itemCount - 1) do
			local item =  getiteminfobyindex(guid, i)
			item_tb[i+1] = getiteminfo(guid,item,1)
		end
	gmbox_tb[4][1].item = item_tb
	gmbox_tb[4][1].input[2] = getbaseinfo(guid,1)
end

--最终界面展示
function flagchange(player,param1,param2)
	local param1 = tonumber(param1)
	local param2 = tonumber(param2)
	if param1 == page then
		if flag == 1 then
			flag = 0
		else
			flag = 1
		end
	else
		param2 = 1
		flag = 1
	end

	say(player,yatools.updateLayout(player,param1,param2,flag))
	return sign
end
--打开关闭按钮缩放
function signchange(player,param1,param2)
	say(player,yatools.updateLayout(player,param1,param2,flag))
	return
end
--界面界面更新
function yatools.updateLayout(player,param1,param2,param3)

	local idStr = ""
	page = tonumber(param1)     --页
	sign = tonumber(param2)     --标签
	flag = tonumber(param3)     --是否展开标签
	--lualib:MsgBox(player,page..":"..sign..":"..tostring(flag))
	local str = [[
<Img|x=203.0|y=58.0|width=680|height=500|show=0|esc=1|bg=1|img=gmbox/1900000610.png|loadDelay=0|move=1|reset=1>
<Button|x=831.0|y=56.0|nimg=gmbox/1900000533.png|link=@exit>
<Img|x=405.0|y=120.0|width=2|height=410|img=gmbox/s.png|show=0|move=0|reset=1>
<Text|x=305.0|y=77.0|size=18|color=69|text=GMBOX>
    ]]
	local x = 0
	local y = 0
	--左侧按钮列表
	for i=1,#gmbox_tb do
		--最外层按钮展示是否灰阶
		if page == i then
			str = str .. [[<Button|id=btn]]..i..[[|color=255|size=18|x=]]..x..[[|y=]]..y..[[|nimg=gmbox\bfshd0.png|text=]]..gmbox_tb[i].name..[[|link=@flagchange,]]..i..[[,]]..sign..[[>]]
			y = y + 45
			--是否展开按钮列表
			if flag == 1 then
				for j=1,#gmbox_tb[i] do
					--按钮列表是否灰阶
					if sign == j then
						str = str .. [[<Button|id=sign]]..j..[[|color=255|size=18|x=]]..x..[[|y=]]..(y+5)..[[|nimg=gmbox\1900012107.png|text=]]..gmbox_tb[i][j].pageName..[[|link=@signchange,]]..page..[[,]]..j..[[>]]
					else
						str = str .. [[<Button|id=sign]]..j..[[|color=255|size=18|x=]]..x..[[|y=]]..(y+5)..[[|nimg=gmbox\1900012107.png|grey=1|text=]]..gmbox_tb[i][j].pageName..[[|link=@signchange,]]..page..[[,]]..j..[[>]]
					end
					idStr = idStr .."sign"..j..","
					y = y + 35
				end
			end
		else
			str = str .. [[<Button|id=btn]]..i..[[|color=255|size=18|x=]]..x..[[|y=]]..y..[[|grey=1|nimg=gmbox\bfshd0.png|text=]]..gmbox_tb[i].name..[[|link=@flagchange,]]..i..[[,]]..sign..[[>]]
			y = y + 45
		end
		--容器下所有id列表
		if i == #gmbox_tb then
			idStr = idStr .."btn"..i..""
		else
			idStr = idStr .. "btn"..i..","
		end
	end
	--左侧列表容器
	str = str .. [[<ListView|x=219.0|children={1}|y=122.0|width=180|height=405|rotate=0|loadStep=1|reload=0|direction=1|margin=0>]]
	--左侧容器下的子容器（这样操作按钮点击后不会初始化到最上面）
	str = str ..[[<Layout|id=1|children={]]..idStr..[[}|x=0|width=180|height=]]..(y)..[[>]]
	--右侧内容
	if page == 1 or page == 2  or (page == 3 and (sign ~= 1 and sign ~= 3 and sign ~= 2)) or (page == 4 and (sign == 4 or sign == 5 or sign == 7 or sign == 8 or sign == 9 or sign == 10))  then
		--提示内容
		for i=1,#gmbox_tb[page][sign].tip do
			local x= 470
			local y = 160 + (i-1)*30
			str = str .. [[<Text|x=]]..x..[[|y=]]..y..[[|color=255|size=14|text=]]..gmbox_tb[page][sign].tip[i]..[[>]]
		end
		local submitId= ""
		local yes = 0
		--input输入框
		for i=1,#gmbox_tb[page][sign].input do
			local x = 540
			local y = 280 +(i-1)*50
			if #gmbox_tb[page][sign].input > 3 then
				y = 230 +(i-1)*50
			end
			if page == 2 then
				--货币输入框特殊处理
				str = str .. [[<Text|x=]]..(x-90)..[[|y=]]..(y+3)..[[|color=255|size=20|color=116|text=]]..gmbox_tb[page][sign].input[i][1]..[[>]]
				str = str .. [[<Img|x=]]..x..[[|y=]]..y..[[|width=200|img=gmbox/input.png|esc=0>]]
				if i == 2 then
					--第二个输入框改成显示货币数量
					str = str .. [[<Text|x=]]..(x+10)..[[|y=]]..(y+3)..[[|width=200|height=35|color=255|size=18|text=]]..gmbox_tb[page][sign].input[i][2]..[[>]]
				else
					yes = yes + 1
					str = str .. [[<Input|x=]]..x..[[|y=]]..y..[[|width=200|height=35|isChatInput=0|rotate=0|type=0|size=18|type=]]..gmbox_tb[page][sign].input[i].inputType..[[|inputid=]]..yes..[[|place=]]..gmbox_tb[page][sign].input[i][2]..[[|color=255|placecolor=250>]]

					if i == #gmbox_tb[page][sign].input then
						submitId = submitId .. yes .. ""
					else
						submitId = submitId .. yes .. ","
					end
				end
			else
				--其他输入框处理
				str = str .. [[<Text|x=]]..(x-70)..[[|y=]]..(y+8)..[[|color=255|size=16|color=116|text=]]..gmbox_tb[page][sign].input[i][1]..[[>]]
				str = str .. [[
                <Img|x=]]..x..[[|y=]]..y..[[|width=200|img=gmbox/input.png>
                <Input|x=]]..x..[[|y=]]..y..[[|width=200|height=35|isChatInput=1|rotate=0|type=0|size=18|type=]]..gmbox_tb[page][sign].input[i].inputType..[[|inputid=]]..i..[[|place=]]..gmbox_tb[page][sign].input[i][2]..[[|color=255|placecolor=250>]]
				if i == #gmbox_tb[page][sign].input then
					submitId = submitId .. i .. ""
				else
					submitId = submitId .. i .. ","
				end
			end
		end
		--确认/查询按钮
		if page == 3 and (sign ~= 1) then
			str = str .. [[<Button|color=255|size=18|x=560|y=450|nimg=gmbox\1900000612.png|submitInput=]]..submitId..[[|text=确定|link=@variableoperation,]]..sign..",1,"..page..[[>]]
		elseif page == 3 and sign == 8 then
			str = str .. [[<Button|color=255|size=18|x=470|y=450|nimg=gmbox\1900000612.png|submitInput=]]..submitId..[[|text=设置|link=@variableoperation,]]..sign..",1,"..page..[[>]]
			str = str .. [[<Button|color=255|size=18|x=630|y=450|nimg=gmbox\1900000612.png|submitInput=]]..submitId..[[|text=删除|link=@variableoperation,]]..sign..",2,"..page..[[>]]
		else
			str = str .. [[<Button|color=255|size=18|x=470|y=450|nimg=gmbox\1900000612.png|submitInput=]]..submitId..[[|text=设置|link=@variableoperation,]]..sign..",1,"..page..[[>]]
			str = str .. [[<Button|color=255|size=18|x=630|y=450|nimg=gmbox\1900000612.png|submitInput=]]..submitId..[[|text=查询|link=@variableoperation,]]..sign..",2,"..page..[[>]]
		end

	elseif page == 3 then
		if sign == 1 then
			for i=1,#gmbox_tb[page][sign].show do
				local x = 420 + ((i-1)%2)*200
				local y = 155 + math.floor((i-1)/2) * 50
				str = str .. [[<Text|x=]]..x..[[|y=]]..(y+5)..[[|color=255|size=18|text=]]..gmbox_tb[page][sign].show[i][1]..[[>]]
				if gmbox_tb[page][sign].show[i].type == 1 then
					--lualib:MsgBox(player,gmbox_tb[page][sign].show[i][2].."")
					str = str .. [[<Img|x=]]..(x+43)..[[|y=]]..(y+7)..[[|width=100|height=25|img=gmbox/input.png>]]
					str = str .. [[<Input|x=]]..(x+43)..[[|y=]]..(y+7)..[[|width=100|isChatInput=0|height=25|rotate=0|type=]]..gmbox_tb[page][sign].show[i].inputType..[[|size=18|inputid=]]..i..[[|place=]]..gmbox_tb[page][sign].show[i][2]..[[|color=255|placecolor=250>]]
					str = str .. [[<Button|color=255|size=18|x=]]..(x+140)..[[|y=]]..(y+8)..[[|nimg=gmbox\1900015210.png|submitInput=]]..i..[[|text=确定|link=@playerupdate,]]..i..[[,0,1>]]
				else
					x = x + 50
					for j = 1, #gmbox_tb[page][sign].show[i][2] do
						if gmbox_tb[page][sign].show[i][2][j] == "GM" then
							str = str .. [[<Text|x=]]..(x-10)..[[|y=]]..(y+5)..[[|color=180|size=18|text=]]..gmbox_tb[page][sign].show[i][2][j]..[[>]]
						else
							str = str .. [[<Text|x=]]..(x)..[[|y=]]..(y+5)..[[|color=180|size=18|text=]]..gmbox_tb[page][sign].show[i][2][j]..[[>]]
						end

						if (gmbox_tb[page][sign].show[i][2].check + 1) == j  then
							str = str ..[[<CheckBox|x=]]..(x+20)..[[|y=]]..y..[[|nimg=public/1900000550.png|pimg=public/1900000551.png|checkboxid=N]]..i..[[|default=1|link=@playerupdate,]]..i..","..j..[[,2>]]
						else
							str = str ..[[<CheckBox|x=]]..(x+20)..[[|y=]]..y..[[|nimg=public/1900000550.png|pimg=public/1900000551.png|checkboxid=N]]..i..[[|default=0|link=@playerupdate,]]..i..","..j..[[,2>]]
						end
						x = x + 50
					end
				end
			end
			--特殊处理
			local x = 430
			local y = 390
			str = str .. [[<Text|x=]]..(x-10)..[[|y=]]..(y+5)..[[|color=180|size=18|text=]]..gmbox_tb[page][sign].special[1]..[[>]]
			str = str .. [[<Img|x=]]..(x+40)..[[|y=]]..(y+7)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(x+40)..[[|y=]]..(y+7)..[[|width=130|height=25|isChatInput=0|rotate=0|type=]]..gmbox_tb[page][sign].special[2].inputType..[[|size=18|inputid=8|place=]]..gmbox_tb[page][sign].special[2][1]..[[|color=255|placecolor=250>]]
			str = str .. [[<Img|x=]]..(x+177)..[[|y=]]..(y+7)..[[|width=80|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(x+177)..[[|y=]]..(y+7)..[[|width=80|height=25|isChatInput=0|rotate=0|type=]]..gmbox_tb[page][sign].special[3].inputType..[[|size=18|inputid=9|place=]]..gmbox_tb[page][sign].special[3][1]..[[|color=255|placecolor=250>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(x+280)..[[|y=]]..(y+8)..[[|nimg=gmbox\1900015210.png|submitInput=8,9|text=确定|link=@playerupdate,0,0,4>]]

			local y = 390
			for i = 1, #gmbox_tb[page][sign].btn do
				local x = 430 + ((i-1)%4)*100
				if (i-1)%4 == 0 then
					y = y + 50
				end
				str = str .. [[<Button|color=255|size=18|x=]]..x..[[|y=]]..y..[[|nimg=gmbox\1900000679.png|text=]]..gmbox_tb[page][sign].btn[i]..[[|link=@playerupdate,]]..i..[[,0,3>]]
			end
		end
		if sign == 3 then
			str = str .. [[<Img|x=]]..(400+40)..[[|y=]]..(153+7)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(400+40)..[[|y=]]..(153+7)..[[|width=130|height=25|isChatInput=0|rotate=0|type=0|size=18|inputid=1|place=模糊输入地图ID|color=255|placecolor=250>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(400+280)..[[|y=]]..(153+8)..[[|nimg=gmbox\1900015210.png|submitInput=1|text=搜索|link=@ssmap>]]

			local data = mapinfo
			local ss = lualib:GetVar(player,"S$模糊搜索")
			if ss ~= "" then
				data = {}
				for i=1,#mapinfo do
					if string.find(mapinfo[i].n,ss) then
						data[#data+1] = mapinfo[i]
					end
				end
			end

			local itemIDStr = ""
			for i=1,#data do
				local x = 30
				local y = 0 + (i-1)*30
				str = str .. [[<Text|id=txt1]]..i..[[|x=]]..x..[[|y=]]..y..[[|size=18|text=]]..data[i].n..[[>]]
				str = str .. [[<Text|id=txt2]]..i..[[|x=]]..(x+150)..[[|y=]]..y..[[|color=255|size=18|text=]]..data[i].v..[[>]]
				str = str .. [[<Button|id=txt3]]..i..[[|color=255|size=18|x=]]..(x+300)..[[|y=]]..y..[[|nimg=gmbox\1900000679.png|text=传送|link=@mapinfo_go,]]..data[i].i..[[,0,5>]]
				str = str ..[[<Layout|id=layout]]..i..[[|children={]].."txt1"..i..",txt3"..i..",txt2"..i..[[}|x=0|width=430|height=]]..(30)..[[>]]
				itemIDStr = itemIDStr .."layout"..i..","
			end
			str = str .. [[<ListView|x=400|children={]]..itemIDStr..[[]}|y=200|width=430|height=320|loadCount=4|loadDelay=1|rotate=0|loadStep=1|direction=1|reload=0|margin=0|color=250>]]

		end

		if sign == 2 then
			str = str .. [[<Img|x=]]..(400+40)..[[|y=]]..(153+7)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(400+40)..[[|y=]]..(153+7)..[[|width=130|height=25|isChatInput=0|rotate=0|type=0|size=18|inputid=1|place=]]..lualib:GetVar(player,"S$名字")..[[|color=255|placecolor=250>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(400+280)..[[|y=]]..(153+8)..[[|nimg=gmbox\1900015210.png|submitInput=1|text=角色名|link=@buffoperation,1>]]

			str = str .. [[<Img|x=]]..(400+40)..[[|y=]]..(153+7+35)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(400+40)..[[|y=]]..(153+7+35)..[[|width=130|isChatInput=0|height=25|rotate=0|type=0|size=18|inputid=2|place=输入BuffID#时间|color=255|placecolor=250>]]

			str = str .. [[<Img|x=]]..(400+40+150)..[[|y=]]..(153+7+35)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(400+40+150)..[[|y=]]..(153+7+35)..[[|width=130|isChatInput=0|height=25|rotate=0|type=0|size=18|inputid=3|place=属性（"{[1]=1}"）|color=255|placecolor=250>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(400+280+60)..[[|y=]]..(153+8+35)..[[|nimg=gmbox\1900015210.png|submitInput=2,3|text=添加|link=@buffoperation,2>]]

			local data = getallbuffid(lualib:GetVar(player,"S$角色"))
			local itemIDStr = ""
			for i=1,#data do
				local x = 30
				local y = 0 + (i-1)*30
				local txt = data[i] .."------------".. getstdbuffinfo(data[i],1) ---.."    "..lualib:TimeFormat(getbuffinfo(player,data[i],2))
				str = str .. [[<Text|id=txt1]]..i..[[|x=]]..x..[[|y=]]..(y+3)..[[|size=18|text=]]..txt..[[>]]
				str = str .. [[<Button|id=txt3]]..i..[[|color=255|size=18|x=]]..(x+300)..[[|y=]]..y..[[|nimg=gmbox\1900000679.png|text=删除|link=@buffoperation,]]..data[i]..[[>]]
				if i == #data then
					itemIDStr = itemIDStr .."txt1"..i..",txt3"..i..",txt2"..i
				else
					itemIDStr = itemIDStr .. "txt1"..i..",txt3"..i..",txt2"..i..","
				end
			end

			str = str ..[[<Layout|id=2|children={]]..itemIDStr..[[}|x=0|width=430|color=10|height=]]..(math.floor(#data)*30)..[[>]]

			str = str .. [[<ListView|x=400|children={2}|y=240|width=430|height=250|rotate=0|loadStep=1|reload=0|direction=1|color=0|margin=0>]]
		end
	elseif page == 4 then
		if sign == 1 then
			--默认背包物品显示，默认显示自己的
			local itemIDStr = ""
			x = 400
			y = 100
			str = str .. [[<ListView|x=400|children={2}|y=260|width=430|height=265|rotate=0|loadStep=1|reload=0|direction=1|margin=0>]]

			for i = 1, #gmbox_tb[page][sign].item do
				x = (i-1)%6*70+7
				y = math.floor((i-1)/6)*65
				str = str .. [[<DBItemShow|x=]]..x..[[|y=]]..y..[[|id=item]]..i..[[|makeindex=]]..gmbox_tb[page][sign].item[i]..[[|bgtype=1|showtips=1|link=@itemupdate,3,]]..i..[[>]]

				if lualib:GetVar(player,"N10") == i then
					str = str .. [[<Img|x=]]..(2+x)..[[|y=]]..(4+y)..[[|width=60|id=flag|height=60|img=gmbox/1900000678_2.png>]]
				end

				if i == #gmbox_tb[page][sign].item then
					itemIDStr = itemIDStr .."item"..i..""
				else
					itemIDStr = itemIDStr .. "item"..i..","
				end
			end

			str = str ..[[<Layout|id=2|children={]]..itemIDStr..[[,flag}|x=410|width=430|height=]]..(math.floor((#gmbox_tb[page][sign].item-1)/6 + 1)*65)..[[>]]

			x = 450
			y = 150
			str = str .. [[<Text|x=]]..(x-20)..[[|y=]]..(y-28)..[[|color=160|size=18|text=]]..gmbox_tb[page][sign].tip[1]..[[>]]
			str = str .. [[<Text|x=]]..(x-20)..[[|y=]]..(y+8)..[[|color=180|size=18|text=]]..gmbox_tb[page][sign].input[1]..[[>]]
			str = str .. [[<Img|x=]]..(x+40)..[[|y=]]..(y+7)..[[|width=130|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(x+40)..[[|y=]]..(y+7)..[[|width=130|isChatInput=0|height=25|rotate=0|type=]]..gmbox_tb[page][sign].input.inputType..[[|size=18|inputid=1|place=]]..gmbox_tb[page][sign].input[2]..[[|color=255|placecolor=250>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(x+200)..[[|y=]]..(y+8)..[[|nimg=gmbox\1900015210.png|submitInput=1|text=背包|link=@itemupdate,1,0>]]
			str = str .. [[<Button|color=255|size=18|x=]]..(x+270)..[[|y=]]..(y+8)..[[|nimg=gmbox\1900015210.png|submitInput=1|text=身上|link=@itemupdate,2,0>]]

			for i = 1, (#gmbox_tb[page][sign].btn-1) do
				str = str .. [[<Button|x=]]..(x+(i-1)*86)..[[|y=]]..(y+40)..[[|nimg=public/1900000652.png|text=]]..gmbox_tb[page][sign].btn[i][1]..[[|link=@itemupdate,4,]]..i..[[>]]
			end

			str = str .. [[<Text|x=]]..(x-20)..[[|y=]]..(y+78)..[[|color=180|size=18|text=json>]]
			str = str .. [[<Img|x=]]..(x+40)..[[|y=]]..(y+77)..[[|width=200|height=25|img=gmbox/input.png>]]
			str = str .. [[<Input|x=]]..(x+40)..[[|y=]]..(y+77)..[[|width=200|isChatInput=0|height=25|rotate=0|type=]]..gmbox_tb[page][sign].input.inputType..[[|size=18|inputid=2|place=输入物品的json|color=255|placecolor=250>]]
			str = str .. [[<Button|x=]]..(x+250)..[[|y=]]..(y+77)..[[|nimg=public/1900000652.png|submitInput=2|text=物品json|link=@itemupdate,4,5>]]
		elseif sign == 2 then
			for i = 1, (#gmbox_tb[page][sign].btn) do
				x = 440 + ((i-1)%3)*130
				y = 160 + math.floor((i-1)/3)*50
				str = str .. [[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=public/1900000652.png|text=]]..gmbox_tb[page][sign].btn[i][1]..[[|link=@func,]]..i..[[>]]
			end
		elseif sign == 6 then
			x = 440
			y = 160
			str = str .. [[
            	<Button|x=]]..(x-20)..[[|y=]]..(y)..[[|width=210|height=38|size=18|nimg=public/1900000680_1.png|color=253|text=输入需要封号的名字|link=@@InputString49(请输入需要封禁的账号：)>
            ]]
		end
	end
	return str
end

function ssmap(player)
	local ss = getconst(player,"$NPCINPUT(1)")
	lualib:SetVar(player,"S$模糊搜索",ss)
	say(player,yatools.updateLayout(player,3,3,1))
end
--处理事务
function variableoperation(player,param1,param2,param3)
	local account = getconst(player,"<$USERACCOUNT>")
	---print("account = " ..account,page,param1)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end
	param1 = tonumber(param1)
	param2 = tonumber(param2)
	param3 = tonumber(param3)
	--其实参数1无需传值，直接全局变量获取，但是不想修改
	sign = tonumber(param1) --就是sign的值
	local check = tonumber(param2) --查询或是设置按钮
	page = tonumber(param3)
	if getgmlevel(player) < 10 then
		return ""
	end

	if page == 1 then
		--对第一格按钮下面的所有变量进行修改或展示
		local str = getconst(player,"$NPCINPUT(1)")  	--第一个输入框内容 一般为变量的名字
		local value = getconst(player,"<$NPCINPUT(2)>") --第二输入框内容 一般为变量值
		local database = 1								--是否存入数据库（0/1）
		local nameToguid = ""  							--名字获得guid
		local param3 = getconst(player,"<$NPCINPUT(3)>") --第三个输入框内容

		--是否保存数据库
		if  #gmbox_tb[page][param1].input < 4 and gmbox_tb[page][param1].input[3].inputType > 0 then
			if param3 ~= "" then
				database = tonumber(database)
			end
		elseif #gmbox_tb[page][param1].input == 4 then
			if getconst(player,"<$NPCINPUT(4)>") ~= "" then
				database = tonumber(getconst(player,"<$NPCINPUT(3)>"))
			end
		end

		--
		--if  #gmbox_tb[page][param1].input < 4 and gmbox_tb[page][param1].input[3].inputType == 0 then
			if param3 == "" then
				nameToguid = player
			else
				nameToguid = getplayerbyname(getconst(player,"<$NPCINPUT(3)>"))
				if nameToguid == nil then
					nameToguid = player
					lualib:MsgBox(player,"该角色不在线或是不存在！")
					return ""
				end
			end
		--end
		--print(serialize(nameToguid))
		--变量名是否为空

		if str == "" then
			lualib:MsgBox(player,"请填写变量名！")
			return
		end
		if param1 == 15 then
			str = "N$"..str
		elseif param1 == 14 then
			str = "S$"..str
		end
		if gmbox_tb[page][param1].type == 1 then  --全局变量
			--为1时设置,2时查询变量
			if param2 == 1 then
				--为""时候,初始化,不为空时进行设置
				if value == "" then
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setsysvar(str,0,1)
					else
						setsysvar(str,"",1)
					end

					lualib:MsgBox(player,"全局变量【"..str.."】变量已经初始化")
				else
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setsysvar(str,value,tonumber(database))
					else
						setsysvar(str,value,tostring(database))
					end
					local num = getsysvar(str)
					lualib:MsgBox(player,"全局变量【"..str.."】变量的值为:"..num)
				end
			else
				--查询变量值
				local num = getsysvar(str)
				lualib:MsgBox(player,"全局变量【"..str.."】变量的值为:"..num)
			end
		elseif gmbox_tb[page][param1].type == 2 then --玩家变量

			--同上
			if param2 == 1 then
				if value == "" then
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						lualib:SetVar(nameToguid,str,0)
					else
						lualib:SetVar(nameToguid,str,"")
					end

					lualib:MsgBox(player,"玩家【"..getconst(player,"<$NPCINPUT(3)>").."】的变量【"..str.."】已经初始化")
				else
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						lualib:SetVar(nameToguid,str,tonumber(value))
					else
						lualib:SetVar(nameToguid,str,tostring(value))
					end

					local num = lualib:GetVar(nameToguid,str)
					lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."】的变量【"..str.."】的值为:"..num)
				end
			else
				local num = lualib:GetVar(nameToguid,str)
				lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."】的变量【"..str.."】的值为:"..num)
			end
		elseif gmbox_tb[page][param1].type == 3 then --玩家标识

			if param2 == 1 then
				if value == "" then
					setflagstatus(nameToguid,str,0)
					lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."】的变量【"..str.."】已经初始化")
				else
					if tonumber(value)  > 1 then
						lualib:MsgBox(player,"只能填写（0/1）")
						return ""
					else
						setflagstatus(nameToguid,str,tonumber(value))
					end
					local num = getflagstatus(player,str)
					lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."的【"..str.."】标识的值为:"..num)
				end
			else
				local num = getflagstatus(nameToguid,str)
				lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."的【"..str.."】标识的值为:"..num)
			end
		elseif gmbox_tb[page][param1].type == 4 then   --玩家自定义变量
			--print(param2)
			if param2 == 1 then
				if gmbox_tb[page][param1].input[2].inputType > 0 then
					iniplayvar(nameToguid,"integer","HUMAN",str,database)
				else
					iniplayvar(nameToguid,"string","HUMAN",str,database)
				end

				if value == "" then
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setplayvar(nameToguid,"integer","HUMAN",str,0)
					else
						setplayvar(nameToguid,"string","HUMAN",str,"")
					end

					lualib:MsgBox(player,"玩家【"..getbaseinfo(nameToguid,1).."的【"..str.."】变量已经初始化")
				else
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setplayvar(nameToguid,"HUMAN",str,tonumber(value),database)
					else
						setplayvar(nameToguid,"HUMAN",str,tostring(value),database)
					end

					local num = getplayvar(player, str)
					lualib:MsgBox(player,"玩家自定义变量【"..getbaseinfo(nameToguid,1).."的【"..str.."】变量的值为:"..num)
				end
			else
				local num = getplayvar(player, str)
				lualib:MsgBox(player,"玩家自定义变量【"..getbaseinfo(nameToguid,1).."的"..str.."】变量的值为:"..num)
			end
		elseif gmbox_tb[page][param1].type == 5 then --自定义全局变量
			if param2 == 1 then
				if gmbox_tb[page][param1].input[2].inputType > 0 then
					inisysvar("integer",str)
				else
					inisysvar("string",str)
				end

				if value == "" then
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setsysvarex(str,0,database)
					else
						setsysvarex(str,"",database)
					end

					lualib:MsgBox(player,"全局自定义变量【"..str.."】已经初始化")
				else
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setsysvarex(str,tonumber(value),database)
					else
						setsysvarex(str,tostring(value),database)
					end

					local num = getsysvarex(str)
					lualib:MsgBox(player,"全局自定义变量【"..str.."】的值为:"..num)
				end
			else
				local num = getsysvarex(str)
				lualib:MsgBox(player,"【"..str.."】变量的值为:"..num)
			end
		elseif gmbox_tb[page][param1].type == 6 then   --自定义行会变量
			local guild = findguild(1,getconst(player,"<$NPCINPUT(3)>"))
			if guild == "" then
				lualib:MsgBox(player,"该行会不存在！")
				return ""
			end
			if gmbox_tb[page][param1].input[2].inputType > 0 then
				iniguildvar(guild,"integer",str)
			else
				iniguildvar(guild,"string",str)
			end

			if param2 == 1 then
				if value == "" then
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						iniguildvar(guild,"integer",str)
					else
						iniguildvar(guild,"string",str)
					end

					lualib:MsgBox(player,"行会自定义变量【"..str.."】已经初始化")
				else
					if gmbox_tb[page][param1].input[2].inputType > 0 then
						setguildvar(guild,str,tonumber(value),database)
					else
						setguildvar(guild,str,tostring(value),database)
					end

					local num = getsysvarex(str)
					lualib:MsgBox(player,"全局自定义变量【"..str.."】的值为:"..num)
				end
			else
				local num = getguildvar(guild,str)
				lualib:MsgBox(player,"行会【"..getconst(player,"<$NPCINPUT(3)>").."】的【"..str.."】自定义变量的值为:"..num)
			end
		end
	elseif page == 2 then 	--货币处理

		local name = getconst(player,"<$NPCINPUT(1)>")			--玩家名字
		local value = getconst(player,"<$NPCINPUT(2)>")			--设置货币的数量
		local nameToguid = ""									--名字获得guid
		local currencyID = cfg_item_tb[param1 - 1].ID 							--货币ID
		local currencyName = cfg_item_tb[param1 - 1].Name
		local param3 = ""										--自己输入的货币I D
		print("货币处理",name,value,currencyID)
		if name ~= "" and name ~= nil then
			nameToguid = getplayerbyname(name)
			if nameToguid == nil then
				nameToguid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end
		else
			nameToguid = player
			name = getbaseinfo(nameToguid,1)
		end

		--特殊处理自助查询变量
		if #gmbox_tb[page][param1].input == 4 then
			param3 = getconst(player,"<$NPCINPUT(3)>")
			currencyID = tonumber(param3)
			if param3 == "" or currencyID < 1 then
				lualib:MsgBox(player,"请输入货币ID或是正确的货币ID！！")
				return ""
			end
			--设置输入货币ID的提示变成变成货币名字
			gmbox_tb[page][param1].input[4][2] = gmbox_tb[page][currencyID+1].pageName
		end
		--货币查询和设置
		if param2 == 2 then
			local currency = querymoney(nameToguid,currencyID)
			gmbox_tb[page][param1].input[2][2] = currency   --input输入框（直接设置货币数量）提示变成货币的数量
			gmbox_tb[page][param1].input[1][2] = name       --input输入框（输入玩家名字）提示变成玩家的名字
			lualib:MsgBox(player,"【"..name.."】的货币【"..currencyName.."】为："..currency)
			--更新界面
			say(player,yatools.updateLayout(player,page,sign,flag))
			return ""
		else
			--清空和设置货币数量
			if value == "" then
				changemoney(nameToguid,currencyID,"=",0,"GM",true)
			else
				changemoney(nameToguid,currencyID,"+",tonumber(value),"GM",true)
			end
			release_print(currencyID,"+",tonumber(value))
			local currency = querymoney(nameToguid,currencyID)
			gmbox_tb[page][param1].input[2][2] = currency   --input输入框（直接设置货币数量）提示变成货币的数量
			gmbox_tb[page][param1].input[1][2] = name       --input输入框（输入玩家名字）提示变成玩家的名字
			lualib:MsgBox(player,"【"..name.."】的货币【"..currencyName.."】为："..currency)
			say(player,yatools.updateLayout(player,page,sign,flag))
			return ""
		end
	elseif page == 3 then
		local nameToguid = ""
		if sign ~= 3 then
			local name = getconst(player,"$NPCINPUT(1)")
			if name ~= "" and name ~= nil then
				nameToguid = getplayerbyname(name)
				if nameToguid == nil then
					nameToguid = player
					lualib:MsgBox(player,"该角色不在线或是不存在！")
					return ""
				end
			else
				nameToguid = player
				name = lualib:Name(player)
			end
		end

		if sign == 3 then
			--飞地图
			local mapName = getconst(player,"$NPCINPUT(1)")
			local mapX = getconst(player,"<$NPCINPUT(2)>")
			local mapY = getconst(player,"<$NPCINPUT(3)>")
			if mapName == "" then
				lualib:MsgBox(player,"请输入地图名字")
				return ""
			end
			--lualib:MsgBox(player,mapName..":"..param2)
			if mapX == "" or mapY == "" then
				map(player,mapName)
			else
				mapmove(player,mapName,mapX,mapY,5)
			end
		elseif sign == 2 then
			--buff操作
			local addBuffID = getconst(player,"<$NPCINPUT(2)>")
			local dleBuffID = getconst(player,"<$NPCINPUT(3)>")
			local queryBuffID = getconst(player,"<$NPCINPUT(4)>")

			if addBuffID == "" and dleBuffID == "" and queryBuffID == "" then
				lualib:MsgBox(player,"增加和删除和查询buffID至少需要填写一个")
				return ""
			end

			if addBuffID ~= "" then
				if not addbuff(nameToguid,tonumber(addBuffID),0,1,player,{}) then
					lualib:MsgBox(player,"添加buff"..addBuffID.."失败！！","","")
				else
					lualib:MsgBox(player,"添加buff"..addBuffID.."成功！！","","")
				end
			end

			if dleBuffID ~= "" then
				if hasbuff(nameToguid,tonumber(dleBuffID)) then
					delbuff(nameToguid,tonumber(dleBuffID))
					lualib:MsgBox(player,"删除buff"..dleBuffID.."成功！！","","")
				else
					lualib:MsgBox(player,"未拥有"..dleBuffID.."buff！！","","")
				end
			end

			if queryBuffID ~= "" then
				----lualib:dbg(lualib:Name(nameToguid))
				if not hasbuff(nameToguid,tonumber(queryBuffID)) then
					lualib:MsgBox(player,"你未拥有"..queryBuffID.."buff！！","","")
				else
					lualib:MsgBox(player,"你拥有"..queryBuffID.."buff！！","","")
				end
			end
		elseif sign == 4 then
			local input2 = getconst(player,"<$NPCINPUT(2)>")
			local input3 = getconst(player,"<$NPCINPUT(3)>")
			local input4 = getconst(player,"<$NPCINPUT(4)>")
			if input2 == "" and input3 == "" and input4 == "" then
				lualib:MsgBox(player,"增加和删除和查询buffID至少需要填写一个")
				return ""
			end
			if input2 ~= "" then
				if not lualib:AddTitle(nameToguid,input2,1) then
					lualib:MsgBox(player,"添加称号【"..input2.."】失败！！","","")
				else
					lualib:MsgBox(player,"添加称号【"..input2.."】成功！！","","")
				end
			end

			if input3 ~= "" then

				lualib:DelTitle(nameToguid,input3)
				lualib:MsgBox(player,"删除buff【"..input3.."】成功！！","","")

			end

			if input4 ~= "" then
				if not checktitle(nameToguid,input4) then
					lualib:MsgBox(player,"你未拥有【"..input4.."】buff！！","","")
				else
					lualib:MsgBox(player,"你拥有【"..input4.."】buff！！","","")
				end
			end
		elseif sign == 5 then
			local where  = getconst(player,"<$NPCINPUT(2)>")
			local effType = getconst(player,"<$NPCINPUT(3)>")
			local resName = getconst(player,"<$NPCINPUT(4)>")
			if where == "" or effType == "" or resName == "" then
				lualib:MsgBox(player,"所有位置全部需要填写")
				return ""
			end
			if effType == "-1" then
				seticon(nameToguid,tonumber(where),-1)
				return ""
			end
			seticon(nameToguid,tonumber(where),tonumber(effType),resName,0,0,1,0)
		elseif sign == 6 then
			local effID = getconst(player,"<$NPCINPUT(2)>")
			local num = getconst(player,"<$NPCINPUT(3)>")
			local behind = getconst(player,"<$NPCINPUT(4)>")
			if effID == ""  then
				lualib:MsgBox(player,"请填写特效id")
				return ""
			end
			if num == "" or behind == "" then
				clearplayeffect(nameToguid,effID)
				return ""
			end
			playeffect(nameToguid,effID,0,0,num,behind,0)
			return ""
		elseif sign == 7 then
			local killType = getconst(player,"<$NPCINPUT(2)>")
			if killType == "" then
				--humamhp(nameToguid,tonumber(1))
			end
		elseif sign == 8 then
			local skillID = getconst(player,"<$NPCINPUT(2)>")
			local num = getconst(player,"<$NPCINPUT(3)>")
			if skillID == "" then
				lualib:MsgBox(player,"请输入技能ID")
				return ""
			end
			if param2 == 1 then
				if num == "" then
					addskill(nameToguid,tonumber(skillID))
				else
					addskill(nameToguid,tonumber(skillID),tonumber(num))
				end
			else
				delskill(nameToguid,tonumber(skillID))
			end
		elseif sign == 9 then
			--充值补发
			local str = getconst(player,"$NPCINPUT(1)")  	--名字
			local money = tonumber(getconst(player,"<$NPCINPUT(2)>"))
			local moneyID =getconst(player,"<$NPCINPUT(3)>")
			if str ~= "" then
				nameToguid = getplayerbyname(str)
				if nameToguid == nil or nameToguid == "0" then
					nameToguid = player
					lualib:MsgBox(player,"该角色不在线或是不存在！")
					return ""
				end
			else
				nameToguid = player
			end

			if money == nil then
				lualib:MsgBox(player,"请输入金额！")
				return ""
			end

			if moneyID == "" then
				moneyID = 10
			end

			moneyID = tonumber(moneyID)

			lualib:dbg(lualib:Name(player).."给"..lualib:Name(nameToguid).."补发充值"..money,'充值ID',moneyID)
			for i=1,#gmbox_tb[page][sign][1][moneyID] do
				changemoney(nameToguid,gmbox_tb[page][sign][1][moneyID][i].id,"+",gmbox_tb[page][sign][1][moneyID][i][1]*money,"充值补发",true)
			end

			lualib:MsgBox(player,"充值补发成功！")
			recharge(nameToguid,money,0,moneyID)
		end
	elseif page == 4 then
		print(page,sign)
		--发送邮件
		if sign == 4 then
			local str = getconst(player,"$NPCINPUT(1)")  	--第一个输入框内容 一般为变量的名字
			local biaoti  = getconst(player,"<$NPCINPUT(2)>")
			local neirong = getconst(player,"<$NPCINPUT(3)>")
			local fujian = getconst(player,"<$NPCINPUT(4)>")
			if str == "" or biaoti == "" or neirong == "" or fujian == "" then
				lualib:MsgBox(player,"所有位置全部需要填写")
				return ""
			end

			sendmail("#"..str,1,biaoti,neirong,fujian)
			lualib:SendMsgEx(player,9,"发送成功！！！！")
		elseif sign == 5 then
			local name = getconst(player,"<$NPCINPUT(1)>")			--玩家名字
			local attrName = getconst(player,"<$NPCINPUT(2)>")			--属性组名字
			local attrValue = getconst(player,"<$NPCINPUT(3)>")			--属性值
			local delName = getconst(player,"<$NPCINPUT(4)>")			--需要删除的属性组名字
			guid = player
			if name ~= "" then
				guid = getplayerbyname(name)
				if guid == nil then
					guid = player
					lualib:MsgBox(player,"该角色不在线或是不存在！")
					return ""
				end
			end

			if attrName == "" then
				lualib:MsgBox(player,"请输入属性名！")
				return ""
			end

			if delName ~= "" then
				delattlist(player,delName)
			else
				if attrValue == "" then
					lualib:MsgBox(player,"请输入属性值！")
					return ""
				end

				lualib:AddAttrList(guid,attrName,"=",attrValue)
				lualib:SendMsgGetColor(player,9,"#22ff00|添加属性成功")
			end
		elseif sign == 7 then
			local name = getconst(player,"$NPCINPUT(1)")  	--名字
			local min = tonumber(getconst(player,"<$NPCINPUT(2)>"))
			local flag = tonumber(getconst(player,"<$NPCINPUT(3)>"))
			local receive = tonumber(getconst(player,"<$NPCINPUT(4)>"))
			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			local nameToguid = getplayerbyname(name)
			if nameToguid == nil or nameToguid == "0" then
				nameToguid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end

			if check == 2 then
				if lualib:HasBuff(nameToguid,30025) then
					local times = getbuffinfo(nameToguid,30025,2)
					lualib:MsgBox(player,"他拥有日享特权，剩余时间："..lualib:TimeFormat(times).."")
				else
					lualib:MsgBox(player,"他没有日享特权")
				end
			else
				local add = min*60
				if lualib:HasBuff(nameToguid,30025) then
					local times = getbuffinfo(nameToguid,30025,2)
					add = times + add
					lualib:DelBuff(nameToguid,30025)
				end

				lualib:AddBuff(nameToguid,30025,add,1)

				if lualib:CheckTitle(nameToguid,riChong.config.all.buff) then
					lualib:DelTitle(nameToguid,"日享特权")
				end

				lualib:AddTitle(nameToguid,"日享特权")
				changetitletime(nameToguid,"日享特权","+",add - 24*60*60)
				if flag == 1 then
					lualib:SetFlag(nameToguid,VarCfg["直购一周"],1)
				end

				if receive == 1 then
					lualib:SendMail(nameToguid,1,"直购一周奖励","直购一周奖励获取",riChong.config.all.mail)
				end
				lualib:MsgBox(player,"增加成功剩余时间："..lualib:TimeFormat(add).."")
			end
		elseif sign == 8 then
			local name = getconst(player,"$NPCINPUT(1)")  	--名字
			local ID = tonumber(getconst(player,"<$NPCINPUT(2)>"))

			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			if ID == "" or ID == nil then
				lualib:MsgBox(player,"请输入属性ID")
				return ""
			end

			local nameToguid = getplayerbyname(name)
			if nameToguid == nil or nameToguid == "0" then
				nameToguid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end

			lualib:SendMsgGetColor(player,9,"#22ff00|"..name.."属性"..ID.."是:"..lualib:Attr(nameToguid,ID))
		elseif sign == 9 then
			local name = getconst(player,"$NPCINPUT(1)")  	--名字
			local itemName = getconst(player,"<$NPCINPUT(2)>")
			print(name,itemName)
			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			if itemName == "" or itemName == nil then
				lualib:MsgBox(player,"请输入装备名字")
				return ""
			end

			local nameToguid = getplayerbyname(name)
			if nameToguid == nil or nameToguid == "0" then
				nameToguid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end

			local size = lualib:GetItemPos(nameToguid,itemName)
			delbodyitem(nameToguid,size,"脚本删除装备")
			lualib:MsgBox(player,name.."-"..itemName.."-回收成功")
		elseif sign == 10 then
			local name = getconst(player,"$NPCINPUT(1)")  	--名字
			local itemName = getconst(player,"<$NPCINPUT(2)>")
			local bind = tonumber(getconst(player,"<$NPCINPUT(3)>"))

			if name == "" or name == nil then
				lualib:MsgBox(player,"请输入名字")
				return ""
			end

			if itemName == "" or itemName == nil then
				lualib:MsgBox(player,"请输入装备名字")
				return ""
			end

			local nameToguid = getplayerbyname(name)
			if nameToguid == nil or nameToguid == "0" then
				nameToguid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end

			local size = lualib:GetItemPos(nameToguid,itemName)
			giveonitem(nameToguid,size,itemName,1,tonumber(bind),"脚本删除装备")
		end
	end
end

--角色操作中的复选框
function playerupdate(player,param1,param2,param3)
	if getgmlevel(player) < 10 then
		return ""
	end

	local account = getconst(player,"<$USERACCOUNT>")
	lualib:dbg("account = " ..account)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end

	param1 = tonumber(param1)
	param2 = tonumber(param2)
	param3 = tonumber(param3)
	if tonumber(param3) == 2 then
		if #gmbox_tb[page][sign].show == param1 then
			if tonumber(getgmlevel(guid)) > 0 then
				lualib:MsgBox(player,tostring(getgmlevel(guid)))
				setgmlevel(guid,0)
			else
				setgmlevel(guid,0)
			end
			recalcabilitys(guid)
			lualib:MsgBox(player,tostring(getgmlevel(guid)))
		else
			if not (gmbox_tb[page][sign].show[tonumber(param1)][2].check == tonumber(param2-1)) then
				gmbox_tb[page][sign].show[tonumber(param1)][2].check = tonumber(param2-1)
				setbaseinfo(guid,gmbox_tb[page][sign].show[tonumber(param1)].info,tonumber(param2)-1)
				lualib:MsgBox(player,"改变【"..gmbox_tb[page][sign].show[tonumber(param1)][1].."】成功！")
			end
		end
		say(player,yatools.updateLayout(player,page,sign,flag))
	elseif tonumber(param3) == 1 then
		local str = getconst(player,"<$NPCINPUT("..param1..")>")
		if tonumber(param1) == 1 then
			playerName = getconst(player,"<$NPCINPUT(1)>")
			if playerName == "" then
				lualib:MsgBox(player,"请输入玩家名字")
				return ""
			end

			guid = getplayerbyname(playerName)
			if guid == nil or guid == "" then
				guid = player
				lualib:MsgBox(player,"玩家不存在或是不在线！！")
				return ""
			end
			initCurrencyTable(guid,2)
			say(player,yatools.updateLayout(player,page,sign,flag))
		else
			if gmbox_tb[page][sign].show[tonumber(param1)].read > 0 then
				lualib:MsgBox(player,gmbox_tb[page][sign].show[tonumber(param1)].info..":"..tostring(str))
				if str == "" then
					lualib:MsgBox(player,"请输入需要修改的数值！！")
					return ""
				end
				if gmbox_tb[page][sign].show[tonumber(param1)].info == 39 then
					lualib:SetRein(guid,tonumber(str))
				else
					setbaseinfo(guid,gmbox_tb[page][sign].show[tonumber(param1)].info,tonumber(str))
				end
			else
				lualib:MsgBox(player,"该字段不可修改！！！")
				return ""
			end

		end
	elseif tonumber(param3) == 3 then
		if tonumber(param1) == 1 then
			local bag_item_tb = getbagitems(guid)
			for i = 1, #bag_item_tb do
				lualib:DelItemObject(guid,bag_item_tb[i])
			end
		elseif tonumber(param1) == 2 then
			local mapID = getbaseinfo(guid,3)
			local mapX = tonumber(getbaseinfo(guid,4))
			local mapY = tonumber(getbaseinfo(guid,5))
			clearitemmap(mapID,mapX,mapY,100,"*")
		elseif param1 == 3  then
			delnojobskill(guid)
		elseif param1 == 4 then
			openstorage(guid)
		elseif param1 == 5 then
			setbagcount(guid,128)
		elseif param1 == 6 then
			changestorage(guid,240)
		elseif param1 == 7 then
			callscriptex(player,"OPENHYPERLINK",34)
		elseif param1 == 8 then
			local mapID = getbaseinfo(guid,3)
			killmonsters(mapID,"*",0,false)
		end
	elseif param3 == 4 then
		local item = getconst(player,"<$NPCINPUT(8)>")
		local num = getconst(player,"<$NPCINPUT(9)>")
		if item == ""  then
			lualib:MsgBox(player,"装备不能为空值")
			return ""
		end
		if num == "" then
			num = 1
		end
		if not lualib:AddItem(guid,item,num,0,"GM制造:"..item) then
			lualib:SendMsgEx(player,9,"生成失败,可能是物品不存在")
			return ""
		end
		lualib:SendMsgEx(player,9,"补发成功！")
	end
	recalcabilitys(guid)
end
--角色道具操作
function itemupdate(player,param1,param2)
	if getgmlevel(player) < 10 then
		return ""
	end

	local account = getconst(player,"<$USERACCOUNT>")
	lualib:dbg("account = " ..account)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end

	local param1 = tonumber(param1)
	local param2 = tonumber(param2)
	if tonumber(param1) == 2 or tonumber(param1) == 1 then
		--背包道具
		gmbox_tb[page][sign].item = {}
		if tonumber(param1) == 1 then
			--获得背包道具唯一ID
			local itemCount = getbaseinfo(guid,34)
			for i = 0, (itemCount - 1) do
				local item =  getiteminfobyindex(guid, i)
				gmbox_tb[page][sign].item[i] = getiteminfo(guid,item,1)
			end
		elseif tonumber(param1) == 2 then
			--获得身上装备唯一iD
			local yes = 1
			for i = 1, 100 do
				local item = getconst(guid,"<$USEITEM["..i.."]>")
				local name = getconst(guid,"<$USEITEMNAME["..i.."]>")
				--也可以用装备常量获得
				--for i = 1, #gmbox_tb[page][sign].constant do
				--local item = getconst(guid,gmbox_tb[page][sign].constant[i])

				if item ~= "0" and item ~= "" then
					gmbox_tb[page][sign].item[yes] = tonumber(item)
					yes = yes + 1
					local itemId = getiteminfo(player,item,2)

					--if itemId ~= 0 then
					--	name = getstditeminfo(itemId,1)
					--end
					--[[local itemguid = getitembymakeindex(player,tonumber(item))
                    local itemname = getiteminfo(player,itemguid,2)
                    ]]--
				end
			end
		end
		gmbox_tb[4][1].input[2] = getbaseinfo(guid,1)
		lualib:SetVar(player,"N10",1)
	end

	if tonumber(param1) == 3 then
		lualib:SetVar(player,"N10",param2)
	elseif tonumber(param1) == 4 then
		local ids = gmbox_tb[page][sign].item[lualib:GetVar(player,"N10")]
		local item = getitembymakeindex(player,tonumber(ids))
		local json = getitemjson(item)
		if param2 == 1 then
			--复制
			if getbagblank(player) < 1 then
				lualib:MsgBox(player,"复制失败！背包空位不足！")
				return ""
			end
			giveitembyjson(player,json)
		elseif param2 == 2 then
			--拿走
			if getbagblank(player) < 1 then
				lualib:MsgBox(player,"拿走失败！背包空位不足！")
				return ""
			end
			delitembymakeindex(player,tonumber(ids))
			giveitembyjson(player,json)
		elseif param2 == 3 then
			--删除
			delitembymakeindex(player,tonumber(ids))
		elseif param2 == 4 then
			--全部删除
			for i = 0, #gmbox_tb[page][sign].item do
				ids = gmbox_tb[page][sign].item[i]
				delitembymakeindex(player,tonumber(ids))
			end
		elseif param2 == 5 then
			local json = getconst(player,"$NPCINPUT(2)")
			if json == "" or json == nil then
				lualib:MsgBox(player,"请输入正确的json！")
				return ""
			end
			giveitembyjson(player,json)
		end
	end
	say(player,yatools.updateLayout(player,page,sign,flag))
	return ""
	--
end
--调用脚本需要在QF中添加
function adduibutton(player)

	if getgmlevel(player) < 10 then
		return ""
	end

	local str = [[<Button|x=-65|y=-223|text=GMBOX|color=255|nimg=gmbox/1900000612.png|link=@gmbox>]]
	addbutton(player,108,10,str)
	return ""
end
--判断输入框是否违法
function checkinput(input)
	if getgmlevel(player) < 10 then
		return ""
	end
	local pattern = "[<>/%@\\]"
	if string.find(input, pattern) then
		-- 包含指定符号，禁止输入
		return false
	else
		-- 不包含指定符号，允许输入
		return true
	end
end
--输入框内容
function inputstring77(player)
	if getgmlevel(player) < 10 then
		return ""
	end

	local account = getconst(player,"<$USERACCOUNT>")
	lualib:dbg("account = " ..account)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end


	local str = serialize(lualib:GetVar(player,"S77"))
	local json = string.gsub(str, '"', '')
	giveitembyjson(player,str)
end
----
function inputstring49(player)
	local account = getconst(player,"<$USERACCOUNT>")
	if account_tb[account] == nil then
		lualib:MsgBox(player,"你没有权限")
		return ""
	end

	local str = lualib:GetVar(player,"S49")
	print("str = "..str)
	local guid = getplayerbyname(str)
	if guid == nil or guid == "" then
		guid = player
		lualib:MsgBox(player,"玩家不存在或是不在线！！")
		return ""
	end

	lualib:MsgBox(player,"封号成功！！")
	lualib:SetVar(guid,VarCfg["登录记录"],"禁止")
	lualib:MsgBox(guid,"【系统公告】：对不起，您的账号已被禁止登录。")
	offlineplay(guid,10)
	kick(guid)
	return ""
end
--
function func(player,param)
	local num = tonumber(param)
	if num == 1 then
		if castleinfo(5) then
			lualib:MsgBox(player,"当前是攻城状态，是否关闭","@open_castle","@no")
		else
			lualib:MsgBox(player,"当前不是攻城状态，是否开启","@open_castle","@no")
		end
	elseif num == 2 then
		click(player, "藏品_main")
	elseif num == 3 then
		local tablePlayerList = getplayerlst()
		for _, v in ipairs(tablePlayerList) do

		end
	elseif num == 4 then
	elseif num == 5 then
	end
end

function open_castle(player)
	if not castleinfo(5) then
		addattacksabakall()
		sendmsgnew(globalinfo(0),58,0,"【沙巴克公告】：攻城已经开始，速度占领皇宫！",1,5)
		sendmovemsg(globalinfo(0),0,254,0,400,1,"【沙巴克公告】：攻城已经开始，速度占领皇宫！只有参与攻城才能获得奖励。")
	else
		sendmsgnew(globalinfo(0),58,0,"<【沙巴克公告】/FCOLOR=58>：攻城已经结束，稍后可以领取攻城奖励！",1,5)
	end

	addtocastlewarlistex("*")
	gmexecute("0","ForcedWallconquestWar","@ForcedWallconquestWar")
end

function mapinfo_go(player,param)
	local account = getconst(player,"<$USERACCOUNT>")
	lualib:dbg("account = " ..account)
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end

	local param = tonumber(param)
	local mapname = mapinfo[param].n
	map(player,mapname)
end

--buff操作
function buffoperation(player,param)
	param = tonumber(param)
	local name = getconst(player,"<$NPCINPUT(1)>")
	local str = getconst(player,"<$NPCINPUT(2)>")
	local attr = getconst(player,"<$NPCINPUT(3)>")
	print(name,param)
	if name ~= "" then
		guid = getplayerbyname(name)
	else
		guid = player
	end

	local account = getconst(player,"<$USERACCOUNT>")
	----lualib:dbg("account = " ..account,lualib:Name( guid))
	if account_tb[account] ~= 1 then
		lualib:MsgBox(player,"你傻逼吧")
		return ""
	end

	if param == 1 then
		--local name = getconst(player,"<$NPCINPUT(1)>")
		if name ~= "" then
			guid = getplayerbyname(name)
			if guid == nil then
				guid = player
				lualib:MsgBox(player,"该角色不在线或是不存在！")
				return ""
			end
			lualib:SetVar(player,"S$名字",name)
			lualib:SetVar(player,"S$角色",guid)
		else
			lualib:SendMsgEx(player,9,"请输入玩家名字！！")
			return
		end
	elseif param == 2  then
		if attr ~= "" then
			lualib:dbg(attr)
			attr = lualib:StrToTable(attr)
		else
			attr = {}
		end

		if str == "" then
			lualib:MsgBox(guid,"请输入buffID")
			return ""
		end

		local data = strsplit(str,"#")
		local min = data[2] or 0

		if not addbuff(guid,data[1],min,1,player,attr) then
			lualib:MsgBox(player,"添加buff失败！！")
		else
			lualib:MsgBox(player,"添加buff成功！！")
		end
	else
		---print(guid,lualib:Name(guid),param)
		delbuff(guid,param)
	end
	say(player,yatools.updateLayout(player,3,2,1))
end

return yatools