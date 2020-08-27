
format long

%% VAN,IVAN,VAUE,IVAUE

%datos
i = 0.15
Flujos_A = [-4000,6000,3000,5000,2000]
Flujos_B = [-3000,4000,3000,6000]

%calculos

n_a = length(Flujos_A)-1
n_b = length(Flujos_B)-1

%Van
VAN_A = calcular_van(Flujos_A,i)
VAN_B = calcular_van(Flujos_B,i)

%Ivan 
IVAN_A = ivan(Flujos_A,i)
IVAN_B = ivan(Flujos_B,i)

%VAUE
VAUE_A = Anualidad_vencida(VAN_A,n_a,i)
VAUE_B = Anualidad_vencida(VAN_B,n_b,i)

%IVAUE
IVAUE_A = VAUE_A/-Flujos_A(1)
IVAUE_B = VAUE_B/-Flujos_B(1)

if VAN_A > VAN_B
    fprintf('No Duplicables y No Repetibles: Gana A con VAN %i \n', VAN_A)
else
    fprintf('No Duplicables y No Repetibles: Gana B con VAN %i \n' , VAN_B)
end

if IVAN_A > IVAN_B
    fprintf('Duplicables y No Repetibles: Gana A con IVAN %i \n', IVAN_A)
else
    fprintf('Duplicables y No Repetibles: Gana B con IVAN %i \n', IVAN_B)
end

if VAUE_A > VAUE_B
    fprintf('No Duplicables y Repetibles: Gana A con VAUE %i \n', VAUE_A)
else
    fprintf('No Duplicables y Repetibles: Gana B con VAUE %i \n', VAUE_B)
end

if IVAUE_A > IVAUE_B
    fprintf('Duplicables y Repetibles: Gana A con IVAUE %i \n', IVAUE_A)
else
    fprintf('Duplicables y Repetibles: Gana B con IVAUE %i  \n', IVAUE_B)
end
%% Solve

x0 = [0.01];
x = fsolve(@prueba,x0);
%%  Ejercicio tipico de cuotas con anualidad
a = 320000
n = 240
i = 1.2/100
pie = 32000000

% Valor presente del total
VP = pie + Presente_Anualidad_v(a,n,i)
% liquidacion de la deuda al vencimiento de la cuota r
r = 30
VP_vencimiento_r = a + Presente_Anualidad_v(a,n-r,i)

% ponerse al dia al vencimiento de la cuota 'o' luego de omitir las 'o-1' primeras cuotas 
i_mora = 1.9/100
o = 39
P_deuda = Futuro_compuesto(Presente_Anualidad_v(a,o,i_mora),o,i_mora)

% liquidar deuda al vencimiento de la cuota o, luego de omitir las o-1
% cuotas anteriores 
o = 20
P_liquidacion_deuda = Futuro_compuesto(Presente_Anualidad_v(a,o,i_mora),o,i_mora) + Presente_Anualidad_v(a,n-o,i)
%% Costos Hundidos

% DATOS
i_credito =10/100
i_capital = 10/100 
capital_propio = 10000
credito = 1500
Inversion = [700,9000,500,1300]


Costos_Operacion = [5400,350,155,0.01*9500] % Mano de obra, patente,sueldo alternativo,impuestos
Costos_Financiamiento = [capital_propio*i_capital,credito*i_credito]% Costo Op. Capital propio, costo credito bancario Anual
% ver si se puede financiar
if sum(Costos_Operacion) >= sum(Costos_Financiamiento)
    disp("Si se puede financiar")
else 
    disp("No se puede financiar")
end
% Cual es el ingreso minimo P_a que debe recibir para ooptar por hacer el
% proyecto

P_a = sum(Costos_Operacion) + sum(Costos_Financiamiento)

% cual es el ingreso minimo P_b si la maquina se puede vender en una diferencia de dif u.m
dif =  9000 - 5000 ; %costo de la maquina - valor_residual
% cambia el capital propio, ya que si liquidamos recuperamos algo
activos_no_liquidables = [700] %no se puede liquidar, ej: permisos
Costos_Financiamiento_v = [(capital_propio - dif - sum(activos_no_liquidables))*i_capital,credito*i_credito]
P_b = sum(Costos_Operacion) + sum(Costos_Financiamiento_v)

%si queremos hacerlo con liquidacion
%Costos_Financiamiento_v = [600000,240000]*i_capital %valor de activos liquidables (valor residual,capital propio,etc)
%P_b = sum(Costos_Operacion) + sum(Costos_Financiamiento_v)

%Llegada de una nueva maquina que trae nuevos costos, cuanto es el P_m
%minimo esperado si la incorporamos? Flujos marginales

%DATOS
capital_extra = 10000
credito_extra = 0
Ingresos_actuales = 7500
Costos_Operacion_m = [3450,100]  %los costos de operacion atribuible a la maquina nueva (mano de obra, impuestos)


Costos_Financiamiento_m = [capital_extra*i_capital,credito_extra*i_credito] %Costo de oportunidad de nueva maquina (capital propio adicional) o credito extra
P_m = Ingresos_actuales + sum(Costos_Operacion_m) + sum(Costos_Financiamiento_m)

fprintf('a) Costos operacionales =  %i  \n', sum(Costos_Operacion))
fprintf('a) Costos financiamiento =  %i  \n', sum(Costos_Financiamiento))
fprintf('Pregunta a I ingreso minimo =  %i  \n', P_a)
fprintf('b) Costos operacionales =  %i  \n', sum(Costos_Operacion))
fprintf('b) Costos financiamiento =  %i  \n', sum(Costos_Financiamiento_v))
fprintf('Pregunta b I si la maquina se puede vender =  %i  \n', P_b)
fprintf('c) Costos marginales operacionales =  %i  \n', sum(Costos_Operacion_m))
fprintf('c) Costos marginales financiamiento =  %i  \n', sum(Costos_Financiamiento_m))
fprintf('Pregunta c maquina nueva I =  %i  \n', P_m)

%% Desarrollo
i = 0.12
i_trim = 0.12/4
i_sem = Interes_Mayor(i_trim,2)
P_23 = Presente_Anualidad_v(2500000,7,i_sem)/(1+ i_trim)^23*(1+i_sem)
Anualidad_trimestral =  Anualidad_vencida(P_23,20,i_trim) 
i = 0.09
Maximo_a_pagar  = Presente_Anualidad_v(1000,2,i) + Presente_Anualidad_v(5000,8,i)/(1+i)^2 + Presente_Anualidad_v(2000,5,i)/(1+i)^10
%% Desarrollo extra
i = 0.22
ej_3 = gradiente_tasa_constante_v(1000,3,i,0.4)+gradiente_uniforme(1760,3,i,-200)/(1+i)^3 + 2000/(1+i)^8 + 1360/(1+i)^9 + 1700/(1+i)^12