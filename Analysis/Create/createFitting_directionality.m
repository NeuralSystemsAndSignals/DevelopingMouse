timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28'};
load('directionalityData.mat')
filestr='spatialData_NumData_1000';
load(strcat(filestr,'.mat'));
file_parts=strsplit(filestr,'_');
NumData=file_parts{3};
% directions={'Coronal','Axial','Sagittal'};
% initialize
distances_all_scaled=cell(length(timePoints),1);
% distances_direction=struct();
% corrCoeff_direction=struct();
% distances_direction_scaled=struct();

% extract distances and correlation coefficients
for i=1:length(timePoints)
  % calculate scaled distance
  distances_all_scaled{i}=distances_all{i}/max(distances_all{i});
end
% sagittal info fitting
[fitting_stat_all, decayConstant, maxDistance]=getFitting(distances_sagittal,corrCoeff_sagittal);
  str=fullfile('Matlab_variables',strcat('fitting_NumData_',NumData,'_sagittal','.mat'));
  save(str,'fitting_stat_all','decayConstant','maxDistance');
% axial info fitting
[fitting_stat_all, decayConstant, maxDistance]=getFitting(distances_axial,corrCoeff_axial);
  str=fullfile('Matlab_variables',strcat('fitting_NumData_',NumData,'_axial','.mat'));
  save(str,'fitting_stat_all','decayConstant','maxDistance');
% coronal info fitting
[fitting_stat_all, decayConstant, maxDistance]=getFitting(distances_coronal,corrCoeff_coronal);
  str=fullfile('Matlab_variables',strcat('fitting_NumData_',NumData,'_coronal','.mat'));
  save(str,'fitting_stat_all','decayConstant','maxDistance');
% for j=1:length(directions)
%   distances_direction.(directions{j})=cell(length(timePoints),1);
%   corrCoeff_direction.(directions{j})=cell(length(timePoints),1);
%   distances_direction_scaled.(directions{j})=cell(length(timePoints),1);
%   for i=1:length(timePoints) % for each time point extract the pairs in the direction
%     distances_direction.(directions{j}){i}=distances_all{i}(strcat('is',directions{j}));
%     corrCoeff_direction.(directions{j}){i}=corrCoeff_all{i}(strcat('is',directions{j}));
%     distances_direction_scaled.(directions{j}){i}=distances_all_scaled{i}(strcat('is',directions{j}));
%   end
% end
%
% % create fitting
% for j=1:length(directions) % for each direction
%   % not scaled
%   [fitting_stat_all, decayConstant, maxDistance]=getFitting(distances_direction.(directions{j}),...
%                                                             corrCoeff_direction.(directions{j}));
%   str=fullfile('Matlab_variables',strcat('fitting_NumData_',NumData,'_',directions{j},'.mat'));
%   save(str,'fitting_stat_all','decayConstant','maxDistance');
%   % scaled distance
%   [fitting_stat_all, decayConstant, ~]=getFitting(distances_direction_scaled.(directions{j}),corrCoeff_direction.(directions{j}));
%   str=fullfile('Matlab_variables',strcat('fitting_NumData_',NumData,'_',directions{j},'_scaled','.mat'));
%   save(str,'fitting_stat_all','decayConstant','maxDistance'); % still save the original max distance
% end
