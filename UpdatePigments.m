function [Chlb, Car, DW] = UpdatePigments(chla, Chlb_, Car_, DW_)
Chlb = chla * Chlb_;
Car = chla * Car_;
DW = chla * DW_;
end