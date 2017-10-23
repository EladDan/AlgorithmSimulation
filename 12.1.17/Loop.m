ConOld = Chla;

% measure red Abs
rAbs = 5 - rPBR; %%%

% measure blue Abs
bAbs = 5 - bPBR; %%%

% Con calc
sumeps_ = (epsa + epsb * Chlb_ + epsc * Car_) * Kd * DW_ ;
Chla = (abs / sumeps_ / width)^0.5;

Car_ = ((bAbs / rAbs) * (rKd / bKd) * (rEpsa + rEpsb * Chlb_) - (bEpsa + bEpsb * Chlb_)) / (bEpsc - (bAbs / rAbs) * (rKd / bKd) * rEpsc);

DW_ = rAbs / (rKd * Chla^2 * width * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_));

rKd = rAbs / (Chla^2 * (rEpsa + rEpsb * Chlb_ + rEpsc * Car_) * width * DW_);
bKd = bAbs / (Chla^2 * (bEpsa + bEpsb * Chlb_ + bEpsc * Car_) * width * DW_);

% Update pigments
Chlb = Chla * Chlb_;
Car = Chla * Car_;
DW = Chla * DW_;
