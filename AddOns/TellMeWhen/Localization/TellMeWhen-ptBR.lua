--[[ Credit for these translations goes to:
--]]

local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "ptBR", false)
if not L then return end


L["ALPHA"] = "Alpha" -- Needs review
L["ANIM_ACTVTNGLOW"] = "Borda de Ativação" -- Needs review
L["ANIM_ACTVTNGLOW_DESC"] = "Mostra a borda da Blizzard para ativação de feitiço." -- Needs review
L["ANIM_COLOR"] = "Cor/Opacidade" -- Needs review
L["ANIM_COLOR_DESC"] = "Configura a cor e a opacidade do flash." -- Needs review
L["ANIM_FADE"] = "Apagar Flashes" -- Needs review
L["ANIM_FADE_DESC"] = "Marque para que cada flash apague suavemente. Desmarque para instantâneo." -- Needs review
L["ANIM_ICONFLASH_DESC"] = "Flash colorido sobre o ícone." -- Needs review
L["ANIM_PERIOD"] = "Período de Flash" -- Needs review
L["ANIM_SCREENFLASH"] = "Tela: Flash" -- Needs review
L["Bleeding"] = "Sangrando"
L["BonusStamina"] = "Stamina aumentada"
L["BOTTOM"] = "botão" -- Needs review
L["BOTTOMLEFT"] = "botão esquerdo" -- Needs review
L["BurstManaRegen"] = "Explosão de Regeneração de Mana" -- Needs review
L["CACHING"] = "TellMeWhen armazena e filtra todos os feitiços no jogo. Isto precisa apenas será feito uma vez por patch. Você pode aumentar ou diminuir o processo usando a barra deslizante. " -- Needs review
L["CACHINGSPEED"] = "Feitiço por quadro" -- Needs review
L["CASTERFORM"] = "Forma Conjuradora" -- Needs review
L["CENTER"] = "Centro" -- Needs review
L["CHAT_FRAME"] = "Janela de Chat" -- Needs review
L["CHAT_MSG_CHANNEL"] = "Canal de bate-papo" -- Needs review
L["CHAT_MSG_CHANNEL_DESC"] = "Será a saída para um canal de bate-papo, tal como o canal de comércio ou um canal personalizado que você tiver entrado." -- Needs review
L["CHAT_MSG_SMART"] = "Canal inteligente" -- Needs review
L["CHAT_MSG_SMART_DESC"] = "Será a saída para os Campos de batalhas, Raids, Grupos ou Conversas - Seja qual for é apropriado." -- Needs review
L["CHECKORDER"] = "Ordem de atualização" -- Needs review
L["CHECKORDER_GROUPDESC"] = "S" -- Needs review
L["CHECKORDER_ICONDESC"] = "Defina a ordem que os ícones dentro deste group serão atualizados.Isto  realmente importa se você estar utilizando as características dos [ícones metas para verificar sub-metas." -- Needs review
L["CHOOSENAME_DIALOG"] = [=[Digite o nome ou ID do que você quer neste ícone para monitor. Você pode adicionar várias entradas (qualquer combinação de nomes, IDs e equivalências), separando-os com ponto e vírgula (;).

Você pode clicar em habilidades/itens/links do chat com shift ou arrastar habilidades/itens para inserí-los nesta caixa de edição.]=] -- Needs review
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "Conj. de Magias/Tipos de Dispell" -- Needs review
L["CHOOSENAME_DIALOG_MSCD"] = "Insira o nome ou ID de qual recarregamento este ícone monitore.Apenas o primeiro feitiço/item serão verificados - lista delimitada por ponto e virgula não serão validos para este tipo de ícone." -- Needs review
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959HABILIDADES DE PETS|r devem usar o ID da habilidade. "
L["CLEU_CAT_AURA"] = "Buffs/Debuffs" -- Needs review
L["CLEU_CAT_CAST"] = "Lançamentos" -- Needs review
L["CLEU_CAT_MISC"] = "Miscelânea" -- Needs review
L["CLEU_CAT_SPELL"] = "Feitiços" -- Needs review
L["CLEU_CAT_SWING"] = "Corpo-a-corpo/Longo-alcance" -- Needs review
L["CLEU_DAMAGE_SHIELD_DESC"] = "Ocorre quando um escudo de dano (%s, %s, etc. mas não %s) causa dano." -- Needs review
L["CLEU_DAMAGE_SHIELD_MISSED_DESC"] = "Ocorre quando um escudo de dano (%s, %s, etc., mas não %s) não causa dano." -- Needs review
L["CLEU_DAMAGE_SPLIT_DESC"] = "Ocorre quando o dano é dividido entre dois ou mais alvos." -- Needs review
L["CLEU_ENCHANT_APPLIED_DESC"] = "Cobre encantos temporários de arma como venenos de ladinos." -- Needs review
L["CLEU_ENCHANT_REMOVED_DESC"] = "Cobre encantos temporários de arma como venenos de ladinos." -- Needs review
L["CLEU_ENVIRONMENTAL_DAMAGE_DESC"] = "Inclui dano de lava, fadiga, afogamento e queda." -- Needs review
L["CLEU_SPELL_DRAIN_DESC"] = "Ocorre quando recursos (vida/mana/raiva/energia/etc) são removidos." -- Needs review
L["CLEU_SPELL_ENERGIZE_DESC"] = "Ocorre quando recursos (vida/mana/raiva/energia/etc) são ganhos." -- Needs review
L["CLEU_SPELL_EXTRA_ATTACKS_DESC"] = "Ocorre quando golpes extras são ganhos por procs." -- Needs review
L["CMD_OPTIONS"] = "Opções" -- Needs review
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "Atributos do jogador" -- Needs review
L["CNDTCAT_ATTRIBUTES_UNIT"] = "Atributos da unidade" -- Needs review
L["CNDTCAT_CURRENCIES"] = "Moedas" -- Needs review
L["CNDTCAT_FREQUENTLYUSED"] = "Frequentemente usado" -- Needs review
L["CNDTCAT_RESOURCES"] = "Recursos" -- Needs review
L["CNDTCAT_SPELLSABILITIES"] = "Feitiços/itens" -- Needs review
L["CNDTCAT_STATS"] = "Status de combate" -- Needs review
L["CNDT_ONLYFIRST"] = "Apenas o primeiro feitiço/item será verificado - listas delimitadas por ponto e vírgula não são validas para este tipo de condição" -- Needs review
L["CODETOEXE"] = "Codigo para executar" -- Needs review
L["COLOR_CBC"] = "Barra de recarregamento - completo " -- Needs review
L["COLOR_CBC_DESC"] = "Cor do recarregamento/duração da barra de camada quando o recarregamento/duração estiver completo." -- Needs review
L["COLOR_CBS"] = "Barra de recarregamento - Começar" -- Needs review
L["COLOR_CBS_DESC"] = "Cor do recarregamento/duração da barra de camada quando o recarregamento/duração estiver iniciando." -- Needs review
L["COLOR_COA"] = "Cronômetro, Relógio escondido, Sempre mostrar" -- Needs review
L["COLOR_COA_DESC"] = [=[Color of the icon when:

The timer is active (unusable/present),
%q is disabled,
Both %q settings are checked]=] -- Needs review
L["COLOR_COLOR"] = "Cor" -- Needs review
L["COLOR_COS"] = "Cronômetro, Relógio escondido, às vezes mostrar" -- Needs review
L["COLOR_COS_DESC"] = [=[Color of the icon when:

The timer is active (unusable/present),
%q is disabled,
Both %q settings are not checked]=] -- Needs review
L["COLOR_CTA"] = "Cronômetro, Relógio visível , Sempre mostrar" -- Needs review
L["COLOR_CTA_DESC"] = [=[Color of the icon when:

The timer is active (unusable/present),
%q is enabled,
Both %q settings are checked]=] -- Needs review
L["COLOR_CTS"] = "Cronometro, relógio visível, as vezes mostrar" -- Needs review
L["COLOR_CTS_DESC"] = [=[Color of the icon when:

The timer is active (unusable/present),
%q is enabled,
Both %q settings are not checked]=] -- Needs review
L["COLOR_DEFAULT"] = "*Cores globais *" -- Needs review
L["COLOR_DESATURATE"] = "Cinza" -- Needs review
L["COLOR_DESATURATE_DESC"] = "Verificar a insaturação do ícone quando esta cor é utilizada, remova todas as colores e crie o ícone em grayscale." -- Needs review
L["COLOR_HEADER"] = [=[Estas cores serão utilizadas para %s ícones se seus %q configurações forem verificadas.

 Brancas solidas não causam  modificações a  textura. Preto solido fará com que a textura seja vendida preta. Algum cinza ou cor no meio irá pintar o ìcone.]=] -- Needs review
