import numpy as np
import sys
import os



#filename = '/home/ayumi/final_project_university/raw_file_data/SR_jan2mar2019_cappi3km/2019/01/R13537439_201901010000.raw'
#path_out = '/home/ayumi/final_project_university/raw_file_data/pŕocessed_file'

#A listagem de nomes do arquivos é executado no shell script 
filename = sys.argv[1]
path_out = sys.argv[2]
file_out = os.path.basename(filename)

# Extensao Radar Sao Roque (PPI)
#nx = 666
#ny = 666
#dx = 0.00747135
#dy = -0.00675451
#x1 = -49.576
#y1 = -21.338 + ny*dy

# Extensao Radar Sao Roque (CAPPI)
nx = 500
ny = 500
dx = 0.009957
dy = -0.0090014
x1 = -49.5786
y1 = -21.3379 + ny*dy

# Recorte SP
#xMin = -46.826
#yMin = -24.0079
#xMax = -46.3648
#yMax = -23.3562

# Recorte Tamanduatei
#xMin = -46.6608
#yMin = -23.7568
#xMax = -46.4041
#yMax = -23.514

# Recorte RMSP + 10km
xMin = -47.298125
yMin = -24.153483
xMax = -45.604801
yMax = -23.092909

# Recorte cidade SP
#xMin = -46.8265
#yMin = -24.0081
#xMax = -46.3645
#yMax = -23.3559

i1 = int(np.floor((yMin - y1)/(dy*-1))-1)
i2 = int(np.ceil((yMax - y1)/(dy*-1)))
j1 = int(np.floor((xMin - x1)/(dx))-1)
j2 = int(np.ceil((xMax - x1)/(dx)))

data = np.fromfile(filename.strip(), dtype=np.float32).reshape((ny,nx))
data = np.flipud(data)
recorte = data[i1:i2, j1:j2].copy(order='C')
print(recorte.shape)
rec = open(os.path.join(path_out, file_out), 'wb')
rec.write(recorte)
rec.close()