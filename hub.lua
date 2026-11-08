-- MIDDAY Hub v2.2 — tabs e conteúdo fixos
-- Key: KEY-MIDDAYCHEAT

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera       = workspace.CurrentCamera
local LP           = Players.LocalPlayer

local C_ACC = Color3.fromRGB(79,142,247)
local C_BG  = Color3.fromRGB(13,13,26)
local C_BG2 = Color3.fromRGB(17,17,32)
local C_BG3 = Color3.fromRGB(26,26,48)
local C_TXT = Color3.fromRGB(200,200,220)
local C_DIM = Color3.fromRGB(68,68,90)
local C_RED = Color3.fromRGB(255,70,90)
local C_GRN = Color3.fromRGB(0,210,90)

local S = {
    Auth=false,
    ESP=false, ESPHp=false, ESPName=false, ESPDist=false,
    WH=false, WHp={},
    AB=false, ABFOV=150, ABSmooth=15,
    SA=false,
}

-- ── Helpers ───────────────────────────────────
local function tw(o,p,t)
    TweenService:Create(o,TweenInfo.new(t or .15),p):Play()
end

local function N(cls,p,par)
    local o=Instance.new(cls)
    for k,v in pairs(p) do pcall(function() o[k]=v end) end
    if par then o.Parent=par end
    return o
end

local function Corn(o,r)
    N("UICorner",{CornerRadius=UDim.new(0,r or 10)},o)
end

local function Stroke(o,c,t)
    N("UIStroke",{Color=c or C_BG3,Thickness=t or 1},o)
end

local function VL(o,gap)
    N("UIListLayout",{
        FillDirection=Enum.FillDirection.Vertical,
        SortOrder=Enum.SortOrder.LayoutOrder,
        Padding=UDim.new(0,gap or 8)
    },o)
end

local function Pad(o,x,y)
    N("UIPadding",{
        PaddingLeft=UDim.new(0,x),PaddingRight=UDim.new(0,x),
        PaddingTop=UDim.new(0,y or x),PaddingBottom=UDim.new(0,y or x)
    },o)
end

-- ── GUI Root ──────────────────────────────────
local GUI = Instance.new("ScreenGui")
GUI.Name="MIDDAY"; GUI.ResetOnSpawn=false; GUI.IgnoreGuiInset=true
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local ok=pcall(function() GUI.Parent=game:GetService("CoreGui") end)
if not ok or not GUI.Parent then GUI.Parent=LP:WaitForChild("PlayerGui") end

-- ══════════════════════════════════════════════
-- KEY SCREEN
-- ══════════════════════════════════════════════
local KF=N("Frame",{
    Size=UDim2.new(0,300,0,195),
    Position=UDim2.new(0.5,-150,0.5,-97),
    BackgroundColor3=C_BG,BorderSizePixel=0
},GUI)
Corn(KF,14); Stroke(KF)

-- Logo
local KM=N("Frame",{
    Size=UDim2.new(0,38,0,38),
    Position=UDim2.new(0,16,0,14),
    BackgroundColor3=C_ACC,BorderSizePixel=0
},KF); Corn(KM,10)
N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="M",Font=Enum.Font.GothamBold,TextSize=20,
    TextColor3=Color3.new(1,1,1)},KM)

N("TextLabel",{
    Size=UDim2.new(1,-70,0,22),Position=UDim2.new(0,62,0,14),
    BackgroundTransparency=1,Text="MIDDAY",
    Font=Enum.Font.GothamBold,TextSize=20,
    TextColor3=Color3.new(1,1,1),
    TextXAlignment=Enum.TextXAlignment.Left
},KF)
N("TextLabel",{
    Size=UDim2.new(1,-70,0,15),Position=UDim2.new(0,62,0,36),
    BackgroundTransparency=1,Text="Universal Cheat Hub",
    Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
    TextXAlignment=Enum.TextXAlignment.Left
},KF)

-- Divisor
N("Frame",{
    Size=UDim2.new(1,-32,0,1),Position=UDim2.new(0,16,0,62),
    BackgroundColor3=C_BG3,BorderSizePixel=0
},KF)

