clear;

[Params, Vars] = GetParameters();

%% Setup
% measure local red light
rLi_ref = Params.rLi_0;
rLo_ref = Params.rLo_0 * 0.33; % take less light than calibration to indicate algae in the PBR
% convert to global in PAR
rPARi_ref = Params.rHz2PARi * rLi_ref;
rPARo_ref = Params.rHz2PARo * rLo_ref;
% calaulate red absorption
rAbs2 = -log10(rPARo_ref / rPARi_ref) - Params.rPBR;

% measure local blue light
bLi_ref = Params.rLi_0;
bLo_ref = Params.rLo_0 * 0.33;
% convert to global in PAR
bPARi_ref = Params.bHz2PARi * bLi_ref;
bPARo_ref = Params.bHz2PARo * bLo_ref;
% calaulate blue absorption
bAbs2 = -log10(bPARo_ref / bPARi_ref) - Params.bPBR;

% Calculate ratio bAbs/rAbs
b_rAbs = bAbs2 / rAbs2; % ED: !!! redundant (calculated again at CalcParameters())

% UpdateSumepsOp()
[rSumeps_, rOp_, bSumeps_, bOp_] = UpdateSumepsOp(Vars.Chlb_, Vars.Car_, Vars.DW_, Vars.rKd, Vars.bKd, Params);

% CalcParameters()
[rCon2, bCon2, Vars.Chlb_, Vars.Car_, Vars.DW_] = CalcParameters(rAbs2, bAbs2, Vars.Chlb_,Vars.Car_, Vars.DW_, Vars.rKd, Vars.bKd, Params);

% ED: continue here

% CalcPARimax()
% [] = CalcPARimax();

% Report
iter = 1;
Data{iter,1} = iter;
Data{iter,2} = rAbs2;
Data{iter,3} = bAbs2;
Data{iter,4} = Chla;
Data{iter,5} = Chlb;
Data{iter,6} = Car;
Data{iter,7} = DW;

%% Loop
for iter = 2:100
    % Update Abs
    %     initRedAbs = initRedAbs * 1.005;
    initBlueAbs = initBlueAbs * 1.005;
    initRedAbs = initRedAbs * 0.995;
    %     initBlueAbs = initBlueAbs * 0.995;
    % red Abs
    rAbs = initRedAbs - rPBR;
    % blue Abs
    bAbs = initBlueAbs - bPBR;
    % Con calc
    sumeps_ = (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * rKd * DW_ ;
    Chla = (rAbs / sumeps_ / width)^0.5;
    % Update ratios and Kd
    Car_ = ((bAbs / rAbs) * (rKd / bKd) * (rEpsa + rEpsb * Chlb_) - (bEpsa + bEpsb * Chlb_)) / (bEpsc - (bAbs / rAbs) * (rKd / bKd) * rEpsc);
    DW_ = rAbs / (rKd * Chla^2 * width * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_));
    rKd = rAbs / (Chla^2 * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * width * DW_);
    bKd = bAbs / (Chla^2 * (bEpsa + bEpsb * Chlb_ + bEpsc * Car_) * width * DW_);
    % Update pigments
    Chlb = Chla * Chlb_;
    Car = Chla * Car_;
    DW = Chla * DW_;
    % Report
    Data{iter,1} = iter;
    Data{iter,2} = rAbs;
    Data{iter,3} = bAbs;
    Data{iter,4} = Chla;
    Data{iter,5} = Chlb;
    Data{iter,6} = Car;
    Data{iter,7} = DW;
    
end
