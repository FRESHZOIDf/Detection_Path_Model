c = 1500;
fd = 10000;
dt = 1 / fd;
t = (0 : dt : 1);
n = 256;
df = fd / n; 
fk = (0 : n - 1) * df; 
fr = [ fk( 1 : n / 2), fk( n / 2 + 1 : n) - fd];
f = input(' B?e???? ??????? ??????? f= '); 
% ????????? ?? (???????) 
d = 0.3; % ????????????? ??????????, ?
m = 20; % ????? ?? ??
% ???????????? ??
Alfa = 30; % ??????????? ??????????? ?? 
tau0 = d/c*sind( Alfa);
tay0 = tau0 * ( 0 : m - 1)'; %?????????????? ???????? 
koef = exp( 1i * 2 * pi * tay0 * fr ); % ???????????? ???????????
kl = 2;
ks = round( f / df + 1);
for al=1 : 180 * kl + 1 
alfa = (al - 90*kl - 1) / kl; % ???? ??????? ???????
tau = d / c * sind( alfa );
tay = tau * (0 : m - 1)'; % ???????? ?????? ??????? ?? ????????? ??
% ???????????? ??????? ?? ????????? ???????? ??:
tt = repmat( t, m, 1) - repmat( tay, 1, size ( t, 2));
z = sin( 2 * pi * f * tt ); % ?????? ?? ?? ??
Z = fft( z, n, 2); % ??????? ? ????????? ??????? 
S = koef .* Z; % ????????? ?? ?????????? ????????????
SS = sum( S, 1); % ????? ??????????? ???????? ?? ????????? ??
sz = ifft( SS, n); % ??????? ?? ????????? ???????
XH(al)= std( sz ( 1 : n / 2 ) ) * sqrt( 2 );
end
figure, plot( ( -90 : 1 / kl : 90), XH), grid on, zoom on
title('????????????? ?????????????? ???????')
