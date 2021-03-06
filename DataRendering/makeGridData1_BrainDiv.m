% user input the value of i (1=E11.5; 2=E13.5; 3=E15.5; 4=E18.5; 5=P4;
% 6=P14; 7=P28)
i=1;
% user input: number of data used in analysis
numData=587;
% user input: current time point
timePointNow={'E11pt5'};

% this script creates a voxel x gene matrix with irrelevant voxels filtered out
sizeGrids=struct('E11pt5',[70,75,40],'E13pt5',[89,109,69],'E15pt5',[94,132,65],'E18pt5',[67,43,40],'P4',[77,43,50],...
    'P14',[68,40,50],'P28',[73,41,53]);
timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28'};

resolutionGrid=struct('E11pt5',80,'E13pt5',100,'E15pt5',120,'E18pt5',140,'P4',160,...
    'P14',200,'P28',200);
%% load variables
% load('timePointInfo.mat')
% load('geneIDInfo.mat')
load('annotationGrids.mat')
load('spinalCordID.mat')
load('foreBrain_ID.mat')
load('midBrain_ID.mat')
load('hindBrain_ID.mat')
brainDivision={'foreBrain','midBrain','hindBrain'};
brainDivisionID=struct('foreBrain',foreBrain_ID,'midBrain',midBrain_ID,'hindBrain',hindBrain_ID);
%%
tic

