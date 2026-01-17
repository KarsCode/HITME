#!/usr/bin/env bash

# Colors
RED="\033[31m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RESET="\033[0m"

clear

get_time_of_day() {
  local hour period

  hour=$(date +%I)   # 01–12
  period=$(date +%p) # AM / PM

  hour=$((10#$hour))

  if [[ "$period" == "AM" && $hour -ge 5 ]]; then
    echo "morning"
  elif [[ "$period" == "PM" && $hour -lt 5 ]]; then
    echo "afternoon"
  else
    echo "morning"
  fi
}

gaurav_header() {
  time_of_day=$(get_time_of_day)

  echo -e "${CYAN}"

  case "$time_of_day" in
    evening)
cat <<'EOF'
 _____                _                 _____                             
|  ___|              (_)               |  __ \                            
| |____   _____ _ __  _ _ __   __ _    | |  \/ __ _ _   _ _ __ __ ___   __
|  __\ \ / / _ \ '_ \| | '_ \ / _` |   | | __ / _` | | | | '__/ _` \ \ / /
| |___\ V /  __/ | | | | | | | (_| |_  | |_\ \ (_| | |_| | | | (_| |\ V / 
\____/ \_/ \___|_| |_|_|_| |_|\__, ( )  \____/\__,_|\__,_|_|  \__,_| \_/  
                               __/ |/                                     
                              |___/                                       
EOF
      ;;
    afternoon)
cat <<'EOF'
  ___   __ _                                        _____                             
 / _ \ / _| |                                      |  __ \                            
/ /_\ \ |_| |_ ___ _ __ _ __   ___   ___  _ __     | |  \/ __ _ _   _ _ __ __ ___   __
|  _  |  _| __/ _ \ '__| '_ \ / _ \ / _ \| '_ \    | | __ / _` | | | | '__/ _` \ \ / /
| | | | | | ||  __/ |  | | | | (_) | (_) | | | |_  | |_\ \ (_| | |_| | | | (_| |\ V / 
\_| |_/_|  \__\___|_|  |_| |_|\___/ \___/|_| |_( )  \____/\__,_|\__,_|_|  \__,_| \_/  
                                               |/                                     
EOF
      ;;
    morning)
cat <<'EOF'
___  ___                 _                 _____                             
|  \/  |                (_)               |  __ \                            
| .  . | ___  _ __ _ __  _ _ __   __ _    | |  \/ __ _ _   _ _ __ __ ___   __
| |\/| |/ _ \| '__| '_ \| | '_ \ / _` |   | | __ / _` | | | | '__/ _` \ \ / /
| |  | | (_) | |  | | | | | | | | (_| |_  | |_\ \ (_| | |_| | | | (_| |\ V / 
\_|  |_/\___/|_|  |_| |_|_|_| |_|\__, ( )  \____/\__,_|\__,_|_|  \__,_| \_/  
                                  __/ |/                                     
                                 |___/                                       
EOF
      ;;
  esac

  echo -e "${RESET}"
  echo
}

celebration() {
frames=(
"✨ 🎉 ✨"
"🎉 ✨ 🎉"
"✨ 🎉 ✨"
)

for i in {1..6}; do
  clear
  echo -e "${GREEN}"
  echo "   HAVE A BLESSED DAY!"
  echo "   ${frames[$((i % 3))]}"
  echo -e "${RESET}"
  sleep 0.3
done
}

fetch_joke() {
  curl -s -H "Accept: text/plain" https://icanhazdadjoke.com/
}

fetch_fact() {
  curl -s https://uselessfacts.jsph.pl/api/v2/facts/random \
  | sed -n 's/.*"text":"\([^"]*\)".*/\1/p'
}

gaurav_header
echo -e "${CYAN}What do you want to hear today?${RESET}"
echo "1) Dad Joke"
echo "2) Random Fact"
read -rp "> " choice

while true; do
  clear
  gaurav_header

  if [[ "$choice" == "1" ]]; then
    content=$(fetch_joke)
    echo -e "${YELLOW}🤡 Dad Joke:${RESET}"
  else
    content=$(fetch_fact)
    echo -e "${YELLOW}🧠 Random Fact:${RESET}"
  fi

  echo
  echo -e "${CYAN}$content${RESET}"
  echo
  echo "👍 Like it? (y)   🔄 Reroll? (r)   ❌ Quit? (q)"
  read -rp "> " action

  case "$action" in
    y|Y)
      celebration
      exit 0
      ;;
    r|R)
      continue
      ;;
    q|Q)
      echo "👋 Later, Gaurav!"
      exit 0
      ;;
  esac
done
