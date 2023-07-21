# importing training


```python
import arcpy
import os
from arcpy import env
# Set up the workspace and environment
env.workspace = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\trainingSamples\Samples_V1"  # Set the path to your workspace directory
csv_files =arcpy.ListFiles("*.csv")
# Loop through all the CSV files in the workspace
for csv_file in csv_files:
    # Create a name for the output point feature class based on the CSV file name
    output_name = arcpy.ValidateTableName(csv_file.replace(".csv", ""), env.workspace)
    # Make XY Event Layer
    in_table = csv_file
    x_coords = "xcoord"  # Replace with the actual X field name in the CSV
    y_coords = "ycoord"  # Replace with the actual Y field name in the CSV
    spatial_reference = arcpy.SpatialReference(4674)  # Replace with the appropriate spatial reference code
    arcpy.MakeXYEventLayer_management(in_table, x_coords, y_coords, output_name, spatial_reference)
```

# importing test


```python
import arcpy
import os
from arcpy import env
# Set up the workspace and environment
env.workspace = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\testSamples\SamplesV1"  # Set the path to your workspace directory
csv_files =arcpy.ListFiles("*.csv")
# Loop through all the CSV files in the workspace
for csv_file in csv_files:
    # Create a name for the output point feature class based on the CSV file name
    output_name = arcpy.ValidateTableName(csv_file.replace(".csv", ""), env.workspace)
    # Make XY Event Layer
    in_table = csv_file
    x_coords = "xcoord"  # Replace with the actual X field name in the CSV
    y_coords = "ycoord"  # Replace with the actual Y field name in the CSV
    spatial_reference = arcpy.SpatialReference(4674)  # Replace with the appropriate spatial reference co
    arcpy.MakeXYEventLayer_management(in_table, x_coords, y_coords, output_name, spatial_reference)
```


```python
import arcpy
import os

# Set the workspace where the output feature classes will be stored
arcpy.env.workspace = r"C:\Users\vitor.yuichi\Documents\ArcGIS\Projects\Projects\Default.gdb"  # Change this to your desired geodatabase or shapefile location

# Input folder containing CSV files
input_folder = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\testSamples\SamplesV1"  # Change this to the folder containing your CSV files

# Get a list of all CSV files in the input folder
csv_files = [f for f in os.listdir(input_folder) if f.endswith('.csv')]

# Loop through each CSV file and convert it to a point feature class
for csv_file in csv_files:
    # Create a name for the output feature class based on the CSV file name
    output_name = os.path.splitext(csv_file)[0]
    
    # Construct the full paths for input CSV file and output feature class
    input_csv = os.path.join(input_folder, csv_file)
    output_feature_class = os.path.join(arcpy.env.workspace, output_name)
    
    # Use XYTableToPoint to convert the CSV to a point feature class
    arcpy.management.XYTableToPoint(input_csv, output_feature_class, "xcoord", "ycoord", "", arcpy.SpatialReference(4326))

    print(f"Converted {csv_file} to {output_name}.")

print("All CSV files converted to point feature classes.")

```


```python
env.workspace
```




    'C:\\Users\\vitor.yuichi\\Desktop\\Pasta Vitor\\Univ\\testSamples\\SamplesV1'




```python
import arcpy
from arcpy.sa import *

# Set the workspace to the current project
arcpy.env.workspace = arcpy.mp.ArcGISProject("CURRENT").defaultGeodatabase

# Get a list of all active map layers in the current project
aprx = arcpy.mp.ArcGISProject("CURRENT")
active_layers = [lyr for lyr in aprx.listMaps()[0].listLayers() if lyr.isFeatureLayer]

# List to hold the rasters created from IDW interpolation of each layer
rasters = []

# Perform IDW interpolation for each active layer and store the resulting raster in the 'rasters' list
for layer in active_layers:
    output_raster = f"{layer.name}_IDW"
    out_idw = Idw(layer, "pluvio_trimester", 0.01, 2)
    out_idw.save(output_raster)
    rasters.append(output_raster)
    print(f"IDW interpolation for {layer.name} completed.")
```


    ---------------------------------------------------------------------------
    RuntimeError                              Traceback (most recent call last)

    In  [48]:
    Line 18:    out_idw.save('C:/Users/vitor.yuichi/Desktop/Pasta Vitor/Univ/rasters/+' + f"{layer.name}_IDW.tiff")
    

    RuntimeError: ERROR 010093: Output raster format UNKNOWN is unsupported.
    ---------------------------------------------------------------------------



