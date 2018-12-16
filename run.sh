#!/bin/bash

if [ ! $1 ] ;
then
    echo "\033[31msh run.sh [complete path to target apk] [complete path to the output dir]"
    exit 1;
fi

#Hmmmm, welcome word hhhh
echo "\033[35m\n\tWelcome To APK-AFL-Fuzzer\n\033[0m"

#reverse using apktool
echo "\033[33mdosi: reverse target apk using apktool.jar ...\033[0m"
{
    java -jar /home/dosi/fuzzapk/tools/apktool.jar d -f $1 -o $2 &&
    echo "\033[33mdosi: done, output in $2 \033[0m"
} || {
    echo "\033[31mdosi: oops! reverse failed \033[0m"
} 

#moving own smali to the output smali dir
smali_dir=$2smali/
echo "\033[33mdosi: move my smali to $smali_dir ...\033[0m"
{    
    cp /home/dosi/fuzzapk/relative/androfuzz/instrumentor/Go0sLog.smali $smali_dir &&
    echo "\033[33mdosi: done \033[0m"
} || {
    echo "\033[31mdosi: oops! move failed \033[30m"
}

#instrument smali
#TODO delete the output argument
cfg_dir=$2cfg/
echo "\033[33mdosi: start instrumenting smali, this will take you several minutes ...\033[0m"
{
    python3 /home/dosi/fuzzapk/relative/androfuzz/instrumentor/androdd.py --input $1 --smali $smali_dir --output $cfg_dir &&
    echo "\033[33mdosi: hooray! instrument finished \033[30m"
} || {
    echo "\033[31mdosi: oops! instrument failed \033[30m"
}

#repack apk
echo "\033[33mdosi: repack apk ...\033[0m"
{
    java -jar /home/dosi/fuzzapk/tools/apktool.jar b $2 -o $2new.apk &&
        echo "\033[33mdosi: now you have new.apk \033[0m"
} || {
    echo "\033[31mdosi: oops! repack failed \033[0m"
}

#sign apk
echo "\033[33mdosi: sign new.apk ...\033[0m"
{
    java -jar /home/dosi/fuzzapk/tools/signapk.jar /home/dosi/fuzzapk/tools/testkey.x509.pem /home/dosi/fuzzapk/tools/testkey.pk8 $2new.apk $2new-sign.apk &&
    echo "\033[33mdosi: now you have new-sign.apk \033[0m"
} || {
    echo "\033[31mdosi: oops! sign failed \033[0m"
}

#install apk via adb
echo "\033[33mdosi: adb install new-sign.apk to your device ...\033[0m"
{
    adb install $2new-sign.apk &&
    echo "\033[33mdosi: done \033[0m"
} || {
    echo "\033[31dosi: oops! have you connected your device??? \033[0m"
}

#logcat, for debug
echo "for testing-----"
adb logcat -s "Go0s"
