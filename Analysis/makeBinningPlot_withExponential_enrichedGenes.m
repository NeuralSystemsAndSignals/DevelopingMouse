function makeBinningPlot_withExponential_enrichedGenes(numData,numThresholds,...
                                                      thisBrainDiv,thisCellType,...
                                                      scaledDistance)
% only when brain subdivisions are considered
timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28'};
if strcmp(thisBrainDiv,'wholeBrain')
  if scaledDistance
    filestr1=strcat('spatialData_NumData_',num2str(numData),'_',thisCellType,'_scaled','.mat');

    filestr2=strcat('fitting_NumData_',num2str(numData),...
                    '_binnedData_numThresholds_',num2str(numThresholds),...
                    '_',thisCellType,'_scaled','.mat');
  else
  filestr1=strcat('spatialData_NumData_',num2str(numData),'_',thisCellType,'.mat');

  filestr2=strcat('fitting_NumData_',num2str(numData),...
                  '_binnedData_numThresholds_',num2str(numThresholds),'_',thisCellType,'.mat');
  end
else
  if scaledDistance
    filestr1=strcat('spatialData_NumData_',num2str(numData),'_',thisBrainDiv,...
                    '_',thisCellType,...
                    '_scaled','.mat');

    filestr2=strcat('fitting_NumData_',num2str(numData),...
                    '_binnedData_numThresholds_',num2str(numThresholds),'_',...
                    thisBrainDiv,'_',thisCellType,'_scaled','.mat');
  else
  filestr1=strcat('spatialData_NumData_',num2str(numData),'_',thisBrainDiv,'_',...
                  thisCellType,'.mat');

  filestr2=strcat('fitting_NumData_',num2str(numData),...
                  '_binnedData_numThresholds_',num2str(numThresholds),'_',...
                  thisBrainDiv,'_',thisCellType,'.mat');
  end
end

load(filestr1);
load(filestr2);
cmapOut = BF_getcmap('dark2',7,0,0);
if scaledDistance
  xLabeling='Separation Distance/maxDistance';
else
  xLabeling='Separation Distance (um)';
end
for i=1:length(timePoints)
  f = figure('color','w','Position',get(0,'Screensize')); box('on');
  [~,~] = BF_PlotQuantiles_diffColor(distances_all{i},corrCoeff_all{i},numData,...
                                    numThresholds,0,cmapOut,false,timePoints{i},...
                                    thisBrainDiv,'allDirections');

  [~,~] = plotFitting_singleTimePoint(distances_all,'exp',fitting_stat_all, 'voxel', ...
                                      xLabeling, 1, ...
                                      sprintf('binned numThresholds=%d',numThresholds),...
                                      'allDirections', timePoints{i},false, ...
                                      thisBrainDiv,thisCellType)
  if strcmp(thisBrainDiv,'wholeBrain')
    if scaledDistance
      str=fullfile('Outs',strcat('binning_plot_withExponential_',thisCellType,'_scaled'),...
                  strcat('voxel_binning_withExponential_',thisCellType,...
                        '_scaled_',timePoints{i},'.jpeg'));
    else
      str=fullfile('Outs',strcat('binning_plot_withExponential_',thisCellType),...
                  strcat('voxel_binning_withExponential_',thisCellType,...
                        '_',timePoints{i},'.jpeg'));
    end
  else
    if scaledDistance
        str=fullfile('Outs',strcat('binning_plot_withExponential','_',thisBrainDiv,...
                                  '_',thisCellType,'_scaled'),...
                            strcat('voxel_binning_withExponential','_',thisBrainDiv,...
                                  '_',thisCellType,'_scaled_',timePoints{i},'.jpeg'));
    else
        str=fullfile('Outs',strcat('binning_plot_withExponential',...
                                  '_',thisBrainDiv,'_',thisCellType),...
                            strcat('voxel_binning_withExponential','_',thisBrainDiv,...
                                    '_',thisCellType,'_',timePoints{i},'.jpeg'));
    end
  end
  F=getframe(f);
  imwrite(F.cdata, str, 'jpeg');
end
end
% str = fullfile('Outs','binning_plot','voxel_binning.jpeg');
% imwrite(F.cdata, str, 'jpeg');