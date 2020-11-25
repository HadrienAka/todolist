#! /bin/bash
chmod +x todolist.sh
printf "\n\e[0;92m+ \e[0m\e[1;77mYou need to enter your sudo password to add todolist to the Path :\e[0;96m\e[0m"
sudo mv todolist.sh /usr/local/bin/todolist
printf "\n"
printf "\n\e[0;92m✓ \e[0m\e[1;77mWell done! \"todolist\" is now ready.\e[0m"
printf "\n"
printf "\n\e[0;92m+ \e[0m\e[1;77mNow you can type \"$ todolist -n 'NameOfTheToDoList'\" to start using it! \e[0;96m\e[0m"
printf "\n"
printf "\n\e[0;92m? \e[0m\e[1;77m\e[0;96m[If you need help, check https://github.com/hadrienaka/todolist]\e[0m"
printf "\n"
cd ../
rm -rf todolist

