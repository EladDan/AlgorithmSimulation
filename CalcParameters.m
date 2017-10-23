function [rCon2, bCon2, Chlb_, Car_, DW_] = CalcParameters(rAbs2, bAbs2, Chlb_, Car_, DW_, rKd, bKd, Params)

% Calc rCon2
rCon2 = ConCalc(rAbs2, 'R', Chlb_, Car_, DW_, rKd, bKd, Params);
Chla = rCon2;

% Calculate DW_ from RED parameters ONLY; independent of Car_
DW_ = rAbs2 / (rKd * Chla^2 * Params.width * (Params.rEpsa + Params.rEpsb * Chlb_));

% update chlb, car and DW
[Chlb, Car, DW] = UpdatePigments(Chla, Chlb_, Car_, DW_); % !!! ED: this function output has no use !!!

% Calc bCon2
bCon2 = ConCalc(bAbs2, 'B', Chlb_, Car_, DW_, rKd, bKd, Params);

% Calculate Car_ from ratio b/rAbs2 and r/bKd
b_rAbs = bAbs2 / rAbs2;
Car_ = (b_rAbs * (rKd / bKd) * (Params.rEpsa + Params.rEpsb * Chlb_) - (Params.bEpsa + Params.bEpsb * Chlb_)) / ...
    (Params.bEpsc - b_rAbs * (rKd / bKd) * Params.rEpsc);

% Calculate DW_ from blue abs, bKd and new Car_; for checking purposes
DW_ = bAbs2 / (bKd * Chla^2 * Params.width * (Params.bEpsa + Params.bEpsb * Chlb_ + Params.bEpsc * Car_));

[Chlb, Car, DW] = UpdatePigments(Chla, Chlb_, Car_, DW_);

Chlb_ = Chlb / Chla; % Methodic update of Chlb_
end