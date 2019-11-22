#!/bin/bash
# shellcheck disable=SC2059

### Imports.
source ./colors.sh
source ./constants.sh
source ./progress-bar.sh # Library by edouard-lopez: https://github.com/edouard-lopez/progress-bar.sh

### Functions.
function rand_decimal() {
    perl -e 'printf("%.2f\n", rand() / $ARGV[0])' -- "$1"
}

function show_line() {
    for ((i = 0; i < ${#1}; i++)); do
        printf "$3${1:$i:1}"
        sleep "$2"
    done
    printf "${Color_Off}"
}

function type_line() {
    for ((i = 0; i < ${#1}; i++)); do
        printf "${1:$i:1}"
        sleep "$(rand_decimal "$2")"
    done
}

function newlines() {
    for (( i = 0; i < $1; i++)) do
        printf "\n"
        sleep 0.3
    done
}

function speak() {
    afplay /System/Library/Sounds/Purr.aiff &
    say -v $Voice "$1" &
}

function print_header() {
    printf "${BIBlue}\n\n$Software_Name_Ascii\n\n"
    printf "$Slogan\n\n"
    printf "$Divider\n\n\n${Color_Off}"
}

function ada_speak() {
    speak "$2"
    show_line "Ada: $1" $Show_Sec "$BBlue"
}

function show_prompt() {
    newlines 2
    printf "$Prompt"
}

# == Intro and Authentication Screen ==
### Intro.
# Credit to RICHERlandTV for this sound: https://freesound.org/people/RICHERlandTV/sounds/351920/
afplay ./startup.mp3 &
newlines 2
show_line "$Software_Name_Ascii" 0.002 "${BIBlue}"
newlines 2
show_line "$Slogan" 0.08 "${BIBlue}"
newlines 3
speak "Welcome to ${Software_Name_Spoken}... My name is Ayda. I personally ensure that all of our citizens are well."
wait

speak "Before we proceed. Please enter your credentials."
show_line "Welcome to ${Software_Name}." $Show_Sec
newlines 1
show_line "Please enter your credentials." $Show_Sec
newlines 2

### Enter email.
printf "Enter secure email: "
wait
sleep 2
type_line $Email 7
sleep 0.5
afplay /System/Library/Sounds/Tink.aiff &
printf "${BIGreen} ✓${Color_Off}"
newlines 1

### Enter password.
printf "Enter password: "
sleep 1
type_line $Password 6
sleep 0.5
afplay /System/Library/Sounds/Tink.aiff &
printf "${BIGreen} ✓${Color_Off}"
newlines 2

### Authentication loading.
Authentication_End=$((SECONDS + 3))
while [ $SECONDS -lt $Authentication_End ]; do
    for s in / - \\ \|; do
        printf "\rAuthenticating...                        $s"
        sleep .25
    done
done
# Successful authentication.
osascript -e 'display notification "Hello, Miles." with title "Authentication successful." sound name "Submarine"'
speak "Good morning $First_Name."

# == Terminal Screen ==
clear
print_header

printf "${UWhite}Logged in as\n${Color_Off}"
printf "$Name\n"
printf "$Department\n"
printf "$Region\n\n\n"
wait

ada_speak "What would you like to do today?" "What would you like to do today?"

show_prompt
wait
sleep 2
type_line "Show me the psychological status of all District 6 residents." 8
sleep 1
printf "\n\n"

ada_speak "Are you sure you want to print the status of all 8,540,095 residents?" "Are you sure you want to print the status of all 8,540,095 residents?"

show_prompt
wait
type_line "No, randomly select 150 residents." 8
sleep 1
printf "\n\n"

ada_speak "One moment, Miles." "One moment Miles."
newlines 2

Print_Residents_End=$((SECONDS + 2))
while [ $SECONDS -lt $Print_Residents_End ]; do
    for s in / - \\ \|; do
        printf "\r$s"
        sleep .25
    done
done
printf "\r"

# Show list of residents with statuses.
for Resident in "${Resident_List[@]}"; do
    if [[ $(( RANDOM % 6 )) == 0 ]] || [ $((cnt + 1)) == 129 ]; then
        Status="DEFICIENT"
        Color=${BIRed}
    elif [[ $(( RANDOM % 6 )) == 0 ]] || [ $((cnt + 1)) == 129 ]; then
        Status="SATISFACTORY"
        Color=${BIYellow}
    else
        Status="SUPERIOR"
        Color=${BIGreen}
    fi

    printf "${UWhite}(%d)${Color_Off}   %.30s	Psychological Status: ${Color}%s${Color_Off}" \ "$(( ++cnt ))" "$Resident...................." "$Status"
    afplay /System/Library/Sounds/Pop.aiff &
    sleep 0.03
    printf "\n"
done
afplay /System/Library/Sounds/Ping.aiff &

show_prompt
sleep 3.5
type_line "Show me more about resident #129." 8
sleep 1
printf "\n\n"

ada_speak "Ok, Miles." "Ok Miles."
newlines 2

Print_Diagnostic_End=$((SECONDS + 4))
while [ $SECONDS -lt $Print_Diagnostic_End ]; do
    for s in / - \\ \|; do
        printf "\r$s"
        sleep .25
    done
done
printf "\r"

show_line "Resident #129" $Show_Sec "${UWhite}"
newlines 2

./imgcat.sh ./resident_129.jpg
afplay /System/Library/Sounds/Pop.aiff &

newlines 1
printf "Mario L Anderson"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Grow Facilities, Gardens"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "District 6"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "${BIWhite}Psychological Conditions:${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "• Depression"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "• Generalized Anxiety"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "• ADHD"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Productivity Level: ${BIRed}40 percent ▼${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Workplace Incidents: ${BIRed}44 ▲${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Social Score: ${BIRed}7C ▼${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 2

show_line "Spouse" $Show_Sec "${UWhite}"
newlines 2

./imgcat.sh ./resident_129_spouse.jpg
afplay /System/Library/Sounds/Pop.aiff &

newlines 1
printf "Melissa S Anderson"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Grow Facilities, Fish Tanks"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "District 6"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Born April 23rd, 2044"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "${BIWhite}Psychological Conditions:${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "• Unknown"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Productivity Level: ${BIYellow}78 percent ▼${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Workplace Incidents: ${BIWhite}3 ►${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
newlines 1
printf "Social Score: ${BIYellow}3A ▼${Color_Off}"
afplay /System/Library/Sounds/Pop.aiff &
printf "\n\n"

sleep 2
ada_speak "Mario Anderson has been determined deficient. Sentencing includes termination of employment and transfer to a rehabilitation facility." "Mario Anderson has been determined deficient. Sentencing includes termination of employment and transfer to a rehabilitation facility."

show_prompt
wait
sleep 1
type_line "Any children?" 7
sleep 0.5
newlines 2

./imgcat.sh ./resident_129_children.png
sleep 0.5
printf "\n\n"
ada_speak "Yes, both children have been extricated." "Yes, both children have been extricated."

show_prompt
wait
sleep 1
type_line "Return custody to the mother, she's in good standing. But monitor the children." 8
sleep 1
printf "\n\n"

ada_speak "Yes, Miles." "Yes Miles."
sleep 0.5
printf "\n\n"

Adjust_Decision_Protocol_End=$((SECONDS + 2))
while [ $SECONDS -lt $Adjust_Decision_Protocol_End ]; do
    for s in / - \\ \|; do
        printf "\rAdjusting decision protocol... $s"
        sleep .25
    done
done
printf "\r                                            "

printf "\r"
ada_speak "Thank you for reviewing my judgement in this case. Would you like to make any other adjustments?" "Thank you for reviewing my judgement in this case. Would you like to make any other adjustments?"

show_prompt
wait
type_line "No, Ada. That'll be all for now. Exit." 7
sleep 1
printf "\n\n"

# Sound by jobro: https://freesound.org/people/jobro/sounds/244603/
afplay ./shutdown.mp3 &
ada_speak "Goodbye."
newlines 10

clear
osascript -e 'display notification "Be well." with title "Logout successful." sound name "Blow"'

sleep 15
exec ./emotional-diagnostic.sh
