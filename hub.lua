-- ═══════════════════════════════════════════
-- MIDDAY Hub v2.1
-- Key: KEY-MIDDAYCHEAT
-- ═══════════════════════════════════════════

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera       = workspace.CurrentCamera
local LP           = Players.LocalPlayer

local C_ACC  = Color3.fromRGB(79,142,247)
local C_BG   = Color3.fromRGB(13,13,26)
local C_BG2  = Color3.fromRGB(17,17,32)
local C_BG3  = Color3.fromRGB(26,26,48)
local C_TXT  = Color3.fromRGB(200,200,220)
local C_DIM  = Color3.fromRGB(68,68,90)
local C_RED  = Color3.fromRGB(255,70,90)
local C_GRN  = Color3.fromRGB(0,220,100)

local S = {
    Auth=false,
    ESP=false, ESPName=false, ESPDist=false, ESPHp=false,
    WH=false, WHp={},
    AB=false, ABSmooth=15, ABFOV=150,
    SA=false,
}

local function tw(o,p,t)
    TweenService:Create(o,TweenInfo.new(t or .18),p):Play()
end
local function New(cls,props,parent)
    local o=Instance.new(cls)
    for k,v in pairs(props) do pcall(function() o[k]=v end) end
    o.Parent=parent; return o
end
local function Corner(p,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r or 10); c.Parent=p
end
local function Pad(p,px,py)
    local u=Instance.new("UIPadding")
    u.PaddingLeft=UDim.new(0,px); u.PaddingRight=UDim.new(0,px)
    u.PaddingTop=UDim.new(0,py or px); u.PaddingBottom=UDim.new(0,py or px)
    u.Parent=p
end
local function VList(p,gap)
    local l=Instance.new("UIListLayout")
    l.FillDirection=Enum.FillDirection.Vertical
    l.SortOrder=Enum.SortOrder.LayoutOrder
    l.Padding=UDim.new(0,gap or 8)
    l.Parent=p
end

-- ── GUI ROOT ──────────────────────────────────
local GUI=Instance.new("ScreenGui")
GUI.Name="MIDDAY"; GUI.ResetOnSpawn=false
GUI.IgnoreGuiInset=true; GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local ok=pcall(function() GUI.Parent=game:GetService("CoreGui") end)
if not ok or not GUI.Parent then GUI.Parent=LP:WaitForChild("PlayerGui") end

-- ══════════════════════════════════════════════
-- KEY SCREEN
-- ══════════════════════════════════════════════
local KF=New("Frame",{
    Size=UDim2.new(0,300,0,200),
    Position=UDim2.new(0.5,-150,0.5,-100),
    BackgroundColor3=C_BG, BorderSizePixel=0,
},GUI)
Corner(KF,16)
do local s=Instance.new("UIStroke"); s.Color=C_BG3; s.Thickness=1; s.Parent=KF end

local KMark=New("Frame",{
    Size=UDim2.new(0,38,0,38),
    Position=UDim2.new(0,18,0,16),
    BackgroundColor3=C_ACC, BorderSizePixel=0,
},KF); Corner(KMark,10)
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="M",Font=Enum.Font.GothamBold,TextSize=20,
    TextColor3=Color3.new(1,1,1)},KMark)

New("TextLabel",{
    Size=UDim2.new(1,-80,0,22),Position=UDim2.new(0,64,0,16),
    BackgroundTransparency=1,Text="MIDDAY",
    Font=Enum.Font.GothamBold,TextSize=20,
    TextColor3=Color3.new(1,1,1),
    TextXAlignment=Enum.TextXAlignment.Left},KF)

New("TextLabel",{
    Size=UDim2.new(1,-80,0,16),Position=UDim2.new(0,64,0,38),
    BackgroundTransparency=1,Text="Universal Cheat Hub",
    Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
    TextXAlignment=Enum.TextXAlignment.Left},KF)

New("Frame",{
    Size=UDim2.new(1,-36,0,1),Position=UDim2.new(0,18,0,66),
    BackgroundColor3=C_BG3,BorderSizePixel=0},KF)

