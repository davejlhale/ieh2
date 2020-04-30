#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines, -1
;Thread, NoTimers
CoordMode, ToolTip
SetTitleMatchMode, 2
DetectHiddenWindows, On

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include clickPoints.txt
global CoordsToggle :=0
global tt_msg
global begin_x, begin_y, end_x, end_y
global gameX,gameY
global developer :=0




	
Initialize()
menu()	
return


menu()
{
	devmenu=setGameWindow,setClickPoints,Record,Stop,Play,Exit,Coords,playerMenu 	
	playermenu=[F1]a,[F2]b,[F3]c,[F4]d,[F5]e,[F6]DevTool
	global developer
	
	removeGUI()
	if (developer)
		addGUI(devmenu)
	else
		addGUI(playermenu)
	return
}


	

	


	
/* 
*** hotkeys  *** 
*/

c:

GuiControl, ,c,[F3]c on ; Put the above font into effect for a control.
return

F6::
DevTool:
playerMenu:
	global developer
	developer:=!developer
	menu()
	return	
	
Escape::
Exit:
	ExitApp
	Return


Initialize:
	Initialize()
	return
	

ClickPoints:
	setClickPoints()
	return
	

	

t::
gameClick(menu1_X, menu1_Y)

	
return

addGUI(sMsg)
{
		GUI()
		For i,v in StrSplit(sMsg, ",")
		{
		  j:=i=1 ? "":"x+0", j.=InStr(v,"Pause") ? " vPause":""
		  Gui, Add, Button, %j% gRunGUI, %v%
		}
		Gui, Show, NA y0, Macro Recorder
		OnMessage(0x200,"WM_MOUSEMOVE")
	return
}

removeGUI()
{	
	Gui, Destroy
	return
}

GUI()
{
	
	Gui, +AlwaysOnTop -Caption +ToolWindow +E0x08000000 +Hwndgui_id
	Gui, Margin, 0, 0
	Gui, Font, s12
	
	SetTimer, OnTop, 2000
	OnTop:
	Gui, +AlwaysOnTop
	return
}

RunGUI:
	if IsLabel(k:=RegExReplace(RegExReplace(A_GuiControl,".*]"),"\W"))
	  Goto, %k%
	return
	;--------------------------



;calcualtes games clickpoint cords with respect to the clients resolution
;prob dont needs move and click but...
gameClick(XPos,YPos)
{
	global gameX,gameY

	gameClickX := (gameX * XPos)+begin_x
	gameClickY := (gameY * Ypos)+begin_Y
	
	mousemove, gameClickX, gameClickY
	sleep, 10
	click, L,gameClickX, gameClickY
	sleep, 10
	return
}




/*
functions
*/


;DEV TOOL
;called to grab games resolution
;calculates games resolution and save top right corner and width/height in globals

Initialize()
{	
	global begin_x:=0 , begin_y:=0 
	global gameX:=0 , gameY:=0
	end_x:=0, end_y:=0
	
	
	
	sMsg:="Click and hold left mouse button at games top left corner `n then move mouse to bottom right corner while holding down the left mouse button"
	
	addGUI(sMsg)
	
	
	KeyWait, LButton, D
	MouseGetPos, begin_x, begin_y

	SetTimer, WatchCursor, 300
    while GetKeyState("LButton")
    {
        MouseGetPos, end_x, end_y
		gameX:=Abs(begin_x-end_x)
		gameY:=Abs(begin_y-end_y)
        tt_msg = % "top left corner `n x:" begin_x " , y:" begin_y "`n`nbottom right corner`n x:" end_x " , y:" end_y "`n`n resolution `nx:" gameX " y: " gameY
        
    }
	KeyWait, LButton, U
	
	removeGUI()
	ToolTip
	SetTimer, WatchCursor, Delete
	Return
}



;DEV TOOL
;called to map right mouse clicks with tooltip shown locations in gameClick
;currently hard forced to notpad - change to overwrite clickpoints.txt in working dir

