function A = Anualidad_vencida(P,n,i)
% check
A = P*i/(1-(1+i)^(-n));

end