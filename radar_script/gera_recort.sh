#!/bin/bash


# for filename in $(ls /home/ayumi/final_project_university/raw_file_data/SR_jan2mar2019_cappi3km/2019/mar_2019/*.raw); do
#  python ./recorte_radar.py ${filename} /home/ayumi/final_project_university/raw_file_data/pŕocessed_file/mar_2019_recorte_radar/
# done

for filename in $(ls /home/ayumi/final_project_university/raw_file_data/pŕocessed_file/mar_2019_recorte_radar/*.raw); do
  python ./gera_bin_prec.py ${filename} /home/ayumi/final_project_university/raw_file_data/pŕocessed_file/mar_2019_gera_bin_prec/
done

#dir_input="/home/ayumi/final_project_university/raw_file_data/pŕocessed_file/jan_2019_gera_bin_prec/"
#dir_output="/home/ayumi/final_project_university/raw_file_data/pŕocessed_file/jan_2019_prec_daily/"
#python ./gera_acum_prec_daily.py 20190101 20190131 ${dir_input} ${dir_output}  