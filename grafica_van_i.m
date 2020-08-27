function g = grafica_van_i(flujos,i)
%check
van = zeros(length(i))
for k = 1:length(i)
    van(k) = calcular_van(flujos,i(k)) 
end
plot(i,van)

end