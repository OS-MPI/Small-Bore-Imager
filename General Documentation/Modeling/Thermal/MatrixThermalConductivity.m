function [KComp_Kanari] = MatrixThermalConductivity(KMatrix,KFill,VolFrac,Spher)
if VolFrac>1; VolFrac = VolFrac/100;end
F = @(KComp) 1-VolFrac-((KComp-KFill)./(KMatrix-KFill).*(KMatrix./KComp).^(1/(1+Spher)));
F_Brugg = @(KComp) VolFrac.*((KFill-KComp)/(KFill+2*KComp))+(1-VolFrac)...
    .*((KMatrix-KComp)./(KMatrix+2*KComp));
KComp_Kanari = mybisect(F,KMatrix,KFill,10)
KComp_Brugg = mybisect(F_Brugg,KMatrix,KFill,10)
end

