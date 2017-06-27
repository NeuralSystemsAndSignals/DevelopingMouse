%% 1. Import acronyms from Structure
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/20 16:56:10

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column2: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
acronym = dataArray{:, 1};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% 2. Import colour from Structure
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/20 16:57:11

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column4: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
color_hex_triplet = dataArray{:, 1};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;


%% 3. Import ID from Structure
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/20 17:03:42

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\structureData_level5_clean.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column11: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
id = dataArray{:, 1};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% 4. Import structure ID from Structure Center
%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\structureCenters_level5.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/20 20:12:30

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\structureCenters_level5.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%f%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
structure_id = dataArray{:, 1};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% 

%% 5. Import reference space ID from Structure Center.
%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\structureCenters_level5.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/20 17:14:39

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\structureCenters_level5.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%f%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
reference_space_id = dataArray{:, 1};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% 6. Import acronym path (unsorted)
% Script for importing data from the following text file:
%
%    D:\Data\DevelopingAllenMouseAPI-master\API data\AcronymPath_level5_clean.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/06/23 15:50:59

%% Initialize variables.
filename = 'D:\Data\DevelopingAllenMouseAPI-master\API data\AcronymPath_level5_clean.csv';
delimiter = ',';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*q%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));


%% Split data into numeric and cell columns.
rawNumericColumns = {};
rawCellColumns = raw(:, [1,2]);


%% Create output variable
AcronymPathlevel5clean = raw;
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawCellColumns;

%% import level 3 acronym and color
[~,acronym_level3,~]=xlsread('structureData_level3_clean.csv',1,'B2:B20');
[~,color_level3,~]=xlsread('structureData_level3_clean.csv',1,'D2:D20');
%% Import coordinates from Structure Center
coOrds=csvread('structureCenters_level5.csv',1,4,[1,4,805,6]);

%% sort the coordinates into different developmental time points
is1=(reference_space_id==1);
is2=(reference_space_id==2);
is3=(reference_space_id==3);
is5=(reference_space_id==5);
is6=(reference_space_id==6);
is7=(reference_space_id==7);
is8=(reference_space_id==8);
is9=(reference_space_id==9);

coOrds_E11pt5=coOrds(is1,:);
coOrds_E13pt5=coOrds(is2,:);
coOrds_E15pt5=coOrds(is3,:);

coOrds_E18pt5=coOrds(is5,:);
coOrds_P4=coOrds(is6,:);
coOrds_P14=coOrds(is7,:);
coOrds_P28=coOrds(is8,:);
coOrds_P56=coOrds(is9,:);
%% 
% sort the acronym path cell into the correct order
[~,iq,ir]=intersect(char(acronym),AcronymPathlevel5clean(:,1),'stable');
AcronymPathlevel5clean=AcronymPathlevel5clean(ir,:);
% extract the acronym of the major division 
AcronymPath=AcronymPathlevel5clean(:,2);
% break each row into separate words and extract the needed one
divisionLabel=cell(length(AcronymPath),1);
divisionColorLabel=cell(length(AcronymPath),1);
for i=1:length(AcronymPath)
    x=strsplit(AcronymPath{i},',');
    divisionLabel{i}=x{ismember(x,char(acronym_level3))};
    divisionColorLabel{i}=color_level3{ismember(char(acronym_level3),divisionLabel{i},'rows')};
end
% extract level 3 colors and sort in correct order
%[T,~,iv]=intersect(char(divisionLabel),char(acronym_level3),'rows','stable');
%color_level3=color_level3(iv);
%%
%match the coordinates with acronym, ID and color
logicalCell={is1,is2,is3,is5,is6,is7,is8,is9};
timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28','P56'};
dataDevMouse=struct();
columnNames={'ID','Acronym','Color','Division','Dvision_Color','Coordinates'};
coOrds_filtered=cell(length(timePoints),1);
% first, match coordinates with the 78 level 5 ID
for i=1:length(timePoints)
    [C,ia,ib]=intersect(id,structure_id(logicalCell{i}),'stable');
    coOrds_filtered{i}=coOrds(logicalCell{i},:);
% extract coordinates,id,acronym and color of structures with matching level 5 ID
    dataDevMouse.(timePoints{i}).coOrd=coOrds_filtered{i}(ib,:);
    dataDevMouse.(timePoints{i}).id=id(ia);
    dataDevMouse.(timePoints{i}).acronym=acronym(ia);
    dataDevMouse.(timePoints{i}).division=divisionLabel(ia);
    dataDevMouse.(timePoints{i}).division_color=divisionColorLabel(ia);
    dataDevMouse.(timePoints{i}).color=color_hex_triplet(ia,:);
    dataDevMouse.(timePoints{i}).info=table(dataDevMouse.(timePoints{i}).id,...
        dataDevMouse.(timePoints{i}).acronym,dataDevMouse.(timePoints{i}).color,...
        dataDevMouse.(timePoints{i}).division,dataDevMouse.(timePoints{i}).division_color,...
        dataDevMouse.(timePoints{i}).coOrd,'VariableNames',columnNames);
    dataDevMouse.(timePoints{i}).distance=squareform(pdist(coOrds_filtered{i}(ib,:),'euclidean'));
end

%%
%% MDS
for i=1:length(timePoints)
    distMat = dataDevMouse.(timePoints{i}).distance;
    score = mdscale(distMat,2);
    xData = score(:,1);
    yData = score(:,2);
    numRegions=height(dataDevMouse.(timePoints{i}).info);

%-------------------------------------------------------------------------------
% Plot
%-------------------------------------------------------------------------------
    f = figure('color','w');
    dotColors = arrayfun(@(x) rgbconv(dataDevMouse.(timePoints{i}).color{x})',...
                                        1:numRegions,'UniformOutput',0);
    dotColors = [dotColors{:}]';

    nodeSize = 50;
    scatter(xData,yData,nodeSize,dotColors,'fill','MarkerEdgeColor','k')

    % Add labels:
    xDataRange = range(xData);
    for j = 1:numRegions
        text(xData(j)+0.04*xDataRange,yData(j),dataDevMouse.(timePoints{i}).acronym{j},...
                        'color',brighten(dotColors(j,:),-0.3))
    end
end

%% Scatter3 plot
for i=1:length(timePoints)
    coOrds_x=dataDevMouse.(timePoints{i}).coOrd(:,1);
    coOrds_y=dataDevMouse.(timePoints{i}).coOrd(:,2);
    coOrds_z=dataDevMouse.(timePoints{i}).coOrd(:,3);
    numRegions=height(dataDevMouse.(timePoints{i}).info);
    
    f1 = figure('color','w');
    dotColors = arrayfun(@(x) rgbconv(dataDevMouse.(timePoints{i}).color{x})',...
                                        1:numRegions,'UniformOutput',0);
    dotColors = [dotColors{:}]';
    
    nodeSize = 50;
    scatter3(coOrds_x,coOrds_y,coOrds_z,nodeSize,dotColors,'fill','MarkerEdgeColor','k');
    xlabel('x');
    ylabel('y');
    zlabel('z');

    % Add labels:
    xCoordRange = range(coOrds_x);
    for j = 1:numRegions
        text(coOrds_x(j)+0.04*xCoordRange,coOrds_y(j),coOrds_z(j),dataDevMouse.(timePoints{i}).acronym{i},...
                        'color',brighten(dotColors(j,:),-0.3))
    end
end

%% save
save('dataDevMouse.mat','dataDevMouse')

