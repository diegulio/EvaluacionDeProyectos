function g = graficar_van_a_b(flujos_A,flujos_B)
%check
i = [0,0.05,.1,.15,.2,.3,.4,.5]
van_A = zeros(length(i))
van_B = zeros(length(i))
for k = 1:length(i)
    van_A(k) = calcular_van(flujos_A,i(k))
    van_B(k) = calcular_van(flujos_B,i(k))
end
plot(i,van_A,i,van_B)
legend(["VAN A","VAN B"])



end