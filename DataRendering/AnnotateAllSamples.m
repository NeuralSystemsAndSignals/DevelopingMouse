function AnnotateAllSamples(procParams)
%-------------------------------------------------------------------------------
% Annotate voxels
%-------------------------------------------------------------------------------

if nargin < 1
    procParams = GiveMeDefaultParams();
end

timePoints = GiveMeParameter('timePoints');
numTimePoints = length(timePoints);
for i = 1:numTimePoints
    fprintf(1,'Time point %s\n',timePoints{i});
    annotateSamples(timePoints{i},procParams);
end

end
