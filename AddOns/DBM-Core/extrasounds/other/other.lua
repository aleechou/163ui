-- DBM_CORE_SOUNDGRIL_CUSTOM 显示为语音包选项中你的语音包名
-- DBM_CORE_SOUNDGRIL_NAME_CUSTOM 显示为你的语音包介绍标题
-- DBM_CORE_SOUNDGRIL_TEXT_CUSTOM 显示为你的语音包介绍内容

if GetLocale() == "zhTW" then
	DBM_CORE_SOUNDGRIL_CUSTOM = "自定義"
	DBM_CORE_SOUNDGRIL_NAME_CUSTOM = "自定義語音"
	DBM_CORE_SOUNDGRIL_TEXT_CUSTOM = "    這是一份自定義的語音文件，但他現在很可能是空的，你若選擇此項可能會沒有語音輸出"
elseif  GetLocale() == "zhCN" then
	DBM_CORE_SOUNDGRIL_CUSTOM = "自定义"
	DBM_CORE_SOUNDGRIL_NAME_CUSTOM = "自定义语音"
	DBM_CORE_SOUNDGRIL_TEXT_CUSTOM = "    这是一份自定义的语音文件，但他现在很可能是空的，你若选择此项可能会没有语音输出"
else
	DBM_CORE_SOUNDGRIL_CUSTOM = "Custom"
	DBM_CORE_SOUNDGRIL_NAME_CUSTOM = "Custom Voice"
	DBM_CORE_SOUNDGRIL_TEXT_CUSTOM = "    This is a custom voice files, but now it is likely to be empty, if you choose this may be no speech output"
end