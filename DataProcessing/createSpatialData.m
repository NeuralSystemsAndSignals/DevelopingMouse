function createSpatialData(numData,withDirection)
  % create distance and correlation distances, and angles that voxel pairs
  % make with the axes for different brain divisions, cell types, using good gene subset, with or without
  % directions
  brainDivisions=GiveMeParameter('brainDivisions');
  scaledDistance=GiveMeParameter('scaledDistance');
  cellTypes=GiveMeParameter('cellTypes');
  % create distances (unscaled) and correlation from good genes
  for j=1:length(brainDivisions)
    for k=1:length(scaledDistance)
      for m=1:length(cellTypes)
      [~,~,~,~,~]=makeSpatialData(numData,true,brainDivisions{j},...
                                  scaledDistance{k},cellTypes{m},withDirection);
      end
    end
  end
end