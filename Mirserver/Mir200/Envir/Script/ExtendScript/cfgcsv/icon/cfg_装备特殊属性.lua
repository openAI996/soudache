local config = {
    --穿戴获得元素属性
    element = {
        --[名字]={元素属性value,value= {最小值,最大值},type = 1(只随机对应属性)，2（随机所有元素属性）,3(num表示随机几个属性)}
        --[\'铁砂环\'] = {{1,7}, value = {{1, 15},{1, 15}}, type = 3},
        ["东冥魄"] = {key = {{254,4,31,0,0}},value = {{50,388}}, type = 4},
        ["星澜如意●"] = {key = {{254,203,31,1,0}},value = {{40,70}}, type = 4},
        ["九龙御虎●金刚●"] = {key = {{254,234,31,1,0}},value = {{30,60}}, type = 4},
        ["塔纳环"] = {key = {{254,25,31,1,0},{254,30,31,1,1}},value = {{1,10},{1,10}}, type = 4},

        random = {0, 1, 2, 3, 4, 5, 7,  11}
    },
    --专属buff特殊效果
    special = {
        --(type = 1,你攻击别人掉血触发，2你被攻击掉血触发，3被动  {}--表示多个触发)
        [0] = {
            [50589] = {1,type=3,cd = 0,chance= 10000, name = "结界斗甲"},
        },
        [1] = {
            [50586] = {1,type={1,3},cd = 0,chance= 10000, name = "九尾妖天剑"},
        },
        [2] = {
            [50039]={1,type = 3,cd = 0,chance=10000,name="金龙佩"},                    ---效果相同等待统一实现
        },
        [3] = {
            [50584]={1,type = 1,cd = 15,chance=200,name="妖链"},
        },
        [4] = {
            [50601]={1,type = 3,cd = 0,chance=10000,name="神王盔"},
        },
        [5] = {
            [50583]={1,type = 3,cd = 0,chance=10000,name="尾镯"},
        },
        [6] = {
            [50583]={1,type = 3,cd = 0,chance=10000,name="尾镯"},
        },
        [7] = {
            [50597]={1,type = 3,cd = 0,chance=10000,name="亚特伍指环"},
        },
        [8] = {
            [50597]={1,type = 3,cd = 0,chance=10000,name="亚特伍指环"},
        },
        [10] = {
            [50587]={1,type = 3,cd = 0,chance=10000,name="青楼"},
        },
        [11] = {
            [50592]={1,type = 1,cd = 0,chance=10,name="清水"},
        },
        [12] = {
            [50448]={1,type = 3,cd = 0,chance=10,name="魔血石(1级)"},
            [50449]={2,type = 3,cd = 0,chance=10,name="魔血石(2级)"},
            [50450]={3,type = 3,cd = 0,chance=10,name="魔血石(3级)"},
            [50451]={4,type = 3,cd = 0,chance=10,name="魔血石(4级)"},
            [50452]={5,type = 3,cd = 0,chance=10,name="魔血石(5级)"},
        },
        [13] = {
            [51341]={1,type = 1,cd = 0,chance=10,name="宿の命"},
        },
        [14] = {
            [50612]={1,type = 3,cd = 0,chance=10000,name="尤利西斯"},
        },
        [15] = {
            [50013]={1,type = 3,cd = 30,chance=10000,name="无畏符"},
        },
        [16] = {
            [51025]={1,type = 3,cd = 0, times = 5,chance=10000,name="火龙·战刃≮左≯"},
        },
        [17] = {
            [50942]={1,type = 3,cd = 30,chance=3000,name="一身■正气"},
        },
        [18] = {
            [50951]={1,type = 1,cd = 0,chance=50,name="酆刀メ自然神"},
        },
        [20] = {
            [50908]={1,type = 1,cd = 30,chance=100,name="生死·链"},
        },
        [21] = {
            [50997]={1,type = 3,cd = 0,chance=100,name="聚仙の盔"},
        },
        [22] = {
            [50881]={1,type = 1,cd = 0,chance=10000,name="残∴龙∴吟"},
        },
        [23] = {
            [50881]={1,type = 1,cd = 0,chance=10000,name="残∴龙∴吟"},
        },
        [24] = {
            [50892]={1,type = 2,cd = 90,chance=100,name="精∴灵∴赐∴福"},
        },
        [25] = {
            [50892]={1,type = 2,cd = 90,chance=100,name="精∴灵∴赐∴福"},
        },
        [26] = {
            [50585]={1,type = 3,cd = 0,chance=10000,name="九尾章"},
        },
        [27] = {
            [50929]={1,type = 3,cd = 0,chance=10000,name="光芒印章"},
        },
        [28] = {
            [50918]={1,type = {1,3},cd = 0,chance=10000,name="天罚·半步颠"},
        },
        [30] = {
            [50633]={1,type = 3,cd = 0,chance=10000,name="邪魔"},
        },
        [31] = {
            [50632]={1,type = 3,cd = 0,chance=10000,name="时之钟"},
        },
        [32] = {
            [50615]={1,type = 1,cd = 0,chance=10000,name="堕落环"},
        },
        [33] = {
            [50623]={1,type = 3,cd = 0,chance=10000,name="奥特珠"},
        },
        [34] = {
            [50921]={1,type = 1,cd = 0,chance=100,name="亡命图腾"},
        },
        [35] = {
            [50817]={1,type = 1,cd = 0,chance=10000,name="鱼鳞"},
        },
        [36] = {
            [50810]={1,type = 1,cd = 60,chance=100,name="灵幽"},
        },
        [37] = {
            [50949]={1,type = 3,cd = 0,chance=10000,name="罗酆メ「撼地」"},
        },
        [38] = {
            [50104]={1,type = 3,cd = 0,chance=10000,name="未知·盔"},
        },
        [39] = {
            [50105]={1,type = 3,cd = 0,chance=10000,name="未知·链"},
        },
        [40] = {
            [50106]={1,type = 3,cd = 0,chance=10000,name="未知·镯"},
        },
        [41] = {
            [50107]={1,type = 3,cd = 0,chance=10000,name="未知·戒"},
        },
        [42] = {
            [50595]={1,type = 1,cd = 9,chance=100,name="寒冰刺"},
        },
        [43] = {
            [50952]={1,type = {1,3},cd = 0,chance=100,name="卐卐真诰天地卐卐"},
        },
        [44] = {
            [50902]={1,type = 1,cd = 0,chance=100,name="妖爪"},
        },
        [71] = {
            [50890]={1,type = 2,cd = 0,chance=100,name="巨人心脏"},
        },
        [72] = {
            [50829]={1,type = 2,cd = 60,chance=100,name="天罡·北斗"},
        },
        [73] = {
            [50830]={1,type = 1,cd = 0,chance=10000,name="万◎剑"},
        },
        [74] = {        --溅射待实现
            [50832]={1,type = 1,cd = 0,chance=10000,name="尸罗"},
        },
        [75] = {
            [51137]={1,type = 1,cd = 0,chance=500,name="先天¤¤¤奥义"},
        },
        [76] = {
            [50865]={1,type = 1,cd = 0,chance=100,name="天尊恶蛊"},
        },
        [77] = {        ---奇遇未实现
                        [50004]={1,type = 3,cd = 0,chance=10000,name="珞珈指环"},
        },
        [78] = {
            [50008]={1,type = 3,cd = 0,chance=10000,name="白虎"},
        },
        [81] = {
            [51410]={1,type = 1,cd = 0,chance=10000,name="△△三钴杵▲▲"},
        },
        [82] = {
            [51411]={1,type = 1,cd = 0,chance=10000,name="须弥△诸天"},
        },
        [83] = {
            [51412]={1,type = 3,cd = 0,chance=10000,name="长阿▲含经"},
        },
        [84] = {
            [51015]={1,type = 1,cd = 60,chance=200,name="斩◎神◎魔"},
        },
        [85] = {
            [50950]={1,type = 3,cd = 0,chance=10000,name="◇◇◇复苏◇◇◇"},
        },
        [87] = {
            [51001]={1,type = 3,cd = 0,chance=10000,name="魔之Ｉ惩戒"},
        },
        [88] = {
            [51408]={1,type = 1,cd = 60,chance=100,name="自食メ恶果"},
        },
        [90] = {
            [50057]={1,type = 3,cd = 00,chance=10000,name="一转去骨·元神"},
        },
        [111] = {
            [51167]={1,type = 1,cd = 0,chance=500,name="趋凶Б避急"},
        },
        [114] = {
            [50824]={1,type = 3,cd = 0,chance=10000,name="海冠"},
        },
        [115] = {
            [50588]={1,type = {1,3},cd = 0,chance=100,hp=60,name="佩郎仙"},
        },
        [116] = {
            [51098]={1,type = 3,cd = 0,chance=10000,name="爱情鲜花"},
        },
        [117] = {   --未实现
            [51043]={1,type = 3,cd = 0,chance=10000,name="佣兵[爆率]"},
        },
        [70] = {  --称号特殊buff
            ["橙怪杀手(限时)"]={43,type = 1,cd = 0,chance=10000,name="橙怪杀手(限时)"},
        },
        suit = {    --套装特殊buff

        },
        ["脚本效果"] = {
            ["暴击之爪"] =      {1 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="暴击之爪"},
            ["无敌斩"] =       {2 ,   type = {3},   cd = 120,   level = 0,   chance=10000,     name="无敌斩"},
            ["单刀赴会"] =      {3 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="单刀赴会"},
            ["泰坦之躯"] =      {4 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="泰坦之躯"},
            ["浴血奋战"] =      {5 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="浴血奋战"},
            ["玻璃大炮"] =      {6 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="玻璃大炮"},
            ["赏金猎人"] =      {7 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="赏金猎人"},
            ["巨人杀手"] =      {8 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="巨人杀手"},
            ["王中王"] =       {9 ,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="王中王"},
            ["处刑官"] =       {10,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="处刑官"},
            ["致命节奏"] =      {11,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="致命节奏"},
            ["越燃越烈"] =      {12,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="越燃越烈"},
            ["连环斩"] =       {13,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="连环斩"},
            ["战意昂扬"] =      {14,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="战意昂扬"},
            ---["星界屏障"] =      {15,   type = {1,3},   cd = 0,   level = 0,   chance=10000,     name="星界屏障"},
            ["弱化射线"] =      {16,   type = {1},   cd = 60,   level = 0,   chance=10000,      name="弱化射线"},
            ["破甲"] =        {17,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="破甲"},
            ["疾行战魂"] =      {18,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="疾行战魂"},
            ["紧急撤离"] =      {19,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="紧急撤离"},
            ["变速齿轮"] =      {20,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="变速齿轮"},
            ---["坦克引擎"] =      {21,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="坦克引擎"},
            ["寒霜"] =        {22,   type = {1},   cd = 10,   level = 0,   chance=10000,      name="寒霜"},
            ["狂热者"] =       {23,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="狂热者"},
            ["唯快不破"] =      {24,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="唯快不破"},
            ["铁骨"] =        {25,   type = {2},   cd = 0,   level = 0,   chance=10000,       name="铁骨"},
            ["力王"] =        {26,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="力王"},
            ["狠狠推开"] =      {27,   type = {2},   cd = 75,   level = 0,   chance=10000,      name="狠狠推开"},
            ["催心"] =        {28,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="催心"},
            ---["肉装重击"] =      {29,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="肉装重击"},
            ["飞毛腿"] =       {30,   type = {1},   cd = 0,   level = 0,   chance=10000,       name="飞毛腿"},
            ["守护神盾"] =      {31,   type = {3},   cd = 45,   level = 0,   chance=10000,      name="守护神盾"},
            ["金蝉脱壳"] =      {32,   type = {2},   cd = 75,   level = 0,   chance=10000,      name="金蝉脱壳"},

            ---羁绊卡
            ["火苗"] =         {34,   type = {1},   cd = 0,   level = 0,   chance=1500,      name="火苗"},
            ["烈焰"] =         {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="烈焰"},
            ["火势蔓延"] =      {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="火势蔓延"},
            ["持续升温"] =      {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="持续升温"},
            ["弱化火焰"] =      {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="弱化火焰"},
            ["不灭焰"] =        {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="不灭焰"},
            ["焚心爆"] =        {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="焚心爆"},
            ---无限进化
            ["攻速进化"] =      {34,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="攻速进化"},
            ["屠杀进化"] =      {35,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="屠杀进化"},
            ["移速进化"] =      {36,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="移速进化"},
            ["噬魂进化"] =      {37,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="噬魂进化"},
            ["猎魔进化"] =      {38,   type = {3},   cd = 0,   level = 0,   chance=1500,      name="猎魔进化"},
            ---利滚利
            ["散财童子"] =      {39,   type = {3},   cd = 0,   level = 0,   chance=1000,      name="散财童子"},
            ["打了小的来大的"] =  {40,   type = {3},   cd = 0,   level = 0,   chance=10000,    name="打了小的来大的"},
            ["是藏品"] =        {41,   type = {3},   cd = 0,   level = 0,   chance=500,       name="是藏品"},
            ["妙手空空"] =      {42,   type = {3},   cd = 0,   level = 0,   chance=10000,     name="妙手空空"},
            ["聚宝成锋"] =      {43,   type = {3},   cd = 0,   level = 0,   chance=10000,     name="聚宝成锋"},
            ---火符
            ["灵魂火符"] =         {44,   type = {1},   cd = 3,   level = 0,   chance=10000,    name="灵魂火符"},
            ["高频火符"] =         {44,   type = {3},   cd = 0,   level = 0,   chance=10000,    name="高频火符"},
            ["双生火符"] =         {44,   type = {3},   cd = 0,   level = 0,   chance=10000,    name="双生火符"},
            ["灼烧火符"] =         {44,   type = {3},   cd = 0,   level = 0,   chance=10000,    name="灼烧火符"},
            ["爆裂火符"] =         {44,   type = {3},   cd = 0,   level = 0,   chance=10000,    name="爆裂火符"},
            ---变速齿轮
            ["疾风锐眼"] =      {45,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="疾风锐眼"},
            ["暴走齿轮"] =      {46,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="暴走齿轮"},
            ["致命攻速"] =      {47,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="致命攻速"},
            ["狂飙"] =         {48,   type = {3},   cd = 0,   level = 0,   chance=10000,       name="狂飙"},
            ---跑刀流
            ["隐身术"] =      {45,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="隐身术"},
            ["影遁"] =        {46,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="影遁"},
            ["轻身如燕"] =    {46,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="轻身如燕"},
            ["绝境逢生"] =    {46,   type = {2},   cd = 0,   level = 0,   chance=10000,      name="绝境逢生"},
            ["调息"] =        {46,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="调息"},
            ---高贵的控制系
            ["变羊术"] =      {47,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="变羊术"},
            ["寒冰锁"] =     {48,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="寒冰锁"},
            ["烈焰震退"] =   {49,   type = {2},   cd = 75,   level = 0,   chance=10000,      name="烈焰震退"},
            ["重锤定身"] =   {50,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="重锤定身"},
            ["控制欲极强"] = {50,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="控制欲极强"},
            ---医疗小队
            ["双技同修"] =   {50,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="双技同修"},
            ["甘霖"] =      {51,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="甘霖"},
            ["铁壁光环"] =   {52,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="铁壁光环"},
            ["灵盾"] =      {53,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="灵盾"},
            ["开箱赐福"] =   {54,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="开箱赐福"},
            ---巨人族
            ["泰坦之躯"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="泰坦之躯"},
            ["星界屏障"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="星界屏障"},
            ["坦克引擎"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="坦克引擎"},
            ["铁甲觉醒"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="铁甲觉醒"},
            ["肉装重击"] =   {55,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="肉装重击"},
            ["金钟罩"] =     {55,   type = {3},   cd = 45,   level = 0,   chance=10000,      name="金钟罩"},
            ---小人国
            ["小人国"] =    {55,   type = {1},   cd = 45,   level = 0,   chance=10000,      name="小人国"},
            ["我小我牛B"] =    {55,   type = {1},   cd = 45,   level = 0,   chance=10000,      name="我小我牛B"},
            ["专揍大高个"] =   {55,   type = {3},   cd = 45,   level = 0,   chance=10000,      name="专揍大高个"},
            ["以小搏大"] =     {55,   type = {1},   cd = 45,   level = 0,   chance=10000,      name="以小搏大"},
            ["蚁噬"] =        {55,   type = {3},   cd = 45,   level = 0,   chance=10000,      name="蚁噬"},
            ["巨人收割机"] =   {55,   type = {3},   cd = 45,   level = 0,   chance=10000,      name="巨人收割机"},
            ---召唤师
            ["召唤神兽"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="召唤神兽"},
            ["二次召唤"] =   {55,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="二次召唤"},
            ["神兽狂化"] =   {56,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="神兽狂化"},
            ["亡灵军团"] =   {57,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="亡灵军团"},
            ["万兽共鸣"] =   {58,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="万兽共鸣"},
            ---赌狗
            ["幸运骰子"] =  {59,   type = {1},   cd = 0,   level = 0,   chance=10000,      name="幸运骰子"},
            ["盲盒"] =     {60,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="盲盒"},
            ["洗牌"] =     {60,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="洗牌"},
            ["天选"] =     {60,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="天选"},
            ["氪命"] =     {60,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="氪命"},
            ["打折卡"] =   {60,   type = {3},   cd = 0,   level = 0,   chance=10000,      name="打折卡"},

        }
    }
}

return config
