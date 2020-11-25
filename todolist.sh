#! /bin/bash
#####################################################################
#####################################################################
####### Created By @HadrienAka ####### Created By @HadrienAka #######
#####################################################################
#####################################################################
####
#### LEARN MORE ABOUT TODOLIST ON GITHUB.COM/HADRIENAKA/todolist
#### If you like todolist, please feel free to leave a star!
####
#### SUMMARY :
####
#### 1. $ todolist
#### 2. CTRL + X
#### 3. ARGUMENTS
#### 4. DISPLAY THE TODOLIST
#### 5. KEYBOARD INPUT
####
###################### 1 - IF NO ARGUMENTS : CHECK FOR UPDATE, TYPE -H TO GET HELP
version=1.0
todoname=$1

empty () {
upversion=$(curl -s -L https://hadrienaka.fr/update2.txt ) 
printf "\e[0;92m✓ \e[0m\e[1;77mToDoList CLI\e[0;96m [v%s]\e[0m" "$version"
if [[ $version == "$upversion" ]]; then 
  printf "\n\e[0;92m✓ \e[0m\e[1;77mtodolist is up to date\e[0m"
else
  printf "\n\e[0;91mx \e[0m\e[1;77mThere is a new update, please type :\e[0;96m todolist -u\e[0m"
fi
printf "\n\e[0;92m? \e[0m\e[1;77mTo get help type :\e[0;96m todolist -h\e[0m"
echo
exit 0
}
[ -z "$1" ] && empty
if [ -d ~/.todo ]; then
  cd ~/.todo || exit
else
  mkdir ~/.todo || exit
fi

###################### 2 - CTRL + X : CLEAR, ECHO "GOOD BAY"

trap ctrl_c INT
function ctrl_c() {
  tput cnorm
  tput rc
  tput ed
  printf "\r\e[0;91mx \e[0m\e[1;77mGood Bye!                                                               \e[0m"
  echo
  exit
}

###################### 3 - ARGUMENTS

while test $# -gt 0; do
  case "$1" in

    -h|--help)
      printf "\n"
      printf "\e[0;92m✓ \e[0m\e[1;77mToDoList CLI\e[0;96m [By @HadrienAka]\e[0m"
      printf "\n"
      printf "\n\e[1;77mArguments :\e[0m"
      printf "\n\e[1;92m-h, --help            \e[0m\e[1;77mShow brief help\e[0m"
      printf "\n\e[1;92m-n, --new             \e[0m\e[1;77mNew ToDoList\e[0m"
      printf "\n\e[1;92m-r, --remove          \e[0m\e[1;77mDelete a ToDoList\e[0m"
      printf "\n\e[1;92m-u, --update          \e[0m\e[1;77mUpdate Todo\e[0m"
      printf "\n"
      printf "\n\e[1;77mShortcuts  :\e[1;96 [When you are on a ToDoList]m\e[0m"
      printf "\n\e[1;92mn                     \e[0m\e[1;77mAdd a new ToDo\e[0m"
      printf "\n\e[1;92mr                     \e[0m\e[1;77mRemove a ToDoe[0m"
      printf "\n\e[1;92mi                     \e[0m\e[1;77mShow as important\e[0m"
      printf "\n\e[1;92mc                     \e[0m\e[1;77mShow as completed\e[0m"
      printf "\n\e[1;92me                     \e[0m\e[1;77mExit\e[0m"
      printf "\n"
      printf "\n\e[0;92m? \e[0m\e[1;77mMore information\e[0;96m on the github page.\e[0m"
      printf "\n\e[0;92m? \e[0m\e[1;77m[https://github.com/hadrienaka/todolist]\e[0m"
      echo
      exit 0
      ;;
      
    -n|--new)
      shift
      touch ~/.todo/"$1"
      printf "\n\e[0;92m✓ \e[0m\e[1;77m\"%s\" added \e[0m" "$1"
      printf "\n\e[0;92m✓ \e[0m\e[1;77mType $ todolist %s \e[0m" "$1"
      printf "\n"
      echo
      exit
      shift
      ;;

      -r|--remove)
      shift
      rm ~/.todo/"$1"
      printf "\n\e[0;92m✓ \e[0m\e[1;77m\"%s\" removed \e[0m" "$1"
      printf "\n"
      echo
      exit
      shift
      ;;

    -u|--update)
      shift
      upversion=$(curl -s -L https://hadrienaka.fr/update2.txt ) 
      if [[ $version == "$upversion" ]]; then 
        printf "\e[0;92m✓ \e[0m\e[1;77mtodolist is already up to date\e[0m"
        echo
        exit
      else
        git clone https://github.com/hadrienaka/todolist &>/dev/null
        cd todo || exit
        chmod +x todo.sh
        sudo rm /usr/local/bin/todo
        sudo mv todo.sh /usr/local/bin/todo
        cd .. || exit
        rm -rf todo
        printf "\e[0;92m✓ \e[0m\e[1;77mSuccessfully Updated\e[0m"
        echo
        exit
      fi
      shift
      ;;
    
    *)
      break
      ;;
  esac
