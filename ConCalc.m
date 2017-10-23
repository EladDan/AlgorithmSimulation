function [con] = ConCalc(Abs, color, Chlb_, Car_, DW_, rKd, bKd, Params)

[rSumeps_, rOp_, bSumeps_, bOp_] = UpdateSumepsOp(Chlb_, Car_, DW_, rKd, bKd, Params);

if (color == 'R')
    sumeps_ = rSumeps_;
    Op_ = rOp_;
else if color == 'B'
        sumeps_ = bSumeps_;
        Op_ = bOp_;
    end
end
con = (Abs / (sumeps_ * Op_ * Params.width))^0.5;
end