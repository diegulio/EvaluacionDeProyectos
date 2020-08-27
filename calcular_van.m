function van = calcular_van(flujos,i)
%check
van = 0;
for f = 1:length(flujos)
    van = van + flujos(f)/(1+i)^(f-1);
end
 
end