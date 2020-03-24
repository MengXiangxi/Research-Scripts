import pydicom
import matplotlib.pyplot as plt

filename = '00000019.dcm'
dcmimg = pydicom.dcmread(filename).pixel_array

plt.imshow(dcmimg)
plt.show()