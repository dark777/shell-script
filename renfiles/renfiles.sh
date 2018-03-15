#!/bin/sh
# Script que renomeia pastas e arquivos que contem espacos e ifen's,
# que de certa forma eh desconfortavel manipula-los via terminal.
# Para resolver isso fiz um script shell que substitue todos
# os espaços de um arquivo e de todos os arquivo numa pasta
# corrente ou caminho declarado por hifen "_".
# https://www.vivaolinux.com.br/script/retira-espacos-em-branco-de-arquivos
IFS='
'

for i in $(ls $1) 
do
  filtra=$(echo $i |grep ' ')
    
   if [ -d $i ]; then
    echo -e "\e[33;1m\n\t$i\e[m<-\e[35;1m it's directory.!!!\e[m"
     fi
      
    if [ $filtra ]; then
     corpo=$(echo $i | awk -F "." '{print $1}')
      extensao=$(echo $i | awk -F "." '{print $2}')
       under=$(echo $corpo | sed 's/^ //g;s/ - /_/g;s/ /_/g;')
        final=$(echo $under.$extensao | sed 's/ $//g;')
         mv $filtra $final
     
    if [ $? -ne 0 ]; then
     echo -e "\e[37;1m$i \e[m<-\e[31;1m nothing done.!!\e[m"
      elif [ -d $final ]; then
       echo -e "\e[36;1m\n\tDirectory\e[35;1m: \e[m$i\e[31;1m\n\n\tRenamed\e[35;1m: \e[33;1m$final\e[m successfully\n\n"
        else
         echo -e "\e[36;1m\n\tFile\e[35;1m: \e[m$i\e[31;1m\n\n\tRenamed\e[35;1m: \e[33;1m$final\e[m successfully\n\n"
          fi
   fi
done