clear
clc
c = 1500;
fd = 10000;
dt = 1 / fd;
t0 = (0: dt : 1);
n = 1024;
df = fd / n; 
fk = (0 : n - 1) * df; 
fr = [fk(1 : n / 2), fk(n / 2 + 1 : n) - fd];
t = t0( 1 : n);
f = input ( ' B������ ������� ������� f='); 
% ��������� �� (�������) 
d = 0.3; % ������������� ����������, �
m = 20; % ����� �� ��
% ������������ ��
Alfa = 15 * pi / 180; % ����������� ����������� �� 
tau0 = d / c * sin ( Alfa );
tay0 = tau0 * ( 0 : m - 1)'; %�������������� �������� ������ ������� 
koef = exp ( 1i * 2 * pi * tay0 * fr); % ������������ �����������
alfa = 15 * pi / 180;
tau = d / c * sin ( alfa ); 
tay = tau * ( 0 : m - 1)'; % �������� ������ ������� �� ��������� ��
% ������������ ������� �� ��������� �������� ��:
tt = repmat ( t, m, 1) - repmat ( tay, 1, size ( t, 2) ); 
z = sin ( 2* pi * f * tt ); % ������ �� �� ��
Z = fft ( z, n, 2); % ������� � ��������� ������� 
S = koef .* Z; % ��������� �� ���������� ������������
SS = sum ( S, 1); % ����� ����������� �������� �� ��������� ��
sz = ifft ( SS, n); % ������� �� ��������� �������
figure, plot ( t, real ( sz ) ), grid on
title (' ������������ � ��������� �������')
tmax = round ( max ( abs ( tau0 * (m - 1) ) ) * fd+0.5);
for m_ = 1:m
 tm = floor ( tau0 * (m_- 1) / dt + 0.5);
z1(m_, 1 : n - tmax) = z( m_, tm + 1 : n - tmax + tm);
end
yz = sum ( z1);
figure, plot( t ( 1 : n - tmax), [real( sz ( 1 : n - tmax) ); yz]), grid on, zoom on
title (' ������������ � 2 ��������')
