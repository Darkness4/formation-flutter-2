
echo "NE PAS EXECUTER, FAIRE UNIQUEMENT PAR SELECTION"
exit 1
# Seulement pour Ubuntu/Debian-based

# Install Android SDK et FlutterSDK (avec PATH vers DartSDK)
sudo apt update
sudo apt install -y apt-transport-https wget curl git sed openjdk-11-jdk unzip lib32stdc++6
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
PATH=$PATH:/usr/lib/jvm/java-11-openjdk-amd64/bin

git clone https://github.com/flutter/flutter.git "$HOME/flutter"
PATH=$INSTALL_DIR/flutter/bin:$PATH

curl -O "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
unzip -qq "sdk-tools-linux-4333796.zip" -d "$HOME/android-sdk"

# Add missing libraries (PLEASE VERIFY IF LATEST, STABLE AND COMPATIBLE WITH JDK 11)
mkdir "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib"
wget http://central.maven.org/maven2/javax/activation/activation/1.1.1/activation-1.1.1.jar -O "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib/activation.jar" || (echo "wget 1 failed" && exit 1)
wget http://central.maven.org/maven2/javax/xml/jaxb-impl/2.1/jaxb-impl-2.1.jar -O "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib/jaxb-impl.jar" || (echo "wget 2 failed" && exit 1)
wget http://central.maven.org/maven2/org/glassfish/jaxb/jaxb-xjc/2.3.2/jaxb-xjc-2.3.2.jar -O "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib/jaxb-xjc.jar" || (echo "wget 3 failed" && exit 1)
wget http://central.maven.org/maven2/org/glassfish/jaxb/jaxb-core/2.3.0.1/jaxb-core-2.3.0.1.jar -O "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib/jaxb-core.jar" || (echo "wget 4 failed" && exit 1)
wget http://central.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar -O "$INSTALL_DIR/android-sdk/tools/bin/jaxb_lib/jaxb-api.jar" || (echo "wget 5 failed" && exit 1)

if [ ! -e "$INSTALL_DIR/android-sdk/tools/bin/sdkmanager.bak" ]
then
    cp "$INSTALL_DIR/android-sdk/tools/bin/sdkmanager" "$INSTALL_DIR/android-sdk/tools/bin/sdkmanager.bak"
fi
if [ ! -e "$INSTALL_DIR/android-sdk/tools/bin/avdmanager.bak" ]
then
    cp "$INSTALL_DIR/android-sdk/tools/bin/avdmanager" "$INSTALL_DIR/android-sdk/tools/bin/avdmanager.bak"
fi

CLASSPATH_TO_ADD="CLASSPATH=\\\$APP_HOME\/bin\/jaxb_lib\/activation.jar:\\\$APP_HOME\/bin\/jaxb_lib\/jaxb-impl.jar:\\\$APP_HOME\/bin\/jaxb_lib\/jaxb-xjc.jar:\\\$APP_HOME\/bin\/jaxb_lib\/jaxb-core.jar:\\\$APP_HOME\/bin\/jaxb_lib\/jaxb-jxc.jar:\\\$APP_HOME\/bin\/jaxb_lib\/jaxb-api.jar:\\\$CLASSPATH"

sed -Ein "/^CLASSPATH=\\\$APP_HOME\/lib*/a $CLASSPATH_TO_ADD" "$INSTALL_DIR/android-sdk/tools/bin/avdmanager" || (echo "sed 1 failed" && exit 1)
sed -Ein "/^CLASSPATH=\\\$APP_HOME\/lib*/a $CLASSPATH_TO_ADD" "$INSTALL_DIR/android-sdk/tools/bin/sdkmanager" || (echo "sed 2 failed" && exit 1)
# -- STOP add libraries --

# Accept licenses
PATH=$INSTALL_DIR/android-sdk/tools/bin:$PATH

mkdir ~/.android
echo 'count=0' > ~/.android/repositories.cfg
yes | sdkmanager --licenses
sdkmanager "tools" \
    "platforms;android-28" \
    "build-tools;29.0.1" \
    "platform-tools" \
yes | sdkmanager --licenses || echo "Failed"
flutter doctor -v

# PATH Updater
if [ ! -e ~/.profile.bak ]
then
    cp ~/.profile ~/.profile.bak
fi

{
    echo "export PATH=$INSTALL_DIR/android-sdk/tools/bin:\$PATH"
    echo "export PATH=$INSTALL_DIR/android-sdk/platform-tools:\$PATH"
    echo "export PATH=$INSTALL_DIR/flutter/bin:\$PATH"
    echo "export PATH=$INSTALL_DIR/flutter/bin/cache/dart-sdk/bin:\$PATH"
    echo "export ANDROID_HOME=$INSTALL_DIR/android-sdk"
    echo "export ANDROID_SDK_ROOT=$INSTALL_DIR/android-sdk"
    echo "export ANDROID_SDK_HOME=\$HOME"
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
    echo "export PATH=\$PATH:/usr/lib/jvm/java-11-openjdk-amd64/bin"
} >> ~/.profile

# Emulateur
sdkmanager "emulator"
echo "export PATH=\$ANDROID_HOME/emulator:\$PATH" >> ~/.profile
sdkmanager "system-images;android-28;default;x86"
yes | sdkmanager --licenses
avdmanager  --verbose create avd --force --name "Nexus_5X_API_28" --device "Nexus 5X"  --package "system-images;android-28;default;x86" --abi "x86"

# Run
emulator -avd Nexus_5X_API_28