local KInput=New("TextBox",{
    Size=UDim2.new(1,-36,0,40),Position=UDim2.new(0,18,0,76),
    BackgroundColor3=C_BG2,BorderSizePixel=0,
    Font=Enum.Font.GothamMono,TextSize=12,TextColor3=C_TXT,
    PlaceholderText="Insira sua key...",PlaceholderColor3=C_DIM,
    ClearTextOnFocus=false,Text=""},KF)
Corner(KInput,10)
do local s=Instance.new("UIStroke"); s.Color=C_BG3; s.Thickness=1; s.Parent=KInput end
Pad(KInput,12,0)

local KErr=New("TextLabel",{
    Size=UDim2.new(1,-36,0,14),Position=UDim2.new(0,18,0,120),
    BackgroundTransparency=1,Text="",Font=Enum.Font.Gotham,
    TextSize=11,TextColor3=C_RED,
    TextXAlignment=Enum.TextXAlignment.Left},KF)

local KBtn=New("TextButton",{
    Size=UDim2.new(1,-36,0,40),Position=UDim2.new(0,18,0,142),
    BackgroundColor3=C_ACC,BorderSizePixel=0,
    Font=Enum.Font.GothamBold,TextSize=14,
    TextColor3=Color3.new(1,1,1),Text="Autenticar"},KF)
Corner(KBtn,10)
KBtn.MouseEnter:Connect(function() tw(KBtn,{BackgroundColor3=Color3.fromRGB(55,115,220)}) end)
KBtn.MouseLeave:Connect(function() tw(KBtn,{BackgroundColor3=C_ACC}) end)

-- ══════════════════════════════════════════════
-- JANELA PRINCIPAL
-- ══════════════════════════════════════════════
local MW=New("Frame",{
    Size=UDim2.new(0,340,0,440),
    Position=UDim2.new(0.5,-170,0.5,-220),
    BackgroundColor3=C_BG,BorderSizePixel=0,
    Visible=false,Active=true},GUI)
Corner(MW,16)
do local s=Instance.new("UIStroke"); s.Color=C_BG3; s.Thickness=1; s.Parent=MW end

-- titlebar
local TBar=New("Frame",{
    Size=UDim2.new(1,0,0,52),
    BackgroundTransparency=1},MW)

local TMark=New("Frame",{
    Size=UDim2.new(0,32,0,32),
    Position=UDim2.new(0,14,0,10),
    BackgroundColor3=C_ACC,BorderSizePixel=0},TBar)
Corner(TMark,9)
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="M",Font=Enum.Font.GothamBold,TextSize=15,
    TextColor3=Color3.new(1,1,1)},TMark)

New("TextLabel",{
    Size=UDim2.new(0,160,0,20),Position=UDim2.new(0,54,0,10),
    BackgroundTransparency=1,Text="MIDDAY",
    Font=Enum.Font.GothamBold,TextSize=16,TextColor3=Color3.new(1,1,1),
    TextXAlignment=Enum.TextXAlignment.Left},TBar)

New("TextLabel",{
    Size=UDim2.new(0,160,0,14),Position=UDim2.new(0,54,0,29),
    BackgroundTransparency=1,Text="v2.1 • Universal",
    Font=Enum.Font.Gotham,TextSize=10,TextColor3=C_DIM,
    TextXAlignment=Enum.TextXAlignment.Left},TBar)

local CloseBtn=New("TextButton",{
    Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-40,0,12),
    BackgroundColor3=Color3.fromRGB(40,20,25),BorderSizePixel=0,
    Text="✕",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C_RED},TBar)
Corner(CloseBtn,8)
CloseBtn.MouseButton1Click:Connect(function()
    tw(MW,{BackgroundTransparency=1},.2)
    task.delay(.21,function() MW.Visible=false end)
end)

New("Frame",{
    Size=UDim2.new(1,-28,0,1),Position=UDim2.new(0,14,0,51),
    BackgroundColor3=C_BG3,BorderSizePixel=0},MW)

-- drag
local drag,ds,dp=false,nil,nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1
    or i.UserInputType==Enum.UserInputType.Touch then
        drag=true; ds=i.Position; dp=MW.Position
    end
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

-- ── TABS (tamanho fixo — sem AutomaticSize) ───
local TAB_W = 90
local TAB_NAMES = {"Visual","Combate","Config"}
local TAB_ICONS = {"👁","⚔","⚙"}

