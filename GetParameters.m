function [Params, Vars] = GetParameters()
%% Variable and parameters
Params.ConMax = 20.0;
Params.width = 4.0;
rPARMax = 1978;
bPARMax = 719;

BgLi = 0.099;
BgLo = 0.167;

Params.rLi_0 = 14576 - BgLi;
Params.rLo_0 = 3028 - BgLo;
Params.bLi_0 = 7462 - BgLi;
Params.bLo_0 = 683 - BgLo;

Params.rHz2PARi = 0.05311;
Params.rHz2PARo = 0.01488;
Params.bHz2PARi = 0.02818;
Params.bHz2PARo = 0.009338;

Params.rPBR = -log10(Params.rLo_0*Params.rHz2PARo / Params.rLi_0 / Params.rHz2PARi);
Params.bPBR = -log10(Params.bLo_0*Params.bHz2PARo / Params.bLi_0 / Params.bHz2PARi);

rTransPBR = 10^(-0.333 * Params.rPBR);
bTransPBR = 10^(-0.333 * Params.bPBR); 

Params.rEpsa = 0.07523;
Params.rEpsb = 0.07815;
Params.rEpsc = 0.0;
Vars.rKd = 0.001493;

Params.bEpsa = 0.098724;
Params.bEpsb = 0.195471;
Params.bEpsc = 0.523529;
Vars.bKd = 0.0005846;

% taken as mean of observations (calculated in Rstudio)
Vars.Chlb_ = 0.3981436; 
Vars.Car_ = 0.6999495;
Vars.DW_ = 52.06334;

rSAC = (Params.rEpsa + Params.rEpsb * Vars.Chlb_ + Params.rEpsc * Vars.Car_) * Vars.rKd * Vars.DW_;
bSAC = (Params.bEpsa + Params.bEpsb * Vars.Chlb_ + Params.bEpsc * Vars.Car_) * Vars.bKd * Vars.DW_;

rSpecLSupply = rPARMax * rTransPBR * ( 1 - exp(-2.30285 * rSAC * Params.ConMax^2 * Params.width)) / Params.ConMax^3;
bSpecLSupply = bPARMax * bTransPBR * ( 1 - exp(-2.30285 * bSAC * Params.ConMax^2 * Params.width)) / Params.ConMax^3;



end








