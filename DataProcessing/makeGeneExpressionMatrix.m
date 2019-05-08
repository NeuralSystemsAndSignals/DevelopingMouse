function makeGeneExpressionMatrix(whatNorm,...
                                  whatVoxelThreshold,...
                                  whatGeneThreshold,...
                                  thisBrainDiv) % both thresholds set to 0.3
%whatNorm='scaledSigmoid'; % normalizing method for makeGridData
%-------------------------------------------------------------------------------
% Create gene coexpression matrix
%-------------------------------------------------------------------------------
%%
% Initialize
timePoints = GiveMeParameter('timePoints');

% full size for 7 time points: 210000, 669369, 806520, 115240, 165550, 136000, 158629
% after filtering off spinal cord, unannotated voxels and only including forebrain,midbrain and hindbrain
% the number of voxels are (from voxelGeneCoexpression_all): 5031,9471,11314,11288,19754,21557,24826
% numData_brainDiv=[587,1000,1000,1000,1000,1000,1000]; % number of data ...
%for each time point when division of brain is under question...
%(instead of all brain)

% create gene coexpression matrix
for i=1:length(timePoints)
    [voxGeneMat, coOrds, propNanGenes, isGoodGene] = makeGridData(timePoints{i}, ...
                                                                  whatNorm, ...
                                                                  whatVoxelThreshold,...
                                                                  whatGeneThreshold,...
                                                                  thisBrainDiv);
    brainStr = GiveMeFileName(thisBrainDiv);

    str=fullfile('Matlab_variables', sprintf('voxelGeneCoexpression%s_%s.mat',...
                  brainStr,timePoints{i}));
    save(str,'voxGeneMat','coOrds','propNanGenes','isGoodGene','-v7.3');
    clear voxGeneMat coOrds numNanGenes isGoodGene
end
end