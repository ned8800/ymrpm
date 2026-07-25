# ymrpm

### -- en --
This repository contains means for creating .rpm package of Yandex Music from official .deb package of Yandex Music.

I do not claim any rights to the Yandex Music app. All rights to the original application belong to Yandex.

This repository only offers tools for building (converting) the .rpm package of Yandex Music app from the official .deb package, and will be archived as soon as Yandex releases the official version of the application in .rpm format.

## Build and create .rpm package
At the moment, the sequence of creating the .rpm package of Yandex Music is as follows:
1) create a virtual machine with a debian-based GNU Linux system (I used ubuntu-22.04). Log in to the machine.
2) Create a makerpm user with superuser privileges (sudo) !!!
3) Prepare the environment for assembly, the preparation instructions are located in the files "create_rpm_from_deb_command_history.txt" <br>
  and "How to Use rpmbuild on Ubuntu to Create an RPM Package.pdf" in the <a href="docs">docs</a> folder. <br>
4) Open the terminal and transfer script to makerpm user space using the command `sudo cp "/home/<your-username>/path/to/script/download_and_convert_script.sh " /home/makerpm/`. <br>
Log in to the terminal under the username "makerpm" using the command `su makerpm` and navigate to its home directory using the command `cd` without command line arguments. <br>
The script should be located inside the makerpm user's home directory, check for its presence with the command "ls -l". <br>
Make the script owned by the makerpm user using the command `sudo chown makerpm:makerpm ./download_and_convert_script.sh `. <br>
Make the script executable using the `chmod +x' command./download_and_convert_script.sh ` command. <br>
Then run the script itself using the command: `./download_and_convert_script.sh `. <br>
The script will download the latest version of the Yandex Music .deb package from the official website and convert it to an .rpm package. <br> 
You will need to enter the makerpm sudo password when the script requests it, so that the alien and rpmbuild programs could use the system utilities and convert .deb package. <br>
The converted .rpm package will be located in the same directory from where the script was launched. <br>
You can transfer the received .rpm file of the Yandex Music application using 2 commands: <br>
`sudo cp yandexmusic-<latest-version-number>.x86_64.rpm  /home/<your-username>/` <br>
and `sudo chown <your-username>  /home/<your-username>/yandexmusic-<latest-version-number>.x86_64.rpm` . <br>
 5*) To prevent unexpected errors, I recommend running the script inside the "/home/makerpm" directory. <br>
   Then transfer the converted .rpm package to the directory of the main user of the VM using the `sudo cp ...` command. <br>


The built packages are tested on Fedora 43.

Latest built package located in [releases](https://github.com/ned8800/ymrpm/releases/latest) page.

---

### -- ru --
Этот репозиторий содержит средства для создания .rpm-пакета Яндекс Музыки из официального .deb-пакета Яндекс Музыки.

Я не претендую на какие-либо права на приложение Яндекс Музыки. Все права на оригинальное приложение принадлежат Яндексу.

Этот репозиторий содержит только инструменты для создания (конвертации) .rpm-пакета приложения Яндекс Музыки из официального .deb-пакета и будет заархивирован, как только Яндекс выпустит официальную версию приложения в формате .rpm.

## Сборка и создание .rpm пакета
На текущий момент последовательность создания .rpm пакета Яндекс Музыки следующая:
1) создать виртуальную машину с debian-based GNU Linux системой (я использовал ubuntu-22.04). Войдите в виртуальную машину.
2) Создать пользователя makerpm с привилегиями суперпользователя (sudo) !!! 
3) Подготовить окружение для сборки, инструкции по подготовке лежат в файлах "create_rpm_from_deb_command_history.txt" <br>
  и "How to Use rpmbuild on Ubuntu to Create an RPM Package.pdf" в папке <a href="docs">docs</a>. <br>
4) Войдите в терминал и перенесите скрипт в пространство пользователя makerpm, используя команду `sudo cp "/home/<ваше-имя-пользователя>/путь/к/скрипту/download_and_convert_script.sh" /home/makerpm/`. <br>
Войдите в терминал под именем пользователя "makerpm", используя команду `su makerpm` и перейдите в его домашнюю директорию используя команду `cd` без аргументов командной строки. <br>
Скрипт должен находиться в домашней директории пользователя makerpm, проверьте его наличие командной "ls -l". <br>
Сделайте скрипт принадлежащим пользователю makerpm с помощью команды  `sudo chown makerpm:makerpm  ./download_and_convert_script.sh`. <br>
Сделайте скрипт исполняемым с помощью команды `chmod +x  ./download_and_convert_script.sh`. <br>
Затем запустите скрипт с помощью команды: `./download_and_convert_script.sh`.  <br>
Скрипт сам скачает последнюю версию .deb пакета Яндекс Музыки с официального сайта и конвертирует его в .rpm пакет. <br> 
Вам нужно будет ввести пароль суперпользователя makerpm, когда скрипт запросит его, это нужно, чтобы программы alien и rpmbuild могли использовать системные утилиты и конвертировать .deb пакет. <br>
Конвертированный .rpm пакет будет лежать в той же директории, откуда скрипт был запущен. <br>
Перенести полученный .rpm файл приложения Яндекс Музыки можно через 2 команды: <br>
`sudo cp yandexmusic-<номер-последней-версии>.x86_64.rpm  /home/<ваше-имя-пользователя>/`  <br>
и `sudo chown <ваше-имя-пользователя> /home/<ваше-имя-пользователя>/yandexmusic-<номер-последней-версии>.x86_64.rpm` . <br>
 5*) Для предотвращения непредвиденных ошибок, я рекомендую запускать скрипт внутри директории"/home/makerpm". <br>
   Затем перенести конвертированный .rpm пакет в директорию основного пользователя виртуальной машины с помощью команды `sudo cp ...`. <br>


Собранные пакеты протестированы на Fedora 43.

Последний собранный пакет находится на странице [releases](https://github.com/ned8800/ymrpm/releases/latest) .

