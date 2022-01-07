isboxer.Character.Name = "黑上一-辛迪加";
isboxer.Character.ActualName = "黑上一";
isboxer.Character.QualifiedName = "黑上一-辛迪加";

function isboxer.Character_LoadBinds()
	if (isboxer.CharacterSet.Name=="黑上飞机") then
		isboxer.SetMacro("FTLAssist","BACKSPACE","/assist [nomod:alt,mod:lshift,nomod:ctrl]黑上一;[nomod:alt,mod:rshift,nomod:ctrl]黑上二;[nomod:alt,nomod:shift,mod:lctrl]黑上三\n",1,1,1,1);

		isboxer.SetMacro("FTLFocus","NONE","/focus [nomod:alt,mod:lshift,nomod:ctrl]黑上一;[nomod:alt,mod:rshift,nomod:ctrl]黑上二;[nomod:alt,nomod:shift,mod:lctrl]黑上三\n",1,1,1,1);

		isboxer.SetMacro("FTLFollow","F11","/jamba-follow snw\n/follow [nomod:alt,mod:lshift,nomod:ctrl]黑上一;[nomod:alt,mod:rshift,nomod:ctrl]黑上二;[nomod:alt,nomod:shift,mod:lctrl]黑上三\n",1,1,1,1);

		isboxer.SetMacro("FTLTarget","]","/targetexact [nomod:alt,mod:lshift,nomod:ctrl]黑上一;[nomod:alt,mod:rshift,nomod:ctrl]黑上二;[nomod:alt,nomod:shift,mod:lctrl]黑上三\n",1,1,1,1);

		isboxer.SetMacro("InviteTeam","ALT-CTRL-SHIFT-I","/invite 黑上二\n/invite 黑上三\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOn","ALT-SHIFT-N","/console autointeract 1\n",nil,nil,nil,1);

		isboxer.SetMacro("CTMOff","ALT-CTRL-N","/console autointeract 0\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaMaster","CTRL-SHIFT-F12","/jamba-team iammaster all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOn","ALT-SHIFT-F12","/jamba-follow strobeonme all\n",nil,nil,nil,1);

		isboxer.SetMacro("JambaStrobeOff","ALT-CTRL-SHIFT-F12","/jamba-follow strobeoff all\n",nil,nil,nil,1);

		isboxer.ManageJambaTeam=True
		isboxer.ClearMembers();
		isboxer.AddMember("黑上一-辛迪加");
		isboxer.AddMember("黑上二-辛迪加");
		isboxer.AddMember("黑上三-辛迪加");
		isboxer.SetMaster("黑上一-辛迪加");
		return
	end
end
isboxer.Character.LoadBinds = isboxer.Character_LoadBinds;

isboxer.Output("Character '黑上一-辛迪加' activated");