setClickPoints()
{
	global begin_x, begin_y
	global gameX, gameY
	checkPoints:= ["menu1","menu2","menu3","menu4","menu5","menu6","menu7","menu8","explore","explore_map1","explore_map2","explore_map3","explore_map4","explore_map5","explore_map6","explore_map7","explore_map8","explore_area1","explore_area2","explore_area3","explore_area4","explore_area5","explore_area6","explore_area7","explore_area8","explore_dungeon1","explore_dungeon2","explore_dungeon3","explore_dungeon4","explore_dungeon5","explore_bestiary","bestiary_lootAll","bestiary_close","upgrade","upgrade_mining1","upgrade_mining2","upgrade_mining3","upgrade_synt1","upgrade_synt2","upgrade_synt3","upgrade_gathering1","upgrade_gathering2","upgrade_gathering3","upgrade_pickaxe1","upgrade_pickaxe2","upgrade_pickaxe3","upgrade_pickaxe4","upgrade_lab1","upgrade_lab2","upgrade_lab3","upgrade_lab4","upgrade_rake1","upgrade_rake2","upgrade_rake3","upgrade_rake4","upgrade_gold_bonus","upgrade_exp_bonus","upgrade_expand_equip","upgrade_stone_ritual","upgrade_crystal_ritual","upgrade_leaf_ritual","upgrade_mystery_box","upgrade_8","upgrade_16","upgrade_24","upgrade_32","upgrade_upgrade1","upgrade_upgrade10","upgrade_upgrade25","upgrade_upgradeMax","upgrade_nitro","upgrade_nitro_pixel_start","upgrade_nitro_pixel_end","upgrade_slime_bank","upgrade_dark_ritual","sb_GoBack","sb_withdraw","sb_withdrawConfirm","sb_times1","sb_times10","sb_times25","sb_timesMax","sb_donate","sb_purifucation","sb_efficiency","sb_exchange","sb_interest","sb_cap","sb_et_stone","sb_et_crystal","sb_et_leaf","sb_strength","sb_mind","sb_healty_captue","sb_enhanced_capture","sb_monster_counter","sb_graduates","sb_ledger","sb_nitro_generators","sb_18","sb_19","sb_20","sb_21","sb_22","sb_23","sb_24","sb_25","sb_26","sb_27","sb_28","sb_29","sb_30","sb_31","sb_32","craft_equip1_level_button","craft_equip2_level_button","craft_equip3_level_button","craft_equip4_level_button","craft_equip5_level_button","craft_equip6_level_button","craft_equip7_level_button","craft_equip8_level_button","craft_equip_d_toggle","craft_equip_c_toggle","craft_equip_b_toggle","craft_craft_confirm_Box","craft_Alchemy_confirm_Box","craft_inventory_confirm_Box","alchemy_size_1ml","alchemy_size_10ml","alchemy_size_100ml","alchemy_size_1L","alchemy_size_10L","alchemy_size_100L","alchemy_size_1kL","alchemy_size_10kL","alchemy_size_100kL","alchemy_size_1mill","alchemy_size_10mill","alchemy_size_100mill","alchemy_size_1BL","alchemy_size_10BL","alchemy_auto","alchemy_plus_button","alchemy_use_all","alchemy_potion_option_1","alchemy_potion_option_2","alchemy_potion_option_3","alchemy_potion_option_4","alchemy_potion_option_5","alchemy_potion_option_6","alchemy_potion_option_7","alchemy_potion_option_8","alchemy_potion_option_9","alchemy_potion_option_10","alchemy_potion_option_11","alchemy_potion_option_12","alchemy_potion_option_13","alchemy_potion_option_14","alchemy_potion_option_15","alchemy_potion_option_16","alchemy_potion_inventory_slot_1","alchemy_potion_inventory_slot_2","alchemy_potion_inventory_slot_3","alchemy_potion_inventory_slot_4","alchemy_potion_inventory_slot_5","alchemy_potion_inventory_slot_6","alchemy_potion_inventory_slot_7","alchemy_potion_inventory_slot_8","alchemy_potion_inventory_slot_9","alchemy_potion_inventory_slot_10","alchemy_potion_inventory_slot_11","alchemy_potion_inventory_slot_12","alchemy_potion_inventory_slot_13","alchemy_potion_inventory_slot_14","alchemy_potion_inventory_slot_15","alchemy_potion_inventory_slot_16","challenge_1","challenge_2","challenge_3","challenge_4","challenge_5","challenge_retryBox","challenge_start","challenge_quit","skill_table_warrior","skill_table_wizard","skill_table_angel","skill_table_skill_1","skill_table_skill_2","skill_table_skill_3","skill_table_skill_4","skill_table_skill_5","skill_table_skill_6","skill_table_skill_7","skill_table_skill_8","skill_table_skill_9","skill_table_skill_10","skill_table_skill_1_stance","skill_table_skill_2_stance","skill_table_skill_3_stance","skill_table_skill_4_stance","skill_table_skill_5_stance","skill_table_skill_6_stance","skill_table_skill_7_stance","skill_table_skill_8_stance","skill_table_skill_9_stance","skill_table_skill_10_stance","skill_table_skill_1_chargeUp","skill_table_skill_2_chargeUp","skill_table_skill_3_chargeUp","skill_table_skill_4_chargeUp","skill_table_skill_5_chargeUp","skill_table_skill_6_chargeUp","skill_table_skill_7_chargeUp","skill_table_skill_8_chargeUp","skill_table_skill_9_chargeUp","skill_table_skill_10_chargeUp","skillbar_class_top_1","skillbar_class_top_2","skillbar_class_top_3","skillbar_class_bottom_1","skillbar_class_bottom_2","skillbar_class_bottom_3","skillbar_global_top_1","skillbar_global_top_2","skillbar_global_top_3","skillbar_global_bottom_1","skillbar_global_bottom_2","skillbar_global_bottom_3","skillbar_active_skill","skillbar_automove"]
	SetTimer, WatchCursor, 150
	
	For index, value in checkPoints
	{
		tt_msg = % value
		KeyWait, RButton, D
		
		MouseGetPos, xpos, ypos
		clickXabs:=Abs(begin_x-xpos)
		clickYabs:=Abs(begin_y-ypos)
		xOffsetRation:=clickXabs/gameX
		yOffsetRation:=clickYabs/gameY
		
		tt_msg =  % value " set at  X="  xOffsetRation " , Y="yOffsetRation 
		
	
		SetTitleMatchMode, 2
		WinActivate, Notepad ;
		sleep 100

		Send {Enter}%value%_X:= %xOffsetRation%
		Send {Enter}%value%_Y:=  %yOffsetRation%		
	}
	return
}


