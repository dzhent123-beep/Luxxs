local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
if not game:IsLoaded() then game.Loaded:Wait() end
local LP = Players.LocalPlayer

local KEY = "NURHUB"
local TG = "https://t.me/NurHuboffical"
local FOLDER = "LUXXS"
local CREATED = {en = "3 October 2026", ru = "3 октября 2026", kz = "2026 жылғы 3 қазан"}

---------------------------------------------------------------- cleanup
local env = (getgenv and getgenv()) or _G
if env.LUXXS_CLEAN then pcall(env.LUXXS_CLEAN) end
local conns, insts = {}, {}
local function bind(c) conns[#conns + 1] = c return c end
local function track(i) insts[#insts + 1] = i return i end
env.LUXXS_CLEAN = function()
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    for _, i in ipairs(insts) do pcall(function() i:Destroy() end) end
    local ch = LP.Character
    if ch then
        for _, n in ipairs({"LuxxsHat", "LuxxsWings"}) do
            local m = ch:FindFirstChild(n)
            if m then m:Destroy() end
        end
    end
end

---------------------------------------------------------------- languages
local L = {
    en = {
        visuals = "Visuals", combat = "Combat", skins = "Skins", players = "Players", settings = "Settings",
        config = "Config", info = "Info", preview = "Preview",
        hat = "Chinese hat", hatRainbow = "Rainbow hat", hatColor = "Hat color", hatTrail = "Hat trail",
        angel = "Angel wings", demon = "Demon wings", wingRainbow = "Rainbow wings",
        wingColor = "Wings color (A = auto)", wingTrail = "Wings trail",
        chams = "Chams", chamsRainbow = "Rainbow chams", chamsFill = "Chams color", chamsOutline = "Chams outline",
        chamsTrans = "Chams transparency", esp = "ESP box", lines = "Lines", nick = "Player nick",
        skeleton = "Enemy skeleton", espRainbow = "Rainbow ESP", espColor = "ESP color",
        teamCheck = "Enemies only (teams)", maxDist = "Max distance",
        menuScale = "Menu size", menuColor = "Menu color", language = "Language",
        cfgName = "Config name", save = "Save", load = "Load", delete = "Delete", refresh = "Refresh",
        cfgList = "Saved configs (tap to select)",
        created = "Created", about = "LUXXS for Delta",
        tgAd = "Join our Telegram: updates, new scripts and keys!",
        copyLink = "Copy Telegram link", copied = "Copied!", noFS = "Executor has no file functions",
        msgSaved = "Config saved", msgLoaded = "Config loaded", msgDeleted = "Config deleted",
        msgName = "Enter a config name", msgNone = "Config not found",
        aimbot = "Aimbot", aimSmooth = "Smooth aim", aimPart = "Aim part",
        aimWallCheck = "Wall check (ignore behind walls)", wallbang = "Wallbang (shoot through walls)",
        aimRange = "Aim range",
        spin = "Spin", spinSpeed = "Spin speed", skin = "Skin",
        thirdPerson = "Third person", tpDist = "3rd person distance",
    },
    ru = {
        visuals = "Визуалы", combat = "Бой", skins = "Скины", players = "Игроки", settings = "Настройки",
        config = "Конфиг", info = "Инфо", preview = "Превью",
        hat = "Китайская шляпа", hatRainbow = "Радужная шляпа", hatColor = "Цвет шляпы", hatTrail = "Трейл шляпы",
        angel = "Ангельские крылья", demon = "Демонские крылья", wingRainbow = "Радужные крылья",
        wingColor = "Цвет крыльев (A = авто)", wingTrail = "Трейл крыльев",
        chams = "Чамсы", chamsRainbow = "Радужные чамсы", chamsFill = "Цвет чамсов", chamsOutline = "Контур чамсов",
        chamsTrans = "Прозрачность чамсов", esp = "ESP бокс", lines = "Линии", nick = "Ник игрока",
        skeleton = "Скелетон врага", espRainbow = "Радужный ESP", espColor = "Цвет ESP",
        teamCheck = "Только враги (команды)", maxDist = "Макс. дистанция",
        menuScale = "Размер меню", menuColor = "Цвет меню", language = "Язык",
        cfgName = "Название конфига", save = "Сохранить", load = "Загрузить", delete = "Удалить", refresh = "Обновить",
        cfgList = "Сохранённые конфиги (нажми)",
        created = "Дата создания", about = "LUXXS для Delta",
        tgAd = "Подписывайся на наш Telegram: обновления, новые скрипты и ключи!",
        copyLink = "Скопировать ссылку Telegram", copied = "Скопировано!", noFS = "Эксплойт не поддерживает файлы",
        msgSaved = "Конфиг сохранён", msgLoaded = "Конфиг загружен", msgDeleted = "Конфиг удалён",
        msgName = "Введи название конфига", msgNone = "Конфиг не найден",
        aimbot = "Аимбот", aimSmooth = "Плавное прицеливание", aimPart = "Часть для прицела",
        aimWallCheck = "Проверка стен (не наводиться через стены)", wallbang = "Воллбанг (стрелять сквозь стены)",
        aimRange = "Дистанция аимбота",
        spin = "Спин", spinSpeed = "Скорость спина", skin = "Скин",
        thirdPerson = "Третье лицо", tpDist = "Дистанция 3-го лица",
    },
    kz = {
        visuals = "Визуал", combat = "Шайқас", skins = "Скиндер", players = "Ойыншылар", settings = "Баптау",
        config = "Конфиг", info = "Ақпарат", preview = "Алдын ала қарау",
        hat = "Қытай қалпағы", hatRainbow = "Кемпірқосақ қалпақ", hatColor = "Қалпақ түсі", hatTrail = "Қалпақ ізі",
        angel = "Періште қанаттары", demon = "Жын қанаттары", wingRainbow = "Кемпірқосақ қанаттар",
        wingColor = "Қанат түсі (A = авто)", wingTrail = "Қанат ізі",
        chams = "Чамс", chamsRainbow = "Кемпірқосақ чамс", chamsFill = "Чамс түсі", chamsOutline = "Чамс контуры",
        chamsTrans = "Чамс мөлдірлігі", esp = "ESP қорап", lines = "Сызықтар", nick = "Ойыншы аты",
        skeleton = "Жау қаңқасы", espRainbow = "Кемпірқосақ ESP", espColor = "ESP түсі",
        teamCheck = "Тек жаулар (командалар)", maxDist = "Макс. қашықтық",
        menuScale = "Мәзір өлшемі", menuColor = "Мәзір түсі", language = "Тіл",
        cfgName = "Конфиг атауы", save = "Сақтау", load = "Жүктеу", delete = "Жою", refresh = "Жаңарту",
        cfgList = "Сақталған конфигтер (таңда)",
        created = "Жасалған күні", about = "Delta үшін LUXXS",
        tgAd = "Telegram арнамызға жазыл: жаңартулар, жаңа скрипттер мен кілттер!",
        copyLink = "Telegram сілтемесін көшіру", copied = "Көшірілді!", noFS = "Эксплойт файлдарды қолдамайды",
        msgSaved = "Конфиг сақталды", msgLoaded = "Конфиг жүктелді", msgDeleted = "Конфиг жойылды",
        msgName = "Конфиг атауын енгізіңіз", msgNone = "Конфиг табылмады",
        aimbot = "Аимбот", aimSmooth = "Жұмсақ көздеу", aimPart = "Көздеу бөлігі",
        aimWallCheck = "Қабырға тексеру", wallbang = "Воллбанг",
        aimRange = "Аимбот қашықтығы",
        spin = "Спин", spinSpeed = "Спин жылдамдығы", skin = "Скин",
        thirdPerson = "Үшінші тұлға", tpDist = "3-тұлға қашықтығы",
    },
}

---------------------------------------------------------------- config
local cfg = {
    lang = "en", menuScale = 0.9, menuColor = "8a5cff",
    hat = false, hatRainbow = true, hatColor = "ff3b3b", hatTrail = false,
    angel = false, demon = false, wingRainbow = false, wingColor = "auto", wingTrail = false,
    chams = false, chamsRainbow = false, chamsFill = "ff3b3b", chamsOutline = "ffffff", chamsTrans = 0.5,
    esp = false, lines = false, nick = false, skeleton = false,
    espRainbow = false, espColor = "ffffff", teamCheck = false, maxDist = 2500,
    aimbot = false, aimSmooth = false, aimPart = "head", aimWallCheck = true, wallbang = false, aimRange = 1500,
    spin = false, spinSpeed = 1500,
    skin = "off",
    thirdPerson = false, tpDist = 18,
}

local function tr(k)
    local d = L[cfg.lang]
    return (d and d[k]) or L.en[k] or k
end

---------------------------------------------------------------- skins & aim helpers
local SKINS = {
    off = nil,
    neon = {color = Color3.fromRGB(0, 255, 200), material = Enum.Material.Neon, transparency = 0},
    ghost = {color = Color3.fromRGB(200, 200, 255), material = Enum.Material.ForceField, transparency = 0.5},
    ice = {color = Color3.fromRGB(150, 220, 255), material = Enum.Material.Ice, transparency = 0.15},
    lava = {color = Color3.fromRGB(255, 80, 0), material = Enum.Material.Neon, transparency = 0.05},
    black = {color = Color3.fromRGB(15, 15, 15), material = Enum.Material.SmoothPlastic, transparency = 0},
    white = {color = Color3.fromRGB(240, 240, 240), material = Enum.Material.SmoothPlastic, transparency = 0},
    rainbow = {color = "rainbow", material = Enum.Material.Neon, transparency = 0},
}
local SKIN_ORDER = {"off", "neon", "ghost", "ice", "lava", "black", "white", "rainbow"}
local SKIN_LABELS = {off="OFF", neon="NEON", ghost="GHOST", ice="ICE", lava="LAVA", black="BLACK", white="WHITE", rainbow="RAINBOW"}
local SKIN_COLORS = {
    off = Color3.fromRGB(90, 90, 110),
    neon = Color3.fromRGB(0, 255, 200),
    ghost = Color3.fromRGB(200, 200, 255),
    ice = Color3.fromRGB(150, 220, 255),
    lava = Color3.fromRGB(255, 80, 0),
    black = Color3.fromRGB(15, 15, 15),
    white = Color3.fromRGB(240, 240, 240),
    rainbow = Color3.fromRGB(255, 100, 200),
}

local AIM_PART_NAMES = {head = "Head", torso = "Torso", armL = "Left Arm", armR = "Right Arm", legL = "Left Leg", legR = "Right Leg"}
local AIM_PARTS_R15 = {
    head = {"Head"}, torso = {"UpperTorso"}, armL = {"LeftUpperArm"}, armR = {"RightUpperArm"},
    legL = {"LeftUpperLeg"}, legR = {"RightUpperLeg"},
}
local AIM_PARTS_R6 = {
    head = {"Head"}, torso = {"Torso"}, armL = {"Left Arm"}, armR = {"Right Arm"},
    legL = {"Left Leg"}, legR = {"Right Leg"},
}

---------------------------------------------------------------- helpers
local T = tick()
local cc = {}
local function C(h)
    local c = cc[h]
    if not c then
        local ok, v = pcall(Color3.fromHex, h)
        c = (ok and v) or Color3.new(1, 1, 1)
        cc[h] = c
    end
    return c
end
local function rainbow(o) return Color3.fromHSV((T * 0.3 + (o or 0)) % 1, 0.85, 1) end

local function new(cls, props, parent)
    local o = Instance.new(cls)
    if props then for k, v in pairs(props) do o[k] = v end end
    if parent then o.Parent = parent end
    return o
end
local function corner(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r or 6)}, o) end

