# functions (steals from RiiConectPacther script...)#
#Allows you to Automate Replaces wineskins icon.

# This Script Can...
#1. /*AppName*.icns -> *AppName*.app/Contents/Resources/Wineskin.icns
#2.  *AppName*.app/Contents/Resources/Wineskin.icns -> /*AppName*.icns

#tip im bad coder sorry for spagetthi / inefficient / Hard to reading codes...

print () {
	printf "${1}" | fold -s -w $(tput cols)
}

InFile=''
OutFile=''
mode=0
while true; do
	clear
	print "Select the number\n"
	if [ ${mode} = 1 ]
		then print "Extracts icns to Folder.\n"
		else print "Patch icns to Applications.\n"
	fi
	print "[ ] Remove Copied item.\n"
	#print "[S] Copy as SuperUser.\n"
	print "Z to Continue>"
	read -n 1 -r choice
			clear
		case ${choice} in
			[Ss])
				mode=$((1 - ${mode}));;
			[Zz])
				while true; do
					title "Input Directory" # 
					print "Please Enter Number or Initial you want. >"
					read -r choice
						case ${choice} in
							*/) OutputDir=${choice}; break;;
							*)  OutputDir=${choice}\/; break;;
						esac
						InputDir=${choice}
					while true; do
						title "Output Directory" # 
						print "Please Enter Number or Initial you want. >"
						read -r choice
							case ${choice} in
								*/) OutputDir=${choice}; break;;
								*)  OutputDir=${choice}\/; break;;
							esac
							OutputDir=${choice}
						break
						done
						break
					done
				case ${mode} in
					0) 
						InFile="/Contents/Resources/Wineskin.icns"
						cd ${InputDir}
						for x in *.icns; do
							cd ${OutputDir}
							for y in *.app; do
								if [ "${x%.*}" == ${y%.*} ]; then
									cp ${InputDir}"$x" ${OutputDir}$y${InFile}
									print "copied ${InputDir}"$x" to ${OutputDir}$y${InFile}"
								fi
							done
						done;;
					1) 
						cd ${InputDir}
						for x in *.app; do
							cp ${InputDir}${x}/Contents/Resources/*.icns ${OutputDir}${x%.*}.icns;
						done
				esac
				break;;
			[Ee]) exit
		esac
	done