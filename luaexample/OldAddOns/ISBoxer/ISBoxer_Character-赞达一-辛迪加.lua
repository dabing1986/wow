isboxer.Character.Name = "赞达一-辛迪加";
isboxer.Character.ActualName = "赞达一";
isboxer.Character.QualifiedName = "赞达一-辛迪加";

function isboxer.Character_LoadBinds()
	if (isboxer.CharacterSet.Name=="赞达拉飞机") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]赞达一;[nomod:alt,mod:rshift,nomod:ctrl]赞达二;[nomod:alt,nomod:shift,mod:lctrl]赞达三\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]赞达一;[nomod:alt,mod:rshift,nomod:ctrl]赞达二;[nomod:alt,nomod:shift,mod:lctrl]赞达三\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]赞达一;[nomod:alt,mod:rshift,nomod:ctrl]赞达二;[nomod:alt,nomod:shift,mod:lctrl]赞达三\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]赞达一;[nomod:alt,mod:rshift,nomod:ctrl]赞达二;[nomod:alt,nomod:shift,mod:lctrl]赞达三\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 赞达二\n/invite 赞达三\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("赞达一-辛迪加");
		isboxer.AddMember("赞达二-辛迪加");
		isboxer.AddMember("赞达三-辛迪加");
		isboxer.SetMaster("赞达一-辛迪加");
		return
	end
end
isboxer.Character.LoadBinds = isboxer.Character_LoadBinds;

isboxer.Output("Character '赞达一-辛迪加' activated");
