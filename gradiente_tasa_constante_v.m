function p = gradiente_tasa_constante_v(v1,n,i,g)
%checkeada
if i ~= g
    p = [(v1/(i-g))*(1-((1+g)/(1+i))^n)];
else
    p = n*v1/(1+i);
end
    


end