-- Input
local KI=N("TextBox",{
    Size=UDim2.new(1,-32,0,40),Position=UDim2.new(0,16,0,72),
    BackgroundColor3=C_BG2,BorderSizePixel=0,
    Font=Enum.Font.GothamMono,TextSize=12,TextColor3=C_TXT,
    PlaceholderText="Insira sua key...",PlaceholderColor3=C_DIM,
    ClearTextOnFocus=false,Text=""
},KF); Corn(KI,8); Stroke(KI); Pad(KI,12,0)

-- Erro
local KE=N("TextLabel",{
    Size=UDim2.new(1,-32,0,14),Position=UDim2.new(0,16,0,116),
    BackgroundTransparency=1,Text="",
    Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_RED,
    TextXAlignment=Enum.TextXAlignment.Left
},KF)

-- Botão
local KB=N("TextButton",{
    Size=UDim2.new(1,-32,0,40),Position=UDim2.new(0,16,0,138),
    BackgroundColor3=C_ACC,BorderSizePixel=0,
    Font=Enum.Font.GothamBold,TextSize=14,
    TextColor3=Color3.new(1,1,1),Text="Autenticar"
},KF); Corn(KB,8)
KB.MouseEnter:Connect(function() tw(KB,{BackgroundColor3=Color3.fromRGB(55,115,220)}) end)
KB.MouseLeave:Connect(function() tw(KB,{BackgroundColor3=C_ACC}) end)

-- ══════════════════════════════════════════════
-- JANELA PRINCIPAL
-- ══════════════════════════════════════════════
local MW=N("Frame",{
    Size=UDim2.new(0,320,0,460),
    Position=UDim2.new(0.5,-160,0.5,-230),
    BackgroundColor3=C_BG,BorderSizePixel=0,
    Visible=false,Active=true
},GUI); Corn(MW,14); Stroke(MW)

-- Titlebar
local TB=N("Frame",{
    Size=UDim2.new(1,0,0,50),
    BackgroundTransparency=1
},MW)

local TM=N("Frame",{
    Size=UDim2.new(0,30,0,30),
    Position=UDim2.new(0,12,0,10),
    BackgroundColor3=C_ACC,BorderSizePixel=0
},TB); Corn(TM,8)
N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="M",Font=Enum.Font.GothamBold,TextSize=14,
    TextColor3=Color3.new(1,1,1)},TM)

N("TextLabel",{
    Size=UDim2.new(0,150,0,18),Position=UDim2.new(0,50,0,10),
    BackgroundTransparency=1,Text="MIDDAY",
    Font=Enum.Font.GothamBold,TextSize=15,
    TextColor3=Color3.new(1,1,1),
    TextXAlignment=Enum.TextXAlignment.Left
},TB)
N("TextLabel",{
    Size=UDim2.new(0,150,0,13),Position=UDim2.new(0,50,0,28),
    BackgroundTransparency=1,Text="v2.2 • Universal",
    Font=Enum.Font.Gotham,TextSize=10,TextColor3=C_DIM,
    TextXAlignment=Enum.TextXAlignment.Left
},TB)

local CB=N("TextButton",{
    Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-36,0,12),
    BackgroundColor3=Color3.fromRGB(38,18,22),BorderSizePixel=0,
    Text="✕",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C_RED
},TB); Corn(CB,7)
CB.MouseButton1Click:Connect(function()
    tw(MW,{BackgroundTransparency=1},.2)
    task.delay(.21,function() MW.Visible=false end)
end)

-- Divisor
N("Frame",{
    Size=UDim2.new(1,-24,0,1),Position=UDim2.new(0,12,0,50),
    BackgroundColor3=C_BG3,BorderSizePixel=0
},MW)

-- Drag
local drag,ds,dp=false
TB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1
    or i.UserInputType==Enum.UserInputType.Touch then
        drag=true; ds=i.Position; dp=MW.Position end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement
    or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-ds
        MW.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1
    or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)

-- ── TABS — 3 botões fixos lado a lado ─────────
local TAB_H = 30
local tabBtns = {}
local tabPages = {}
local activeTab = nil

local tabBar = N("Frame",{
    Size=UDim2.new(1,-24,0,TAB_H),
    Position=UDim2.new(0,12,0,56),
    BackgroundColor3=C_BG2,BorderSizePixel=0
},MW); Corn(tabBar,8)