L["COLOR_HEADER_DEFAULT"] = [=[Estas  cores irão ser usados por algum ícone de digitação que não ultrapasse eles nas configurações de cores de digitação.

Brancas solidas não causam  modificações a  textura. Preto solido fará com que a textura seja vendida preta. Algum cinza ou cor no meio irá pintar o ìcone.]=] -- Needs review
L["COLOR_MSQ_COLOR"] = "Cor da borda masque " -- Needs review
L["COLOR_MSQ_COLOR_DESC"] = "Verificando isto irá causar a bordar de uma camada masque (se a camada que você estar usando tem uma borda) ser colorida." -- Needs review
L["COLOR_MSQ_ONLY"] = "Apenas a cor da borda masque" -- Needs review
L["COLOR_MSQ_ONLY_DESC"] = "Verificando isto irá causar apenas a bordar de uma camada masque (se a camada que você estar usando tem uma borda) ser colorida. Ìcones não serão coloridos." -- Needs review
L["COLOR_NA"] = "Terminado, Sempre mostrar" -- Needs review
L["COLOR_NA_DESC"] = [=[Color of the icon when:

The timer is finished (usable/absent),
Both %q settings are checked]=] -- Needs review
L["COLOR_NS"] = "terminado, as vezes mostrar" -- Needs review
L["COLOR_NS_DESC"] = [=[Color of the icon when:

The timer is finished (usable/absent),
Both %q settings are not checked]=] -- Needs review
L["COLOR_OOM"] = "Pouca mana" -- Needs review
L["COLOR_OOM_DESC"] = "A cor do ícone quando você carece de poder para usar uma habilidade." -- Needs review
L["COLOR_OOR"] = "Fora de alcance" -- Needs review
L["COLOR_OOR_DESC"] = "A cor do ícone quando você não tem alcance para usar uma habilidade." -- Needs review
L["COLOR_OORM"] = "Fora de alcance e mana baixa" -- Needs review
L["COLOR_OORM_DESC"] = "A cor do ícone quando você carece de poder e não tem alcance para usar uma habilidade." -- Needs review
L["COLOR_OVERRIDEDEFAULT"] = "Utilizar" -- Needs review
L["COLOR_OVERRIDEDEFAULT_DESC"] = "Verificar ultrapassou as configurações de *Cores globais * e utilize esta configuração como alternativa." -- Needs review
L["COLOR_RESET_DESC"] = "Redefina esta configuração para valores padrões" -- Needs review
L["COMPARISON"] = "Comparação" -- Needs review
L["CONDITIONALPHA"] = "condição/reqs falhada" -- Needs review
L["CONDITIONALPHA_CONDITIONICON"] = "Duração falhada" -- Needs review
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "Esta será utilizado quando a duração necessário não é conhecida. Esta configuração será ignorada se o ícone já estiver escondido por outras duas configurações opacidade." -- Needs review
L["CONDITIONALPHA_DESC"] = "Isto será usado quando a condição falhar ou se a duração ou estacas necessárias não são conhecidas. Esta configuração será ignorada se o ícone já estiver escondido pela as outras duas configurações de opacidade." -- Needs review
L["CONDITIONPANEL_ABSOLUTE"] = "Absoluto" -- Needs review
L["CONDITIONPANEL_ADD"] = "Adicionar  uma condição" -- Needs review
L["CONDITIONPANEL_ALIVE"] = "Unidade está Viva" -- Needs review
L["CONDITIONPANEL_ALIVE_DESC"] = "A condição será passada se a unidade especifica estiver viva." -- Needs review
L["CONDITIONPANEL_ALTPOWER"] = "Alt.Poder" -- Needs review
L["CONDITIONPANEL_ALTPOWER_DESC"] = "Isto é o poder de encontro especifico usado em diversos encontros no Cataclysma, incluindo Cho'gall and Atramedes." -- Needs review
L["CONDITIONPANEL_AND"] = "E"
L["CONDITIONPANEL_ANDOR"] = "E / Ou"
L["CONDITIONPANEL_AUTOCAST"] = "Feitiço autolançavel" -- Needs review
L["CONDITIONPANEL_CASTTOMATCH"] = "Feitiços para combinar" -- Needs review
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = "Digite um nome de um feitiço aqui para criar uma condição que apenas passe se o feitiço conjurado corresponder exatamente." -- Needs review
L["CONDITIONPANEL_CLASS"] = "classe de unidade" -- Needs review
L["CONDITIONPANEL_CLASSIFICATION"] = "Classificação da unidade." -- Needs review
L["CONDITIONPANEL_COMBAT"] = "unidade em combate" -- Needs review
L["CONDITIONPANEL_COMBO"] = "Pontos de Combo" -- Needs review
L["CONDITIONPANEL_DEFAULT"] = "Escolha um tipo" -- Needs review
L["CONDITIONPANEL_ECLIPSE_DESC"] = "Eclipse tem um alcance de -100 (eclipse lunar) até 100 (eclipse solar). Insira -80 se quiser que o ícone apareça com um valor de 80 poder lunar." -- Needs review
L["CONDITIONPANEL_EQUALS"] = "Igual a"
L["CONDITIONPANEL_GREATER"] = "Maior Que"
L["CONDITIONPANEL_GREATEREQUAL"] = "Maior ou Igual a"
L["CONDITIONPANEL_GROUPTYPE"] = "tipo de grupo" -- Needs review
L["CONDITIONPANEL_ICON"] = "Ícone Mostrado" -- Needs review
L["CONDITIONPANEL_ICON_DESC"] = [=[A condição será verdadeira se o ícone especificado for mostrado com um alpha acima de 0 ou escondido com alpha de 0 se definido como falso.

Se você não quiser mostrar os ícones que estão sendo checados, cheque %q no editor de ícones checados.

O grupo do ícone checado deverá também ser mostrado em ordem para checar o ícone, mesmo se a condição for definida como falsa.]=] -- Needs review
L["CONDITIONPANEL_ICON_HIDDEN"] = "Esconder" -- Needs review
L["CONDITIONPANEL_ICON_SHOWN"] = "Mostrar" -- Needs review
L["CONDITIONPANEL_INSTANCETYPE"] = "Instancias de tipos" -- Needs review
L["CONDITIONPANEL_INTERRUPTIBLE"] = "interruptível" -- Needs review
L["CONDITIONPANEL_ITEMRANGE"] = "item no alcance da unidade" -- Needs review
L["CONDITIONPANEL_LESS"] = "Menor Que"
L["CONDITIONPANEL_LESSEQUAL"] = "Menor ou Igual a"
L["CONDITIONPANEL_LEVEL"] = "Nível da unidade" -- Needs review
L["CONDITIONPANEL_MANAUSABLE"] = "Feitiço utilizável (Mana/Energia/etc.)" -- Needs review
L["CONDITIONPANEL_MAX"] = "Maximo" -- Needs review
L["CONDITIONPANEL_MOUNTED"] = "Montada" -- Needs review
L["CONDITIONPANEL_NAME"] = "Nome da unidade" -- Needs review
L["CONDITIONPANEL_NAMETOMATCH"] = "Nome para corresponder" -- Needs review
L["CONDITIONPANEL_NAMETOOLTIP"] = "Você podem inserir múltiplos nomes para serem combinados, separando-os com um ponto e virgula(;) cada um. A condição sserá permitida se alguns nomes estiverem combinados." -- Needs review
L["CONDITIONPANEL_NOTEQUAL"] = "Diferente de"
L["CONDITIONPANEL_OPERATOR"] = "Operador"
L["CONDITIONPANEL_OR"] = "Ou"
L["CONDITIONPANEL_PETMODE"] = "Ajudante modo de ataque" -- Needs review
L["CONDITIONPANEL_PETTREE"] = "Árvore de talentos do ajudante" -- Needs review
L["CONDITIONPANEL_POWER"] = "Recurso primário" -- Needs review
L["CONDITIONPANEL_POWER_DESC"] = "Vai checar a energia se a unidade for um druida em forma de felino, raiva se for um guerreiro, etc." -- Needs review
L["CONDITIONPANEL_RAIDICON"] = "Ìcone da unidade da raid" -- Needs review
L["CONDITIONPANEL_REMOVE"] = "Remova esta condição" -- Needs review
L["CONDITIONPANEL_RESTING"] = "Descansando" -- Needs review
L["CONDITIONPANEL_ROLE"] = "Função da unidade" -- Needs review
L["CONDITIONPANEL_RUNES_DESC"] = [=[Use esta tipo de condição para apenas mostra o ícone quando as runas selecionadas estiverem selecionadas.
Cada runa é um butão de verificação. Uma marca de seleção será necessária para que a aquela runa seja utilizável, um "X" será necessário para que aquela runa seja inutilizável, sem marca a runa será ignorada.
As runas na seconda fileira são as runas da morte, versão de cada runa acima.]=] -- Needs review
L["CONDITIONPANEL_SPELLRANGE"] = "feitiço no alcance da unidade" -- Needs review
L["CONDITIONPANEL_SWIMMING"] = "Nadando" -- Needs review
L["CONDITIONPANEL_THREAT_RAW"] = "Ameaça da unidade - bruto" -- Needs review
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [=[Esta condição verificar sua porcentagem de ameça bruta na unidade.
Jogadores de ataque a curta distancia atraem a agressividade dos monstro  em 110%.
Jogadores com ataque a longa distância atraem a agressividade dos monstros em 130%
Jogadres com os monstro já o atacando tem a porcentagem de ameaça bruta de 255%]=] -- Needs review
L["CONDITIONPANEL_THREAT_SCALED"] = "Ameça da unidade - Escalada" -- Needs review
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [=[Esta condição verifica sua escala porcentagem de ameaça na unidade.
100 % indica que você estar tankando a unidade.]=] -- Needs review
L["CONDITIONPANEL_TRACKING"] = "Rastreamento ativado" -- Needs review
L["CONDITIONPANEL_TYPE"] = "Tipo"
L["CONDITIONPANEL_UNIT"] = "Unidade" -- Needs review
L["CONDITIONPANEL_UNITISUNIT"] = "Unidade é unidade" -- Needs review
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "Esta condição passará se a unidade na primeira caixa de edição e na segunda caixa de edição forem as mesmas entidades." -- Needs review
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "Insira a unidade nesta caixa de edição para ser comparada com a primeira unidade" -- Needs review
L["CONDITIONPANEL_VALUEN"] = "Valor" -- Needs review
L["CONDITIONPANEL_VEHICLE"] = "Unidade de controle do veículo" -- Needs review
L["CONDITIONS"] = "Condição" -- Needs review
L["CONDITION_TIMERS_FAIL_DESC"] = "A duração de um relógio para  definir sobre o ícone quando as condições começam a falhar ." -- Needs review
L["CONDITION_TIMERS_HEADER"] = "Relogios" -- Needs review
L["CONDITION_TIMERS_SUCCEED_DESC"] = "A duração de um relógio para  definir sobre o ícone quando as condições começam a ter sucesso." -- Needs review
L["CONFIGMODE"] = "TellMeWhen estar em modo de configuração. Ìcones não funcionaram enquanto você não sair do modo de configuração. Digite '/tellmewhen' ou /tmw pata" -- Needs review
L["CONFIGMODE_EXIT"] = "Sair do modo de configuração" -- Needs review
L["CONFIGMODE_NEVERSHOW"] = "Não mostrar de novo." -- Needs review
L["COPYGROUP"] = "copiar grupo" -- Needs review
L["COPYPOSSCALE"] = "copiar posição/escala" -- Needs review
L["CREATURETYPE_1"] = "Fera"
L["CREATURETYPE_10"] = "Não Especificado"
L["CREATURETYPE_11"] = "Totem"
L["CREATURETYPE_12"] = "Mascote"
L["CREATURETYPE_13"] = "Nuvem de Gás"
L["CREATURETYPE_14"] = "Mascote Selvagem"
L["CREATURETYPE_2"] = "Draconiano"
L["CREATURETYPE_3"] = "Demônio"
L["CREATURETYPE_4"] = "Elemental"
L["CREATURETYPE_5"] = "Gigante"
L["CREATURETYPE_6"] = "Morto-vivo"
L["CREATURETYPE_7"] = "Humanoide"
L["CREATURETYPE_8"] = "Bicho"
L["CREATURETYPE_9"] = "Mecânico"
L["CrowdControl"] = "controle de grupo" -- Needs review
L["Curse"] = "maldição" -- Needs review
L["DESCENDING"] = "Descendente" -- Needs review
L["DISABLED"] = "Desativado" -- Needs review
L["Disarmed"] = "Desarmado"
L["Disease"] = "Doente" -- Needs review
L["Disoriented"] = "Desorientado"
L["DR-Banish"] = "Banimento" -- Needs review
L["DR-ControlledRoot"] = "Raízes controladas" -- Needs review
L["DR-ControlledStun"] = "Tontura controlada" -- Needs review
L["DR-Cyclone"] = "Ciclone" -- Needs review
L["DR-Disarm"] = "Desarmados" -- Needs review
L["DR-Disorient"] = "Desorientados" -- Needs review
L["DR-DragonsBreath"] = "Sopro de Dragão" -- Needs review
L["DR-Fear"] = "Medos" -- Needs review
L["DR-Horrify"] = "horrorizados" -- Needs review
L["DR-MindControl"] = "Controle da mente" -- Needs review
L["EARTH"] = "Terra" -- Needs review
L["ECLIPSE_DIRECTION"] = "Direção do Eclipse" -- Needs review
L["elite"] = "Elite" -- Needs review
L["ENABLINGOPT"] = "TellMeWhen_Options está desativado. Ativando..." -- Needs review
L["Enraged"] = "Enraivecer" -- Needs review
L["ERROR_MISSINGFILE"] = "Um completo reinicio do Wow é necessário para utilizar o TellMeWhen %s (%s não foi encontrado). Gostaria de reiniciar o Wow agora ?" -- Needs review
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "e" -- Needs review
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "Previni que o evento seja manuseado a menos que a condição configurada esteja sucedendo." -- Needs review
L["EVENTS_SETTINGS_HEADER"] = "Configurações de eventos" -- Needs review
L["EVENTS_SETTINGS_ONLYSHOWN"] = "Apenas se o ícone estiver visível" -- Needs review
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "Impede o evento se o ícone não estiver sendo mostrado." -- Needs review
L["EVENTS_SETTINGS_PASSINGCNDT"] = "Apenas manusear se a condição estiver passando:" -- Needs review
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "Previne que o evento seja manuseado a menos que a condição abaixo suceda." -- Needs review
L["EVENTS_SETTINGS_PASSTHROUGH"] = "Continuar diminuindo eventos" -- Needs review
L["EXPORT_f"] = "Exportar %s" -- Needs review
L["EXPORT_HEADING"] = "Exportar" -- Needs review
L["EXPORT_TOCOMM"] = "Para Jogador" -- Needs review
L["EXPORT_TOCOMM_DESC"] = "Escreva os nomes dos jogadores na caixa de edição e escolha esta opção para enviar os dados para eles. Deve ser alguém que você possa enviar um sussurro (mesma facção e servidor e que esteja online), e eles devem ter TellMeWhen v4.0.0+" -- Needs review
L["EXPORT_TOSTRING"] = "Para String" -- Needs review
L["EXPORT_TOSTRING_DESC"] = "Uma string contendo os dados necessários para serem colados na caixa de edição. Pressione Ctrl+C para copiar, e então cole isto onde você queria compartilhar." -- Needs review
L["FALSE"] = "Falso" -- Needs review
L["Feared"] = "Medo" -- Needs review
L["fICON"] = "ìcone: %s" -- Needs review
L["FIRE"] = "Fogo" -- Needs review
L["FONTCOLOR"] = "Cor da fonte" -- Needs review
L["FONTSIZE"] = "Tamanho da fonte" -- Needs review
L["FORWARDS_IE_DESC"] = "Carregar o proximo ícone que foi editado (%s |T%s:0|t)." -- Needs review
L["fPROFILE"] = "Perfil: %s" -- Needs review
L["FROMNEWERVERSION"] = "Você estar importando dados que foram criados em uma versão mais recente do TellMeWhen que sua versão. Algumas configurações podem não funcionar até você atualizar para a última versão." -- Needs review
L["GCD"] = "Global Cooldown" -- Needs review
L["GCD_ACTIVE"] = "GCD ativo" -- Needs review
L["GROUPICON"] = "Grupo: %s, Ícone: %s" -- Needs review
L["HEALER"] = "Cura" -- Needs review
L["HELP_EXPORT_DOCOPY_MAC"] = "Pressione |cff7fffffCMD+C|r para copiar" -- Needs review
L["HELP_EXPORT_DOCOPY_WIN"] = "Pressione |cff7fffffCTRL+C|r para copiar" -- Needs review
L["HELP_MS_NOFOUND"] = [=[A habilidade %q poderia não ser encontrado em sua barra de ação.
Garante que a habilidade estar em sua barra de ação, em seu estado padrão, e que não é apenas um macro que estar colocando o feitiço em sua barra ação. Caso contrário, este ícone não irá funcionar corretamente.]=] -- Needs review
L["HELP_NOUNIT"] = "Você deve digitar uma unidade!" -- Needs review
L["HELP_NOUNITS"] = "Você deve ter no mínimo uma unidade!" -- Needs review
L["ICON"] = "ícone" -- Needs review
L["ICONALPHAPANEL_FAKEHIDDEN"] = "Sempre Esconder" -- Needs review
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = "Causa que o ícone seja escondido o tempo todo, mas ativado para permitir as condições dos outros ícones a checar este icone ou para os ícones meta incluírem este ícone." -- Needs review
L["ICONMENU_ABSENT"] = "Ausente"
L["ICONMENU_ALPHA"] = "Opacidade" -- Needs review
L["ICONMENU_BUFF"] = "Buff"
L["ICONMENU_BUFFDEBUFF"] = "Buff/Debuff"
L["ICONMENU_BUFFTYPE"] = "Buff ou debuff" -- Needs review
L["ICONMENU_COOLDOWNCHECK"] = "Checagem de recarga" -- Needs review
L["ICONMENU_COOLDOWNCHECK_DESC"] = "Marque isto para fazer com que o ícone seja considerado inutilizável caso esteja carregando." -- Needs review
L["ICONMENU_DEBUFF"] = "Debuff"
L["ICONMENU_ENABLE"] = "Habilitado"
L["ICONMENU_FOCUS"] = "Foco"
L["ICONMENU_FOCUSTARGET"] = "Alvo do foco"
L["ICONMENU_FRIEND"] = "Amigável"
L["ICONMENU_HOSTILE"] = "Hostil"
L["ICONMENU_IGNORENOMANA"] = "Ignorar perda de força" -- Needs review
L["ICONMENU_INVERTBARS"] = "Preencher barras" -- Needs review
L["ICONMENU_ITEMCOOLDOWN"] = "Recarga do Item" -- Needs review
L["ICONMENU_MANACHECK"] = "Checar poder" -- Needs review
L["ICONMENU_ONLYMINE"] = "Mostrar somente o meu"
L["ICONMENU_PETTARGET"] = "Alvo do Pet"
L["ICONMENU_PRESENT"] = "Presente"
L["ICONMENU_RANGECHECK"] = "Verificação de alcance" -- Needs review
L["ICONMENU_REACT"] = "Reação da Unidade"
L["ICONMENU_REACTIVE"] = "Habilidade Reativa"
L["ICONMENU_SHOWTIMER"] = "Mostrar o tempo"
L["ICONMENU_SHOWTIMERTEXT"] = "Mostrar texto de contagem" -- Needs review
L["ICONMENU_SHOWTIMERTEXT_DESC"] = "Marque esta opção para mostrar em texto o cooldown/duração restante no ícone." -- Needs review
L["ICONMENU_SHOWWHEN"] = "Mostrar ícone quando"
L["ICONMENU_SPELLCOOLDOWN"] = "Recarga do Feitiço" -- Needs review
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "Rastreia as recargas dos feitiços do seu grimório." -- Needs review
L["ICONMENU_STACKS_MAX_DESC"] = "Número máximo de stacks permitidos a mostrar o ícone" -- Needs review
L["ICONMENU_STACKS_MIN_DESC"] = "Número mínimo de stacks necessários para mostrar o ícone" -- Needs review
L["ICONMENU_TARGETTARGET"] = "Alvo do alvo"
L["ICONMENU_TOTEM"] = "Totem"
L["ICONMENU_TYPE"] = "Tipo do ícone"
L["ICONMENU_UNITCOOLDOWN"] = "Recarga de Unidades" -- Needs review
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[Rastreia a recarga de outra pessoa.

%s pode ser rastreado usando %q como nome.]=] -- Needs review
L["ICONMENU_UNUSABLE"] = "Inutilizável"
L["ICONMENU_USABLE"] = "Utilizável"
L["ICONMENU_VEHICLE"] = "Veículo" -- Needs review
L["ICONMENU_WPNENCHANT"] = "Encantamento da Arma"
L["ICONMENU_WPNENCHANTTYPE"] = "Slot de arma a ser monitorado"
L["ICONTOCHECK"] = "Ícone a marcar" -- Needs review
L["ImmuneToMagicCC"] = "Imune a Mágica de Controle (CC)"
L["ImmuneToStun"] = "Imune a Atordoamento"
L["IMPORT_EXPORT_DESC"] = [=[Click na seta de baixo para a direita da caixa de edição para importar e exportar  ícones, grupos e perfis.

Importando para ou para a string, ou exportando para outro jogador, precisará da caixa de edição. Veja a caixa de ferramentes no inteiro do dropdown menu para mais detalhes]=] -- Needs review
L["IMPORT_FROMBACKUP"] = "Para Backup" -- Needs review
L["IMPORT_FROMBACKUP_WARNING"] = "CONFIGURAÇÕES DE BACKUP: s%" -- Needs review
L["IMPORT_FROMCOMM"] = "Para o Jogador " -- Needs review
L["IMPORT_FROMCOMM_DESC"] = "Se outro usuário de TellMeWhen lhe enviar alguma configuração de dados, você pode permitir a importação destes dados  a partir deste submenu." -- Needs review
L["IMPORT_FROMLOCAL"] = "De um Perfil" -- Needs review
L["IMPORT_FROMSTRING"] = "De uma String" -- Needs review
L["IMPORT_HEADING"] = "Importar" -- Needs review
L["IMPORT_PROFILE"] = "Copiar Perfil" -- Needs review
L["Incapacitated"] = "Incapacitado"
L["IncreasedAP"] = "Poder de Ataque aumentado"
L["IncreasedCrit"] = "Chance de Crítico aumentada"
L["IncreasedPhysHaste"] = "Aceleração física aumentada"
L["IncreasedSpellHaste"] = "Aceleração de magia aumentado"
L["IncreasedSPsix"] = "Poder mágico aumentado (6%)"
L["IncreasedSPten"] = "Poder mágico aumentado (10%)"
L["IncreasedStats"] = "Atributos Aumentados" -- Needs review
L["ITEMCOOLDOWN"] = "Recarga de item" -- Needs review
L["MOON"] = "Lua" -- Needs review
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "<no mouseover>" -- Needs review
L["NEWVERSION"] = "Uma  nova versão do Tell Me When estar disponível" -- Needs review
L["NONE"] = "Nenhum" -- Needs review
L["normal"] = "Normal" -- Needs review
L["NOTINRANGE"] = "Fora  alcance" -- Needs review
L["NUMAURAS"] = "Números de" -- Needs review
L["NUMAURAS_DESC"] = "Esta condição verificar os números da sua aura ativada - não confunda com o numero de estacas da sua aura. Isto é para   verificar coisas como se tiver tanto um encantamento procs ativado na arma ao mesmo tempo. Use com moderação, visto que o processo utilizado para contar os números é uma CPU pouco intensiva." -- Needs review
L["OUTLINE_NO"] = "Sem Contorno" -- Needs review
L["OUTLINE_THICK"] = "Contorno Grosso" -- Needs review
L["OUTLINE_THIN"] = "Contorno Fino" -- Needs review
L["PhysicalDmgTaken"] = "Dano Físico Levado"
L["ReducedArmor"] = "Armadura Reduzida"
L["ReducedCastingSpeed"] = "Velocidade de Lançamento Reduzida" -- Needs review
L["ReducedHealing"] = "Cura Reduzida"
L["ReducedPhysicalDone"] = "Dano Físico Causado Reduzido"
L["RESIZE"] = "Redimensionar"
L["RESIZE_TOOLTIP"] = "Clique e arraste para mudar o tamanho" -- Needs review
L["Rooted"] = "Enraizado" -- Needs review
L["Silenced"] = "Silenciado"
L["SOUND_EVENT_ONFINISH_DESC"] = "Esse evento ativa quando a recarga torna-se usável, o debuff/buff acaba, etc." -- Needs review
L["SPELLCOOLDOWN"] = "Recarga de feitiço" -- Needs review
L["SpellDamageTaken"] = "Dano de Magia Levado Aumentado" -- Needs review
L["Stunned"] = "Atordoado" -- Needs review
L["SUG_INSERTEQUIV"] = "%s para inserir equivalência" -- Needs review
L["SUG_MATCH_WPNENCH_ENCH"] = "Arma ?d?[ae]? (.*)" -- Needs review
L["SUG_PATTERNMATCH_FISHINGLURE"] = "Isca de Pesca %(%+%d+ Pesca%)"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "Afiado %(%+%d+ Dano%)"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "Pesado %(%+%d+ Dano%)"
L["SUN"] = "Sol" -- Needs review
L["UIPANEL_ALLRESET"] = "Redefinir tudo"
L["UIPANEL_BARIGNOREGCD"] = "Barras Ignoram GCD" -- Needs review
L["UIPANEL_BARIGNOREGCD_DESC"] = "Se marcado, as barras de cooldown não irão mudar de valor se o cooldown ativado for um cooldown global." -- Needs review
L["UIPANEL_BARTEXTURE"] = "Textura da Barra"
L["UIPANEL_CLOCKIGNOREGCD"] = "Timers Ignoram GCD" -- Needs review
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "Se marcado, os timers e os relógios de cooldown não irão ativar de um cooldown global." -- Needs review
L["UIPANEL_COLORS"] = "Cores" -- Needs review
L["UIPANEL_COLUMNS"] = "Colunas"
L["UIPANEL_ENABLEGROUP"] = "Habilitar Grupo"
L["UIPANEL_GROUPRESET"] = "Redefinir Posição"
L["UIPANEL_GROUPS"] = "Grupos" -- Needs review
L["UIPANEL_LOCK"] = "Trancar Grupo" -- Needs review
L["UIPANEL_LOCKUNLOCK"] = "Trancar/Destrancar AddOn"
L["UIPANEL_MAINOPT"] = "Opções Principais" -- Needs review
L["UIPANEL_ONLYINCOMBAT"] = "Mostrar somente em combate"
L["UIPANEL_PRIMARYSPEC"] = "Especialização Primária"
L["UIPANEL_ROWS"] = "Linhas"
L["UIPANEL_SECONDARYSPEC"] = "Especialização Secundária"
L["UIPANEL_SUBTEXT2"] = "Ícones funcionam quando trancados. Quando destrancados, você pode mover/redimensionar grupos e clicar com o botão direito nos ícones para mais configurações. Você também pode digitar /tellmewhen ou /tmw para travar/destravar." -- Needs review
L["UIPANEL_TOOLTIP_ALLRESET"] = "Redefinir DADOS e POSIÇÃO para todos os ícones e grupos, assim como qualquer outra configuração. "
L["UIPANEL_TOOLTIP_COLUMNS"] = "Definir o número de colunas neste grupo"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "Mostrar e habilitar este grupo"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "Redefinir a posição e escala deste grupo"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "Marque para que este grupo só seja mostrado em combate"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "Marque para mostrar este grupo enquanto sua especialização primária estiver ativa"
L["UIPANEL_TOOLTIP_ROWS"] = "Define o número de linhas neste grupo"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "Marque para mostrar este grupo enquanto sua especiação secundária estiver ativa"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = "Define o quão frequente (em segundos) os ícones são verificados para mostrar/esconder, alfa, condições, etc. Zero é o mais rápido possível. Valores menores podem ter um impacto significativo no número de quadros por segundo em computadores mais fracos"
L["UIPANEL_UPDATEINTERVAL"] = "Intervalo de Atualização"
L["WATER"] = "^Àgua" -- Needs review
L["worldboss"] = "Chefe do mundo" -- Needs review