% loop through the brain divisions
for d=1:3
    % load gene expression energy grid
    str=strcat('energyGrids_',timePoints{i},'.mat');
    load(str)
    % filters
    isSpinalCord=ismember(annotationGrids{i},spinalCord_ID);
    isAnno=annotationGrids{i}>0;
    isBrainDivision=ismember(annotationGrids{i},brainDivisionID.(brainDivision{d}));
    % create coordinates
    [a,b,c]=ind2sub(sizeGrids.(timePoints{i}),find(isAnno & ~isSpinalCord & isBrainDivision));
    coOrds=horzcat(a,b,c);

    % make voxel x gene matrix

    voxGeneMat=zeros(nnz(isAnno & ~isSpinalCord & isBrainDivision),length(energyGrids));

    h = waitbar(0,'Computing voxel x gene expression matrix...');
    steps=length(energyGrids);
    for j=1:size(voxGeneMat,2) % for each gene
        energyGridsNow=energyGrids{j};
        energyGridsNow=energyGridsNow(isAnno & ~isSpinalCord & isBrainDivision);
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

    
    %% only keep good voxels
    isGoodVoxel=(sum(isnan(voxGeneMat),2) < 0.3*size(voxGeneMat,2));

    voxGeneMat=voxGeneMat(isGoodVoxel,:);
    coOrds=coOrds(isGoodVoxel,:);
    % normalize
    voxGeneMat=BF_NormalizeMatrix(voxGeneMat,'scaledSigmoid');

    %%
    if numData>size(voxGeneMat,1)
        error('number of data analyzed cannot be larger than number of available voxels')
    end

    [dataIndSelect,~]=datasample([1:size(voxGeneMat,1)],numData,'replace',false);
    geneCorr=corrcoef((voxGeneMat(dataIndSelect,:))','rows','pairwise');


    distMat=squareform(pdist(coOrds(dataIndSelect,:),'euclidean')*resolutionGrid.(timePoints{i}));

    %%
    % extract the correlation coefficients
    corrCoeff=geneCorr(find(triu(ones(size(geneCorr)),1)));

    distance=distMat(find(triu(ones(size(distMat)),1)));

    %% plot coexpression against distance
    f=figure('color','w');
    gcf;
    scatter(distance,corrCoeff,'.')
    xlabel('Separation Distance (um)','FontSize',16)
    ylabel('Gene Coexpression (Pearson correlation coefficient)','FontSize',13)
    str = sprintf('Developing Mouse %s %s',timePoints{i},brainDivision{d});
    title(str,'Fontsize',19);
    f=figureFullScreen(f,true); 
    %% fitting

    adjRSquare=struct();
    fitObject=struct();
    fitMethods={'linear','exp_1_0','exp1','exp'};
    fHandle=struct();
    %%

    for j=1:length(fitMethods)
        [f_handle,Stats,c] = GiveMeFit(distance,corrCoeff,fitMethods{j},true);
        fitObject.(fitMethods{j})=c;
        fHandle.(fitMethods{j})=f_handle;
        adjRSquare.(fitMethods{j})=Stats.adjrsquare;
        confInt.(fitMethods{j})=confint(c,0.95);
        coeffValue.(fitMethods{j})=coeffvalues(c);
    end

    %%
    matAdjRSquare=zeros(length(timePointNow),length(fitMethods)); 
    for k=1:length(timePointNow)
        for j=1:length(fitMethods)
            matAdjRSquare(k,j)=adjRSquare.(fitMethods{j})(k);
        end
    end

    %%
    % User input; must leave it as empty string ' ' if 'scaledSigmoid'; options:' ', 'zscore','log2';
    whatNorm=' ';
    % User input: which field from DevMouseGeneExpression you want to use: 'norm' or normStructure';
    % 'norm' is normalized across genes using a method specified in file name,
    % or otherwise ScaledSigmoid; if normStructure is chosen, it doesn't matter
    % what "whatNorm" is as long as the DevMouseGeneExpression.mat is up to
    % date (i.e. contains the field "normStructure") [at the moment, only whatNorm='log2' is up to date]
    % User input: Choose whether to plot the graph, which takes much longer running time) (plot=1;no plot=0)
    plotGraph=0;


    g=figure('color','w');
    xAxis=[1:length(timePointNow)];
    %BarChart=bar(matAdjRSquare,'grouped');
    BarChart=bar(vertcat(matAdjRSquare,nan(size(matAdjRSquare))));

    BarChat.BarWidth = 0.4;
    ax = gca;

    ax.XTick=[1];
    ax.XTickLabel=timePointNow;

    xt=[1];

    if whatNorm==' ';
        str=sprintf('Degree of freedom adjusted R-square, scaled sigmoid, %s %s',timePoints{i},brainDivision{d});
    else
        str=sprintf('Degree of freedom adjusted R-square, %s, %s %s',whatNorm,timePoints{i},brainDivision{d});
    end
    Title=title(str);
    set(Title, 'FontSize', 16)
    grid on
    grid minor

    L = cell(1,4);
    L{1}='linear';
    L{2}='1 parameter exponential';
    L{3}='2 parameter exponential';
    L{4}='3 parameter exponential';
    legend(BarChart,L,'Location','northeast')
    hold on

    g=figureFullScreen(g,true); 

    %% plot exponential fit
    w=figure('color','w');
    gcf;
    scatter(distance,corrCoeff,'.')
    hold on
    xData=linspace(min(distance),max(distance),0.1*length(distance));
    p=plot(xData,fHandle.exp(xData),'-x'); 
    set(p,'Color','k')
    legend(p,'Exponential fit')
    xlabel('Separation Distance (um)','FontSize',16)
    ylabel('Gene Coexpression (Pearson correlation coefficient)','FontSize',13)
    str = sprintf('Developing Mouse %s %s',timePoints{i},brainDivision{d});
    title(str,'Fontsize',19);
    w=figureFullScreen(w,true); 
    
    clear energyGrids

    %% save variables and figures
    cd '/projects/kg98/Gladys/Output/makeGridData1_BrainDiv_var'
    str=strcat('makeGridData1_',timePoints{i},brainDivision{d},'.mat');
    save(str,'-v7.3')
    cd '/projects/kg98/Gladys/Output/makeGridData1_BrainDiv_fig'
    str=strcat('GeneCoexpress_',timePoints{i},brainDivision{d},'_random1000_annoOnly_30%filter_noSC_massiveVer.jpg');
    saveas(f,str)
    str=strcat('R-square_exp_voxel_',timePoints{i},brainDivision{d},'_random1000_annoOnly_30%filter_noSC_massiveVer.jpg');
    saveas(g,str)
    str=strcat('expoFit_voxel_',timePoints{i},brainDivision{d},'_random1000_annoOnly_30%filter_noSC_massiveVer.jpg');
    saveas(w,str)
end

%%
toc
