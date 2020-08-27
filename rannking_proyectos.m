%% Recordar primero descartar los excluyentes segun su VAN

% DATOS INICIALES
Nombres = {'A';'B';'C';'D'};
I = [15000;25000;30000;40000];
VAN = [5000;10000;8000;11000];

presupuesto = 100000
%% Creamos la tabla
T = table(Nombres, I, VAN)
%% Calculamos IVAN
T.IVAN = T.VAN./T.I;
%% Ordenamos de menor a mayor
T = sortrows(T,{'IVAN', 'VAN'},'descend')
%% Ahora vamos escogiendo proyectos sin que se agote el presupuesto
proyectos_escogidos = []
numrows = height(T)
for i = 1:numrows
    if presupuesto >= T{i,2}
        proyectos_escogidos = [proyectos_escogidos T{i,1}]
        presupuesto = presupuesto - T{i,2}
    end
end
 

     
    