local GUIP
do
    local ok, h = pcall(function() return gethui and gethui() end)
    if ok and h then
        GUIP = h
    else
        local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
        GUIP = (ok2 and cg) or LP:WaitForChild("PlayerGui")
    end
end

local function mkGui(name, order)
    local g = Instance.new("ScreenGui")
    g.Name = name
    g.ResetOnSpawn = false
    g.IgnoreGuiInset = true
    g.DisplayOrder = order or 1
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function() g.Parent = GUIP end)
    if not ok or not g.Parent then g.Parent = LP:WaitForChild("PlayerGui") end
    track(g)
    return g
end

local function setLine(f, a, b, thick, col)
    local d = b - a
    f.Size = UDim2.fromOffset(d.Magnitude, thick)
    f.Position = UDim2.fromOffset((a.X + b.X) / 2, (a.Y + b.Y) / 2)
    f.Rotation = math.deg(math.atan2(d.Y, d.X))
    f.BackgroundColor3 = col
    f.Visible = true
end

local function copy(t)
    local fn = setclipboard or toclipboard
    if fn then pcall(fn, t) return true end
    return false
end

local function makeDraggable(handle, target, onClick)
    local dragging, moved, start, startPos = false, false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging, moved, start, startPos = true, false, i.Position, target.Position
            local c
            c = i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    c:Disconnect()
                    if not moved and onClick then onClick() end
                end
            end)
        end
    end)
    bind(UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - start
            if d.Magnitude > 6 then moved = true end
            if moved then
                target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end))
end

---------------------------------------------------------------- 3D visuals: hat + wings
local hatModel, hatLayers, hatTrail = nil, {}, nil
local wingModel, wingItems, wingTrails, wingKind = nil, {}, {}, nil

local WING = {
    angel = {phi = {65, 50, 35, 20, 5, -10, -25}, len = {3.2, 4, 4.8, 5, 4.6, 3.8, 2.8}},
    demon = {phi = {72, 42, 14, -14, -40}, len = {4.2, 5.8, 5.2, 4.4, 3.2}},
}

local function mkPart(parent, size)
    local p = Instance.new("Part")
    p.Size = size
    p.Material = Enum.Material.SmoothPlastic
    p.CanCollide = false
    p.CanTouch = false
    p.CanQuery = false
    p.Massless = true
    p.CastShadow = false
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    p.Parent = parent
    return p
end
local function weld(a, b, c0)
    local w = Instance.new("Weld")
    w.Part0, w.Part1, w.C0 = a, b, c0
    w.Parent = b
    return w
end
local function mkTrail(part, p0, p1, life)
    local a0 = new("Attachment", {Position = p0}, part)
    local a1 = new("Attachment", {Position = p1}, part)
    local t = new("Trail", {
        Attachment0 = a0, Attachment1 = a1, Lifetime = life or 0.7, LightEmission = 1,
        FaceCamera = true, MinLength = 0.05, Enabled = false,
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)}),
    }, part)
    return t
end
local function setTrail(t, on, rb, base)
    if not t then return end
    t.Enabled = on and true or false
    if not on then return end
    if rb then
        t.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, rainbow(0)),
            ColorSequenceKeypoint.new(0.5, rainbow(0.2)),
            ColorSequenceKeypoint.new(1, rainbow(0.4)),
        })
    else
        t.Color = ColorSequence.new(base)
    end
end

local function wingCol(kind, role, i)
    if cfg.wingRainbow then return rainbow(i * 0.07) end
    if cfg.wingColor ~= "auto" then
        local c = C(cfg.wingColor)
        if role == "s" then c = c:Lerp(Color3.new(0, 0, 0), 0.5) end
        return c
    end
    if kind == "angel" then
        return Color3.fromRGB(250, 250, 255):Lerp(Color3.fromRGB(175, 195, 255), i / 9)
    end
    if role == "m" then return Color3.fromRGB(150, 12, 32) end
    return Color3.fromRGB(28, 28, 32)
end

local function buildHat()
    if hatModel then hatModel:Destroy() hatModel = nil end
    hatLayers, hatTrail = {}, nil
    local ch = LP.Character
    local head = ch and ch:FindFirstChild("Head")
    if not (cfg.hat and head) then return end
    hatModel = Instance.new("Model")
    hatModel.Name = "LuxxsHat"
    hatModel.Parent = ch
    local base = head.Size.Y / 2 + 0.05
    for i = 1, 8 do
        local d = 4.4 - (i - 1) * 0.5
        local p = mkPart(hatModel, Vector3.new(0.22, d, d))
        p.Shape = Enum.PartType.Cylinder
        weld(head, p, CFrame.new(0, base + (i - 1) * 0.2, 0) * CFrame.Angles(0, 0, math.pi / 2))
        hatLayers[i] = p
    end
    local tp = mkPart(hatModel, Vector3.new(0.2, 0.2, 0.2))
    tp.Transparency = 1
    weld(head, tp, CFrame.new(0, base, 0))
    hatTrail = mkTrail(tp, Vector3.new(0, 0.2, 0), Vector3.new(0, 1.8, 0), 0.8)
end

