function [rPARimax, bPARimax] = CalcPARimax(Params)
% Calculate total incident light [uE/m2/s] to supply to the algae (NET)
rPARimax = rSpecLSupply * Chla^3 / ( 1 - exp(-2.30285 * rSAC * Chla^2 * Params.width));
% bPARimax calculated from rPARimax with appropriate weighting factors (epsilons, Kd, FrR_target)
bPARimax = rPARimax * (bSAC / rSAC) * ((1 - FrR_target) / FrR_target) * ((1 - exp(-2.30285 * rSAC * pow(Chla, 2) * width)) / (1 - exp(-2.30285 * bSAC * pow(Chla, 2) * width)));
end