-- Conteúdo — Frame simples com tamanho automático dentro de um ScrollingFrame
local scroll = N("ScrollingFrame",{
    Size=UDim2.new(1,-24,1,-100),
    Position=UDim2.new(0,12,0,94),
    BackgroundTransparency=1,
    BorderSizePixel=0,
    ScrollBarThickness=2,
    ScrollBarImageColor3=C_BG3,
    CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ClipsDescendants=true,
},MW)

local tabW = (1/3)

local function MakeTab(name, idx)
    -- botão
    local btn = N("TextButton",{
        Size=UDim2.new(tabW,-2,1,-4),
        Position=UDim2.new(tabW*(idx-1),idx==1 and 2 or 1,0,2),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        Font=Enum.Font.GothamSemibold,
        TextSize=12,
        TextColor3=C_DIM,
        Text=name,
    },tabBar); Corn(btn,6)

    -- página — Frame com AutomaticSize
    local page = N("Frame",{
        Size=UDim2.new(1,0,0,0),
        AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundTransparency=1,
        Visible=false,
    },scroll)
    VL(page,8); Pad(page,0,4)

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(tabPages) do p.Visible=false end
        for _,b in pairs(tabBtns) do
            b.TextColor3=C_DIM
            tw(b,{BackgroundColor3=Color3.new(0,0,0,0)})
        end
        page.Visible=true
        btn.TextColor3=C_ACC
        tw(btn,{BackgroundColor3=C_BG3})
        activeTab=name
    end)

    tabBtns[name]=btn
    tabPages[name]=page
    return page
end

local PV = MakeTab("👁 Visual",  1)
local PC = MakeTab("⚔ Combate", 2)
local PG = MakeTab("⚙ Config",  3)

-- ══════════════════════════════════════════════
-- COMPONENTES
-- ══════════════════════════════════════════════
local function Sect(page, txt, order)
    N("TextLabel",{
        Size=UDim2.new(1,0,0,14),
        BackgroundTransparency=1,
        Text=txt,Font=Enum.Font.GothamBold,
        TextSize=10,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left,
        LayoutOrder=order
    },page)
end

local function Tog(page, ico, lbl, desc, getF, setF, order)
    local row=N("Frame",{
        Size=UDim2.new(1,0,0,52),
        BackgroundColor3=C_BG2,BorderSizePixel=0,
        LayoutOrder=order
    },page); Corn(row,10)

    -- ícone
    local ib=N("Frame",{
        Size=UDim2.new(0,32,0,32),
        Position=UDim2.new(0,10,0.5,-16),
        BackgroundColor3=C_BG3,BorderSizePixel=0
    },row); Corn(ib,8)
    N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Text=ico,TextSize=15,Font=Enum.Font.Gotham},ib)

    -- textos
    N("TextLabel",{
        Size=UDim2.new(1,-90,0,17),Position=UDim2.new(0,50,0,9),
        BackgroundTransparency=1,Text=lbl,
        Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Left
    },row)
    N("TextLabel",{
        Size=UDim2.new(1,-90,0,13),Position=UDim2.new(0,50,0,27),
        BackgroundTransparency=1,Text=desc,
        Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left
    },row)

    -- toggle
    local track=N("Frame",{
        Size=UDim2.new(0,36,0,20),
        Position=UDim2.new(1,-46,0.5,-10),
        BackgroundColor3=C_BG3,BorderSizePixel=0
    },row); Corn(track,99)
    local thumb=N("Frame",{
        Size=UDim2.new(0,16,0,16),
        Position=UDim2.new(0,2,0.5,-8),
        BackgroundColor3=Color3.fromRGB(80,80,100),BorderSizePixel=0
    },track); Corn(thumb,99)

    local function ref()
        local on=getF()
        tw(track,{BackgroundColor3=on and C_ACC or C_BG3})
        tw(thumb,{
            Position=on and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8),
            BackgroundColor3=on and Color3.new(1,1,1) or Color3.fromRGB(80,80,100)
        })
        tw(ib,{BackgroundColor3=on and Color3.fromRGB(16,36,76) or C_BG3})
    end

    local b=N("TextButton",{Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,Text=""},row)
    b.MouseButton1Click:Connect(function() setF(not getF()); ref() end)
    ref()
end

