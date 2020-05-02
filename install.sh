#!/bin/bash
clear

echo -e "\e[92m** Installation started **\e[0m"

echo -e "\e[93mMaking sure the Pi is updated...\e[0m"
sudo apt-get update -y
sudo apt-get upgrade -y

echo -e "\e[93mInstalling Apache Web Server...\e[0m"
sudo apt-get install apache2 -y

echo -e "\e[93mInstalling PHP...\e[0m"
sudo apt-get install php -y

echo -e "\e[93mInstalling php-sqlite...\e[0m"
sudo apt-get install php-sqlite3 -y

echo -e "\e[93mCreating and initializing database...\e[0m"
cd ~/pi-score-counter
rm -f pi-score-counter.db
touch pi-score-counter.db
sudo python3 ~/pi-score-counter/initialize_db.py
sudo python3 ~/pi-score-counter/migrate_scores_into_games.py

echo -e "\e[93mSeeding players...\e[0m"
sudo python3 ~/pi-score-counter/seed_players.py

echo -e "\e[93mInstalling PHP API...\e[0m"
sudo rm -rf /var/www/html/api
sudo mkdir /var/www/html/api
sudo cp ~/pi-score-counter/api/* /var/www/html/api

echo -e "\e[93mCreating shortcut on desktop\e[0m"
cp -f ~/pi-score-counter/game/start.sh /home/pi/Desktop

echo -e "\e[101mYOU MUST REBOOT YOUR RASPBERRY PI NOW!\e[0m"

echo -e "\e[92m** Installation finished! **\e[0m"