done

if [ -f "$todoname" ]; then
  :
else 
  printf "\r\e[0;91mx \e[0m\e[1;77m%s Not Found!                                                               \e[0m" "$todoname"
  echo
  exit
fi
tput civis

###################### 4 - DISPLAY THE TODOLIST ($todoname)

selected=1
display() {
  printf "\r\e[0;92m✓ \e[0m\e[1;77m%s                                \e[0m" "$todoname"
  i=1;
  testtodo=$(cat "$todoname")
  for todoitem in $testtodo
  do

    todoitem=$( sed -n "$i"p "$todoname" )
    if [ -z "$todoitem" ]; then
    break
    else
    :
    fi

    if [[ $selected == "$i" ]] && [[ $todoitem == *"#"* ]]; then
      printf "\n\r\e[1;96m>\e[1;90m %s                             \e[0m" "$todoitem"
    elif [[ $selected == "$i" ]] && [[ $todoitem == *"!"* ]]; then
      printf "\n\r\e[1;96m>\e[1;91m %s                             \e[0m" "$todoitem"
    elif [[ $todoitem == *"#"* ]]; then
      printf "\n\r\e[1;90m  %s                             \e[0m" "$todoitem"
    elif [[ $todoitem == *"!"* ]]; then
      printf "\n\r\e[1;91m  %s                             \e[0m" "$todoitem"
    elif [[ $selected == "$i" ]]; then
      printf "\n\r\e[1;96m> \e[0m%s                             \e[0m" "$todoitem"
    else
      printf "\n\r  %s                                   " "$todoitem"
    fi

  i=$((i + 1));
  done

  tempi=$i
  if [[ $selected == "$tempi" ]] || [[ $selected == 0 ]]; then 
    selected=1
    tput sc
    for (( testi=1; testi<i; ++testi)); do
      tput cuu1
      tput sc
    done
  else
    tput sc
    for (( testi=1; testi<i; ++testi)); do
      tput cuu1
      tput sc
    done
  fi

}

###################### 5 - KEYBOARD INPUT

pressenter () {
  printf "\r                                                                            "
  for (( clearenter=1; clearenter<i; ++clearenter)); do
  printf "\n\r                                                                             "
  done
  tput rc
  tput sc
  tput ed
  return
}

importance () {
    if [[ $addex == *"!"* ]]; then
    newaddex=$( echo "$addex" | sed 's/! //' )
    sed "s/^$addex/$newaddex/g" "$todoname" > temp.txt
    mv temp.txt "$todoname"
    else
    sed "/$addex/ s/^/! /" "$todoname" > temp.txt
    mv temp.txt "$todoname"
    fi
}

completer () {
    if [[ $addex == *"#"* ]]; then
    newaddex=$( echo "$addex" | sed 's/# //' )
    sed "s/^$addex/$newaddex/g" "$todoname" > temp.txt
    mv temp.txt "$todoname"
    else
    sed "/$addex/ s/^/# /" "$todoname" > temp.txt
    mv temp.txt "$todoname"
    fi
}

keyboardinput () {
while true
  do

  read -r -sn1 t
  if [[ $t == A ]]; then #GO UP
    selected=$((selected - 1))
    display

  elif [[ $t == B ]]; then #GO DOWN
    selected=$((selected + 1))
    display

  elif [[ $t == "n" ]]; then #ADD A TODO
  pressenter
  read -r -p $'\r\e[0;92m+\e[0m\e[1;77m Todo\'s Name : \e[0;96m' newtodo
  if [ -z "$newtodo" ]; then
      tput rc
  else
  tput rc
    echo "$newtodo" >> "$todoname"
    selected=1
  fi

  elif [[ $t == "r" ]]; then #REMOVE A TODO
  pressenter
  sed "$selected"d "$todoname" > temp.txt
  mv temp.txt "$todoname"
    selected=$(( $selected -1 ))

  elif [[ $t == "i" ]]; then #ADD/REMOVE IMPORTANCE
  pressenter
  addex=$( sed -n "$selected"p "$todoname" )
  importance

  elif [[ $t == "c" ]]; then #ADD/REMOVE COMPLETED
  pressenter
  addex=$( sed -n "$selected"p "$todoname" )
  completer

  elif [[ $t == "e" ]]; then #EXIT
  tput cnorm
  tput rc
  tput ed
  printf "\r\e[0;91mx \e[0m\e[1;77mGood Bye!                                                               \e[0m"
  echo
  exit
  fi

display
done
}

# DISPLAY AND CAPTURE KEYBOARD INPUT
display
keyboardinput