local function buildWings()
    if wingModel then wingModel:Destroy() wingModel = nil end
    wingItems, wingTrails, wingKind = {}, {}, nil
    local ch = LP.Character
    local tor = ch and (ch:FindFirstChild("UpperTorso") or ch:FindFirstChild("Torso"))
    local kind = cfg.angel and "angel" or (cfg.demon and "demon" or nil)
    if not (tor and kind) then return end
    wingKind = kind
    wingModel = Instance.new("Model")
    wingModel.Name = "LuxxsWings"
    wingModel.Parent = ch
    local W = WING[kind]
    for _, s in ipairs({1, -1}) do
        for i = 1, #W.phi do
            local len = W.len[i]
            local role = (kind == "angel") and "f" or "s"
            local size = (kind == "angel") and Vector3.new(len, 0.85, 0.1) or Vector3.new(len, 0.2, 0.2)
            local p = mkPart(wingModel, size)
            local w = weld(tor, p, CFrame.new())
            wingItems[#wingItems + 1] = {p = p, w = w, s = s, phi = W.phi[i], len = len, i = i, role = role}
            if (kind == "angel" and i == 3) or (kind == "demon" and i == 2) then
                wingTrails[#wingTrails + 1] = mkTrail(p, Vector3.new(s * len / 2, 0.4, 0), Vector3.new(s * len / 2, -0.4, 0), 0.6)
            end
        end
        if kind == "demon" then
            for i = 1, #W.phi - 1 do
                local a, b = W.phi[i], W.phi[i + 1]
                local len = math.min(W.len[i], W.len[i + 1]) * 0.95
                local width = len * math.rad(a - b) * 0.85
                local p = mkPart(wingModel, Vector3.new(len, width, 0.05))
                p.Transparency = 0.1
                local w = weld(tor, p, CFrame.new())
                wingItems[#wingItems + 1] = {p = p, w = w, s = s, phi = (a + b) / 2, len = len, i = i + 10, role = "m"}
            end
        end
    end
end

local function updateHat()
    if not hatModel then return end
    local base = C(cfg.hatColor)
    for i, p in ipairs(hatLayers) do
        if cfg.hatRainbow then
            p.Color = rainbow(i * 0.05)
        else
            p.Color = base:Lerp(Color3.new(1, 1, 1), (i % 2) * 0.18)
        end
    end
    setTrail(hatTrail, cfg.hatTrail, cfg.hatRainbow, base)
end

local function updateWings()
    if not wingModel then return end
    local f = math.sin(T * 3.2)
    local yaw = math.rad(38) + f * 0.28
    for _, it in ipairs(wingItems) do
        local s = it.s
        local ph = math.rad(it.phi) + f * 0.08
        it.w.C0 = CFrame.new(s * 0.5, 0.45, 0.5) * CFrame.Angles(0, -s * yaw, 0)
            * CFrame.Angles(0, 0, s * ph) * CFrame.new(s * it.len / 2, 0, it.i * 0.012)
        it.p.Color = wingCol(wingKind, it.role, it.i)
    end
    local base = wingCol(wingKind, wingKind == "demon" and "m" or "f", 3)
    for _, t in ipairs(wingTrails) do setTrail(t, cfg.wingTrail, cfg.wingRainbow, base) end
end

---------------------------------------------------------------- skins / aimbot / spin / third person
local function applySkin()
    if cfg.skin == "off" then return end
    local s = SKINS[cfg.skin]
    if not s then return end
    local ch = LP.Character
    if not ch then return end
    local col = s.color
    if col == "rainbow" then col = rainbow(0) end
    for _, p in ipairs(ch:GetChildren()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            pcall(function()
                p.Color = col
                p.Material = s.material
                p.Transparency = s.transparency
            end)
        end
    end
end

local function getAimPart(plr)
    local ch = plr.Character
    if not ch then return nil end
    local isR15 = ch:FindFirstChild("UpperTorso") ~= nil
    local names = isR15 and AIM_PARTS_R15[cfg.aimPart] or AIM_PARTS_R6[cfg.aimPart]
    if not names then return nil end
    for _, n in ipairs(names) do
        local p = ch:FindFirstChild(n)
        if p then return p end
    end
    return nil
end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true

local function hasWallBetween(targetPart, targetChar)
    local cam = workspace.CurrentCamera
    if not cam then return false end
    local ignore = {}
    if LP.Character then table.insert(ignore, LP.Character) end
    if targetChar then table.insert(ignore, targetChar) end
    rayParams.FilterDescendantsInstances = ignore
    local origin = cam.CFrame.Position
    local dir = targetPart.Position - origin
    local hit = workspace:Raycast(origin, dir, rayParams)
    if not hit then return false end
    if targetChar and hit.Instance and hit.Instance:IsDescendantOf(targetChar) then return false end
    return true
end

local aimTarget = nil

local function updateAimbot()
    if not cfg.aimbot then aimTarget = nil return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local myPos = cam.CFrame.Position
    local closest, closestDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local ch = plr.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local skip = false
                if cfg.teamCheck and plr.Team and plr.Team == LP.Team then skip = true end
                if not skip then
                    local ap = getAimPart(plr)
                    if ap then
                        local d = (ap.Position - myPos).Magnitude
                        if d < closestDist and d <= cfg.aimRange then
                            if cfg.aimWallCheck and not cfg.wallbang then
                                if hasWallBetween(ap, ch) then
                                    -- blocked
                                else
                                    closest, closestDist = ap, d
                                end
                            else
                                closest, closestDist = ap, d
                            end
                        end
                    end
                end
            end
        end
    end
    aimTarget = closest
    if closest then
        local targetCF = CFrame.new(myPos, closest.Position)
        if cfg.aimSmooth then
            cam.CFrame = cam.CFrame:Lerp(targetCF, 0.18)
        else
            cam.CFrame = targetCF
        end
    end
end

local spinAngle, spinGyro = 0, nil
local function updateSpin(dt)
    local ch = LP.Character
    if not ch then return end
    local root = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if cfg.spin then
        hum.AutoRotate = false
        if not spinGyro or spinGyro.Parent ~= root then
            if spinGyro then spinGyro:Destroy() end
            spinGyro = Instance.new("BodyGyro")
            spinGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            spinGyro.P = 1e6
            spinGyro.D = 1e4
            spinGyro.Parent = root
        end
        spinAngle = (spinAngle + math.rad(cfg.spinSpeed) * (dt or 0)) % (math.pi * 2)
        spinGyro.CFrame = CFrame.Angles(0, spinAngle, 0)
    else
        if spinGyro then spinGyro:Destroy() spinGyro = nil end
        if hum and not hum.AutoRotate then hum.AutoRotate = true end
    end
end

local function updateThirdPerson()
    local cam = workspace.CurrentCamera
    if cfg.thirdPerson then
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if LP.CameraMode ~= Enum.CameraMode.Classic then LP.CameraMode = Enum.CameraMode.Classic end
            local d = cfg.tpDist
            if LP.CameraMinZoomDistance ~= d then LP.CameraMinZoomDistance = d end
            if LP.CameraMaxZoomDistance ~= d then LP.CameraMaxZoomDistance = d end
            if cam then
                if cam.CameraType ~= Enum.CameraType.Custom then cam.CameraType = Enum.CameraType.Custom end
                if cam.CameraSubject ~= hum then cam.CameraSubject = hum end
            end
        end
    else
        if LP.CameraMinZoomDistance ~= 0.5 then LP.CameraMinZoomDistance = 0.5 end
        if LP.CameraMaxZoomDistance ~= 128 then LP.CameraMaxZoomDistance = 128 end
    end
end

---------------------------------------------------------------- ESP (chams, box, lines, nick, skeleton)
local espGui, hlFolder
local objs = {}
local R15B = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}
local R6B = {
    {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"},
}

local function getObj(plr)
    local o = objs[plr]
    if o then return o end
    o = {bones = {}, on = false}
    o.box = new("Frame", {BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false, ZIndex = 2}, espGui)
    o.stroke = new("UIStroke", {Thickness = 1.5}, o.box)
    o.name = new("TextLabel", {
        BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 13, Size = UDim2.fromOffset(160, 14),
        AnchorPoint = Vector2.new(0.5, 1), Visible = false, TextStrokeTransparency = 0.4, ZIndex = 3,
    }, espGui)
    o.line = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Visible = false, ZIndex = 2}, espGui)
    o.hl = new("Highlight", {
        Enabled = false, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, FillTransparency = 0.5, OutlineTransparency = 0,
    }, hlFolder)
    objs[plr] = o
    return o
end

local function hideObj(o)
    o.on = false
    o.box.Visible, o.name.Visible, o.line.Visible = false, false, false
    o.hl.Enabled = false
    for _, b in ipairs(o.bones) do b.Visible = false end
end

local function updateESP()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local any = cfg.chams or cfg.esp or cfg.lines or cfg.nick or cfg.skeleton
    local vp = cam.ViewportSize
    local camPos = cam.CFrame.Position
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local o = objs[plr]
            local ch = plr.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            local root = ch and ch:FindFirstChild("HumanoidRootPart")
            local show = any and hum and root and hum.Health > 0
            if show and cfg.teamCheck and plr.Team and plr.Team == LP.Team then show = false end
            if show and (camPos - root.Position).Magnitude > cfg.maxDist then show = false end
            if not show then
                if o and o.on then hideObj(o) end
            else
                o = o or getObj(plr)
                o.on = true
                local ec = cfg.espRainbow and rainbow(0.2) or C(cfg.espColor)
                if cfg.chams then
                    local hl = o.hl
                    if hl.Adornee ~= ch then hl.Adornee = ch end
                    hl.Enabled = true
                    hl.FillColor = cfg.chamsRainbow and rainbow(0) or C(cfg.chamsFill)
                    hl.OutlineColor = cfg.chamsRainbow and rainbow(0.5) or C(cfg.chamsOutline)
                    hl.FillTransparency = cfg.chamsTrans
                else
                    o.hl.Enabled = false
                end
                local top = cam:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0))
                local bot = cam:WorldToViewportPoint(root.Position - Vector3.new(0, 3.5, 0))
                local vis = top.Z > 0 and bot.Z > 0
                if vis and cfg.esp then
                    local h = math.abs(bot.Y - top.Y)
                    local w = h * 0.55
                    o.box.Position = UDim2.fromOffset(top.X - w / 2, top.Y)
                    o.box.Size = UDim2.fromOffset(w, h)
                    o.stroke.Color = ec
                    o.box.Visible = true
                else
                    o.box.Visible = false
                end
                if vis and cfg.nick then
                    o.name.Text = plr.Name
                    o.name.TextColor3 = ec
                    o.name.Position = UDim2.fromOffset(top.X, top.Y - 2)
                    o.name.Visible = true
                else
                    o.name.Visible = false
                end
                if vis and cfg.lines then
                    setLine(o.line, Vector2.new(vp.X / 2, vp.Y), Vector2.new(bot.X, bot.Y), 1.5, ec)
                else
                    o.line.Visible = false
                end
                if vis and cfg.skeleton then
                    local bones = ch:FindFirstChild("UpperTorso") and R15B or R6B
                    for k, pair in ipairs(bones) do
                        local fr = o.bones[k]
                        if not fr then
                            fr = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Visible = false, ZIndex = 2}, espGui)
                            o.bones[k] = fr
                        end
                        local a, b = ch:FindFirstChild(pair[1]), ch:FindFirstChild(pair[2])
                        if a and b then
                            local pa = cam:WorldToViewportPoint(a.Position)
                            local pb = cam:WorldToViewportPoint(b.Position)
                            if pa.Z > 0 and pb.Z > 0 then
                                setLine(fr, Vector2.new(pa.X, pa.Y), Vector2.new(pb.X, pb.Y), 1.5, ec)
                            else
                                fr.Visible = false
                            end
                        else
                            fr.Visible = false
                        end
                    end
                else
                    for _, fr in ipairs(o.bones) do fr.Visible = false end
                end
            end
        end
    end