WatchCursor: 
	global CoordsToggle
	if (CoordsToggle)
	{ 
		MouseGetPos, xpos, ypos
		tt_msg = %xpos% %ypos%
	}
	ToolTip, %tt_msg%
	
	return

Coords:
	{
		global CoordsToggle 
		CoordsToggle := !CoordsToggle
		if (CoordsToggle)
			SetTimer, WatchCursor, 100
		else
			{
			ToolTip
			SetTimer, WatchCursor, Delete
			}
	return
	}
	

/*
*** commen	ts containing all click point variables from include file so they useable in notepad++ intelisense
*/

; menu1_Y , menu2_Y , menu3_Y , menu4_Y , menu5_Y , menu6_Y , menu7_Y , menu8_Y 
; explore_Y , explore_map1_Y , explore_map2_Y , explore_map3_Y , explore_map4_Y , explore_map5_Y , explore_map6_Y , explore_map7_Y , explore_map8_Y 
; explore_area1_Y , explore_area2_Y , explore_area3_Y , explore_area4_Y , explore_area5_Y , explore_area6_Y , explore_area7_Y , explore_area8_Y , explore_dungeon1_Y 
; explore_dungeon2_Y , explore_dungeon3_Y , explore_dungeon4_Y , explore_dungeon5_Y 
; explore_bestiary_Y , bestiary_lootAll_Y , bestiary_close_Y 
; upgrade_Y , upgrade_mining1_Y , upgrade_mining2_Y , upgrade_mining3_Y 
; upgrade_synt1_Y , upgrade_synt2_Y , upgrade_synt3_Y ;
; upgrade_gathering1_Y , upgrade_gathering2_Y , upgrade_gathering3_Y 
; upgrade_pickaxe1_Y , upgrade_pickaxe2_Y , upgrade_pickaxe3_Y , upgrade_pickaxe4_Y 
; upgrade_lab1_Y , upgrade_lab2_Y , upgrade_lab3_Y , upgrade_lab4_Y ;
; upgrade_rake1_Y , upgrade_rake2_Y , upgrade_rake3_Y , upgrade_rake4_Y ;
; upgrade_gold_bonus_Y , upgrade_exp_bonus_Y , upgrade_expand_equip_Y 
; upgrade_stone_ritual_Y , upgrade_crystal_ritual_Y , upgrade_leaf_ritual_Y , upgrade_mystery_box_Y 
; upgrade_8_Y , upgrade_16_Y , upgrade_24_Y , upgrade_32_Y 
; upgrade_upgrade1_Y , upgrade_upgrade10_Y , upgrade_upgrade25_Y , upgrade_upgradeMax_Y 
; upgrade_nitro_Y , upgrade_nitro_pixel_start_Y , upgrade_nitro_pixel_end_Y 
; upgrade_slime_bank_Y , upgrade_dark_ritual_Y , sb_GoBack_Y , sb_withdraw_Y , sb_withdrawConfirm_Y 
; sb_times1_Y , sb_times10_Y , sb_times25_Y , sb_timesMax_Y 
; sb_donate_Y , sb_purifucation_Y , sb_efficiency_Y , sb_exchange_Y , sb_interest_Y , sb_cap_Y 
; sb_et_stone_Y , sb_et_crystal_Y , sb_et_leaf_Y ;
; sb_strength_Y , sb_mind_Y 
; sb_healty_captue_Y , sb_enhanced_capture_Y 
; sb_monster_counter_Y , sb_graduates_Y , sb_ledger_Y , sb_nitro_generators_Y 
; sb_18_Y , sb_19_Y , sb_20_Y , sb_21_Y , sb_22_Y , sb_23_Y , sb_24_Y , sb_25_Y , sb_26_Y , sb_27_Y , sb_28_Y , sb_29_Y , sb_30_Y , sb_31_Y , sb_32_Y 
; craft_equip1_level_button_Y , craft_equip2_level_button_Y , craft_equip3_level_button_Y , craft_equip4_level_button_Y , craft_equip5_level_button_Y , craft_equip6_level_button_Y , craft_equip7_level_button_Y , craft_equip8_level_button_Y 
; craft_equip_d_toggle_Y , craft_equip_c_toggle_Y , craft_equip_b_toggle_Y 
; craft_craft_confirm_Box_Y , craft_Alchemy_confirm_Box_Y , craft_inventory_confirm_Box_Y 
; alchemy_size_1ml_Y , alchemy_size_10ml_Y , alchemy_size_100ml_Y , alchemy_size_1L_Y , alchemy_size_10L_Y , alchemy_size_100L_Y , alchemy_size_1kL_Y , alchemy_size_10kL_Y , alchemy_size_100kL_Y , alchemy_size_1mill_Y , alchemy_size_10mill_Y , alchemy_size_100mill_Y , alchemy_size_1BL_Y , alchemy_size_10BL_Y 
; alchemy_auto_Y , alchemy_plus_button_Y , alchemy_use_all_Y 
; alchemy_potion_option_1_Y , alchemy_potion_option_2_Y , alchemy_potion_option_3_Y , alchemy_potion_option_4_Y , alchemy_potion_option_5_Y , alchemy_potion_option_6_Y , alchemy_potion_option_7_Y , alchemy_potion_option_8_Y , alchemy_potion_option_9_Y , alchemy_potion_option_10_Y , alchemy_potion_option_11_Y , alchemy_potion_option_12_Y , alchemy_potion_option_13_Y , alchemy_potion_option_14_Y , alchemy_potion_option_15_Y , alchemy_potion_option_16_Y 
; alchemy_potion_inventory_slot_1_Y , alchemy_potion_inventory_slot_2_Y , alchemy_potion_inventory_slot_3_Y , alchemy_potion_inventory_slot_4_Y , alchemy_potion_inventory_slot_5_Y , alchemy_potion_inventory_slot_6_Y , alchemy_potion_inventory_slot_7_Y , alchemy_potion_inventory_slot_8_Y , alchemy_potion_inventory_slot_9_Y , alchemy_potion_inventory_slot_10_Y , alchemy_potion_inventory_slot_11_Y , alchemy_potion_inventory_slot_12_Y , alchemy_potion_inventory_slot_13_Y , alchemy_potion_inventory_slot_14_Y , alchemy_potion_inventory_slot_15_Y , alchemy_potion_inventory_slot_16_Y 
; challenge_1_Y , challenge_2_Y , challenge_3_Y , challenge_4_Y , challenge_5_Y 
; challenge_retryBox_Y , challenge_start_Y , challenge_quit_Y 
; skill_table_warrior_Y , skill_table_wizard_Y , skill_table_angel_Y 
; skill_table_skill_1_Y , skill_table_skill_2_Y , skill_table_skill_3_Y , skill_table_skill_4_Y , skill_table_skill_5_Y , skill_table_skill_6_Y , skill_table_skill_7_Y , skill_table_skill_8_Y , skill_table_skill_9_Y , skill_table_skill_10_Y 
; skill_table_skill_1_stance_Y , skill_table_skill_2_stance_Y , skill_table_skill_3_stance_Y , skill_table_skill_4_stance_Y , skill_table_skill_5_stance_Y , skill_table_skill_6_stance_Y , skill_table_skill_7_stance_Y , skill_table_skill_8_stance_Y , skill_table_skill_9_stance_Y , skill_table_skill_10_stance_Y 
; skill_table_skill_1_chargeUp_Y , skill_table_skill_2_chargeUp_Y , skill_table_skill_3_chargeUp_Y , skill_table_skill_4_chargeUp_Y , skill_table_skill_5_chargeUp_Y , skill_table_skill_6_chargeUp_Y , skill_table_skill_7_chargeUp_Y , skill_table_skill_8_chargeUp_Y , skill_table_skill_9_chargeUp_Y , skill_table_skill_10_chargeUp_Y 
; skillbar_class_top_1_Y , skillbar_class_top_2_Y , skillbar_class_top_3_Y , skillbar_class_bottom_1_Y , skillbar_class_bottom_2_Y , skillbar_class_bottom_3_Y 
; skillbar_global_top_1_Y , skillbar_global_top_2_Y , skillbar_global_top_3_Y , skillbar_global_bottom_1_Y , skillbar_global_bottom_2_Y , skillbar_global_bottom_3_Y ;
; skillbar_active_skill_Y , skillbar_automove_Y 



