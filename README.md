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
4) Log in to the console under user "makerpm" with comand `su makerpm`. Transfer the script to the makerpm user space <br>
  using the command `sudo cp "/home/<your-username>/path/to/script"  ./`. Then  run the script:`./download_and_convert_script.sh `.  <br>
  If the script does not run, make it executable using the command `chmod +x./download_and_convert_script.sh `. <br>
  The script will automatically download the latest version of .deb Yandex Music package from the official website and convert it to <br>
  the .rpm package. The converted .rpm package will be stored in the directory from where the script was launched. <br>
 5*) To prevent errors, I recommend running the script inside the "/home/makerpm" directory. <br>
   Then transfer the converted .rpm package to the directory of the main user of the VM using the `sudo cp` command. <br>


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
4) Войти в консоль под именем пользователя "makerpm", используя команду `su makerpm`. Перенесите скрипт в пространство <br>
  пользователя makerpm, используя команду `sudo cp "/home/<ваше-имя-пользователя>/путь/к/скрипту" ./`. <br>
  Затем запустите скрипт: `./download_and_convert_script.sh`.  <br>
  Если скрипт не запускается, сделать его исполняемым с помощью команды  `chmod +x  ./download_and_convert_script.sh`. <br>
  Скрипт сам скачает последнюю версию .deb пакета Яндекс Музыки с официального сайта и конвертирует его в .rpm пакет. <br>
  Конвертированный .rpm пакет будет лежать в директории, откуда скрипт был запущен. <br>
 5*) Для предотвращения ошибок, рекомендую запускать скрипт внутри директории"/home/makerpm". <br>
   Затем перенести конвертированный .rpm пакет в директорию основного пользователя виртуальной машины с помощью команды `sudo cp`. <br>