```python
import arcpy
from arcpy.sa import *

# Set the workspace to the current project
arcpy.env.workspace = arcpy.mp.ArcGISProject("CURRENT").defaultGeodatabase

# Define the directory to save the output rasters
output_directory = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\rasters"

# Get a list of all active map layers in the current project
aprx = arcpy.mp.ArcGISProject("CURRENT")
active_layers = [lyr for lyr in aprx.listMaps()[0].listLayers() if lyr.isFeatureLayer]

# List to hold the rasters created from IDW interpolation of each layer
rasters = []

# Perform IDW interpolation for each active layer and store the resulting raster in the 'rasters' list
for layer in active_layers:
    output_raster = f"{layer.name}_IDW"
    out_idw = Idw(layer, "pluvio_trimester", 0.01, 2)
    
    # Save the raster to the specified output directory
    output_path = os.path.join(output_directory, f"{output_raster}.tif")
    out_idw.save(output_path)
    
    rasters.append(output_path)
    print(f"IDW interpolation for {layer.name} completed.")

```

    IDW interpolation for training9 completed.
    IDW interpolation for training8 completed.
    IDW interpolation for training7 completed.
    IDW interpolation for training6 completed.
    IDW interpolation for training5 completed.
    IDW interpolation for training4 completed.
    IDW interpolation for training3 completed.
    IDW interpolation for training29 completed.
    IDW interpolation for training28 completed.
    IDW interpolation for training27 completed.
    IDW interpolation for training26 completed.
    IDW interpolation for training25 completed.
    IDW interpolation for training24 completed.
    IDW interpolation for training23 completed.
    IDW interpolation for training22 completed.
    IDW interpolation for training21 completed.
    IDW interpolation for training20 completed.
    IDW interpolation for training2 completed.
    IDW interpolation for training19 completed.
    IDW interpolation for training18 completed.
    IDW interpolation for training17 completed.
    IDW interpolation for training16 completed.
    IDW interpolation for training15 completed.
    IDW interpolation for training14 completed.
    IDW interpolation for training13 completed.
    IDW interpolation for training12 completed.
    IDW interpolation for training11 completed.
    IDW interpolation for training10 completed.
    IDW interpolation for training1 completed.
    IDW interpolation for training0 completed.
    


```python
arcpy.mp.ArcGISProject("CURRENT")
```




    <arcpy._mp.ArcGISProject object at 0x000001CB66460100>




```python

```

# raster values


```python
import arcpy

# Get the current map in ArcGIS Pro
aprx = arcpy.mp.ArcGISProject("CURRENT")
map = aprx.listMaps()[1]  # Assuming you want to work with the first map in the project

# List all active raster layers in the map
active_raster_layers = [layer for layer in map.listLayers() if layer.isRasterLayer]
rasters_map = []
# Print the names of all active raster layers
for raster_layer in active_raster_layers:
    rasters_map.append(raster_layer.name)

```


```python

```


```python
import arcpy

# Get the current map in ArcGIS Pro
aprx = arcpy.mp.ArcGISProject("CURRENT")
map = aprx.listMaps()[1]  # Assuming you want to work with the first map in the project

# List all vector point layers in the map
vector_point_layers = [layer for layer in map.listLayers() if layer.isFeatureLayer and arcpy.Describe(layer).shapeType == 'Point']
vectors_points = []
# Print the names of all vector point layers
for vector_layer in vector_point_layers:
    vectors_points.append(vector_layer.name)

```


```python
vectors_points

```




    ['testing9', 'testing8', 'testing7', 'testing6', 'testing5', 'testing4', 'testing3', 'testing29', 'testing28', 'testing27', 'testing26', 'testing25', 'testing24', 'testing23', 'testing22', 'testing21', 'testing20', 'testing2', 'testing19', 'testing18', 'testing17', 'testing16', 'testing15', 'testing14', 'testing13', 'testing12', 'testing11', 'testing10', 'testing1', 'testing0']




