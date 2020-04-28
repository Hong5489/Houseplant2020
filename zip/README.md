# Zip-a-Dee-Doo-Dah 129 Points 
```
I zipped the file a bit too many times it seems... and I may have added passwords to some of the zip files... eh, they should be pretty common passwords right?

Dev: William
 Hint! A script will help you with this, please don't try do this manually...
 Hint! All passwords should be in the SecLists/Passwords/xato-net-10-million-passwords-100.txt file, which you can get here : https://github.com/danielmiessler/SecLists/blob/master/Passwords/xato-net-10-million-passwords-100.txt
or alternatively, use "git clone https://github.com/danielmiessler/SecLists"
```
[1819.gz](1819.gz)

It is a gzip file:
```
file 1819.gz 
1819.gz: gzip compressed data, was "1818.tar", last modified: Sat Apr 25 01:57:45 2020, from Unix, original size modulo 2^32 256000
```
Inside after `gunzip` it, got `1819` tar file:
```
1819: POSIX tar archive (GNU)
```
Run `tar -xf 1819` to "untar" it, then got `1817.tar`

Notice the name of the file keep decreasing

Obviously it got **1819 layers of different compression**

Then I extract until `1816` is a Zip file, and need password to extract it:
```
unzip 1816
Archive:  1816
[1816] 1814.tar password: 
```
According to the hint:
```
Hint! All passwords should be in the SecLists/Passwords/xato-net-10-million-passwords-100.txt file, which you can get here : https://github.com/danielmiessler/SecLists/blob/master/Passwords/xato-net-10-million-passwords-100.txt
```
So I download it and save as [passwords.txt](passwords.txt)

Try using `zip2john 1816 > hash` and `john hash` to brute force the password
Result:
```
ver 2.0 efh 5455 efh 7875 1816/1814.tar PKZIP Encr: 2b chk, TS_chk, cmplen=233900, decmplen=235520, crc=C52EE628
1816/1814.tar:7777777:1814.tar:1816::1816

1 password hash cracked, 0 left
```
And inside got `1814.tar`, still got many layers

I wrote a bash script for auto extract all layers based on the file type:
```bash
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
```

`chmod +x solve.sh` and run it `./solve.sh`

Result:
```
...
...
2.zip                   bad CRC 39b2691b  (should be 2d9b0dc8)
    (may instead be incorrect password)
2.zip                   bad CRC 5a30a5cd  (should be 2d9b0dc8)
    (may instead be incorrect password)
2.zip: Zip archive data, at least v2.0 to extract
1.tar: POSIX tar archive (GNU)
0.gz: gzip compressed data, was "flag.txt", last modified: Fri Apr 10 05:09:28 2020, from Unix, original size modulo 2^32 46
```
Press `Ctrl + C` to stop the script

Then `0.gz` is the flag!!
```
cat chall/0.gz 
rtcp{z1pPeD_4_c0uPl3_t00_M4Ny_t1m3s_a1b8c687}
```

## Flag
```
rtcp{z1pPeD_4_c0uPl3_t00_M4Ny_t1m3s_a1b8c687}
```