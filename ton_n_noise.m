clear;
clc;
fd = 2000;
dt = 1 / fd;
t = ( 0 : dt : 0.6 );
n = 512;
df = fd / n;
fk = df *( 0 : n / 2 - 1);
fc = 40;
q = 2;
s = sin ( 2 * pi * fc * t );
ns = randn ( size ( t ) );
x = s + q * ns;
Fs = fft ( x, n);
figure, subplot ( 2, 1, 1), plot( t, x), grid on
title ('тональный сигнал на фоне шума')
subplot ( 2, 1, 2), plot( fk, abs ( Fs( 1 : n / 2) ) ), grid on
title ('спектр сигнала')