```python
vectors_points = ['testing0', 'testing1', 'testing2', 'testing3', 'testing4', 'testing5', 'testing6',
                  'testing7', 'testing8', 'testing9', 'testing10', 'testing11', 'testing12', 'testing13', 'testing14', 
                  'testing15', 'testing16', 'testing17', 'testing18', 'testing19', 'testing20', 'testing21', 'testing22',
                  'testing23', 'testing24', 'testing25', 'testing26', 'testing27', 'testing28', 'testing29']

```


```python
rasters_map = ['training0_IDW.tif', 'training1_IDW.tif', 'training2_IDW.tif', 'training3_IDW.tif', 'training4_IDW.tif', 'training5_IDW.tif', 
               'training6_IDW.tif', 'training7_IDW.tif', 'training8_IDW.tif', 'training9_IDW.tif', 'training10_IDW.tif', 
               'training11_IDW.tif', 'training12_IDW.tif', 'training13_IDW.tif', 'training14_IDW.tif', 'training15_IDW.tif', 
               'training16_IDW.tif', 'training17_IDW.tif', 'training18_IDW.tif', 'training19_IDW.tif', 'training20_IDW.tif', 
               'training21_IDW.tif', 'training22_IDW.tif', 'training23_IDW.tif', 'training24_IDW.tif', 'training25_IDW.tif', 
               'training26_IDW.tif', 'training27_IDW.tif', 'training28_IDW.tif', 'training29_IDW.tif']

```


```python
print(len(rasters), len(vector_point_layers))
```

    30 30
    

# extracting value (value to points)


```python
import arcpy

# Set the workspace to the current project
arcpy.env.workspace = arcpy.mp.ArcGISProject("CURRENT").defaultGeodatabase

# List of vector point layers and rasters
vector_point_layers = ['testing0', 'testing1', 'testing2', 'testing3', 'testing4', 'testing5', 'testing6',
                  'testing7', 'testing8', 'testing9', 'testing10', 'testing11', 'testing12', 'testing13', 'testing14', 
                  'testing15', 'testing16', 'testing17', 'testing18', 'testing19', 'testing20', 'testing21', 'testing22',
                  'testing23', 'testing24', 'testing25', 'testing26', 'testing27', 'testing28', 'testing29']
rasters = ['training0_IDW.tif', 'training1_IDW.tif', 'training2_IDW.tif', 'training3_IDW.tif', 'training4_IDW.tif', 'training5_IDW.tif', 
               'training6_IDW.tif', 'training7_IDW.tif', 'training8_IDW.tif', 'training9_IDW.tif', 'training10_IDW.tif', 
               'training11_IDW.tif', 'training12_IDW.tif', 'training13_IDW.tif', 'training14_IDW.tif', 'training15_IDW.tif', 
               'training16_IDW.tif', 'training17_IDW.tif', 'training18_IDW.tif', 'training19_IDW.tif', 'training20_IDW.tif', 
               'training21_IDW.tif', 'training22_IDW.tif', 'training23_IDW.tif', 'training24_IDW.tif', 'training25_IDW.tif', 
               'training26_IDW.tif', 'training27_IDW.tif', 'training28_IDW.tif', 'training29_IDW.tif']

output_directory = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints"

# Get the active map in ArcGIS Pro
aprx = arcpy.mp.ArcGISProject("CURRENT")
map = aprx.listMaps()[1]  # Assuming you want to work with the first map in the project

# Loop through each vector point layer and raster
for vector_layer_name, raster_name in zip(vector_point_layers, rasters):
    # Get the vector point layer and raster
    vector_layer = None
    raster = None

    for layer in map.listLayers():
        if layer.name == vector_layer_name:
            vector_layer = layer
        elif layer.name == raster_name:
            raster = layer

        if vector_layer and raster:
            break

    if not vector_layer:
        print(f"Vector point layer '{vector_layer_name}' not found in the map.")
        continue
    if not raster:
        print(f"Raster '{raster_name}' not found in the map.")
        continue

    # Extract values to points
    out_table = os.path.join(output_directory, f"{vector_layer_name}_{raster_name}_extracted_values.dbf")
    arcpy.sa.ExtractValuesToPoints(vector_layer, raster, out_table, "INTERPOLATE", "VALUE_ONLY")
    print(f"ExtractValuesToPoints completed for {vector_layer_name} and {raster_name}. Output table: {out_table}")

```

    ExtractValuesToPoints completed for testing0 and training0_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing0_training0_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing1 and training1_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing1_training1_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing2 and training2_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing2_training2_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing3 and training3_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing3_training3_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing4 and training4_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing4_training4_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing5 and training5_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing5_training5_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing6 and training6_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing6_training6_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing7 and training7_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing7_training7_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing8 and training8_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing8_training8_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing9 and training9_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing9_training9_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing10 and training10_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing10_training10_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing11 and training11_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing11_training11_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing12 and training12_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing12_training12_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing13 and training13_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing13_training13_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing14 and training14_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing14_training14_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing15 and training15_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing15_training15_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing16 and training16_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing16_training16_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing17 and training17_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing17_training17_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing18 and training18_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing18_training18_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing19 and training19_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing19_training19_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing20 and training20_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing20_training20_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing21 and training21_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing21_training21_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing22 and training22_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing22_training22_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing23 and training23_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing23_training23_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing24 and training24_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing24_training24_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing25 and training25_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing25_training25_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing26 and training26_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing26_training26_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing27 and training27_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing27_training27_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing28 and training28_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing28_training28_IDW.tif_extracted_values.dbf
    ExtractValuesToPoints completed for testing29 and training29_IDW.tif. Output table: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing29_training29_IDW.tif_extracted_values.dbf
    


