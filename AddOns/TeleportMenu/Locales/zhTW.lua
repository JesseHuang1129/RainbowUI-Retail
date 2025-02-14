local L = LibStub("AceLocale-3.0"):NewLocale("TeleportMenu", "zhTW")
if not L then return end

L["AddonNamePrint"] = "\124cFFFF0000傳送選單:\124r " -- 1 space after the :
L["Not In Combat Tooltip"] = "\124cFFFF0000<戰鬥中不可使用>\124r"
L["Random Hearthstone"] = "隨機爐石"
L["Random Hearthstone Tooltip"] = "\124cFF34B7EB點擊後，會隨機使用一個爐石。\n重新打開主選單時，會選擇一個新的爐石。\124r"
L["Random Hearthstone Location"] = "\n\124cFF34B7EB爐石所在地：\124r \124cFF1EFF0C%s\124r"
L["No Hearthtone In Bags"] = "您的背包中沒有爐石，也沒有自行設定爐石。請使用 /tpm 指令以設定一個。"
L["Hearthone Reset Error"] = "我們已將你的爐石重置為預設狀態，因為此物品ID: %s 的玩具並不在您的收藏中。"

-- dungeons abreviated Text
L["The Vortex Pinnacle"] = "漩渦"
L["Throne of the Tides"] = "海潮"
L["Grim Batol"] = "格瑞"
L["Temple of the Jade Serpentl"] = "玉蛟"
L["Stormstout Brewery"] = "風暴"
L["Shado-Pan Monastery"] = "影潘"
L["Mogu'shan Palace"] = "魔古"
L["Gate of the Setting Sun"] = "落陽"
L["Siege of Niuzao Temple"] = "怒兆"
L["Scarlet Monastery"] = "修道院"
L["Scarlet Halls"] = "血色"
L["Scholomance"] = "通靈"
L["The Everblooml"] = "永茂"
L["Shadowmoon Burial Grounds"] = "影月"
L["Grimrail Depot"] = "車站"
L["Iron Docks"] = "碼頭"
L["Bloodmaul Slag Mines"] = "血槌"
L["Auchindoun"] = "奧齊頓"
L["Skyreach"] = "擎天"
L["Upper Blackrock Spire"] = "黑石上"
L["Halls of Valor"] = "英靈"
L["Neltharion's Lair"] = "巢穴"
L["Court of Stars"] = "眾星"
L["Karazhan"] = "卡拉贊"
L["Black Rook Hold"] = "玄鴉"
L["Darkheart Thicket"] = "暗心"
L["Freehold"] = "自由"
L["The Underrot"] = "幽腐"
L["Mechagon"] = "機械"
L["Waycrest Manor"] = "莊園"
L["Atal'Dazar"] = "阿塔"
L["Siege of Boralus"] = "圍城"
L["The Necrotic Wake"] = "死靈"
L["Plaguefall"] = "瘟疫"
L["Mists of Tirna Scithe"] = "迷霧"
L["Halls of Atonement"] = "贖罪"
L["Bastion"] = "晉升"
L["Theater of Pain"] = "苦痛"
L["De Other Side"] = "彼界"
L["Sanguine Depths"] = "血紅"
L["Tazavesh, the Veiled Market"] = "市集"
L["Castle Nathria"] = "納堡"
L["Sanctum of Domination"] = "統御"
L["Sepulcher of the First Ones"] = "首創"
L["Ruby Life Pools"] = "晶紅"
L["The Nokhud Offensive"] = "進攻"
L["Brackenhide Hollow"] = "蕨皮"
L["Algeth'ar Academy"] = "學院"
L["Neltharus"] = "奈堡"
L["The Azure Vault"] = "蒼藍"
L["Halls of Infusion"] = "灌注"
L["Uldaman"] = "奧達曼"
L["Dawn of the Infinite"] = "恆龍"
L["Vault of the Incarnates"] = "洪荒"
L["Aberrus, the Shadowed Crucible"] = "亞貝"
L["Amirdrassil, the Dream's Hope"] = "夢境"
L["City of Threads"] = "蛛絲"
L["The Dawnbreaker"] = "破曉"
L["The Stonevault"] = "石庫"
L["The Rookery"] = "培育"
L["Cinderbrew Meadery"] = "酒莊"
L["Priory of the Sacred Flame"] = "聖焰"
L["Ara-Kara, City of Echoes"] = "回音"
L["Darkflame Cleft"] = "暗焰"

