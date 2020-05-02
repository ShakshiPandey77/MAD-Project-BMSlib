#!/bin/bash 
# script to build, install and launch app on connected device
# or avd
# build ans install the android app
alias buildInstallApk = "./gradlew installDebug"
# launch the app
alias launchDebugApk="adb shell monkey -p `aapt dump badging ./app/build/outputs/apk/debug/app-debug.apk | grep -e 'package: name' | cut -d \' -f 2` 1"
# command
buildInstallApk && launchDebugApk
