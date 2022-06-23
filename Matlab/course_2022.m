clc; close all; clear;

% Версия Matlab, в которой был создан этот код и модель - Simulink R2022a

% Важно! Полный функционал fi() (такой как, например, представление в
% десятичном виде) может не работать в старых версиях Matlab (в 2016а уже не
% работает). Это - критический момент, используйте соответствующие версии
% Matlab

% коэффициенты фильтра

b=[0.00319806247283222151 0 -0.00639612494566444301 0 0.00319806247283222151]; % numerator (числитель)
a=[1 -3.78125206442570505 5.44829440482254412 -3.54414088511948755 0.878834866871245235]; % denominator (знаменатель)

word_lenght = 24; % Длина слова (разрядность)
fraction_lenght = 18; % Длина точки
int_lenght = word_lenght - fraction_lenght; % Длина целой части

% 0.032 - коэффициент, зависящий от stop time модели simulink
% ВАЖНО! Если хотим, чтобы работала таблица data_table - смотрим на размерность матриц
% y_double и y_fpga_double и подбираем stop time так, чтобы размерности
% совпадали, тогда ошибок не будет. Сама таблица data_table необязательна,
% а служет лишь для удобного представления данных входов\выходов

t = [0:1:(round(0.032 * 1e4))];

% Генерация синусоиды

amp = 3.3;
bias = 0;
freq = 650;

%x = (amp * sin(2*pi*(freq/10000) * t)) + bias;

% ВАЖНО! Расскоментируйте 33 строку и закоментируйте 40, чтобы подавать не
% скачок, а синусоиду. При этом в simulink модели необходимо щелкнуть 2 раза
% на блок Manual Switch, иначе данные из Matlab не будут соотносится с
% результатом осциллографа. Число 321 подбирается также, как и кэф 0.032

x = 1 * ones(1, 321);

% --- Double

b_double = b; % Кэфы b в double
a_double = a; % Кэфы a в double
x_double = x; % Входные данные x в double

y_double = filter(b_double, a_double, x_double); % Выходные (отфильтрованные) данные y в double

% Выходные данные образцового фильтра в формате с фикс. точкой в доп коде
y_fixed = split(fi(y_double, 1, word_lenght, fraction_lenght).dec);

% --- Fixed

% split() служит для разделения строки char в массив, т.к fi() выдает
% строку

% Кефы b в формате с фикс. точкой в доп коде
b_fixed = split(fi(b, 1, word_lenght, fraction_lenght).dec);

% ВАЖНО!!! Нельзя забывать, что кэфы a в MAX\Quartus всегда должны быть * на
% -1. Так как мы только суммируем. Матлаб делаем все автоматически, для
% него знак - не нужен.

% Кефы a в формате с фикс. точкой в доп коде
a_fixed = split(fi(-a, 1, word_lenght, fraction_lenght).dec);

% Входные данные x в формате с фикс. точкой в доп коде
x_fixed = split(fi(x, 1, word_lenght, fraction_lenght).dec);

% course_simulink.slx - название модели, которое будем использовать.
% Различаются модели лишь версией Matlab, которая используется в данный
% момент, так как Matlab выдаст ошибку если запускать модель Simulink в
% старом Matlab (с новой версии можно запустить любую старую модель).

simOut = sim("course_simulink.slx");

% Выходные данные фильтра на ПЛИС в формате с фикс. точкой в доп коде
y_fpga = simOut.get('fixed_filter_data');

y_fpga = reshape(y_fpga, [1 length(y_fpga)]);

y_fpga_fix = split(y_fpga.dec);
y_fpga_double = y_fpga.data;

% --- Импорт данных в таблицу для наглядного представления данных

% Из вектор-строки делаем вектор-столбец, для представления в таблице

b_double = reshape(b_double, [length(b_double) 1]);
a_double = reshape(a_double, [length(a_double) 1]);
x_double = reshape(x_double, [length(x_double) 1]);
y_double = reshape(y_double, [length(y_double) 1]);
y_fpga_fix = reshape(y_fpga_fix, [length(y_fpga_fix) 1]);
y_fpga_double = reshape(y_fpga_double, [length(y_fpga_double) 1]);

coefficient_table = table(a_double, a_fixed, b_double, b_fixed);
data_table = table(x_double, x_fixed, y_double, y_fixed, y_fpga_double, y_fpga_fix);

