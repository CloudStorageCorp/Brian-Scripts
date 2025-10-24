@echo off
setlocal enabledelayedexpansion

echo Starting to clear 'readonly' attribute from disks 0 through 26...

for /L %%D in (0,1,26) do (

	echo Processing disk %%D...

	set DP_SCRIPT=%temp%\diskpart_%%D.txt
	(
		echo select disk %%D
		echo attributes disk clear readonly
	) > "!DP_SCRIPT!"

	diskpart /s "!DP_SCRIPT!"

	del "!DP_SCRIPT!" >nul 2>&1

	echo -----------------------------------
	echo -----------------------------------

)

echo Done.
pause