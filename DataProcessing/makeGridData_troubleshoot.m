% function [voxGeneMat, distMat, dataIndSelect] = makeGridData(whatTimePointNow, ...
%                                                             whatNumData, whatNorm, ...
%                                                             whatVoxelThreshold, thisBrainDiv)
  % for whatNorm: must leave it as empty string ' ' if 'scaledSigmoid'; options:' ', 'zscore','log2';
  % for thisBrainDiv: 'forebrain', 'midbrain' or 'hindbrain'; if left out, all brain divisions included
  % for whatNumData: either input 'all' or the number of voxels to be included
    %% Sets background variables
    % current time point
    whatTimePointNow='E11pt5';
    timePointNow=whatTimePointNow;
    whatNumData=1000;
    whatNorm='scaledSigmoid';
    whatVoxelThreshold=0.3;
    thisBrainDiv='all';

    % matlab variable directory
    varDir=fullfile('Matlab_variables');

    % this script creates a voxel x gene matrix with irrelevant voxels filtered out
    sizeGrids=struct('E11pt5',[70,75,40],'E13pt5',[89,109,69],'E15pt5',[94,132,65],'E18pt5',[67,43,40],'P4',[77,43,50],...
        'P14',[68,40,50],'P28',[73,41,53]);
    timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28'};
    timePointIndex=find(cellfun(@(c)strcmp(timePointNow,c),timePoints)); %match index to the chosen timepoint
    resolutionGrid=struct('E11pt5',80,'E13pt5',100,'E15pt5',120,'E18pt5',140,'P4',160,...
        'P14',200,'P28',200);
    %% load matlab variables
    filename=strcat('energyGrids_',timePoints{timePointIndex},'.mat');
    str=fullfile(varDir,filename);
    load(str)
    load('annotationGrids.mat')
    load('spinalCord_ID.mat')
    load('brainDivision.mat')
    %% Create the matrix
    % filters off spinal cord voxels
    isSpinalCord=ismember(annotationGrids{timePointIndex},spinalCord_ID);
    isAnno=annotationGrids{timePointIndex}>0;

    if strcmp(thisBrainDiv,'all')
        isIncluded=or(or(ismember(annotationGrids{timePointIndex},brainDivision.forebrain.ID),...
                          ismember(annotationGrids{timePointIndex},brainDivision.midbrain.ID)),...
                          ismember(annotationGrids{timePointIndex},brainDivision.hindbrain.ID));
    elseif strcmp(thisBrainDiv,'forebrain')
      isIncluded=ismember(annotationGrids{timePointIndex},brainDivision.forebrain.ID);
    elseif strcmp(thisBrainDiv,'midbrain')
      isIncluded=ismember(annotationGrids{timePointIndex},brainDivision.midbrain.ID);
    elseif strcmp(thisBrainDiv,'hindbrain')
      isIncluded=ismember(annotationGrids{timePointIndex},brainDivision.hindrain.ID);
    else
      error('Invalid brain division input')
    end
    % make voxel x gene matrix
    voxGeneMat=zeros(nnz(isAnno & ~isSpinalCord & isIncluded),length(energyGrids));

    h = waitbar(0,'Computing voxel x gene expression matrix...');
    steps=length(energyGrids);
    for j=1:size(voxGeneMat,2) % for each gene
        energyGridsNow=energyGrids{j};
        energyGridsNow=energyGridsNow(isAnno & ~isSpinalCord & isIncluded);
        for k=1:size(voxGeneMat,1) % for each voxel
            if energyGridsNow(k)<0
               voxGeneMat(k,j)=NaN;
            else
                voxGeneMat(k,j)=energyGridsNow(k);
            end
        end
        waitbar(j/steps)
    end
    close(h)

    clear energyGrids
    %% only keep good voxels
    isGoodVoxel=(sum(isnan(voxGeneMat),2) < whatVoxelThreshold*size(voxGeneMat,2));
    voxGeneMat=voxGeneMat(isGoodVoxel,:);

    %% normalize matrix
    voxGeneMat=BF_NormalizeMatrix(voxGeneMat,whatNorm); % 'scaledSigmoid' used in Monash analysis

    % number of data used in analysis
    if isnumeric(whatNumData)
        numData=whatNumData; % 1000 used in Monash analysis
        % Check against error
        if numData>size(voxGeneMat,1)
            error('number of data analyzed cannot be larger than number of available voxels')
        end
    elseif strcmp(whatNumData,'all')
        numData=size(voxGeneMat,1);
    else
        error('Invalid numData input')
    end
    %% create coordinates and compute distance matrix
    % get all coordinates
    [a,b,c]=ind2sub(sizeGrids.(timePoints{timePointIndex}),find(isAnno & ~isSpinalCord & isIncluded));
    coOrds=horzcat(a,b,c);
    % only keep good voxels
    coOrds=coOrds(isGoodVoxel,:);
    % Create distance matrix from only voxels selected for gene expression matrix
    [dataIndSelect,~]=datasample([1:size(voxGeneMat,1)],numData,'replace',false);
    distMat=squareform(pdist(coOrds(dataIndSelect,:),'euclidean')*resolutionGrid.(timePoints{timePointIndex}));
% end
