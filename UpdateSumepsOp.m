function [rSumeps_, rOp_, bSumeps_, bOp_] = UpdateSumepsOp(Chlb_, Car_, DW_, rKd, bKd, Params)
rSumeps_ = Params.rEpsa + Params.rEpsb * Chlb_;                          % independent of Chla and Car_
rOp_ = rKd * DW_;                                                        % independent of Chla and width
bSumeps_ = Params.bEpsa + Params.bEpsb * Chlb_ + Params.bEpsc * Car_;    % independent of Chla
bOp_ = bKd * DW_;                                                        % independent of Chla and width
end