local TabRow=New("Frame",{
    Size=UDim2.new(0, TAB_W*3+8, 0, 32),
    Position=UDim2.new(0,14,0,56),
    BackgroundTransparency=1},MW)
do
    local l=Instance.new("UIListLayout")
    l.FillDirection=Enum.FillDirection.Horizontal
    l.SortOrder=Enum.SortOrder.LayoutOrder
    l.Padding=UDim.new(0,4); l.Parent=TabRow
end

local ContentArea=New("Frame",{
    Size=UDim2.new(1,-28,1,-96),
    Position=UDim2.new(0,14,0,92),
    BackgroundTransparency=1,
    ClipsDescendants=true},MW)

local Pages,TBtns,ActiveTab={},{},nil

local function MakePage(name,icon,order)
    local btn=New("TextButton",{
        Size=UDim2.new(0,TAB_W,1,0),
        BackgroundColor3=C_BG2,BorderSizePixel=0,
        Font=Enum.Font.GothamSemibold,TextSize=12,
        TextColor3=C_DIM,Text=icon.."  "..name,
        LayoutOrder=order},TabRow)
    Corner(btn,8)

    local page=New("ScrollingFrame",{
        Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,
        ScrollBarThickness=2,
        ScrollBarImageColor3=C_BG3,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=false},ContentArea)
    VList(page,8)
    Pad(page,2,4)

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(Pages) do p.Visible=false end
        for _,b in pairs(TBtns) do
            b.TextColor3=C_DIM; tw(b,{BackgroundColor3=C_BG2})
        end
        page.Visible=true
        btn.TextColor3=C_ACC; tw(btn,{BackgroundColor3=C_BG3})
        ActiveTab=name
    end)

    Pages[name]=page; TBtns[name]=btn
    return page
end

local PVisual = MakePage("Visual","👁",1)
local PCombat = MakePage("Combate","⚔",2)
local PConfig = MakePage("Config","⚙",3)

-- ── COMPONENTES ───────────────────────────────
local function Section(page,text,order)
    New("TextLabel",{
        Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,
        Text=text,Font=Enum.Font.GothamBold,TextSize=10,
        TextColor3=C_DIM,TextXAlignment=Enum.TextXAlignment.Left,
        LayoutOrder=order or 0},page)
end

local function Toggle(page,icon,label,desc,getF,setF,order)
    local row=New("Frame",{
        Size=UDim2.new(1,0,0,54),
        BackgroundColor3=C_BG2,BorderSizePixel=0,
        LayoutOrder=order or 0},page)
    Corner(row,10)

    local iBox=New("Frame",{
        Size=UDim2.new(0,34,0,34),
        Position=UDim2.new(0,10,0.5,-17),
        BackgroundColor3=C_BG3,BorderSizePixel=0},row)
    Corner(iBox,8)
    New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Text=icon,TextSize=16,Font=Enum.Font.Gotham},iBox)

    New("TextLabel",{
        Size=UDim2.new(1,-90,0,18),Position=UDim2.new(0,52,0,9),
        BackgroundTransparency=1,Text=label,
        Font=Enum.Font.GothamSemibold,TextSize=13,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Left},row)
    New("TextLabel",{
        Size=UDim2.new(1,-90,0,14),Position=UDim2.new(0,52,0,27),
        BackgroundTransparency=1,Text=desc,
        Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left},row)

    local track=New("Frame",{
        Size=UDim2.new(0,38,0,22),
        Position=UDim2.new(1,-50,0.5,-11),
        BackgroundColor3=C_BG3,BorderSizePixel=0},row)
    Corner(track,99)
    local thumb=New("Frame",{
        Size=UDim2.new(0,18,0,18),
        Position=UDim2.new(0,2,0.5,-9),
        BackgroundColor3=Color3.fromRGB(80,80,100),BorderSizePixel=0},track)
    Corner(thumb,99)

    local function refresh()
        local on=getF()
        tw(track,{BackgroundColor3=on and C_ACC or C_BG3})
        tw(thumb,{
            Position=on and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9),
            BackgroundColor3=on and Color3.new(1,1,1) or Color3.fromRGB(80,80,100)})
        tw(iBox,{BackgroundColor3=on and Color3.fromRGB(18,38,80) or C_BG3})
    end

    local b=New("TextButton",{Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,Text=""},row)
    b.MouseButton1Click:Connect(function() setF(not getF()); refresh() end)
    refresh()