local function Sld(page, lbl, min, max, getF, setF, order)
    local row=N("Frame",{
        Size=UDim2.new(1,0,0,56),
        BackgroundColor3=C_BG2,BorderSizePixel=0,
        LayoutOrder=order
    },page); Corn(row,10)

    local lbEl=N("TextLabel",{
        Size=UDim2.new(1,-70,0,16),Position=UDim2.new(0,12,0,10),
        BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,
        TextSize=12,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Left
    },row)

    local vb=N("Frame",{
        Size=UDim2.new(0,44,0,18),Position=UDim2.new(1,-56,0,9),
        BackgroundColor3=C_BG3,BorderSizePixel=0
    },row); Corn(vb,6)
    local vl=N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C_ACC},vb)

    local tr=N("Frame",{
        Size=UDim2.new(1,-24,0,4),Position=UDim2.new(0,12,0,38),
        BackgroundColor3=C_BG3,BorderSizePixel=0
    },row); Corn(tr,99)
    local fi=N("Frame",{Size=UDim2.new(0,0,1,0),
        BackgroundColor3=C_ACC,BorderSizePixel=0},tr); Corn(fi,99)
    local th=N("Frame",{
        Size=UDim2.new(0,14,0,14),AnchorPoint=Vector2.new(0.5,0.5),
        BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0
    },tr); Corn(th,99)

    local function ref()
        local v=getF(); local pct=(v-min)/(max-min)
        fi.Size=UDim2.new(pct,0,1,0)
        th.Position=UDim2.new(pct,0,0.5,0)
        lbEl.Text=lbl; vl.Text=tostring(math.floor(v))
    end

    local sl=false
    local function fx(x)
        local a=tr.AbsolutePosition.X; local w=tr.AbsoluteSize.X
        setF(min+(max-min)*math.clamp((x-a)/w,0,1)); ref()
    end
    tr.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then sl=true; fx(i.Position.X) end
    end)
    UIS.InputChanged:Connect(function(i)
        if sl and (i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then fx(i.Position.X) end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then sl=false end
    end)
    ref()
end

-- ══════════════════════════════════════════════
-- POPULAR ABAS
-- ══════════════════════════════════════════════

-- Visual
Sect(PV,"── ESP ──",1)
Tog(PV,"👁","ESP","Caixas nos jogadores",
    function() return S.ESP end,
    function(v)
        S.ESP=v
        if not v then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local b=p.Character:FindFirstChild("_MESP")
                    if b then b:Destroy() end
                end
            end
        end
    end,2)
Tog(PV,"❤️","Barra de Vida","HP em tempo real",
    function() return S.ESPHp end,function(v) S.ESPHp=v end,3)
Tog(PV,"📛","Nome","Nome acima do personagem",
    function() return S.ESPName end,function(v) S.ESPName=v end,4)
Tog(PV,"📏","Distância","Studs até o alvo",
    function() return S.ESPDist end,function(v) S.ESPDist=v end,5)

Sect(PV,"── WALLHACK ──",10)
Tog(PV,"🧱","Wallhack","Ver através de paredes",
    function() return S.WH end,
    function(v)
        S.WH=v
        if not v then
            for part,orig in pairs(S.WHp) do
                pcall(function() part.Transparency=orig end)
            end; S.WHp={}
        else
            for _,obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency<0.6 then
                    local skip=false
                    for _,pl in ipairs(Players:GetPlayers()) do
                        if pl.Character and obj:IsDescendantOf(pl.Character) then skip=true;break end
                    end
                    if LP.Character and obj:IsDescendantOf(LP.Character) then skip=true end
                    if not skip then S.WHp[obj]=obj.Transparency; obj.Transparency=0.72 end
                end
            end
        end
    end,11)

-- Combate
Sect(PC,"── AIMBOT ──",1)
Tog(PC,"🎯","Aimbot","Mira automática — segura RMB",
    function() return S.AB end,function(v) S.AB=v end,2)
Sld(PC,"FOV",50,400,
    function() return S.ABFOV end,function(v) S.ABFOV=v end,3)
Sld(PC,"Suavidade",1,30,
    function() return S.ABSmooth end,function(v) S.ABSmooth=v end,4)

Sect(PC,"── SILENT AIM ──",10)
Tog(PC,"🔇","Silent Aim","Projétil vai pro alvo",
    function() return S.SA end,function(v) S.SA=v end,11)

-- Config
Sect(PG,"── INFO ──",1)
local ic=N("Frame",{
    Size=UDim2.new(1,0,0,72),
    BackgroundColor3=C_BG2,BorderSizePixel=0,LayoutOrder=2
},PG); Corn(ic,10); Pad(ic,12,8); VL(ic,4)

local function IR(l,v,o)
    local r=N("Frame",{Size=UDim2.new(1,0,0,16),
        BackgroundTransparency=1,LayoutOrder=o},ic)
    N("TextLabel",{Size=UDim2.new(0.5,0,1,0),BackgroundTransparency=1,
        Text=l,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left},r)
    N("TextLabel",{Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0.5,0,0,0),
        BackgroundTransparency=1,Text=v,Font=Enum.Font.GothamSemibold,
        TextSize=11,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Right},r)
