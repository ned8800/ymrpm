#!/bin/bash


if [[ $1 == "-v" || $1 == "--verbose"  ]]; then
  verbose="-v"
fi

echo "${CYAN}Hello, this script will automatically download the latest version of Yandex Music .deb pachage existing on oficial website at the moment and convert it into an .rpm package. ${NC}"
echo "${CYAN}This new .rpm package will appear in location from which script was executed. ${NC}"

# Prepair environment
yandex_music_deb_file="yandex_music.deb"
download_dirname="$(pwd)"
rpmbuild_sources_dir="$HOME/rpmbuild/SOURCES"
rpmbuild_specs_dir="$HOME/rpmbuild/SPECS"

RED='\033[0;31m' # Red color
GREEN='\033[0;32m' # Green color
CYAN='\033[0;36m' #Cyan color
NC='\033[0m'     # Reset to normal colors

validate_sudo_session() {
    # Attempt authentication silently
    echo "$1" | sudo -S -k whoami >/dev/null 2>&1

    # Evaluate exit status
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}sudo password validated successfully. ${NC}"
    else
        echo -e "${RED}provided sudo password is not valid. Exiting. ${NC}"
        return 1
    fi
}


# Check for verbose flag to setup logging errors in console
err_stream="2>/dev/null"
if [ ! -z $verbose ]; then
  err_stream=""
fi

eval "mkdir $rpmbuild_sources_dir $err_stream"
eval "mkdir $rpmbuild_specs_dir $err_stream"

echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Begin downloading current version of yandex music .deb"
echo -ne "<------------------------------------------------------> ${NC}\n\n"
cd $download_dirname/

pwd
ls -latr

rm -rf ./location.txt
curl $verbose -X GET -L https://desktop.app.music.yandex.net/stable/download.json > ./location.txt 
grep linux ./location.txt | tail -1 | grep -E -o "\"https.*\"" | sed 's/\"//g' 

yandex_music_download_link="$(grep linux ./location.txt | tail -1 | grep -E -o "\"https.*\"" | sed 's/\"//g')"

echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Found download link: $yandex_music_download_link"
echo -ne "<------------------------------------------------------>${NC}\n\n"

rm -rf ./$yandex_music_deb_file $err_stream
curl -X GET -L -o ./$yandex_music_deb_file $yandex_music_download_link


pwd
ls -latr

# Prepair alien to generate install scripts
cd $rpmbuild_sources_dir

pwd
ls -latr

cp $download_dirname/$yandex_music_deb_file ./

echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Generating scripts using alien"
echo -ne "<------------------------------------------------------>${NC}\n\n"
echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "You must provide elevated (SUDO) privileges, so alien could correctly generate scripts, otherwise alien would skip some files resauling broken rpm package."
echo -ne "Provide your sudo password using stdin or console input below:${NC}\n"

# read password to local variable
read -p "[sudo] password for $USER: " -s SUDOPWD

echo -ne "${CYAN}\n<------------------------------------------------------>${NC}\n\n"

# sudo password is provided and valid check
validate_sudo_session "$SUDOPWD"
if [[ -z "$SUDOPWD" || $? -ne 0 ]]; then
    echo -e "${RED}sudo session expired or not available. Exiting. ${NC}"
    exit 1
fi



eval "echo $SUDOPWD | sudo -S rm -rf ./tempSource $err_stream"
eval "mkdir ./tempSource $err_stream"

cd tempSource/
eval "sudo -S alien -r -v --scripts --generate ../$yandex_music_deb_file $err_stream"

yandex_music_alien_build_dirname=$(ls ./)

echo -ne "${CYAN} $yandex_music_alien_build_dirname \n${NC}"
pwd
ls -latr

# Move install scripts to intended rpmbuild directory for building

cp -R ./$yandex_music_alien_build_dirname $rpmbuild_specs_dir
cd $rpmbuild_specs_dir


pwd
ls -latr

cd $yandex_music_alien_build_dirname
yandex_music_alien_build_specname=$(ls ./*.spec)

pwd
ls -latr

echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Add additional name to yandexmusic.desktop file"
echo -ne "<------------------------------------------------------>\n\n${NC}"

yandex_music_desktop_file_location="./usr/share/applications/yandexmusic.desktop" 

if [[ -e "$yandex_music_desktop_file_location" && -r "$yandex_music_desktop_file_location" ]]; then
    echo -ne "${CYAN} yandex music desktop file exists.\n${NC}"
    sed -i '/^Name=.*$/ s/\(.*\)/\1 Yandex Music/' $yandex_music_desktop_file_location
    sed -i '/^Categories=.*$/ s/\(.*\)/\1AudioVideo/' $yandex_music_desktop_file_location
else
    echo -ne "${CYAN}yandex music desktop file does not exist.\n${NC}"
fi


echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Building .rpm package"
echo -ne "<------------------------------------------------------>\n\n${NC}"

sudo rpmbuild -ba --target x86_64 --buildroot="$(pwd)" ./$yandex_music_alien_build_specname

pwd
ls -latr

cd $rpmbuild_specs_dir

pwd
ls -latr

yandex_music_rpm_package_name=$(ls ./*.rpm | tail -1)
cp $yandex_music_rpm_package_name $download_dirname/
rm -rf $yandex_music_rpm_package_name

pwd
ls -latr

cd $download_dirname

unset SUDOPWD
echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Clearing build directory"
echo -ne "<------------------------------------------------------>\n\n${NC}"

rm -rf ./$yandex_music_deb_file
rm -rf ./location.txt
sudo rm -rf $rpmbuild_sources_dir/tempSource
rm -rf $rpmbuild_sources_dir/$yandex_music_deb_file
rm -rf $rpmbuild_specs_dir/$yandex_music_rpm_package_name


echo -ne "${CYAN}\n<------------------------------------------------------>\n"
echo "Your Yandex Music $download_dirname/${yandex_music_rpm_package_name#./} package has been successfully created. Good luck!"
echo -ne "<------------------------------------------------------>\n\n${NC}"

