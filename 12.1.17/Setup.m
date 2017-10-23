Chla = ChlaLab;
% measure red Abs
rAbs2 = 5 - rPBR; %%%
rKd = rAbs2 / ( ChlaLab^2 * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * width * DW_);
rSumeps = (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * rKd * DW_ * Chla;

% measure blue Abs
bAbs2 = 5 - bPBR; %%%
bKd = bAbs2 / (ChlaLab^2 * (bEpsa + bEpsb * Chlb_ + bEpsc * Car_) * width * DW_);
bSumeps = (bEpsa + bEpsb * Chlb_ + bEpsc * Car_) * bKd * DW_ * Chla;

Chla = ChlaLab;
Chlb = ChlbLab;
Car = CarLab;
DW = DWLab;