end
IR("Versão","2.2",1)
IR("Plataforma",UIS.TouchEnabled and "Mobile" or "PC",2)
IR("Jogo",tostring(game.PlaceId),3)

Sect(PG,"── ATALHOS ──",10)
local hc=N("Frame",{
    Size=UDim2.new(1,0,0,42),
    BackgroundColor3=C_BG2,BorderSizePixel=0,LayoutOrder=11
},PG); Corn(hc,10); Pad(hc,12,8); VL(hc,4)

local hints = UIS.TouchEnabled and not UIS.KeyboardEnabled
    and {"Botão M → abre/fecha menu","Toca no toggle pra ativar"}
    or  {"RightCtrl → abre/fecha menu","RMB → ativa aimbot"}

for i,h in ipairs(hints) do
    N("TextLabel",{Size=UDim2.new(1,0,0,13),BackgroundTransparency=1,
        Text=h,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=i},hc)
end

-- ══════════════════════════════════════════════
-- ESP BILLBOARD
-- ══════════════════════════════════════════════
local function GetESP(char,player)
    local bb=char:FindFirstChild("_MESP"); if bb then return bb end
    bb=Instance.new("BillboardGui")
    bb.Name="_MESP"; bb.AlwaysOnTop=true
    bb.Size=UDim2.new(0,100,0,50)
    bb.StudsOffset=Vector3.new(0,3,0)
    bb.Parent=char

    N("TextLabel",{Name="NL",Size=UDim2.new(1,0,0,16),
        BackgroundTransparency=1,Font=Enum.Font.GothamBold,
        TextSize=12,TextColor3=C_ACC,
        TextStrokeTransparency=0,TextStrokeColor3=Color3.new(0,0,0),
        Text=player.Name},bb)

    local hb=N("Frame",{Name="HB",Size=UDim2.new(1,0,0,5),
        Position=UDim2.new(0,0,0,18),
        BackgroundColor3=Color3.fromRGB(25,25,35),BorderSizePixel=0},bb)
    Corn(hb,99)
    local hf=N("Frame",{Name="HF",Size=UDim2.new(1,0,1,0),
        BackgroundColor3=C_GRN,BorderSizePixel=0},hb); Corn(hf,99)

    N("TextLabel",{Name="DL",Size=UDim2.new(1,0,0,13),
        Position=UDim2.new(0,0,0,26),
        BackgroundTransparency=1,Font=Enum.Font.Gotham,
        TextSize=10,TextColor3=C_DIM,
        TextStrokeTransparency=0,TextStrokeColor3=Color3.new(0,0,0),
        Text=""},bb)
    return bb
end

-- ══════════════════════════════════════════════
-- MELHOR ALVO
-- ══════════════════════════════════════════════
local function Best()
    local vp=Camera.ViewportSize; local cx,cy=vp.X/2,vp.Y/2
    local best,bd=nil,math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local hum=p.Character:FindFirstChildOfClass("Humanoid")
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health>0 then
                local sp,on,z=Camera:WorldToViewportPoint(hrp.Position)
                if on and z>0 then
                    local d=math.sqrt((sp.X-cx)^2+(sp.Y-cy)^2)
                    if d<S.ABFOV and d<bd then bd=d; best={p=p,hrp=hrp,hum=hum} end
                end
            end
        end
    end
    return best
end

