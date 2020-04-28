#!/bin/bash
mkdir chall
cp 1819.gz chall
cd chall
wordlist=$(cat ../passwords.txt)

while [ 1 ]
do
	filename=$(ls *)
	# Test if is a zip file
	file $filename | grep "Zip archive data"
	if [ "$?" -eq "0" ]
	then
		mv $filename $filename.zip
		# Brute force every password
		for w in $wordlist
		do 
			# Test if the password successfully extract the zip file
			unzip -o -q -P "$w" $filename.zip
			if [ "$?" -eq "0" ]
			then
				break
			fi
		done
		rm $filename.zip
		continue
	fi
	# Test if is a gzip file
	file $filename | grep "gzip compressed data"
	if [ "$?" -eq "0" ]
	then
		mv $filename $filename.gz
		gunzip $filename.gz
		continue
	fi
	# Test if is a tar file
	file $filename | grep "POSIX tar archive"
	if [ "$?" -eq "0" ]
	then
		tar -xf $filename
		rm $filename
		continue
	fi
done