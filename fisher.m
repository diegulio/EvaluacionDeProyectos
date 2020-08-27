function f = fisher(x)
%check
flujos_A = [-20000,11800,13924]
flujos_B = [-30000,6900,31740]

f = calcular_van(flujos_A,x) - calcular_van(flujos_B,x)

end