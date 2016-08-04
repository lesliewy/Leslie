; Ctrl-G (Total Commander: splitter menu)
~^g::
	if not WinActive( "ahk_class TTOTAL_CMD" )
		Return

	WinGet sf_aControls, ControlList
	Loop Parse, sf_aControls, `n
	{
		StringLeft sf_sTemp, A_LoopField, 6
		if (sf_sTemp = "TPanel")
		{
			ControlGetPos Cx,Cy,Cw,Ch, %A_LoopField%
			if (Cw < 16)
			{
				ControlClick %A_LoopField%, A,,RIGHT
				Break
			}
		}
	}
	Return


