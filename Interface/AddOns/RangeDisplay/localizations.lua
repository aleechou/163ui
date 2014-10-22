local AppName = ...
local AL = LibStub("AceLocale-3.0")
local L = AL:NewLocale(AppName, "enUS", true)

L["focus"] = "Focus"
L["mouseover"] = "Mouseover"
L["pet"] = "Pet"
L["playertarget"] = "Target"
L["arena%d"]="Arena%d"
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55fControl + Left Click|r to lock frames"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55fDrag|r to move the frame"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55fLeft Click|r to lock/unlock frames"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + Left Click|r to toggle sound"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55fRight Click|r to open the configuration window"

-----------------------------------------------------------------------------

L = AL:NewLocale(AppName, "deDE")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55fStrg + Linksklick|r, um die Rahmen zu sperren"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55fZiehen|r, um den Rahmen zu verschieben"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55fLinksklick|r, um die Rahmen fest- und freizusetzen"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55fRechtsklick|r, um das Konfigurationsfenster zu öffnen"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + Linksklick|r, um das Audiosignal zu ein- und auszuschalten."
L["focus"] = "Fokus"
L["mouseover"] = "Mouseover"
L["pet"] = "Begleiter"
L["playertarget"] = "Ziel"

end

L = AL:NewLocale(AppName, "esES")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = " |cffeda55fControl + Clic Izquierdo|r para bloquear los marcos"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55fArrastrar|r para mover el marco"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = " |cffeda55fClic Izquierdo|r para bloquear/desbloquear los marcos"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55fClic Derecho|r para abrir la ventana de configuración"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + boton Izquierdo|r para activar/desactivar sonido"
L["focus"] = "Foco"
L["mouseover"] = "Sobre el raton"
L["pet"] = "Mascota"
L["playertarget"] = "Objetivo"

end

L = AL:NewLocale(AppName, "esMX")
if L then

end

L = AL:NewLocale(AppName, "frFR")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = " |cffeda55fCtrl + Clic gauche|r pour verrouiller"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = " |cffeda55fClic gauche|r pour verrouiller/déverrouiller les frames"
L["|cffeda55fRight Click|r to open the configuration window"] = " |cffeda55fClic droit|r pour ouvrir la fenêtre de configuration"
L["|cffeda55fShift + Left Click|r to toggle sound"] = " |cffeda55fShift + Clic gauche|r pour activer/désactiver le son"
L["focus"] = "Focus"
L["pet"] = "Familier"
L["playertarget"] = "Cible"

end

L = AL:NewLocale(AppName, "koKR")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55fCtrl + 왼쪽 클릭|r 창 잠금"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55f드래그|r 창 이동"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55f왼쪽 클릭|r 창 잠금/이동"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55f오른쪽 클릭|r 설정 창 열기"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + 왼쪽 클릭|r to 경고음 전환"
L["focus"] = "주시"
L["mouseover"] = "마우스를 오버"
L["pet"] = "소환수"
L["playertarget"] = "대상"

end

L = AL:NewLocale(AppName, "ruRU")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55f[Control + Левый клик]|r фиксирует фрейм"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55f[Двигайте]|r для перемещения окна"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55f[Левый клик]|r фиксирует/освобождает фреймы"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55f[Правый клик]|r открывает окно настроек"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + Левый клик|r - переключить звук"
L["focus"] = "Фокус"
L["mouseover"] = "Mouseover"
L["pet"] = "Питомец"
L["playertarget"] = "Цель"

end

L = AL:NewLocale(AppName, "zhCN")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55fCtrl+点击|r锁定所有框架"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55f拖拽|r 移动位置"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55f点击|r锁定/解锁框架"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55f右击|r打开设置窗口"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + 左键点击|r 来开启/关闭音效"
L["focus"] = "焦点"
L["mouseover"] = "鼠标悬停"
L["pet"] = "宠物"
L["playertarget"] = "目标"

end

L = AL:NewLocale(AppName, "zhTW")
if L then
L["|cffeda55fControl + Left Click|r to lock frames"] = "|cffeda55fCtrl+點擊|r鎖定所有框架"
L["|cffeda55fDrag|r to move the frame"] = "|cffeda55f拖拽|r 移動位置"
L["|cffeda55fLeft Click|r to lock/unlock frames"] = "|cffeda55f點擊|r鎖定/解鎖框架"
L["|cffeda55fRight Click|r to open the configuration window"] = "|cffeda55f右擊|r打開設置視窗"
L["|cffeda55fShift + Left Click|r to toggle sound"] = "|cffeda55fShift + 左鍵點擊|r切換聲音"
L["focus"] = "焦點"
L["mouseover"] = "鼠標懸停"
L["pet"] = "寵物"
L["playertarget"] = "目標"

end

