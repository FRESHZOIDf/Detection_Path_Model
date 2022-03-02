% Тракт обнаружения

clear
clc

M = 20; % количество элементов в антенне
d = 0.3; % расстояние между элементами 
c = 1500; % скорость волны в воде
f_n = 1000;
f_v = 2000;
fd = 10000;
t = 0:1/fd:10;

% 1-й сигнал
f = 1500;
alpha0 = 30;
v = -0.5;
alpha = alpha0 + v*t;

% 2-й сигнал
f_2 = 1250;
alpha0_2 = -5;
a = 10; 
b = 5;
alpha_2 = alpha0_2 + sin(2*pi*t*0.2)*10; % распространение сигнала по синусоиде

%alpha = 30;
beta = -50:2:50;
n = 256;
k = 5;

df = fd/n;
fk = df*(0:n-1);

T = repmat(t, M, 1);

tau0 = d * sin(alpha * pi / 180) / c;
%taum = tau0*(M-1:-1:0);
Taum = (M-1:-1:0)'*tau0;
%Taum = repmat(taum', 1, size(T, 2));
Y = sin(2*pi*f*(T - Taum));

tau0_2 = d * sin(alpha_2 * pi / 180) / c;
Taum_2 = (M-1:-1:0)'*tau0_2;
Y_2 = sin(2*pi*f*(T - Taum_2));


noise = randn(size(Y));

Y = Y + Y_2 + k*noise;

%----------------СИГНАЛ СФОРМИРОВАН-------------------
%----------------НАЧИНАЕМ ОБРАБОТКУ-------------------

count = floor(size(Y,2)/n);

k_n = round(f_n/df + 1);
k_v = round(f_v/df + 1);

V = [];

for  i = 1:count
    i_n = n * (i-1) + 1;
    i_k = n * i;
    Y_f = fft(Y(:, i_n:i_k), n, 2);
    Z = [];
    for b = beta
        tau0_komp = d/c*sind(b);
        tau_komp = tau0_komp*(M-1:-1:0);
        koef = exp(1i*2*pi*tau_komp'*fk);
        Ytao_1 = sum(Y_f.*koef, 1); % сформированный пространственный канал
        Z(end+1) = sum(abs(Ytao_1(k_n:k_v)).^2);
    end
    V(end+1,:) = Z;
end

figure
imagesc(beta, 1:count, V)
%figure
%plot(beta,sum(V, 1))
