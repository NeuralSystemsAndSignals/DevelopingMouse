function makeEnergyGrid_enrichedGenes(thisCellType)
  timePoints={'E11pt5','E13pt5','E15pt5','E18pt5','P4','P14','P28'};
  for i=1:length(timePoints)
    readGridData_enrichedGenes(timePoints{i},thisCellType);
  end
end
