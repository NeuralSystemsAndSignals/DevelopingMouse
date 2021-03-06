function GeneName = importfile_PostmitoticOligodendrocyte_enriched(workbookFile,sheetName,startRow,endRow)
%IMPORTFILE Import data from a spreadsheet
%   GeneName = IMPORTFILE(FILE) reads data from the first worksheet in the
%   Microsoft Excel spreadsheet file named FILE and returns the data as
%   column vectors.
%
%   GeneName = IMPORTFILE(FILE,SHEET) reads from the specified worksheet.
%
%   GeneName = IMPORTFILE(FILE,SHEET,STARTROW,ENDROW) reads from the
%   specified worksheet for the specified row interval(s). Specify STARTROW
%   and ENDROW as a pair of scalars or vectors of matching size for
%   dis-contiguous row intervals. To read to the end of the file specify an
%   ENDROW of inf.%
% Example:
%   GeneName = importfile('Postmitotic_oligodendrocyte_enriched_Cahoy_S18.xls','Sheet1',3,187);
%
%   See also XLSREAD.

% Auto-generated by MATLAB on 2019/04/23 18:03:39

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 3
    startRow = 3;
    endRow = 187;
end

%% Import the data
[~, ~, raw] = xlsread(workbookFile, sheetName, sprintf('C%d:C%d',startRow(1),endRow(1)));
for block=2:length(startRow)
    [~, ~, tmpRawBlock] = xlsread(workbookFile, sheetName, sprintf('C%d:C%d',startRow(block),endRow(block)));
    raw = [raw;tmpRawBlock]; %#ok<AGROW>
end
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,1);

%% Allocate imported array to column variable names
GeneName = cellVectors(:,1);

