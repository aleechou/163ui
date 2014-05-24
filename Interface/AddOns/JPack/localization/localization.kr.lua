--[=[
	Language Localization: koKR
	Translated by: fenlis <jungseop.park@gmail.com>
]=]

if GetLocale() ~= "koKR" then return end
local L = JPackLocale


L.TYPE_BAG="가방"
L.TYPE_FISHWEAPON="낚싯대"

JPACK_ORDER={"귀환석","##탈것","채광용 곡괭이","무두용 칼","낚싯대","#낚싯대",
"#무기","#방어구","#무기##기타","#방어구##기타","#문양","#제조법",
"#퀘스트","##원소","##광물","##약초","#보석","##보석세공",
"#소비용품","#직업용품##천","#직업용품","##고기","#","#기타##재료","영혼의 조각","#기타"}
JPACK_DEPOSIT={"##원소","##광물","##약초","#보석세공","#가방"}
JPACK_DRAW={"#퀘스트"}

L["HELP"] = '도움말을 보려면 "/jpack help"를 입력하세요.'
L["COMPLETE"] = "정리 완료..."
L["WARN"] = "마우스로 집고 있는 아이템이 있다면 놓으세요. 정리 중에는 아이템, 골드, 스킬 등을 클릭하지 마세요."
L["Unknown command"] = "알 수 없는 명령어"

-- Help info
L["Slash command"] = "명령어"
L["Pack"] = "정리"
L["Set sequence to ascend"] = "오름차순으로 설정"
L["Set sequence to descend"] = "내림차순으로 설정"
L["Save to the bank"] = "은행에 넣기"
L["Load from the bank"] = "은행에서 꺼내기"
L["Print help info"] = "도움말 정보 출력"

L["Sequence"] = "순서"
L["asc"] = "오름차순"
L["desc"] = "내림차순"

L["Click"] = "클릭"
L["Pack"] = "정리"

L["Shift + Left-Click"] = "SHIFT + 왼쪽-클릭"
L["Ctrl + Left-Click"] = "CTRL + 왼쪽-클릭"
L["Shift + Right-Click"] = "SHIFT + 오른쪽-클릭"
L["Ctrl + Right-Click"] = "CTRL + 오른쪽-클릭"