end

local function Slider(page,label,min,max,getF,setF,order)
    local row=New("Frame",{
        Size=UDim2.new(1,0,0,58),
        BackgroundColor3=C_BG2,BorderSizePixel=0,
        LayoutOrder=order or 0},page)
    Corner(row,10)

    local lbl=New("TextLabel",{
        Size=UDim2.new(1,-70,0,18),Position=UDim2.new(0,12,0,10),
        BackgroundTransparency=1,Font=Enum.Font.GothamSemibold,
        TextSize=12,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Left},row)

    local vBox=New("Frame",{
        Size=UDim2.new(0,46,0,20),Position=UDim2.new(1,-58,0,8),
        BackgroundColor3=C_BG3,BorderSizePixel=0},row)
    Corner(vBox,6)
    local vLbl=New("TextLabel",{Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,Font=Enum.Font.GothamBold,
        TextSize=11,TextColor3=C_ACC},vBox)

    local track=New("Frame",{
        Size=UDim2.new(1,-24,0,4),Position=UDim2.new(0,12,0,38),
        BackgroundColor3=C_BG3,BorderSizePixel=0},row)
    Corner(track,99)
    local fill=New("Frame",{Size=UDim2.new(0,0,1,0),
        BackgroundColor3=C_ACC,BorderSizePixel=0},track)
    Corner(fill,99)
    local thumb=New("Frame",{
        Size=UDim2.new(0,14,0,14),
        AnchorPoint=Vector2.new(0.5,0.5),
        BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},track)
    Corner(thumb,99)

    local function refresh()
        local v=getF(); local pct=(v-min)/(max-min)
        fill.Size=UDim2.new(pct,0,1,0)
        thumb.Position=UDim2.new(pct,0,0.5,0)
        lbl.Text=label; vLbl.Text=tostring(math.floor(v))
    end

    local sliding=false
    local function fromX(x)
        local a=track.AbsolutePosition.X; local w=track.AbsoluteSize.X
        setF(min+(max-min)*math.clamp((x-a)/w,0,1)); refresh()
    end
    track.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then
            sliding=true; fromX(i.Position.X) end
    end)
    UIS.InputChanged:Connect(function(i)
        if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then fromX(i.Position.X) end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then sliding=false end
    end)
    refresh()
end

-- ── POPULAR ABAS ──────────────────────────────
Section(PVisual,"ESP",1)
Toggle(PVisual,"👁","ESP","Exibe caixas nos jogadores",
    function() return S.ESP end,
    function(v)
        S.ESP=v
        if not v then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    local bb=p.Character:FindFirstChild("_MESP")
                    if bb then bb:Destroy() end
                end
            end
        end
    end,2)

Toggle(PVisual,"❤️","Barra de Vida","HP do alvo em tempo real",
    function() return S.ESPHp end,
    function(v) S.ESPHp=v end,3)

Toggle(PVisual,"📛","Nome","Nome do jogador acima",
    function() return S.ESPName end,
    function(v) S.ESPName=v end,4)

Toggle(PVisual,"📏","Distância","Distância em studs até o alvo",
    function() return S.ESPDist end,
    function(v) S.ESPDist=v end,5)

Section(PVisual,"WALLHACK",10)
Toggle(PVisual,"🧱","Wallhack","Ver através de paredes",
    function() return S.WH end,
    function(v)
        S.WH=v
        if not v then
            for part,orig in pairs(S.WHp) do
                pcall(function() part.Transparency=orig end)
            end
            S.WHp={}
        else
            for _,obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency<0.6 then
                    local skip=false
                    for _,pl in ipairs(Players:GetPlayers()) do
                        if pl.Character and obj:IsDescendantOf(pl.Character) then
                            skip=true; break
                        end
                    end
                    if LP.Character and obj:IsDescendantOf(LP.Character) then
                        skip=true
                    end
                    if not skip then
                        S.WHp[obj]=obj.Transparency
                        obj.Transparency=0.72
                    end
                end
            end
        end
    end,11)

Section(PCombat,"AIMBOT",1)
Toggle(PCombat,"🎯","Aimbot","Mira automática — segura RMB",
    function() return S.AB end,
    function(v) S.AB=v end,2)
