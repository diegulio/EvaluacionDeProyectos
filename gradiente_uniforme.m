function f = gradiente_uniforme(a,n,i,g)
%checkeada
f = [(a+g/i)*((1-(1+i)^(-n))/i) - n*g/(i*(1+i)^n)];

end