end

---------------------------------------------------------------- config files
local fsOK = type(writefile) == "function" and type(readfile) == "function" and type(listfiles) == "function"
    and type(makefolder) == "function" and type(isfolder) == "function"

local function ensureFolder()
    if fsOK and not isfolder(FOLDER) then makefolder(FOLDER) end
end
local function listCfg()
    local out = {}
    if not fsOK then return out end
    pcall(function()
        ensureFolder()
        for _, p in ipairs(listfiles(FOLDER)) do
            local n = p:match("([^/\\]+)%.json$")
            if n then out[#out + 1] = n end
        end
    end)
    table.sort(out)
    return out
end

---------------------------------------------------------------- UI
local COL = {
    bg = Color3.fromRGB(18, 18, 26), panel = Color3.fromRGB(26, 26, 38), item = Color3.fromRGB(34, 34, 50),
    off = Color3.fromRGB(70, 70, 92), text = Color3.fromRGB(235, 235, 245), sub = Color3.fromRGB(150, 150, 172),
}
local FONT = Enum.Font.SourceSansSemibold
local PAL = {"ff3b3b", "ff9d2e", "ffe135", "4cff5a", "2ef0ff", "3b7bff", "8a5cff", "ff4fd8", "ffffff", "222222"}
local accent = C(cfg.menuColor)
local ui = {}
local toast, toastTok = nil, 0
local previewUpdate = function() end

local function notify(msg)
    if not toast then return end
    toastTok = toastTok + 1
    local my = toastTok
    toast.Text = msg
    toast.Visible = true
    task.delay(2, function() if toastTok == my then toast.Visible = false end end)
end

local function newStreak(parent, n)
    local t = {}
    for i = 1, n do
        t[i] = new("Frame", {BorderSizePixel = 0, Size = UDim2.fromOffset(12, 4), ZIndex = 3, Visible = false}, parent)
        corner(t[i], 2)
    end
    return t
end
local function updStreak(t, on, x, y, dx, colfn)
    for i, f in ipairs(t) do
        f.Visible = on and true or false
        if on then
            f.Position = UDim2.fromOffset(x + dx * i * 10 - 6, y + math.sin(T * 4 + i * 0.7) * 4 - 2)
            f.BackgroundColor3 = colfn(i)
            f.BackgroundTransparency = (i / #t) * 0.9
        end
    end
end

local function buildMenu()
    local gui = mkGui("LuxxsMenu", 50)
    local texts, refreshers, accentFns, hooks = {}, {}, {}, {}
    local ord = 0

    local function reg(o, k, prop)
        prop = prop or "Text"
        texts[#texts + 1] = {o = o, k = k, p = prop}
        o[prop] = (type(k) == "function") and k() or tr(k)
    end
    local function applyLang()
        for _, t in ipairs(texts) do
            t.o[t.p] = (type(t.k) == "function") and t.k() or tr(t.k)
        end
    end
    local function refreshAll() for _, f in ipairs(refreshers) do f() end end
    local function changed(k) local h = hooks[k] if h then h() end end

    toast = new("TextLabel", {
        Size = UDim2.fromOffset(260, 30), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 14),
        BackgroundColor3 = COL.bg, TextColor3 = COL.text, Font = FONT, TextSize = 17, Visible = false, ZIndex = 60,
    }, gui)
    corner(toast, 8)

    local root = new("Frame", {
        Size = UDim2.fromOffset(566, 270), Position = UDim2.new(0.5, -283, 0.5, -135),
        BackgroundTransparency = 1, BorderSizePixel = 0,
    }, gui)
    local scale = new("UIScale", {Scale = cfg.menuScale}, root)
    local main = new("Frame", {Size = UDim2.fromOffset(380, 270), BackgroundColor3 = COL.bg, BorderSizePixel = 0, Active = true}, root)
    corner(main, 10)
    local mstroke = new("UIStroke", {Color = accent, Thickness = 1.5}, main)
    accentFns[#accentFns + 1] = function() mstroke.Color = accent end
    local pvf = new("Frame", {
        Size = UDim2.fromOffset(176, 270), Position = UDim2.fromOffset(390, 0),
        BackgroundColor3 = COL.bg, BorderSizePixel = 0, Active = true,
    }, root)
    corner(pvf, 10)
    local pstroke = new("UIStroke", {Color = accent, Thickness = 1.5}, pvf)
    accentFns[#accentFns + 1] = function() pstroke.Color = accent end

    local function header(parent)
        local h = new("Frame", {Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = COL.panel, BorderSizePixel = 0}, parent)
        corner(h, 10)
        new("Frame", {Size = UDim2.new(1, 0, 0, 10), Position = UDim2.fromOffset(0, 18), BackgroundColor3 = COL.panel, BorderSizePixel = 0}, h)
        return h
    end
    local hdr = header(main)
    ui.title = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(0.5, 0, 1, 0),
        Text = "LUXXS", Font = Enum.Font.GothamBlack, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1, 1, 1),
    }, hdr)
    local closeBtn = new("TextButton", {
        Text = "—", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = COL.text, BackgroundColor3 = COL.item,
        Size = UDim2.fromOffset(28, 20), Position = UDim2.new(1, -34, 0, 4), BorderSizePixel = 0,
    }, hdr)
    corner(closeBtn, 5)
    closeBtn.MouseButton1Click:Connect(function() root.Visible = false end)
    makeDraggable(hdr, root)

    local phdr = header(pvf)
    local ptitle = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -10, 1, 0),
        Font = FONT, TextSize = 17, TextColor3 = COL.text, TextXAlignment = Enum.TextXAlignment.Left,
    }, phdr)
    reg(ptitle, "preview")
    makeDraggable(phdr, root)

    local icon = new("TextButton", {
        Size = UDim2.fromOffset(46, 46), Position = UDim2.new(0, 16, 0.5, -23), BackgroundColor3 = COL.bg,
        Text = "LX", Font = Enum.Font.GothamBlack, TextSize = 17, TextColor3 = Color3.new(1, 1, 1),
        AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 20,
    }, gui)
    corner(icon, 23)
    ui.iconStroke = new("UIStroke", {Thickness = 2.5, Color = accent}, icon)
    makeDraggable(icon, icon, function() root.Visible = not root.Visible end)

    local pages, tabBtn, cur = {}, {}, "visuals"
    local function newPage(name)
        local p = new("ScrollingFrame", {
            Size = UDim2.new(1, -12, 1, -66), Position = UDim2.fromOffset(6, 60), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 3, AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(), Visible = false, ScrollBarImageColor3 = accent,
        }, main)
        new("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, p)
        accentFns[#accentFns + 1] = function() p.ScrollBarImageColor3 = accent end
        pages[name] = p
        return p
    end
    local function selectTab(n)
        cur = n
        for k, p in pairs(pages) do p.Visible = (k == n) end
        for k, b in pairs(tabBtn) do b.BackgroundColor3 = (k == n) and accent or COL.item end
    end
    accentFns[#accentFns + 1] = function() selectTab(cur) end

    local tbar = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 32), Size = UDim2.new(1, -12, 0, 24)}, main)
    new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 3)}, tbar)
    local TAB_LIST = {"visuals", "combat", "skins", "players", "settings", "config", "info"}
    local TAB_W = 1 / #TAB_LIST
    for _, name in ipairs(TAB_LIST) do
        local b = new("TextButton", {
            Size = UDim2.new(TAB_W, -3, 1, 0), BackgroundColor3 = COL.item, Font = FONT, TextSize = 12,
            TextColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, AutoButtonColor = false, TextScaled = true,
        }, tbar)
        corner(b, 6)
        reg(b, name)
        b.MouseButton1Click:Connect(function() selectTab(name) end)
        tabBtn[name] = b
        newPage(name)
    end

    local function row(page, h)
        ord = ord + 1
        local f = new("Frame", {Size = UDim2.new(1, -8, 0, h), BackgroundColor3 = COL.item, BorderSizePixel = 0, LayoutOrder = ord}, page)
        corner(f, 6)
        return f
    end
    local function lbl(parent, k, props)
        local l = new("TextLabel", {
            BackgroundTransparency = 1, Font = FONT, TextSize = 16, TextColor3 = COL.text,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        }, parent)
        for a, b in pairs(props or {}) do l[a] = b end
        reg(l, k)
        return l
    end
    local function button(parent, k, size, pos, cb)
        local b = new("TextButton", {
            Size = size, Position = pos or UDim2.new(), BackgroundColor3 = accent, Font = FONT, TextSize = 16,
            TextColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
        }, parent)
        corner(b, 6)
        reg(b, k)
        accentFns[#accentFns + 1] = function() b.BackgroundColor3 = accent end
        b.MouseButton1Click:Connect(cb)
        return b
    end
    local function btnRow(page, defs)
        local f = row(page, 30)
        f.BackgroundTransparency = 1
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, f)
        local n = #defs
        for _, d in ipairs(defs) do
            button(f, d[1], UDim2.new(1 / n, -6 * (n - 1) / n, 1, 0), nil, d[2])
        end
    end

    local function toggle(page, key)
        local f = row(page, 30)
        lbl(f, key, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -60, 1, 0)})
        local sw = new("TextButton", {
            Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(38, 18), Position = UDim2.new(1, -46, 0.5, -9),
            BackgroundColor3 = COL.off, BorderSizePixel = 0,
        }, f)
        corner(sw, 9)
        local dot = new("Frame", {Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(2, 2), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, sw)
        corner(dot, 7)
        local function refresh()
            local on = cfg[key]
            sw.BackgroundColor3 = on and accent or COL.off
            TweenService:Create(dot, TweenInfo.new(0.12), {Position = on and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)}):Play()
        end
        refresh()
        refreshers[#refreshers + 1] = refresh
        accentFns[#accentFns + 1] = refresh
        sw.MouseButton1Click:Connect(function()
            cfg[key] = not cfg[key]
            refresh()
            changed(key)
        end)
    end

    local function slider(page, key, mn, mx, step, fmt)
        local f = row(page, 46)
        lbl(f, key, {Position = UDim2.fromOffset(10, 2), Size = UDim2.new(1, -80, 0, 20)})
        local val = new("TextLabel", {
            BackgroundTransparency = 1, Font = FONT, TextSize = 16, TextColor3 = COL.sub,
            Position = UDim2.new(1, -66, 0, 2), Size = UDim2.fromOffset(56, 20), TextXAlignment = Enum.TextXAlignment.Right,
        }, f)
        local bar = new("Frame", {Position = UDim2.new(0, 10, 0, 33), Size = UDim2.new(1, -20, 0, 8), BackgroundColor3 = COL.off, BorderSizePixel = 0}, f)
        corner(bar, 4)
        local fill = new("Frame", {BackgroundColor3 = accent, BorderSizePixel = 0, Size = UDim2.fromScale(0, 1)}, bar)
        corner(fill, 4)
        local knob = new("Frame", {
            Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5),
            BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
        }, bar)
        corner(knob, 7)
        local hit = new("TextButton", {Text = "", BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 22), Size = UDim2.new(1, 0, 0, 24)}, f)
        local function refresh()
            local r = (cfg[key] - mn) / (mx - mn)
            fill.Size = UDim2.fromScale(r, 1)
            knob.Position = UDim2.fromScale(r, 0.5)
            val.Text = string.format(fmt or "%.2f", cfg[key])
            fill.BackgroundColor3 = accent
        end
        refresh()
        refreshers[#refreshers + 1] = refresh
        accentFns[#accentFns + 1] = refresh
        local dragging = false
        local function setX(x)
            local r = math.clamp((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
            local v = math.floor((mn + (mx - mn) * r) / step + 0.5) * step
            cfg[key] = math.clamp(v, mn, mx)
            refresh()
            changed(key)
        end
        hit.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                page.ScrollingEnabled = false
                setX(i.Position.X)
            end
        end)
        bind(UIS.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                setX(i.Position.X)
            end
        end))
        bind(UIS.InputEnded:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
                dragging = false
                page.ScrollingEnabled = true
            end
        end))
    end

    local function colorRow(page, key, auto)
        local f = row(page, 54)
        lbl(f, key, {Position = UDim2.fromOffset(10, 2), Size = UDim2.new(1, -20, 0, 20)})
        local holder = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 27), Size = UDim2.new(1, -20, 0, 22)}, f)
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5)}, holder)
        local sw = {}
        local function refresh()
            for h, st in pairs(sw) do st.Enabled = (cfg[key] == h) end
        end
        local list = {}
        if auto then list[1] = "auto" end
        for _, h in ipairs(PAL) do list[#list + 1] = h end
        for _, h in ipairs(list) do
            local b = new("TextButton", {
                Size = UDim2.fromOffset(22, 22), Text = (h == "auto") and "A" or "", Font = Enum.Font.GothamBold, TextSize = 13,
                TextColor3 = Color3.new(1, 1, 1), BackgroundColor3 = (h == "auto") and COL.off or C(h),
                BorderSizePixel = 0, AutoButtonColor = false,
            }, holder)
            corner(b, 5)
            sw[h] = new("UIStroke", {Color = Color3.new(1, 1, 1), Thickness = 2, Enabled = false}, b)
            b.MouseButton1Click:Connect(function()
                cfg[key] = h
                refresh()
                changed(key)
            end)
        end
        refresh()
        refreshers[#refreshers + 1] = refresh
    end

    ---------------------------------------------------------- VISUALS page
    local pv_ = pages.visuals
    toggle(pv_, "hat")
    toggle(pv_, "hatRainbow")
    colorRow(pv_, "hatColor")
    toggle(pv_, "hatTrail")
    toggle(pv_, "angel")
    toggle(pv_, "demon")
    toggle(pv_, "wingRainbow")
    colorRow(pv_, "wingColor", true)
    toggle(pv_, "wingTrail")
    toggle(pv_, "spin")
    slider(pv_, "spinSpeed", 100, 3600, 50, "%.0f")
    hooks.hat = buildHat
    hooks.angel = function() if cfg.angel then cfg.demon = false end refreshAll() buildWings() end
    hooks.demon = function() if cfg.demon then cfg.angel = false end refreshAll() buildWings() end

    ---------------------------------------------------------- COMBAT page
    local pc_ = pages.combat
    toggle(pc_, "aimbot")
    toggle(pc_, "aimSmooth")
    toggle(pc_, "aimWallCheck")
    toggle(pc_, "wallbang")
    slider(pc_, "aimRange", 100, 5000, 50, "%.0f")
    do
        local f = row(pc_, 30)
        ui.aimLabel = lbl(f, function() return tr("aimPart") .. ": " .. (AIM_PART_NAMES[cfg.aimPart] or "") end,
            {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), TextColor3 = Color3.fromRGB(255, 80, 80)})
    end

    ---------------------------------------------------------- SKINS page
    local pks = pages.skins
    do
        local holder = new("Frame", {
            Size = UDim2.new(1, -8, 0, 0), BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1,
        }, pks)
        new("UIListLayout", {Padding = UDim.new(0, 5)}, holder)
        local btns = {}
        local function refresh()
            for k, b in pairs(btns) do
                if cfg.skin == k then
                    b.BackgroundColor3 = accent
                else
                    b.BackgroundColor3 = COL.item
                end
            end
        end
        for _, k in ipairs(SKIN_ORDER) do
            local b = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 34), Font = Enum.Font.GothamBold, TextSize = 16,
                Text = SKIN_LABELS[k], TextColor3 = Color3.new(1, 1, 1), BackgroundColor3 = COL.item,
                BorderSizePixel = 0, AutoButtonColor = false, LayoutOrder = #btns + 1,
            }, holder)
            corner(b, 6)
            local chip = new("Frame", {
                Size = UDim2.fromOffset(20, 20), Position = UDim2.new(1, -28, 0.5, -10),
                BackgroundColor3 = SKIN_COLORS[k], BorderSizePixel = 0,
            }, b)
            corner(chip, 5)
            btns[k] = b
            b.MouseButton1Click:Connect(function()
                cfg.skin = k
                refresh()
            end)
        end
        refresh()
        refreshers[#refreshers + 1] = refresh
        accentFns[#accentFns + 1] = refresh
    end

    ---------------------------------------------------------- PLAYERS page
    local pp = pages.players
    toggle(pp, "chams")
    toggle(pp, "chamsRainbow")
    colorRow(pp, "chamsFill")
    colorRow(pp, "chamsOutline")
    slider(pp, "chamsTrans", 0, 1, 0.05, "%.2f")
    toggle(pp, "esp")
    toggle(pp, "lines")
    toggle(pp, "nick")
    toggle(pp, "skeleton")
    toggle(pp, "espRainbow")
    colorRow(pp, "espColor")
    toggle(pp, "teamCheck")
    slider(pp, "maxDist", 100, 5000, 100, "%.0f")

    ---------------------------------------------------------- SETTINGS page
    local ps = pages.settings
    slider(ps, "menuScale", 0.6, 1.3, 0.05, "%.2f")
    colorRow(ps, "menuColor")
    toggle(ps, "thirdPerson")
    slider(ps, "tpDist", 5, 60, 1, "%.0f")
    do
        local f = row(ps, 52)
        lbl(f, "language", {Position = UDim2.fromOffset(10, 2), Size = UDim2.new(1, -20, 0, 20)})
        local holder = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 26), Size = UDim2.new(1, -20, 0, 22)}, f)
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, holder)
        local btns = {}
        local function refresh()
            for code, b in pairs(btns) do b.BackgroundColor3 = (cfg.lang == code) and accent or COL.off end
        end
        for _, code in ipairs({"en", "ru", "kz"}) do
            local b = new("TextButton", {
                Text = code:upper(), Size = UDim2.new(1 / 3, -4, 1, 0), Font = Enum.Font.GothamBold, TextSize = 14,
                TextColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, BackgroundColor3 = COL.off,
            }, holder)
            corner(b, 5)
            btns[code] = b
            b.MouseButton1Click:Connect(function()
                cfg.lang = code
                applyLang()
                refresh()
            end)
        end
        refresh()
        refreshers[#refreshers + 1] = refresh
        accentFns[#accentFns + 1] = refresh
    end
    hooks.menuScale = function() scale.Scale = cfg.menuScale end
    hooks.menuColor = function()
        accent = C(cfg.menuColor)
        for _, f in ipairs(accentFns) do f() end
    end

    ---------------------------------------------------------- CONFIG page
    local pcf = pages.config
    local nameBox
    do
        local f = row(pcf, 34)
        nameBox = new("TextBox", {
            BackgroundColor3 = COL.panel, Size = UDim2.new(1, -16, 0, 24), Position = UDim2.fromOffset(8, 5), Font = FONT,
            TextSize = 16, TextColor3 = COL.text, PlaceholderColor3 = COL.sub, Text = "default", ClearTextOnFocus = false,
            BorderSizePixel = 0,
        }, f)
        corner(nameBox, 5)
        reg(nameBox, "cfgName", "PlaceholderText")
    end
    local listBox
    local function refreshList()
        for _, c in ipairs(listBox:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for n, name in ipairs(listCfg()) do
            local b = new("TextButton", {
                Size = UDim2.new(1, -16, 0, 24), BackgroundColor3 = COL.panel, Font = FONT, TextSize = 16,
                TextColor3 = COL.text, Text = name, BorderSizePixel = 0, LayoutOrder = n,
            }, listBox)
            corner(b, 5)
            b.MouseButton1Click:Connect(function() nameBox.Text = name end)
        end
    end
    local function cleanName() return (nameBox.Text:gsub("[^%w_%-]", "")) end
    local function applyAll()
        accent = C(cfg.menuColor)
        scale.Scale = cfg.menuScale
        for _, f in ipairs(accentFns) do f() end
        applyLang()
        refreshAll()
        buildHat()
        buildWings()
    end
    btnRow(pcf, {
        {"save", function()
            if not fsOK then return notify(tr("noFS")) end
            local n = cleanName()
            if n == "" then return notify(tr("msgName")) end
            local ok = pcall(function()
                ensureFolder()
                writefile(FOLDER .. "/" .. n .. ".json", HttpService:JSONEncode(cfg))
            end)
            if ok then notify(tr("msgSaved")) refreshList() end
        end},
        {"load", function()
            if not fsOK then return notify(tr("noFS")) end
            local n = cleanName()
            if n == "" then return notify(tr("msgName")) end
            local path = FOLDER .. "/" .. n .. ".json"
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
            if not ok or type(data) ~= "table" then return notify(tr("msgNone")) end
            for k, v in pairs(data) do
                if cfg[k] ~= nil and type(cfg[k]) == type(v) then cfg[k] = v end
            end
            if cfg.angel and cfg.demon then cfg.demon = false end
            applyAll()
            notify(tr("msgLoaded"))
        end},
        {"delete", function()
            if not fsOK or type(delfile) ~= "function" then return notify(tr("noFS")) end
            local n = cleanName()
            local ok = pcall(function() delfile(FOLDER .. "/" .. n .. ".json") end)
            if ok then notify(tr("msgDeleted")) refreshList() else notify(tr("msgNone")) end
        end},
    })
    btnRow(pcf, {{"refresh", function() refreshList() end}})
    do
        local h = row(pcf, 22)
        h.BackgroundTransparency = 1
        lbl(h, "cfgList", {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.fromOffset(4, 0), TextColor3 = COL.sub})
        ord = ord + 1
        listBox = new("Frame", {
            Size = UDim2.new(1, -8, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = ord,
        }, pcf)
        new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, listBox)
    end
    refreshList()

    ---------------------------------------------------------- INFO page
    local pi = pages.info
    do
        local f = row(pi, 34)
        lbl(f, "about", {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Font = Enum.Font.GothamBold, TextSize = 15})
        local f2 = row(pi, 34)
        lbl(f2, function() return tr("created") .. ": " .. CREATED[cfg.lang] end,
            {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0)})
        local f3 = row(pi, 64)
        lbl(f3, "tgAd", {Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -20, 0, 36), TextWrapped = true, TextTruncate = Enum.TextTruncate.None, TextYAlignment = Enum.TextYAlignment.Top})
        new("TextLabel", {
            BackgroundTransparency = 1, Font = FONT, TextSize = 15, TextColor3 = accent, Text = TG,
            Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 0, 18), TextXAlignment = Enum.TextXAlignment.Left,
        }, f3)
        btnRow(pi, {{"copyLink", function()
            if copy(TG) then notify(tr("copied")) else notify(TG) end
        end}})
    end

    ---------------------------------------------------------- PREVIEW
    local CX = 82
    local GREY = Color3.fromRGB(160, 160, 168)
    local view = new("Frame", {
        Position = UDim2.fromOffset(6, 32), Size = UDim2.fromOffset(164, 232), BackgroundColor3 = Color3.fromRGB(14, 14, 20),
        BorderSizePixel = 0, ClipsDescendants = true,
    }, pvf)
    corner(view, 8)
    local function pf(x, y, w, h, z)
        return new("Frame", {Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h), BackgroundColor3 = GREY, BorderSizePixel = 0, ZIndex = z or 2}, view)
    end
    local pv = {body = {}, hat = {}, wings = {}, bones = {}}

    for _, s in ipairs({1, -1}) do
        local w = {s = s, f = {}, m = {}, streak = newStreak(view, 5)}
        for i = 1, 7 do
            w.f[i] = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, ZIndex = 1, Visible = false}, view)
            corner(w.f[i], 3)
        end
        for i = 1, 4 do
            w.m[i] = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, ZIndex = 1, Visible = false}, view)
        end
        pv.wings[#pv.wings + 1] = w
    end

    local function body(x, y, w, h, r, key)
        local f = pf(x, y, w, h, 2)
        corner(f, r)
        local st = new("UIStroke", {Thickness = 1.5, Enabled = false}, f)
        local stAim = new("UIStroke", {Thickness = 3, Enabled = false, Color = Color3.fromRGB(255, 0, 0), Transparency = 0.35}, f)
        local btn = new("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 7, BorderSizePixel = 0}, f)
        btn.MouseButton1Click:Connect(function() cfg.aimPart = key end)
        pv.body[#pv.body + 1] = {f = f, st = st, stAim = stAim}
    end
    body(CX - 13, 56, 26, 26, 13, "head")
    body(CX - 18, 84, 36, 50, 5, "torso")
    body(CX - 29, 86, 10, 46, 4, "armL")
    body(CX + 19, 86, 10, 46, 4, "armR")
    body(CX - 17, 136, 15, 58, 4, "legL")
    body(CX + 2, 136, 15, 58, 4, "legR")

    for i = 1, 8 do
        local w = (4.4 - (i - 1) * 0.5) * 11
        local f = pf(CX - w / 2, 56 - 4 * i, w, 4, 3)
        f.Visible = false
        pv.hat[i] = f
    end
    pv.hatStreak = newStreak(view, 7)

    pv.box = new("Frame", {Position = UDim2.fromOffset(CX - 46, 14), Size = UDim2.fromOffset(92, 184), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 4, Visible = false}, view)
    pv.boxStroke = new("UIStroke", {Thickness = 1.5}, pv.box)
    pv.nick = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(164, 13), Text = "Player",
        Font = Enum.Font.GothamBold, TextSize = 12, ZIndex = 5, Visible = false, TextStrokeTransparency = 0.5,
    }, view)
    pv.line = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, ZIndex = 4, Visible = false}, view)

    pv.aimDot = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 0.35,
        BorderSizePixel = 0, ZIndex = 9, Visible = false,
    }, view)
    corner(pv.aimDot, 6)
    local aimDotCur = nil

    local J = {
        head = {CX, 69}, neck = {CX, 84}, shL = {CX - 16, 90}, shR = {CX + 16, 90}, elL = {CX - 24, 112}, elR = {CX + 24, 112},
        haL = {CX - 24, 132}, haR = {CX + 24, 132}, hip = {CX, 134}, knL = {CX - 9, 164}, knR = {CX + 9, 164},
        ftL = {CX - 9, 192}, ftR = {CX + 9, 192},
    }
    local PB = {
        {"head", "neck"}, {"neck", "hip"}, {"neck", "shL"}, {"neck", "shR"}, {"shL", "elL"}, {"elL", "haL"},
        {"shR", "elR"}, {"elR", "haR"}, {"hip", "knL"}, {"knL", "ftL"}, {"hip", "knR"}, {"knR", "ftR"},
    }
    for k = 1, #PB do
        pv.bones[k] = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, ZIndex = 6, Visible = false}, view)
    end
    local function V(n) return Vector2.new(J[n][1], J[n][2]) end

    local AIM_DOT_POS = {
        head = {CX, 69}, torso = {CX, 109}, armL = {CX - 24, 109}, armR = {CX + 24, 109},
        legL = {CX - 9, 165}, legR = {CX + 9, 165},
    }
    local AIM_IDX = {head = 1, torso = 2, armL = 3, armR = 4, legL = 5, legR = 6}

    previewUpdate = function()
        for _, p in ipairs(pv.body) do
            if cfg.chams then
                p.f.BackgroundColor3 = cfg.chamsRainbow and rainbow(0) or C(cfg.chamsFill)
                p.f.BackgroundTransparency = cfg.chamsTrans * 0.7
                p.st.Enabled = true
                p.st.Color = cfg.chamsRainbow and rainbow(0.5) or C(cfg.chamsOutline)
            else
                p.f.BackgroundColor3 = GREY
                p.f.BackgroundTransparency = 0
                p.st.Enabled = false
            end
        end
        local selIdx = AIM_IDX[cfg.aimPart]
        for i, p in ipairs(pv.body) do
            if cfg.aimbot and i == selIdx then
                p.stAim.Enabled = true
                p.stAim.Color = Color3.fromRGB(255, 0, 0)
                p.stAim.Transparency = 0.35
            else
                p.stAim.Enabled = false
            end
        end
        local hb = C(cfg.hatColor)
        for i, f in ipairs(pv.hat) do
            f.Visible = cfg.hat
            if cfg.hat then
                f.BackgroundColor3 = cfg.hatRainbow and rainbow(i * 0.05) or hb:Lerp(Color3.new(1, 1, 1), (i % 2) * 0.18)
            end
        end
        updStreak(pv.hatStreak, cfg.hat and cfg.hatTrail, CX - 28, 38, -1, function(i)
            return cfg.hatRainbow and rainbow(i * 0.08) or hb
        end)
        local kind = cfg.angel and "angel" or (cfg.demon and "demon" or nil)
        local W = kind and WING[kind]
        local fl = math.sin(T * 3.2) * 7
        for _, w in ipairs(pv.wings) do
            local s = w.s
            local px, py = CX + s * 16, 90
            for i = 1, 7 do
                local fr = w.f[i]
                if W and W.phi[i] then
                    local len = W.len[i] * 11
                    local ph = W.phi[i] + fl
                    local r = math.rad(ph)
                    fr.Size = UDim2.fromOffset(len, kind == "angel" and 7 or 3)
                    fr.Position = UDim2.fromOffset(px + s * math.cos(r) * len / 2, py - math.sin(r) * len / 2)
                    fr.Rotation = -s * ph
                    fr.BackgroundColor3 = wingCol(kind, kind == "angel" and "f" or "s", i)
                    fr.Visible = true
                else
                    fr.Visible = false
                end
            end
            for i = 1, 4 do
                local fr = w.m[i]
                if kind == "demon" and i < #W.phi then
                    local a, b = W.phi[i], W.phi[i + 1]
                    local len = math.min(W.len[i], W.len[i + 1]) * 0.95 * 11
                    local mid = (a + b) / 2 + fl
                    local r = math.rad(mid)
                    fr.Size = UDim2.fromOffset(len, len * math.rad(a - b) * 0.8)
                    fr.Position = UDim2.fromOffset(px + s * math.cos(r) * len / 2, py - math.sin(r) * len / 2)
                    fr.Rotation = -s * mid
                    fr.BackgroundColor3 = wingCol("demon", "m", i)
                    fr.BackgroundTransparency = 0.2
                    fr.Visible = true
                else
                    fr.Visible = false
                end
            end
            if kind and cfg.wingTrail then
                local idx = (kind == "angel") and 3 or 2
                local len = W.len[idx] * 11
                local r = math.rad(W.phi[idx] + fl)
                updStreak(w.streak, true, px + s * math.cos(r) * len, py - math.sin(r) * len, s, function(i)
                    return cfg.wingRainbow and rainbow(i * 0.08) or wingCol(kind, kind == "demon" and "m" or "f", 3)
                end)
            else
                updStreak(w.streak, false, 0, 0, 1, nil)
            end
        end
        local ec = cfg.espRainbow and rainbow(0.2) or C(cfg.espColor)
        pv.box.Visible = cfg.esp
        pv.boxStroke.Color = ec
        pv.nick.Visible = cfg.nick
        pv.nick.TextColor3 = ec
        if cfg.lines then
            setLine(pv.line, Vector2.new(CX, 232), Vector2.new(CX, 198), 2, ec)
        else
            pv.line.Visible = false
        end
        for k, pair in ipairs(PB) do
            if cfg.skeleton then
                setLine(pv.bones[k], V(pair[1]), V(pair[2]), 2, ec)
            else
                pv.bones[k].Visible = false
            end
        end
        if cfg.aimbot then
            local tgt = AIM_DOT_POS[cfg.aimPart] or AIM_DOT_POS.head
            local tv = Vector2.new(tgt[1], tgt[2])
            if not aimDotCur then aimDotCur = tv end
            aimDotCur = aimDotCur:Lerp(tv, 0.2)
            pv.aimDot.Position = UDim2.fromOffset(aimDotCur.X, aimDotCur.Y)
            pv.aimDot.Visible = true
        else
            pv.aimDot.Visible = false
        end
        if ui.aimLabel then
            local txt = tr("aimPart") .. ": " .. (AIM_PART_NAMES[cfg.aimPart] or "")
            if ui.aimLabel.Text ~= txt then ui.aimLabel.Text = txt end
        end
    end

    selectTab("visuals")
    applyLang()
    ui.iconStroke.Color = accent