-- ══════════════════════════════════════════════
-- SILENT AIM
-- ══════════════════════════════════════════════
local saH=false
local function HookSA()
    if saH then return end
    local ok1,mt=pcall(getrawmetatable,game); if not ok1 then return end
    pcall(setreadonly,mt,false)
    local orig=mt.__namecall
    mt.__namecall=newcclosure(function(self,...)
        if getnamecallmethod()=="FireServer" and S.SA then
            local b=Best()
            if b then
                local pt=b.p.Character:FindFirstChild("Head") or b.hrp
                local args={...}
                for i,v in ipairs(args) do
                    if typeof(v)=="CFrame" then
                        args[i]=CFrame.new(Camera.CFrame.Position,pt.Position); break
                    elseif typeof(v)=="Vector3" then args[i]=pt.Position; break end
                end
                return orig(self,table.unpack(args))
            end
        end
        return orig(self,...)
    end)
    pcall(setreadonly,mt,true); saH=true
end

-- ══════════════════════════════════════════════
-- RENDER LOOP
-- ══════════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    if not S.Auth then return end
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local hum=p.Character:FindFirstChildOfClass("Humanoid")
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp then
                if S.ESP and hum.Health>0 then
                    local bb=GetESP(p.Character,p)
                    bb.Enabled=true
                    local nl=bb:FindFirstChild("NL"); if nl then nl.Visible=S.ESPName end
                    local hb=bb:FindFirstChild("HB")
                    if hb then
                        hb.Visible=S.ESPHp
                        local hf=hb:FindFirstChild("HF")
                        if hf then
                            local pct=hum.Health/math.max(hum.MaxHealth,1)
                            hf.Size=UDim2.new(pct,0,1,0)
                            hf.BackgroundColor3=Color3.fromRGB(
                                math.floor((1-pct)*255),math.floor(pct*210),0)
                        end
                    end
                    local dl=bb:FindFirstChild("DL")
                    if dl then
                        dl.Visible=S.ESPDist
                        if S.ESPDist then
                            dl.Text=string.format("%.0fm",
                                (Camera.CFrame.Position-hrp.Position).Magnitude)
                        end
                    end
                else
                    local bb=p.Character:FindFirstChild("_MESP")
                    if bb then bb.Enabled=false end
                end
            end
        end
    end
    if S.AB and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t=Best()
        if t then
            local aim=t.p.Character:FindFirstChild("Head") or t.hrp
            Camera.CFrame=Camera.CFrame:Lerp(
                CFrame.lookAt(Camera.CFrame.Position,aim.Position),
                math.clamp(S.ABSmooth/100,0.01,1))
        end
    end
end)

-- ══════════════════════════════════════════════
-- AUTH
-- ══════════════════════════════════════════════
local function Open()
    S.Auth=true; KF.Visible=false
    MW.Visible=true; MW.BackgroundTransparency=1
    MW.Position=UDim2.new(0.5,-160,0.6,-230)
    tw(MW,{BackgroundTransparency=0,Position=UDim2.new(0.5,-160,0.5,-230)},.3)
    HookSA()
    -- abre aba Visual por padrão
    task.defer(function()
        tabPages["👁 Visual"].Visible=true
        tabBtns["👁 Visual"].TextColor3=C_ACC
        tw(tabBtns["👁 Visual"],{BackgroundColor3=C_BG3})
        activeTab="👁 Visual"
    end)
end

KB.MouseButton1Click:Connect(function()
    if KI.Text:gsub("%s","")=="KEY-MIDDAYCHEAT" then Open()
    else
        KE.Text="✕  Key inválida"
        tw(KI,{BackgroundColor3=Color3.fromRGB(40,15,20)},.1)
        task.delay(.3,function() tw(KI,{BackgroundColor3=C_BG2}) end)
        task.delay(2.5,function() KE.Text="" end)
    end
end)
KI.FocusLost:Connect(function(e) if e then KB.MouseButton1Click:Fire() end end)

-- Reabrir
if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    local fab=N("TextButton",{
        Size=UDim2.new(0,44,0,44),
        Position=UDim2.new(1,-52,0.5,-22),
        BackgroundColor3=C_ACC,BorderSizePixel=0,
        Text="M",Font=Enum.Font.GothamBold,
        TextSize=14,TextColor3=Color3.new(1,1,1)
    },GUI); Corn(fab,99)
    fab.MouseButton1Click:Connect(function()
        if S.Auth then MW.Visible=not MW.Visible end
    end)
else
    UIS.InputBegan:Connect(function(i,g)
        if g then return end
        if i.KeyCode==Enum.KeyCode.RightControl and S.Auth then
            MW.Visible=not MW.Visible
        end
    end)
end

print("[MIDDAY] OK — KEY-MIDDAYCHEAT")
