isboxer.Character.Name = "替补一-辛迪加";
isboxer.Character.ActualName = "替补一";
isboxer.Character.QualifiedName = "替补一-辛迪加";

function isboxer.Character_LoadBinds()
	if (isboxer.CharacterSet.Name=="替补飞机") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]替补一;[nomod:alt,mod:rshift,nomod:ctrl]替补二;[nomod:alt,nomod:shift,mod:lctrl]替补三\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]替补一;[nomod:alt,mod:rshift,nomod:ctrl]替补二;[nomod:alt,nomod:shift,mod:lctrl]替补三\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]替补一;[nomod:alt,mod:rshift,nomod:ctrl]替补二;[nomod:alt,nomod:shift,mod:lctrl]替补三\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]替补一;[nomod:alt,mod:rshift,nomod:ctrl]替补二;[nomod:alt,nomod:shift,mod:lctrl]替补三\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 替补二\n/invite 替补三\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("替补一-辛迪加");
		isboxer.AddMember("替补二-辛迪加");
		isboxer.AddMember("替补三-辛迪加");
		isboxer.SetMaster("替补一-辛迪加");
		return
	end
end
isboxer.Character.LoadBinds = isboxer.Character_LoadBinds;

isboxer.Output("Character '替补一-辛迪加' activated");
