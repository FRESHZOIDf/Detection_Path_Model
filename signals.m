clear;
clc;
fd = 1000;
dt = 1 / fd;
t = ( 0 : dt : 1 );
fc = 40;
fm = 5;
n = 512;
df = fd / n;
fk = df * ( 0 : n - 1);
s = sin ( 2*pi*fc*t );
NS = randn ( size ( t ) );
% ��������� ������
fH = 50; % �������� ������ 
fB = 400;
k = 4; % ������� �������
a0 = 0.1; % ��������� � ������ ����������� (��)
b0 = 40; % ���������� ��� ������ (��)
[ b, a] = ellip ( k, a0, b0, [ fH fB] * 2 / fd);
[ H, w] = freqz ( b, a, n); 
Zi = zeros ( 1, max( length( a ), length( b ) ) - 1);
% ���������� � ������ ( fH � fB):
[ noise, Zf ] = filter ( b, a, NS, Zi);
Fs = fft ( s, n);
Fn = fft ( noise, n);
figure, subplot ( 2, 1, 1), plot ( t, s), grid on
title ('��������� ������')
subplot ( 2,1, 2), plot ( fk, abs ( Fs ) ), grid on
title ('������ ���������� �������')
figure, subplot ( 2, 1, 1), plot ( t, noise), grid on
title ('������� ������')
subplot ( 2 , 1, 2), plot ( fk, abs ( Fn ) ), grid on
title ('���������� ������ ������� �������� �������')
Am = 2+cos ( 2 * pi * fm * t );
sA = Am.*s;
noiseA = Am.*s;
FsA = fft ( sA, n );
FnA = fft ( noiseA, n );
figure, subplot ( 2, 1, 1), plot( t, sA), grid on
title ('����������-�������������� ��������� ������')
subplot ( 2, 1, 2), plot ( k, abs ( FsA ) ), grid on
title ('������ ����������-��������������� ���������� �������')
figure, subplot( 2, 1, 1), plot( t, noiseA), grid on
title ('����������-�������������� ������� ������')
subplot ( 2, 1, 2), plot( fk, abs ( FnA ) ), grid on
title ('���������� ������ ������� �� �������� �������')
