#!/bin/sh

# Erstmal aufräumen (Löscht auch ./Abgabe/)
git clean -f -d -X

mkdir Abgabe
cp -r ./Blatt* ./Abgabe/

# In der .abgabeignore stehen alle Dateien drin, die wir nicht mit abgeben wollen.
while read -r line; do
    # Also löschen >:(
    rm ./Abgabe/*/$line
done <.abgabeignore

cd Abgabe

# Ersetzt ../krautsourcing/homework durch homework
sed -i 's/\.\.\/krautsourcing\/homework/homework/g' ./*/Abgabe*.tex

for i in *
do
    # homework.cls in jeden Ordner kopieren
    cp "../krautsourcing/homework.cls" "./$i"
#    cd "$i"
    # Order zippen
#    zip "$i.zip" *
    # Nach oben verschieben
#    mv "$i.zip" "../"
#    cd ..
    # Und löschen
#    rm -rf "$i"
done
