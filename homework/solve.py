import numpy as np
A = np.array([[1.6 ,-1.4  ,1.8],
			 [2.2  ,-1.8  ,1.6],
			 [-1 , 1 , -1]])

B = np.array([[37, 34, 160, 58, 66, 143, 11],
			 [36 ,27 ,237 ,110 ,93 ,210 ,33],
			 [-1 ,-7, 56 ,44, 22, 49, 22]])

C = np.dot(A,B)
print(C)
flag = ""
for i in range(7):
	for j in range(3):
		f = int(C[j][i])
		if f == 0:
			flag += "_"
		else:
			flag += chr(f+97)
print(flag)
