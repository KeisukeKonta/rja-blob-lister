RJARC=".rjarc"

account=""
container=""
token=""

extract(){
  grep $1 $RJARC | awk -F : '{print $2}'
}

usage(){
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h            Display help
  -a [VALUE]    Specify the account name
  -c [VALUE]    Specify the container name
  -t [VALUE]    Specify the SAS token
EOM
  exit 2
}

while getopts :a:c:t:h option; do
  case $option in
    a)
      account=$OPTARG;;
    c)
      container=$OPTARG;;
    t)
      token=$OPTARG;;
    '-h'|'--help'|* )
      usage;;
  esac
done

if ([ -e $account ] || [ -e $container ] || [ -e $token ]) && [ ! -e $RJARC ];then
  echo "Specify parameters as command options or write them in $RJARC file."
  exit 1
else
  if [ -e $account ]; then
    account=`extract account`
    if [ -e $account ]; then
      echo "'account' was not found in $RJARC."
      exit 1
    fi
  fi
  if [ -e $container ]; then
    container=`extract container`
    if [ -e $container ]; then
      echo "'container' was not found in $RJARC."
      exit 1
    fi
  fi
  if [ -e $token ]; then
    token=`extract token`
    if [ -e $token ]; then
      echo "'token' was not found in $RJARC."
      exit 1
    fi
  fi
fi

echo "Collecting data from https://${account}.blob.core.windows.net/${container} ..."

XML=""
marker=""
URI="https://${account}.blob.core.windows.net/${container}?restype=container&comp=list${token}"

while :
do
  xml=`curl -sS "${URI}&marker=${marker}"`
  XML=$XML$xml
  A=`echo $xml | grep '<NextMarker>'`
  if [ "$A" ]; then
    marker=`echo $xml | sed -r 's|.*<NextMarker>(.*)</NextMarker>.*|\1|'`
  else
    break
  fi
done

echo "Currently, playback logs are available on following dates:"

LIST=(`echo $XML | grep -o -E "(\d{4})-(\d{2})-(\d{2})-(\d{1,2})_minimum_AI.csv" | tr -d "_minimum_AI.csv"`)

date=(${LIST[0]//-/ })
Y=0
M=0
D=$((10#${date[2]}))
H=()
last=0

for ((i=0; i<${#LIST[@]}; i++)); do
  date=(${LIST[$i]//-/ })
  yyyy=$((10#${date[0]}))
  mm=$((10#${date[1]}))
  dd=$((10#${date[2]}))
  h=$((10#${date[3]}))
  if [ $yyyy -gt $Y ]; then
    echo "${yyyy}年"
    Y=$yyyy
    M=0
  fi
  if [ $mm -gt $M ]; then
    last=0
    if [ ${#H[@]} -gt 0 ]; then
      echo -n "  │   ├── `printf %02d ${D}`日 ── "
      echo `printf "%s\n" "${H[@]}" | sort -n -u`
      ((last++))
      D=$dd
      H=()
    fi
    if [ $i -gt 0 ]; then
      echo -e "\e[1F\e[7C\b└"
    fi
    echo "  ├── `printf %02d ${mm}`月"
    M=$mm
    D=$dd
  fi
  if [ $dd -gt $D ]; then
    echo -n "  │   ├── `printf %02d ${D}`日 ── "
    echo `printf "%s\n" "${H[@]}" | sort -n -u`
    ((last++))
    D=$dd
    H=()
  fi
  H+=($(printf "%02d" ${h}))
done
echo -n "  │   └── `printf %02d ${D}`日 ── "
echo `printf "%s\n" "${H[@]}" | sort -n -u`
echo -e "\e[$(($last+1))F\e[3C\b└"
for ((i=0; i<$last; i++)); do
  echo -e "\e[3C\b "
done
