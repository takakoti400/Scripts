#debug=false
WiiUIP=${1}
SubDir=${2}

print () {
	printf "${1}" | fold -s -w $(tput cols)
}

#TitleIDCheck () {
#}

#DirMaker () {
#  case ${1} in
#    "MK8")
#    mkdir 
#  esac
#}

#CheckOnline () {
#  # https://superuser.com/questions/272265/getting-curl-to-output-http-status-code
#  return $(())
#}

uploader () {
  #Options=( )
  clear
  print "Please Select Install Destination to"
  if [ "${SubDir}" = '' ]; then
    select VAR in "Auto" "Internal" "External" exit
	  	#doからdoneまでループ処理
	  	do
        case ${VAR} in
          "Auto")
            SubDir='storage_mlc'; break;;
          "Internal")
            SubDir='storage_mlc'; break;;
          "External")
            SubDir='storage_usb'; break;;
          "exit")
            exit;;
        esac
	  	done
  else
    case ${SubDir} in
      *'usb'*|'external')
        SubDir='storage_usb'; break;;
      *'mlc'*|"internal")
        SubDir='storage_mlc'; break;;
    esac
  fi;
  clear
  IFS=$'\n'; for i in `find ${PWD} -type f`;do
    fn=${i##*/}
    i=${i#.\/}
    filePath="ftp://${WiiUIP}:21/${SubDir}/usr/title${i}"
    EfilePath="ftp://${WiiUIP}:21/${SubDir}/usr/title${i/00050000/0005000e}"
    if [[ ${fn} != "${fn%.*}.sh" && ${fn} != ".DS_Store" && ${fn} != "._${fn}" ]]; then
      ftp_code=$(curl -s -o /dev/null -w "%{http_code}" ${filePath})
      # upload to update folder
      if [[ "${ftp_code}" == "226" || "${ftp_code}" == "150" ]]; then
        print "\nuploading file... | (${ftp_code})\n ${i}\n -> ${filePath}"
        curl -T ${i} ${filePath}
      else
        FailedFiles+=( "${i} (${ftp_code})" );
      fi
      #trys upload main file to update folder.
      Eftp_code=$(curl -s -o /dev/null -w "%{http_code}" ${filePath})
      if [[ "${Eftp_code}" == "226" || "${Eftp_code}" == "150" ]]; then
        print "\nuploading file... | (${Eftp_code})\n ${i}\n -> ${EfilePath}"
        curl -T ${i} ${EfilePath}
      else
        FailedFiles+=( "${EfilePath} (${Eftp_code})" );
      fi
    fi
  done;
    if [[ "${FailedFiles}" != "" ]]; then
      printf ${FailedFiles} " are failed."
      ${FailedFiles} > FailedFiles.txt
    fi
}
uploader