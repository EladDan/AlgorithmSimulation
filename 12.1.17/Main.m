clear;
run ('Variables');
initRedAbs = 9;
initBlueAbs = 9;

%% Setup
Chla = ChlaLab;
% red Abs
rAbs2 = initRedAbs - rPBR;
rKd = rAbs2 / ( Chla^2 * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * width * DW_);
% blue Abs
bAbs2 = initBlueAbs - bPBR;
bKd = bAbs2 / (Chla^2 * (bEpsa + bEpsb * Chlb_ + bEpsc * Car_) * width * DW_);

Chlb = ChlbLab;
Car = CarLab;
DW = DWLab;
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