Slider(PCombat,"FOV",50,400,
    function() return S.ABFOV end,
    function(v) S.ABFOV=v end,3)
Slider(PCombat,"Suavidade",1,30,
    function() return S.ABSmooth end,
    function(v) S.ABSmooth=v end,4)

Section(PCombat,"SILENT AIM",10)
Toggle(PCombat,"🔇","Silent Aim","Projétil vai direto pro alvo",
    function() return S.SA end,
    function(v) S.SA=v end,11)

Section(PConfig,"INFORMAÇÕES",1)
local infoCard=New("Frame",{
    Size=UDim2.new(1,0,0,76),
    BackgroundColor3=C_BG2,BorderSizePixel=0,
    LayoutOrder=2},PConfig)
Corner(infoCard,10); Pad(infoCard,14,10)
VList(infoCard,4)

local function InfoRow(lbl,val,order)
    local r=New("Frame",{Size=UDim2.new(1,0,0,18),
        BackgroundTransparency=1,LayoutOrder=order},infoCard)
    New("TextLabel",{Size=UDim2.new(0.5,0,1,0),BackgroundTransparency=1,
        Text=lbl,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left},r)
    New("TextLabel",{Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0.5,0,0,0),
        BackgroundTransparency=1,Text=val,Font=Enum.Font.GothamSemibold,
        TextSize=11,TextColor3=C_TXT,
        TextXAlignment=Enum.TextXAlignment.Right},r)
end

InfoRow("Versão","2.1",1)
InfoRow("Plataforma",UIS.TouchEnabled and "Mobile" or "PC",2)
InfoRow("Jogo",tostring(game.PlaceId),3)

Section(PConfig,"ATALHOS",10)
local hCard=New("Frame",{
    Size=UDim2.new(1,0,0,46),
    BackgroundColor3=C_BG2,BorderSizePixel=0,
    LayoutOrder=11},PConfig)
Corner(hCard,10); Pad(hCard,14,8); VList(hCard,4)

local function Hint(txt,order)
    New("TextLabel",{Size=UDim2.new(1,0,0,14),
        BackgroundTransparency=1,Text=txt,
        Font=Enum.Font.Gotham,TextSize=11,TextColor3=C_DIM,
        TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=order},hCard)
end

if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    Hint("Botão M → abre/fecha o menu",1)
    Hint("Mobile: toca no toggle pra ativar",2)
else
    Hint("RightCtrl → abre/fecha menu",1)
    Hint("RMB segurado → ativa aimbot",2)
end

-- ══════════════════════════════════════════════
-- ESP BILLBOARDGUI
-- ══════════════════════════════════════════════
local function GetESP(char,player)
    local bb=char:FindFirstChild("_MESP")
    if bb then return bb end
    bb=Instance.new("BillboardGui")
    bb.Name="_MESP"; bb.AlwaysOnTop=true
    bb.Size=UDim2.new(0,110,0,52)
    bb.StudsOffset=Vector3.new(0,3.2,0)
    bb.Parent=char

    New("TextLabel",{
        Name="NL",Size=UDim2.new(1,0,0,18),
        BackgroundTransparency=1,Font=Enum.Font.GothamBold,
        TextSize=13,TextColor3=C_ACC,
        TextStrokeTransparency=0,
        TextStrokeColor3=Color3.new(0,0,0),
        Text=player.Name},bb)

    local hBg=New("Frame",{
        Name="HB",Size=UDim2.new(1,0,0,6),
        Position=UDim2.new(0,0,0,20),
        BackgroundColor3=Color3.fromRGB(30,30,40),
        BorderSizePixel=0},bb)
    Corner(hBg,99)
    local hF=New("Frame",{Name="HF",Size=UDim2.new(1,0,1,0),
        BackgroundColor3=C_GRN,BorderSizePixel=0},hBg)
    Corner(hF,99)

    New("TextLabel",{
        Name="DL",Size=UDim2.new(1,0,0,14),
        Position=UDim2.new(0,0,0,30),
        BackgroundTransparency=1,Font=Enum.Font.Gotham,
        TextSize=10,TextColor3=C_DIM,
        TextStrokeTransparency=0,
        TextStrokeColor3=Color3.new(0,0,0),Text=""},bb)

    return bb
end

