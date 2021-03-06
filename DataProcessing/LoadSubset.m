function [voxelGeneExpression,coOrds,voxInfo,geneInfo] = LoadSubset(params,timePointNow)
% Load voxel-wise gene expression data (and coordinates) according to the
% criteria specified in params.
%-------------------------------------------------------------------------------

if nargin < 1
    params = GiveMeDefaultParams();
end

fprintf(1,'Loading voxelwise gene-expression data for %s\n',timePointNow);
fprintf(1,'(%s voxels, %s genes)\n',params.thisBrainDiv,params.thisCellType);

% Get all data for this time point:
theFile = GiveMeFileName(timePointNow);
load(theFile,'coOrds','voxGeneMat','voxLabelTable','geneInfo');

% Take a voxel subset:

switch params.thisBrainDiv
case 'all'
    numVoxels = height(voxLabelTable);
    keepMeVoxel = true(numVoxels,1);
case {'brain','wholeBrain'}
    if params.doSubsample
        keepMeVoxel = voxLabelTable.sampleBrain;
    else
        keepMeVoxel = voxLabelTable.isBrain;
    end
case 'fmhSample'
    keepMeVoxel = (voxLabelTable.sampleForebrain|voxLabelTable.sampleMidbrain|voxLabelTable.sampleHindbrain);
case 'forebrain'
    if params.doSubsample
        keepMeVoxel = voxLabelTable.sampleForebrain;
    else
        keepMeVoxel = voxLabelTable.isForebrain;
    end
case 'midbrain'
    if params.doSubsample
        keepMeVoxel = voxLabelTable.sampleMidbrain;
    else
        keepMeVoxel = voxLabelTable.isMidbrain;
    end
case 'hindbrain'
    if params.doSubsample
        keepMeVoxel = voxLabelTable.sampleHindbrain;
    else
        keepMeVoxel = voxLabelTable.isHindbrain;
    end
case 'Dpall'
    if params.doSubsample
        keepMeVoxel = voxLabelTable.sampleDpall;
    else
        keepMeVoxel = voxLabelTable.isDpall;
    end
otherwise
    error('Unknown region, ''%s''',params.thisBrainDiv);
end

fprintf(1,'Keeping %u %s voxels\n',sum(keepMeVoxel),params.thisBrainDiv);

%-------------------------------------------------------------------------------
% Take a gene subset
switch params.thisCellType
case {'all','allCellTypes'}
    keepMeGene = true(height(geneInfo),1);
case 'neuron'
    keepMeGene = geneInfo.isNeuronEnriched;
case 'astrocyte'
    keepMeGene = geneInfo.isAstrocyteEnriched;
case 'oligodendrocyte'
    keepMeGene = geneInfo.isOligodendrocyteEnriched;
end
fprintf(1,'Keeping %u %s genes\n',sum(keepMeGene),params.thisCellType);

% Check the usePersistentGenes flag:
if params.usePersistentGenes
    keepMeGene = (keepMeGene & geneInfo.isPersistent);
    fprintf(1,'Only keeping genes that are good across all time points\n');
end

%-------------------------------------------------------------------------------
% Simple filtering:
[voxelGeneExpression,coOrds,voxInfo,geneInfo] = ApplySubset(keepMeVoxel,keepMeGene,...
                                    voxGeneMat,coOrds,voxLabelTable,geneInfo);

%-------------------------------------------------------------------------------
% Data-based quality filtering:
%% only keep good voxels
isGoodVoxel = (mean(isnan(voxelGeneExpression),2) < params.whatVoxelThreshold);
fprintf(1,'%u/%u voxels are good\n',sum(isGoodVoxel),length(isGoodVoxel));
% genes that are not nan in at least a reasonable proportion of voxels:
isGoodGene = (mean(isnan(voxelGeneExpression),1) < params.whatGeneThreshold);
fprintf(1,'%u/%u genes are good\n',sum(isGoodGene),length(isGoodGene));

if sum(isGoodVoxel)==0 || sum(isGoodGene)==0
    warning('Not enough good data');
end

% Perform the subsetting:
[voxelGeneExpression,coOrds,voxInfo,geneInfo] = ApplySubset(isGoodVoxel,isGoodGene,...
                                    voxelGeneExpression,coOrds,voxInfo,geneInfo);

%-------------------------------------------------------------------------------
% Additional max-voxel filtering (to test dependence on subsampling)
if ~isempty(params.maxVoxels)
    numVoxels = height(voxInfo);
    if numVoxels > params.maxVoxels
        fprintf(1,'~~~+++^^^Additionally subsampling to %u voxels\n',params.maxVoxels);
        isSampled = randsample(numVoxels,params.maxVoxels);
        isGoodGene = true(height(geneInfo),1);
        [voxelGeneExpression,coOrds,voxInfo,geneInfo] = ApplySubset(isSampled,isGoodGene,...
                                            voxelGeneExpression,coOrds,voxInfo,geneInfo);
    end
end

%-------------------------------------------------------------------------------
%% Normalize the expression data
if ~any(size(voxelGeneExpression)==0)
    fprintf(1,'Normalizing each gene''s expression as ''%s''\n',params.whatNorm);
    voxelGeneExpression = BF_NormalizeMatrix(voxelGeneExpression,params.whatNorm);

    % Checks:
    assert(size(voxelGeneExpression,1)==height(voxInfo))
    assert(size(voxelGeneExpression,2)==height(geneInfo))
    assert(size(coOrds,1)==size(voxelGeneExpression,1))
end

%-------------------------------------------------------------------------------
function [OUTvoxelGeneExpression,OUTcoOrds,OUTvoxInfo,OUTgeneInfo] = ApplySubset(keepRow,keepColumn,...
                                            INvoxelGeneExpression,INcoOrds,INvoxInfo,INgeneInfo)
    OUTvoxelGeneExpression = INvoxelGeneExpression(keepRow,keepColumn);
    OUTcoOrds = INcoOrds(keepRow,:);
    OUTvoxInfo = INvoxInfo(keepRow,:);
    OUTgeneInfo = INgeneInfo(keepColumn,:);
end

end
