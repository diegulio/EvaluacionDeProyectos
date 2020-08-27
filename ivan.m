function iv = ivan(flujos,i)
%check
van = calcular_van(flujos,i)
iv = -van/flujos(1);
end