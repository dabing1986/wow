isboxer.Character.Name = "红布皮-辛迪加";
isboxer.Character.ActualName = "红布皮";
isboxer.Character.QualifiedName = "红布皮-辛迪加";

function isboxer.Character_LoadBinds()
	if (isboxer.CharacterSet.Name=="五人队") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶黑铁;[nomod:alt,mod:rshift,nomod:ctrl]塞卡丽;[nomod:alt,nomod:shift,mod:lctrl]肖恩丶狂暴者;[mod:lalt,nomod:shift,nomod:ctrl]红布皮;[nomod:alt,mod:lshift,mod:lctrl]红工程库\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶黑铁;[nomod:alt,mod:rshift,nomod:ctrl]塞卡丽;[nomod:alt,nomod:shift,mod:lctrl]肖恩丶狂暴者;[mod:lalt,nomod:shift,nomod:ctrl]红布皮;[nomod:alt,mod:lshift,mod:lctrl]红工程库\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶黑铁;[nomod:alt,mod:rshift,nomod:ctrl]塞卡丽;[nomod:alt,nomod:shift,mod:lctrl]肖恩丶狂暴者;[mod:lalt,nomod:shift,nomod:ctrl]红布皮;[nomod:alt,mod:lshift,mod:lctrl]红工程库\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶黑铁;[nomod:alt,mod:rshift,nomod:ctrl]塞卡丽;[nomod:alt,nomod:shift,mod:lctrl]肖恩丶狂暴者;[mod:lalt,nomod:shift,nomod:ctrl]红布皮;[nomod:alt,mod:lshift,mod:lctrl]红工程库\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 萨丽丶黑铁\n/invite 塞卡丽\n/invite 肖恩丶狂暴者\n/invite 红工程库\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("萨丽丶黑铁-辛迪加");
		isboxer.AddMember("塞卡丽-辛迪加");
		isboxer.AddMember("肖恩丶狂暴者-辛迪加");
		isboxer.AddMember("红布皮-辛迪加");
		isboxer.AddMember("红工程库-辛迪加");
		isboxer.SetMaster("萨丽丶黑铁-辛迪加");
		return
	end
end
isboxer.Character.LoadBinds = isboxer.Character_LoadBinds;

isboxer.Output("Character '红布皮-辛迪加' activated");
