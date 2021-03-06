function [fitting_stat_all,constantOut] = getFitting(xData,yData,whatConstantOut)
% xData and yData are cells each containing distances and correlation coefficient of all time points
% dataProcessing: 'original' or 'binned numThresholds=xx'
timePoints = GiveMeParameter('timePoints');
constantTypes = GiveMeParameter('constantTypes');
% Initialize:
fitting_stat_all = struct();
constantOut = zeros(length(timePoints),1);
for i = 1:length(timePoints)
    [fitting_stat_all.(timePoints{i}).adjRSquare, ...
    fitting_stat_all.(timePoints{i}).fitObject,...
    fitting_stat_all.(timePoints{i}).fHandle]=fitting_stat({'exp'}, ...
                                            xData{i}, yData{i}); % only keep exp for the time being
    % fitting_stat_all.(timePoints{i}).fHandle]=fitting_stat({'linear','exp_1_0','exp1','exp'}, ...
    %                                           xData{i}, yData{i});
    % collect the constant
    switch whatConstantOut
    case constantTypes{1} % decayConstant
        constantOut(i) = fitting_stat_all.(timePoints{i}).fitObject.exp.n;
    case constantTypes{2} % strength
        constantOut(i) = fitting_stat_all.(timePoints{i}).fitObject.exp.A;
    case constantTypes{3} % offset
        constantOut(i) = fitting_stat_all.(timePoints{i}).fitObject.exp.B;
    end
end

end
