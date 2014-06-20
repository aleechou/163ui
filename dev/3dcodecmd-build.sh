cd ../Interface/AddOns/\!\!\!163UI.3dcodecmd\!\!\!-src
git pull
git checkout $1
./build
git checkout master
cd ../\!\!\!163UI.3dcodecmd\!\!\!
git add .
git commit -m "build 3dcodecmd"
git push