end

---------------------------------------------------------------- start
local function start()
    espGui = mkGui("LuxxsESP", 5)
    hlFolder = Instance.new("Folder")
    hlFolder.Name = "LuxxsHL"
    pcall(function() hlFolder.Parent = GUIP end)
    if not hlFolder.Parent then hlFolder.Parent = workspace end
    track(hlFolder)

    buildMenu()

    bind(Players.PlayerRemoving:Connect(function(p)
        local o = objs[p]
        if o then
            o.box:Destroy() o.name:Destroy() o.line:Destroy() o.hl:Destroy()
            for _, b in ipairs(o.bones) do b:Destroy() end
            objs[p] = nil
        end
    end))
    bind(LP.CharacterAdded:Connect(function(ch)
        task.spawn(function()
            ch:WaitForChild("Head", 10)
            ch:WaitForChild("HumanoidRootPart", 10)
            task.wait(0.5)
            buildHat()
            buildWings()
        end)
    end))
    if LP.Character then
        buildHat()
        buildWings()
    end
    bind(RunService.RenderStepped:Connect(function(dt)
        T = tick()
        pcall(updateHat)
        pcall(updateWings)
        pcall(updateESP)
        pcall(previewUpdate)
        pcall(function() updateSpin(dt) end)
        pcall(updateThirdPerson)
        pcall(updateAimbot)
        pcall(applySkin)
        if ui.title then
            ui.title.TextColor3 = rainbow(0)
            ui.iconStroke.Color = rainbow(0.3)
        end
    end))