```python

```


```python
import arcpy
import os
import re

# Get the active map in ArcGIS Pro
aprx = arcpy.mp.ArcGISProject("CURRENT")
map2 = aprx.listMaps()[2]  # Assuming you want to work with the first map in the project

# Output directory for saving the CSV files
output_directory = r"C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints"

# Function to sanitize the filename
def sanitize_filename(name):
    # Remove invalid characters from the name and replace them with underscores
    return re.sub(r'[\\./:*?"<>|]', '_', name)

# Loop through each layer in the active map
for layer in map2.listLayers():
    # Ensure the layer is a feature layer (not a raster or other layer types)
    if layer.isFeatureLayer:
        # Get the full path for the output CSV file
        csv_filename = f"{sanitize_filename(layer.name)}.csv"
        csv_filepath = os.path.join(output_directory, csv_filename)

        # Export the attribute table to CSV
        arcpy.conversion.TableToTable(layer, output_directory, csv_filename)

        print(f"Exported attribute table of '{layer.name}' to CSV: {csv_filepath}")

print("Attribute tables have been exported as CSV files.")

```

    Exported attribute table of 'testing7_training7_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing7_training7_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing6_training6_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing6_training6_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing5_training5_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing5_training5_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing4_training4_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing4_training4_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing3_training3_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing3_training3_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing2_training2_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing2_training2_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing1_training1_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing1_training1_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing0_training0_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing0_training0_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing29_training29_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing29_training29_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing28_training28_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing28_training28_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing27_training27_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing27_training27_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing26_training26_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing26_training26_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing25_training25_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing25_training25_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing24_training24_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing24_training24_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing23_training23_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing23_training23_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing22_training22_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing22_training22_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing21_training21_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing21_training21_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing20_training20_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing20_training20_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing19_training19_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing19_training19_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing18_training18_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing18_training18_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing17_training17_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing17_training17_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing16_training16_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing16_training16_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing15_training15_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing15_training15_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing14_training14_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing14_training14_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing13_training13_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing13_training13_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing12_training12_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing12_training12_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing11_training11_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing11_training11_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing10_training10_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing10_training10_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing9_training9_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing9_training9_IDW_tif_extracted_values.csv
    Exported attribute table of 'testing8_training8_IDW.tif_extracted_values' to CSV: C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\samplesPoints\testing8_training8_IDW_tif_extracted_values.csv
    Attribute tables have been exported as CSV files.
    


```python




```


```python

```
