import os
import sys
import numpy as np

dbz_file_path = '/home/ayumi/final_project_university/raw_file_data/pŕocessed_file/jan_2019_gera_bin_prec/R13537439_201901010000.raw'

with open(dbz_file_path, 'rb') as file:
    # Read the content of the file
    dbz = np.fromfile(file, dtype=np.float32)

print(len(dbz))