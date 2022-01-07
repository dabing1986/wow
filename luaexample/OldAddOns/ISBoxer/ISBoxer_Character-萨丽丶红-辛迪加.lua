isboxer.Character.Name = "萨丽丶红-辛迪加";
isboxer.Character.ActualName = "萨丽丶红";
isboxer.Character.QualifiedName = "萨丽丶红-辛迪加";

function isboxer.Character_LoadBinds()
	if (isboxer.CharacterSet.Name=="猎牧法") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红铁;[nomod:alt,nomod:shift,mod:lctrl]红灿灿\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红铁;[nomod:alt,nomod:shift,mod:lctrl]红灿灿\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红铁;[nomod:alt,nomod:shift,mod:lctrl]红灿灿\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红铁;[nomod:alt,nomod:shift,mod:lctrl]红灿灿\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 红铁\n/invite 红灿灿\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("萨丽丶红-辛迪加");
		isboxer.AddMember("红铁-辛迪加");
		isboxer.AddMember("红灿灿-辛迪加");
		isboxer.SetMaster("萨丽丶红-辛迪加");
		return
	end
	if (isboxer.CharacterSet.Name=="猎人冲工程") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红工程库;[nomod:alt,nomod:shift,mod:lctrl]红药矿仓库\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红工程库;[nomod:alt,nomod:shift,mod:lctrl]红药矿仓库\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红工程库;[nomod:alt,nomod:shift,mod:lctrl]红药矿仓库\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]萨丽丶红;[nomod:alt,mod:rshift,nomod:ctrl]红工程库;[nomod:alt,nomod:shift,mod:lctrl]红药矿仓库\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 红工程库\n/invite 红药矿仓库\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("萨丽丶红-辛迪加");
		isboxer.AddMember("红工程库-辛迪加");
		isboxer.AddMember("红药矿仓库-辛迪加");
		isboxer.SetMaster("萨丽丶红-辛迪加");
		return
	end
end
isboxer.Character.LoadBinds = isboxer.Character_LoadBinds;

isboxer.Output("Character '萨丽丶红-辛迪加' activated");
