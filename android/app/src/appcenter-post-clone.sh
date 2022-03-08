#!/usr/bin/env bash
 #Coloque este script en project/android/app/ 

cd .. 

# falle si algún comando falla 
set -e 
# debug log 
set -x 

cd .. 
git clone -b beta https:// github.com/flutter/flutter.git 
export PATH=`pwd`/flutter/bin:$PATH 

flutter channel stable 
flutter doctor 

echo "Installed flutter to `pwd`/flutter" 

# compilar APK 
# si obtienes "Error de ejecución para la tarea ':aplicación:lintVitalRelease'". error, elimine el comentario de las siguientes dos líneas 
flutter build apk --debug 
flutter build apk --profile 
flutter build apk --release 

# si necesita el paquete de compilación (AAB) además de su APK, elimine el comentario de la línea a continuación y la última línea de este script .
#flutter build appbundle --release --build-number $APPCENTER_BUILD_ID 

# copia el APK donde AppCenter lo encontrará 
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/apk/release/app-release.apk $_ 

# copia el AAB donde AppCenter lo encontrará 
#mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_