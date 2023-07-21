```python
import pandas as pd
import numpy as np
df = pd.read_csv(r'C:\Users\vitor.yuichi\Desktop\Pasta Vitor\Univ\RawFile\new.csv', decimal = ',')
```


```python
df['pluvio_trimester']= df.pluvio_jan + df.pluvio_fev + df.pluvio_mar
df['value_trimester'] = df.value_fev + df.value_jan + df['value_mar ']
rain_gauges = df[['prefixo', 'ycoord', 'xcoord', 'pluvio_trimester', 'value_trimester']]
```


```python
print("number of rows:", len(rain_gauges), "  | 2/3 of the data (training):", 2*len(rain_gauges)//3, '|   1/3 of the data (test):' , len(rain_gauges)//3)
```

    number of rows: 25   | 2/3 of the data (training): 16 |   1/3 of the data (test): 8
    


```python
# Load your dataset as a pandas DataFrame

# Define the number of samples and test percentage
num_samples = 30
test_percentage = 1/3

# Create lists to store the training and testing datasets
training_datasets = []
testing_datasets = []

for i in range(num_samples):
    # Shuffle the DataFrame rows
    shuffled_df = rain_gauges.sample(frac=1, random_state=i)

    # Split the dataset into training and testing sets
    test_size = int(len(shuffled_df) * test_percentage)
    training_set = shuffled_df.iloc[test_size:]
    testing_set = shuffled_df.iloc[:test_size]

    # Append the datasets to the lists
    training_datasets.append(training_set)
    testing_datasets.append(testing_set)
```


```python
# for i in range(num_samples):
#     print(f"Training Set {i+1}:\n{training_datasets[i]}")
#     print(f"Testing Set {i+1}:\n{testing_datasets[i]}")
#     print("-------------------------------")
```


```python
# Export each DataFrame to a separate CSV file
for i, df in enumerate(training_datasets):
    filename = f'C:/Users/vitor.yuichi/Desktop/Pasta Vitor/Univ/trainingSamples/Samples_V1/training{i}.csv'  # Replace with the desired file path and name
    df.to_csv(filename, index=False)
```


```python

```
