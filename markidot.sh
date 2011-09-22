#!/bin/bash

##########################
# markidot               #
# skrip download paket   #
# kaka.prakasa@gmail.com #
##########################

if [ -z $1 ]  ; then

	echo "Penggunaan : "
	echo $0" [nama_paket_1] [nama_paket_2]...[nama_paket_n]"

else  
	for i in $@; do

		mkdir -p ~/paket/$i

		pushd ~/paket/$i

		dpkg --get-selections > ~/paket/bakup.cache
		dpkg --clear-selections
		apt-get --reinstall --print-uris --yes install $i | grep ^\' | cut -d\' -f2 > $i.info
                dpkg --set-selections < ~/paket/bakup.cache

		cut -d\/ -f9 $i.info > $i.list
        
        echo "Berkas yang akan di Unduh :"
        cat $i.list
        sleep 1

        echo "-------------Mulai Mengunduh-----------"
        sleep 1
		wget -i $i.info 

		popd

	done	
fi