-- expansion abreviated Text
L["Cataclysm"] = "浩劫重生"
L["Mists of Pandaria"] = "潘達利亞"
L["Warlords of Draenor"] = "德拉諾"
L["Legion"] = "軍臨"
L["Battle for Azeroth"] = "決戰"
L["Shadowlands"] = "暗影"
L["Shadowlands Raids"] = "暗影 團"
L["Dragonflight"] = "巨龍"
L["Dragonflight Raids"] = "巨龍 團"
L["The War Within"] = "地心"
L["Season 1"] = "賽季1"

-- Mage teleport/portal abreviated text
-- Alliance
L["Stormwind"] = "暴風"
L["Ironforge"] = "鐵爐堡"
L["Darnassus"] = "達納"
L["Exodar"] = "艾克"
L["Theramore"] = "賽拉摩"
L["Stormshield"] = "風暴盾"
L["Boralus"] = "波拉勒斯"

-- Horde
L["Orgrimmar"] = "奧格瑪"
L["Undercity"] = "幽暗"
L["Thunder Bluff"] = "雷霆"
L["Silvermoon"] = "銀月"
L["Stonard"] = "斯通"
L["Warspear"] = "戰矛"
L["Dazar'alor"] = "達薩"

-- Shared
L["Shattrath"] = "撒塔斯"
L["Dalaran - Northrend"] = "達拉-北"
L["Tol Barad"] = "托巴"
L["Vale of Eternal Blossoms"] = "恆春谷"
L["Dalaran - Broken Isles"] = "達拉-破"
L["Oribos"] = "奧睿博司"
L["Valdrakken"] = "沃卓肯"
L["Dalaran - Ancient"] = "達拉-古"
L["Hall of the Guardian"] = "守衛廳"
L["Dornogal"] = "多恩"

-- Options
L["Opening Options Menu"] = "打開選項選單"
L["Enabled"] = "啟用"
L["Enable Tooltip"] = "啟用/停用 此傳送選單。"
L["Hearthstone Toy"] = "爐石玩具"
L["Hearthstone Toy Tooltip"] = "設定首選的爐石玩具。\n\n如果設為隨機，則每次打開遊戲選單都會隨機選擇一個爐石玩具。"
L["None"] = "無"
L["Random"] = "隨機"
L["ButtonText"] = "傳送圖示顯示文字"
L["ButtonText Tooltip"] = "啟用時，地城傳送法術會顯示該地城的縮寫名稱。"
L["Reverse Mage Flyouts"] = "法師傳送選單反向排序"
L["Reverse Mage Flyouts Tooltip"] = "反向排序法師技能的彈出式選單，讓新資料片的傳送法術顯示在前面。"
L["Seasonal Teleports"] = "賽季傳送術"
L["Seasonal Teleports Tooltip"] = "\124cFF34B7EB這些是當前傳奇鑰石賽季的傳送法術。\124r"
L["Seasonal Teleports Toggle Tooltip"] = "啟用/停用只顯示賽季傳送術。"
L["Icon Size"] = "圖示大小"
L["Icon Size Tooltip"] = "加大或縮小圖示的大小。"
L["%s px"] = "%s 像素"
L["Icons Per Flyout Row"] = "彈出選單每行幾個圖示"
L["Icons Per Flyout Row Tooltip"] = "設定彈出式選單的圖示最大數量，超過會換行。"
L["%s icons"] = "%s 個圖示"

-- 自行加入
L["TeleportMenu"] = "傳送選單"