-- ══════════════════════════════════════════════
-- MELHOR ALVO
-- ══════════════════════════════════════════════
local function GetBest()
    local vp=Camera.ViewportSize
    local cx,cy=vp.X/2,vp.Y/2
    local best,bD=nil,math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local hum=p.Character:FindFirstChildOfClass("Humanoid")
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health>0 then
                local sp,on,z=Camera:WorldToViewportPoint(hrp.Position)
                if on and z>0 then
                    local d=math.sqrt((sp.X-cx)^2+(sp.Y-cy)^2)
                    if d<S.ABFOV and d<bD then
                        bD=d; best={p=p,hrp=hrp,hum=hum}
                    end
                end
            end
        end
    end
    return best
end

-- ══════════════════════════════════════════════
-- SILENT AIM
-- ══════════════════════════════════════════════
local saHooked=false
local function HookSA()
    if saHooked then return end
    local ok1,mt=pcall(getrawmetatable,game)
    if not ok1 then return end
    pcall(setreadonly,mt,false)
    local orig=mt.__namecall
    mt.__namecall=newcclosure(function(self,...)
        local m=getnamecallmethod()
        if m=="FireServer" and S.SA then
            local best=GetBest()
            if best then
                local part=best.p.Character:FindFirstChild("Head") or best.hrp
                local args={...}
                for i,v in ipairs(args) do
                    if typeof(v)=="CFrame" then
                        args[i]=CFrame.new(Camera.CFrame.Position,part.Position)
                        break
                    elseif typeof(v)=="Vector3" then
                        args[i]=part.Position; break
                    end
                end
                return orig(self,table.unpack(args))
            end
        end
        return orig(self,...)
    end)
    pcall(setreadonly,mt,true)
    saHooked=true
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
                    local nl=bb:FindFirstChild("NL")
                    if nl then nl.Visible=S.ESPName end
                    local hb=bb:FindFirstChild("HB")
                    if hb then
                        hb.Visible=S.ESPHp
                        local hf=hb:FindFirstChild("HF")
                        if hf then
                            local pct=hum.Health/math.max(hum.MaxHealth,1)
                            hf.Size=UDim2.new(pct,0,1,0)
                            hf.BackgroundColor3=Color3.fromRGB(
                                math.floor((1-pct)*255),
                                math.floor(pct*220),0)
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
        local t=GetBest()
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
local function OpenMain()
    S.Auth=true
    KF.Visible=false
    MW.Visible=true
    MW.BackgroundTransparency=1
    MW.Position=UDim2.new(0.5,-170,0.6,-220)
    tw(MW,{BackgroundTransparency=0,
           Position=UDim2.new(0.5,-170,0.5,-220)},.3)
    HookSA()
    task.defer(function()
        Pages["Visual"].Visible=true
        TBtns["Visual"].TextColor3=C_ACC
        tw(TBtns["Visual"],{BackgroundColor3=C_BG3})
        ActiveTab="Visual"
    end)
end

KBtn.MouseButton1Click:Connect(function()
    if KInput.Text:gsub("%s","")=="KEY-MIDDAYCHEAT" then
        OpenMain()
    else
        KErr.Text="✕  Key inválida"
        tw(KInput,{BackgroundColor3=Color3.fromRGB(40,15,20)},.1)
        task.delay(.3,function() tw(KInput,{BackgroundColor3=C_BG2}) end)
        task.delay(2.5,function() KErr.Text="" end)
    end
end)
KInput.FocusLost:Connect(function(enter)
    if enter then KBtn.MouseButton1Click:Fire() end
end)

-- ── Reabrir ───────────────────────────────────
if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    local fab=New("TextButton",{
        Size=UDim2.new(0,46,0,46),
        Position=UDim2.new(1,-54,0.5,-23),
        BackgroundColor3=C_ACC,BorderSizePixel=0,
        Text="M",Font=Enum.Font.GothamBold,
        TextSize=15,TextColor3=Color3.new(1,1,1)},GUI)
    Corner(fab,99)
    fab.MouseButton1Click:Connect(function()
        if S.Auth then MW.Visible=not MW.Visible end
    end)
else
    UIS.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode==Enum.KeyCode.RightControl and S.Auth then
            MW.Visible=not MW.Visible
        end
    end)
end

print("[MIDDAY] Loaded — KEY-MIDDAYCHEAT")
