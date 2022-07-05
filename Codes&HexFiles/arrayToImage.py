import numpy as np
from cv2 import waitKey
from PIL import Image

desampled_file=open("Desampled.txt",'r')
lines = desampled_file.readlines()
y = []
x = []
j=1
for i in lines  :
    y.append(int(i))
    j = j+1
    if j==129:
        j=1
        x.append(y)
        y=[]


downsampled=np.array(x)
# print(downsampled)
gr_im= Image.fromarray(downsampled)
gr_im.convert("L").save('downsampled_image_from_processor.png')