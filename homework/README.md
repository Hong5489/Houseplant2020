# Post-Homework Death 570 Points
```
My math teacher made me do this so now I'm forcing you to do this too.

Flag is all lowercase; replace spaces with underscores.

Dev: Claire
Hint! When placing the string in the matrix go up to down rather than left to right.
Hint! Google matrix multiplication properties if you're stuck.
```
[posthomeworkdeaths.txt](posthomeworkdeaths.txt)

Inside the text file:
```
Decoding matrix:

1.6  -1.4  1.8
2.2  -1.8  1.6
-1     1    -1


String:

37 36 -1 34 27 -7 160 237 56 58 110 44 66 93 22 143 210 49 11 33 22
```

Its just a simple [matrix multiplication](https://www.mathsisfun.com/algebra/matrix-multiplying.html)

Assume the `Matrix A` is Decode matrix and `Matrix B` is String Matrix
``` 
According to the hint, we place string up to down so become 3X7 Matrix

     Matrix A                  Matrix B 
| 1.6  -1.4  1.8 |   | 37 34 160  58 66 143 11 | 
| 2.2  -1.8  1.6 | X | 36 27 237 110 93 210 33 |
| -1     1    -1 |   | -1 -7  56  44 22  49 22 |
```
I wrote a [python script](solve.py) to calculate:
```py
import numpy as np
A = np.array([[1.6 ,-1.4  ,1.8],
			 [2.2  ,-1.8  ,1.6],
			 [-1 , 1 , -1]])

B = np.array([[37, 34, 160, 58, 66, 143, 11],
			 [36 ,27 ,237 ,110 ,93 ,210 ,33],
			 [-1 ,-7, 56 ,44, 22, 49, 22]])

C = np.dot(A,B)
print(C)
```
Result:
```
[[7.00000000e+00 4.00000000e+00 2.50000000e+01 1.80000000e+01
  1.50000000e+01 2.30000000e+01 1.10000000e+01]
 [1.50000000e+01 1.50000000e+01 1.50000000e+01 1.42108547e-14
  1.30000000e+01 1.50000000e+01 7.10542736e-15]
 [0.00000000e+00 0.00000000e+00 2.10000000e+01 8.00000000e+00
  5.00000000e+00 1.80000000e+01 0.00000000e+00]]
```

Search `Decode Matrix` on Google, I saw [this page](https://www.instructables.com/id/Encrypt-a-message-using-matrixes/) says 1-26 is A-Z and 0 is space

Then I add few lines of code below:
```py
flag = ""
for i in range(7):
	for j in range(3):
		f = int(C[j][i])
		if f == 0:
			flag += "_"
		else:
			flag += chr(f+97)
print(flag)
```
Result:
```
HP_EP_ZOVS_IPNFXPSL__
```
Emm seems is encrypted, lets try caesar cipher!
```
+1	go_do_ynur_homework__
+7	ai_xi_shol_bigyqile__
+11	we_te_odkh_xecumeha__
+22	lt_it_dszw_mtrjbtwp__
...
...
```
Can see the **first one** is the flag! (Don't know why is abit off)

## Flag 
```
rtcp{go_do_your_homework}
```