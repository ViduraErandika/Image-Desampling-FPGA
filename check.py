import cv2
import numpy
import numpy as np
from cv2 import waitKey
from PIL import Image

desampled_file=open("Desampled.txt")
list=desampled_file.readlines()
list1=[]
for i in list:
    i=int(i)
    list1.append(i)
print(list1)

start = 0
end=128*128
step = 128
list3=[]
for i in range(start, end, step):
    x = i
    list2=list1[x:x+step]
    list3.append(list2)
print(list3)
print(len(list3))

downsampled=np.array(list3)
print(downsampled)
gr_im= Image.fromarray(list3).save('downsampled_bird.png')