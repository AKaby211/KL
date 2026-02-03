local Translations = {
    ["Get Key (Work.ink)"] = "14小时叫爸免费解",
    ["Get Key (Linkvertise)"] = "7小时不会解屌飞你",
    ["Check Key"] = "检查你的卡密",
    ["Ink Game | by AlexScriptX"] = "小机机我癌你",
    ["AX-SCRIPTS"] = "人汉化AX",
    ["Unload"] = "卸载UI",
    ["Games"] = "游戏内容",
    [" Red Light. Green Light"] = "红绿灯",
    ["Auto Stop"] = "自动在红灯时停止",
    ["Disable Injury"] = "移除受伤状态",
    ["Finish RLGL"] = "传送到终点",
    ["Pentathlon"] = "五猪六蹄",
    ["Auto Ddakji (Remote)"] = "自动打纸板(建议手打)",
    ["Auto Flying Stone (Remote)"] = "自动飞石",
    ["Auto Gonggi (Remote)"] = "自动打石子",
    ["Auto Spinning Top (Remote)"] = "自动转陀螺",
    ["Auto Jegi (Remote)"] = "自动踢毽子(不需要操作)",
    ["Auto Flying Stone"] = "自动飞石",
    ["Gonggi Auto QTE"] = "自动点石子",
    ["Gonggi QTE Speed"] = "石子QTE速度",
    ["Randomize QTE Speed"] = "随机QTE速度",
    ["Spinning Top Auto Balance"] = "陀螺自动平衡速度",
    ["Spinning Top Speed"] = "陀螺平衡速度",
    ["Randomize Balance Speed"] = "陀螺随机平衡速度",
    ["Dalgona"] = "扣糖饼",
    ["Anti Crack"] = "获得打火机",
    ["Get Lighter"]= "不会破碎糖饼",
    ["Auto Dalgona"] = "自动扣糖饼",
    ["Auto Dalgona V2"] = "自动扣糖饼V2",
    ["Lights Out"] = "熄灯"
    ["Safe Zone"] = "传送至安全区"
    ["Tug of War"] = "拔河",
    ["Rope Pull Mode"] ="拔河模式",
    ["Troll"] = "必输",
    ["Manual"] = "失误"'
    ["Normal"] = "普通",
    ["Perfect"] = "完美",
    ["Ultra Rage"] = "超级无敌狂暴",
    ["Pull Rope"] = "自动拔河",
    ["👁Hide N' Seek"] = "透视门",
    ["Show Exit Doors (Yellow)"] = "显示出口",
    ["Show Doors (Green | Cir/Tri/Sqr)"] = "显示门(绿门|三楼|广场)",
    ["Show Dropped Keys (Purple)"] = "透视钥匙",
    ["Show Staircases (Brown)"] = "显示楼梯",
    ["Show Spikes (Black)"] = "显示尖刺",
    ["Pickup Keys"] = "拾取钥匙",
    ["Auto Escape"] = "自动逃生",
    ["Infinite Stamina"] = "无限体力",
    ["Fast Sprint"] = "快速冲刺",
    ["Spikes Kill"] = "快速击杀",
    ["Disable Spikes"] = "禁用尖刺",
    ["Teleport to Hider"] = "传送到躲藏者",
    ["Teleport to Seeker"] = "传送至杀手",
    ["Select Exit Door"] = "选择逃生门",
    ["Teleport to Exit Door"] = "传送至逃生门",
    ["Glass Bridge"] = "玻璃桥",
    ["Reveal Safe & Fake Glass"] = "显示真玻璃和假玻璃",
    ["Anti Break Glass"] = "防坠落",
    ["Finish Glass Bridge"] = "传送至终点",
    ["Jump Rope"] = "跳绳",
    ["Finish Jump Rope"] = "完成跳绳",
    ["Disable Game"] = "禁用游戏",
    ["Simulate Balance"] = "自动平衡",
    ["Auto Jump"] = "自动跳跃",
    ["Fix Broken Tracks"] = "修复断桥",
    ["Unlimited Chances"] = "无限倒地机会",
    ["Rebel"] = "反叛",
    ["Auto Shoot Guards"] = "自动射击守卫",
    ["Wall Check"] = "墙壁检测",
    ["Guards Hitbox + ESP"] = "增加守卫碰撞箱和透视",
    ["Hitbox Size"] = "碰撞箱大小",
    ["Hitbox Transparency"] = "碰撞箱透明度",
    ["Last Dinner"] = "最后的晚餐",
    ["Safe Zone"] = "传送到安全区",
    ["Zone Kill"] = "区域击杀",
    ["Squid Game"] = "鱿鱼游戏",
    ["Safe Zone"] = "传送至安全区",
    ["Get Rock"] = "自动获得石头"
    ["Sky Squid Game"] = "天空鱿鱼游戏"
    ["Infinite Stamina"] = "无限体力",
    ["Press Button"] = "按下按纽",
    ["Get Pole"] = "获取杆子",
    ["Anti Fall"] = "防坠落",
    ["Void Kill"] = "虚空击杀",
["Barriers"] = "屏障",
    
    

    
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    if Translations[text] then return Translations[text] end
    for en, cn in pairs(Translations) do
        if text:find(en) then return text:gsub(en, cn) end
    end
    return text
end

local translatedElements = {}
local originalTexts = {}

local function safeTranslateElement(element)
    if translatedElements[element] then return end
    
    pcall(function()
        if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
            local currentText = element.Text
            if currentText and currentText ~= "" then
                if not originalTexts[element] then
                    originalTexts[element] = currentText
                end
                
                local translatedText = translateText(currentText)
                if translatedText ~= currentText then
                    element.Text = translatedText
                    translatedElements[element] = true
                end
            end
        end
    end)
end

local function setupSmartListener()
    local function onTextPropertyChanged(element)
        if translatedElements[element] then
            local currentText = element.Text
            local originalText = originalTexts[element]
            
            if currentText == originalText or translateText(currentText) == currentText then
                translatedElements[element] = nil
                return
            end
            
            local translatedText = translateText(currentText)
            if translatedText ~= currentText then
                element.Text = translatedText
            end
        else
            safeTranslateElement(element)
        end
    end

    local function addSmartListener(parent)
        parent.DescendantAdded:Connect(function(descendant)
            task.wait(0.3)
            safeTranslateElement(descendant)
            
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                descendant:GetPropertyChangedSignal("Text"):Connect(function()
                    task.wait(0.1)
                    onTextPropertyChanged(descendant)
                end)
            end
        end)
    end
    
    pcall(addSmartListener, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(addSmartListener, player.PlayerGui)
    end
end

local function delayedInitialTranslate()
    task.wait(5)
    
    for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        safeTranslateElement(gui)
    end
    
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
            safeTranslateElement(gui)
        end
    end
end

task.wait(2)
setupSmartListener()
delayedInitialTranslate()

local success, err = pcall(function()
loadstring(game:HttpGet("https://officialaxscripts.vercel.app/scripts/AX-Loader.lua"))()

end)

if not success then
    warn("加载失败:", err)
end