end

---------------------------------------------------------------- key system
local function keySystem(onOk)
    local g = mkGui("LuxxsKey", 100)
    local dim = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.35, BorderSizePixel = 0}, g)
    local card = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(340, 230),
        BackgroundColor3 = Color3.fromRGB(16, 16, 24), BorderSizePixel = 0,
    }, g)
    corner(card, 14)
    local cst = new("UIStroke", {Thickness = 2.5, Color = Color3.new(1, 1, 1)}, card)

    local word = "LUXXS"
    local letters, big = {}, {}
    local t0 = tick()
    for i = 1, #word do
        local l = new("TextLabel", {
            BackgroundTransparency = 1, Size = UDim2.fromOffset(46, 56), Position = UDim2.fromOffset(55 + (i - 1) * 46, -40),
            Text = word:sub(i, i), Font = Enum.Font.GothamBlack, TextSize = 50, TextTransparency = 1, TextColor3 = Color3.new(1, 1, 1),
        }, card)
        letters[i] = l
        task.delay((i - 1) * 0.13, function()
            TweenService:Create(l, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.fromOffset(55 + (i - 1) * 46, 16), TextTransparency = 0,
            }):Play()
        end)
    end

    local sub = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 80), Size = UDim2.fromOffset(300, 20),
        Text = "Enter your key to continue", Font = Enum.Font.GothamMedium, TextSize = 14, TextColor3 = Color3.fromRGB(170, 170, 190),
    }, card)
    local box = new("TextBox", {
        Position = UDim2.fromOffset(20, 108), Size = UDim2.fromOffset(300, 36), BackgroundColor3 = Color3.fromRGB(30, 30, 44),
        Font = Enum.Font.GothamMedium, TextSize = 16, TextColor3 = Color3.new(1, 1, 1), PlaceholderText = "Key...",
        PlaceholderColor3 = Color3.fromRGB(120, 120, 140), Text = "", ClearTextOnFocus = false, BorderSizePixel = 0,
    }, card)
    corner(box, 8)
    local unlock = new("TextButton", {
        Position = UDim2.fromOffset(20, 152), Size = UDim2.fromOffset(190, 34), BackgroundColor3 = Color3.fromRGB(138, 92, 255),
        Text = "Unlock", Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
    }, card)
    corner(unlock, 8)
    local getKey = new("TextButton", {
        Position = UDim2.fromOffset(220, 152), Size = UDim2.fromOffset(100, 34), BackgroundColor3 = Color3.fromRGB(40, 40, 58),
        Text = "Get key", Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
    }, card)
    corner(getKey, 8)
    local status = new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 194), Size = UDim2.fromOffset(300, 24),
        Text = "t.me/NurHuboffical", Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = Color3.fromRGB(130, 130, 150),
    }, card)

    local done = false
    local conn
    conn = RunService.RenderStepped:Connect(function()
        T = tick()
        cst.Color = rainbow(0)
        unlock.BackgroundColor3 = rainbow(0.1):Lerp(Color3.fromRGB(138, 92, 255), 0.5)
        local waving = (tick() - t0) > 1.5
        for i, l in ipairs(letters) do
            l.TextColor3 = rainbow(i * 0.1)
            if waving and not done then
                l.Position = UDim2.fromOffset(55 + (i - 1) * 46, 16 + math.sin(T * 3 + i * 0.7) * 4)
            end
        end
        for i, b in ipairs(big) do b.TextColor3 = rainbow(i * 0.12) end
    end)
    bind(conn)

    getKey.MouseButton1Click:Connect(function()
        status.TextColor3 = Color3.fromRGB(130, 200, 255)
        status.Text = copy(TG) and "Telegram link copied!" or TG
    end)

    local function submit()
        if done then return end
        local v = (box.Text:gsub("%s", ""))
        if v:upper() == KEY then
            done = true
            status.TextColor3 = Color3.fromRGB(80, 255, 120)
            status.Text = "Access granted"
            task.spawn(function()
                task.wait(0.35)
                card.Visible = false
                for i = 1, #word do
                    local l = new("TextLabel", {
                        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, (i - 3) * 74, 0.5, 70), Size = UDim2.fromOffset(74, 110),
                        BackgroundTransparency = 1, Text = word:sub(i, i), Font = Enum.Font.GothamBlack, TextSize = 90,
                        TextTransparency = 1, TextColor3 = Color3.new(1, 1, 1),
                    }, g)
                    local st = new("UIStroke", {Thickness = 3, Color = Color3.new(1, 1, 1), Transparency = 1}, l)
                    big[i] = l
                    task.delay((i - 1) * 0.12, function()
                        TweenService:Create(l, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Position = UDim2.new(0.5, (i - 3) * 74, 0.5, 0), TextTransparency = 0,
                        }):Play()
                        TweenService:Create(st, TweenInfo.new(0.5), {Transparency = 0.3}):Play()
                    end)
                end
                task.wait(2.0)
                for _, l in ipairs(big) do
                    TweenService:Create(l, TweenInfo.new(0.5), {TextTransparency = 1, Position = l.Position + UDim2.fromOffset(0, -30)}):Play()
                    local st = l:FindFirstChildOfClass("UIStroke")
                    if st then TweenService:Create(st, TweenInfo.new(0.5), {Transparency = 1}):Play() end
                end
                TweenService:Create(dim, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                task.wait(0.6)
                conn:Disconnect()
                g:Destroy()
                onOk()
            end)
        else
            status.TextColor3 = Color3.fromRGB(255, 80, 80)
            status.Text = "Wrong key"
            task.spawn(function()
                local p = card.Position
                for i = 1, 6 do
                    card.Position = p + UDim2.fromOffset(i % 2 == 0 and 9 or -9, 0)
                    task.wait(0.04)
                end
                card.Position = p
            end)
        end
    end
    unlock.MouseButton1Click:Connect(submit)
    box.FocusLost:Connect(function(enter) if enter then submit() end end)
end

keySystem(start)