/*
*** same as _Y ***
*/

; menu1_X , menu2_X , menu3_X , menu4_X , menu5_X , menu6_X , menu7_X , menu8_X , explore_X , explore_map1_X , explore_map2_X , explore_map3_X , explore_map4_X , explore_map5_X , explore_map6_X , explore_map7_X , explore_map8_X , explore_area1_X , explore_area2_X , explore_area3_X , explore_area4_X , explore_area5_X , explore_area6_X , explore_area7_X , explore_area8_X , explore_dungeon1_X , explore_dungeon2_X , explore_dungeon3_X , explore_dungeon4_X , explore_dungeon5_X , explore_bestiary_X , bestiary_lootAll_X , bestiary_close_X , upgrade_X , upgrade_mining1_X , upgrade_mining2_X , upgrade_mining3_X , upgrade_synt1_X , upgrade_synt2_X , upgrade_synt3_X , upgrade_gathering1_X , upgrade_gathering2_X , upgrade_gathering3_X , upgrade_pickaxe1_X , upgrade_pickaxe2_X , upgrade_pickaxe3_X , upgrade_pickaxe4_X , upgrade_lab1_X , upgrade_lab2_X , upgrade_lab3_X , upgrade_lab4_X , upgrade_rake1_X , upgrade_rake2_X , upgrade_rake3_X , upgrade_rake4_X , upgrade_gold_bonus_X , upgrade_exp_bonus_X , upgrade_expand_equip_X , upgrade_stone_ritual_X , upgrade_crystal_ritual_X , upgrade_leaf_ritual_X , upgrade_mystery_box_X , upgrade_8_X , upgrade_16_X , upgrade_24_X , upgrade_32_X , upgrade_upgrade1_X , upgrade_upgrade10_X , upgrade_upgrade25_X , upgrade_upgradeMax_X , upgrade_nitro_X , upgrade_nitro_pixel_start_X , upgrade_nitro_pixel_end_X , upgrade_slime_bank_X , upgrade_dark_ritual_X , sb_GoBack_X , sb_withdraw_X , sb_withdrawConfirm_X , sb_times1_X , sb_times10_X , sb_times25_X , sb_timesMax_X , sb_donate_X , sb_purifucation_X , sb_efficiency_X , sb_exchange_X , sb_interest_X , sb_cap_X , sb_et_stone_X , sb_et_crystal_X , sb_et_leaf_X , sb_strength_X , sb_mind_X , sb_healty_captue_X , sb_enhanced_capture_X , sb_monster_counter_X , sb_graduates_X , sb_ledger_X , sb_nitro_generators_X , sb_18_X , sb_19_X , sb_20_X , sb_21_X , sb_22_X , sb_23_X , sb_24_X , sb_25_X , sb_26_X , sb_27_X , sb_28_X , sb_29_X , sb_30_X , sb_31_X , sb_32_X , craft_equip1_level_button_X , craft_equip2_level_button_X , craft_equip3_level_button_X , craft_equip4_level_button_X , craft_equip5_level_button_X , craft_equip6_level_button_X , craft_equip7_level_button_X , craft_equip8_level_button_X , craft_equip_d_toggle_X , craft_equip_c_toggle_X , craft_equip_b_toggle_X , craft_craft_confirm_Box_X , craft_Alchemy_confirm_Box_X , craft_inventory_confirm_Box_X , alchemy_size_1ml_X , alchemy_size_10ml_X , alchemy_size_100ml_X , alchemy_size_1L_X , alchemy_size_10L_X , alchemy_size_100L_X , alchemy_size_1kL_X , alchemy_size_10kL_X , alchemy_size_100kL_X , alchemy_size_1mill_X , alchemy_size_10mill_X , alchemy_size_100mill_X , alchemy_size_1BL_X , alchemy_size_10BL_X , alchemy_auto_X , alchemy_plus_button_X , alchemy_use_all_X , alchemy_potion_option_1_X , alchemy_potion_option_2_X , alchemy_potion_option_3_X , alchemy_potion_option_4_X , alchemy_potion_option_5_X , alchemy_potion_option_6_X , alchemy_potion_option_7_X , alchemy_potion_option_8_X , alchemy_potion_option_9_X , alchemy_potion_option_10_X , alchemy_potion_option_11_X , alchemy_potion_option_12_X , alchemy_potion_option_13_X , alchemy_potion_option_14_X , alchemy_potion_option_15_X , alchemy_potion_option_16_X , alchemy_potion_inventory_slot_1_X , alchemy_potion_inventory_slot_2_X , alchemy_potion_inventory_slot_3_X , alchemy_potion_inventory_slot_4_X , alchemy_potion_inventory_slot_5_X , alchemy_potion_inventory_slot_6_X , alchemy_potion_inventory_slot_7_X , alchemy_potion_inventory_slot_8_X , alchemy_potion_inventory_slot_9_X , alchemy_potion_inventory_slot_10_X , alchemy_potion_inventory_slot_11_X , alchemy_potion_inventory_slot_12_X , alchemy_potion_inventory_slot_13_X , alchemy_potion_inventory_slot_14_X , alchemy_potion_inventory_slot_15_X , alchemy_potion_inventory_slot_16_X , challenge_1_X , challenge_2_X , challenge_3_X , challenge_4_X , challenge_5_X , challenge_retryBox_X , challenge_start_X , challenge_quit_X , skill_table_warrior_X , skill_table_wizard_X , skill_table_angel_X , skill_table_skill_1_X , skill_table_skill_2_X , skill_table_skill_3_X , skill_table_skill_4_X , skill_table_skill_5_X , skill_table_skill_6_X , skill_table_skill_7_X , skill_table_skill_8_X , skill_table_skill_9_X , skill_table_skill_10_X , skill_table_skill_1_stance_X , skill_table_skill_2_stance_X , skill_table_skill_3_stance_X , skill_table_skill_4_stance_X , skill_table_skill_5_stance_X , skill_table_skill_6_stance_X , skill_table_skill_7_stance_X , skill_table_skill_8_stance_X , skill_table_skill_9_stance_X , skill_table_skill_10_stance_X , skill_table_skill_1_chargeUp_X , skill_table_skill_2_chargeUp_X , skill_table_skill_3_chargeUp_X , skill_table_skill_4_chargeUp_X , skill_table_skill_5_chargeUp_X , skill_table_skill_6_chargeUp_X , skill_table_skill_7_chargeUp_X , skill_table_skill_8_chargeUp_X , skill_table_skill_9_chargeUp_X , skill_table_skill_10_chargeUp_X , skillbar_class_top_1_X , skillbar_class_top_2_X , skillbar_class_top_3_X , skillbar_class_bottom_1_X , skillbar_class_bottom_2_X , skillbar_class_bottom_3_X , skillbar_global_top_1_X , skillbar_global_top_2_X , skillbar_global_top_3_X , skillbar_global_bottom_1_X , skillbar_global_bottom_2_X , skillbar_global_bottom_3_X , skillbar_active_skill_X , skillbar_automove_X 
	

	