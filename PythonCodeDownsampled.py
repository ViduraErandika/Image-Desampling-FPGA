import cv2
import numpy as np
from cv2 import waitKey
from PIL import Image 

im = cv2.imread("bird.jpg",0)         #Output the image in gray scale mode
#cv2.imshow('Original_Image',im)

im=np.pad(im,1, mode='constant')     #Zero pad for the image
im=im.flatten(order='C')             #Convert the image into 1D array

imageArrayhexfile = open ('imageArrayhexfile.txt' , 'w' )
imageArrayhexfile.write('FF')
imageArrayhexfile.write("\n")

for l in im :
    hexVal = hex(l)
    strHex = str(hexVal)
    finalhex = strHex[2:]
    imageArrayhexfile.write(str(finalhex))
    imageArrayhexfile.write("\n")

print(len(im))

i = ((1+256+1)+1)
j=1
while(i<((256*256)-(256-2)-1)):      #Filter out high pass frequecies by passing through kernal
    total = im[i-1+256+2]
    total = total + 2*im[i+256+2]
    total = total + im[i+1+256+2]
    total = total +2*im[i-1]
    total = total + 4*im[i]
    total = total + 2*im[i+1]
    total = total + im[i-1-256-2]
    total = total + 2*im[i-256-2]
    total = total + im[i+1-256-2]
    im[i] = total/16
    i = i+2
    j=j+1
    if j==129:
        j=1
        i=i+256+4

#Got the downsampled image to a list
a=[]
downsampled=[]
i=((1+256+1)+1)
j=1
while i<((256+2)*(256+2))-(256+2)-1:
    a.append(im[i])
    i=i+2
    j=j+1
    if j==128:
        j=1
        i=i+256+4
        downsampled.append(a)
        a=[]

downsampled=np.array(downsampled)
print(len(downsampled))
gr_im= Image.fromarray(downsampled).save('downsampled_bird.png')