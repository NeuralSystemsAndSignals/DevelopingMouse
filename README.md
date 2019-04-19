# Developing Mouse Scripts

## Retrieve data from Allen API
* Fills the `Data` directory.
* First download Allen API package by `pip install allensdk`
* Run `structure.py` to download structure information

## Other raw data
`A mesoscale connectome of the mouse brain supp table 4_ipsi` is obtained from supplementary table 4 of the Oh et. al paper, which contains a distance matrix of adult brain structures

### Voxel-level expression data

Downloading gene-expression data:

```python
API_DevelopingMouseLevel5.py
```

### Distance data
Downloading distance related data (coordinates, colours):
Allen RMA
```
API.ipynb
```
OR
```
Allen+RMA+API.py
```

Produces the following data files:
* SDFDJKSL.csv
* ...

Other functionalities:
Looking at the organization of the RMA query classes:
Allen RMA API query `classes.ipynb` OR `Allen+RMA+API+query+classes.py`

## Data processing

Convert downloaded data into Matlab variables, fills the `DataRendering` [`ProcessedData`] directory.
* `createStructureInfo.m` creates a Matlab variable `dataDevMouse.mat` containing structure information, including structure abbreviation, ID, colour, coordinates, major division abbreviation (the level 3 structure it belongs to), major division colour, a table containing the above info, and distance matrix
* `createGeneExpressionMatrix.m` creates a Matlab variable containing voxel x gene matrix, distance matrix and a selector (determines which voxels are sampled for further analysis) for 7 time points
* `createDevMouseGeneExpression` creates gene expression matrices normalized by different methods
* `extractCoords` extracts coordinates and ID of adult mouse (from `structureCenters_adult.csv`) with correct map ID into `coOrds_AdultMouse.csv` and `ID_AdultMouse.csv`
* `getAcronymFromID.py` queries (from API) for adult mouse acronym from ID using `ID_AdultMouse.csv` as input, yielding `acronym_AdultMouse.csv`
* Matlab variables are saved in the folder `Matlab_variables`
* csv files are saved in the folder `Processed`

* Extracted coordinates (`coOrds_AdultMouse.csv`) and ID (`ID_AdultMouse.csv`) of adult mouse structures from the file "coOrds_AdultMouse.csv": `extractCoords_allenserver.m`
* Obtain the list of adult mouse structure abbreviation (`acronym_AdultMouse.csv`) using the list of structure ID
Allen_Reference `space-make_abbrev_list.ipynb` OR `Allen_Reference+space-make_abbrev_list.py`
and inputting `ID_AdultMouse.csv`
* Convert developing mouse distance-related info into `dataDevMouse.mat` which stores structure abbreviation, ID, colour, coordinates, major division abbreviation (the level 3 structure it belongs to), major division colour, a table containing the above info, and distance matrix
`level5info.m` (function) and `LoadData_SDK_full_data_level5.m` (script)
* Convert gene expression data into `DevMouseGeneExpression.mat` with structure fields ``raw`, `norm` and `normGene`.

Using scaled sigmoid for norm field:
```
whatNormalization = 'log2';
MakeDevMouseGeneExpression(whatNormalization);
```
Using log2 for norm field: `MakeDevMouseGeneExpression_log2.m`
Using z-score for norm field: `MakeDevMouseGeneExpression_zscore.m`

Note: the `.csv` files are stored in `Data` folder

## Analysis
* `geneCoexpression_scatter_voxel` plots gene coexpression against distance separation at the voxel level
* `createFitting` fits the data to a few types of curves, plots decay constant (3 parameter exponential fitting) against maximum distance in each time point); and save the fitting statistic, decay constant and maximum distance to `fitting.mat`
* `decayConstant_voxel.m` plots the logarithm of decay constant (3 parameter exponential fitting) against maximum distance
* `GeneCoexpression_scatter` plots gene coexpression against distance separation at the structure level

* All figures are saved in Outs
## Testing

### Distance comparison
 Compared distances obtained from adult structure coordinates with that provided in Oh et al supplementary table 4 ("A mesoscale connectome of the mouse brain supp table 4_ipsi.xlsx"), plot MDS and scatter 3 for API adult structure and Oh et al, as well as for 7 developmental time points [`DataAnalysis` folder]

```
distanceMatrix_removeDup
```

### Spatial dependence functional form

Fitting linear, 1 parameter exponential, 2 parameter exponential and 3 parameter exponential to each of the 7 time points and all time point together (global) and checking Degrees of Freedom Adjusted R-Square and the fitting parameter values with 95% confidence interval
```
GeneCoexpression
```

5. Fitting 3 parameter exponential to each time point and plotting all together on the same graph, also performs binning [Analysis folder]
`GeneCoexpression_Binning`

6. Plotting exponential decay constant against max distances for different methods of normalization [Analysis folder]
`fittingGeneCoexpression.m`
