R = 20;
L = 960e-6;
C = 100e-12;
freq = logspace(5, 7, 10000);

% 绘制第一条曲线
H1 = 20*log10(abs(1./(-L*C.*(2*pi.*freq).^2+R*C*1i*2*pi.*freq+1)));
p = semilogx(freq, H1);
p.LineStyle = '-.';
grid on;
hold on;

% 修改线条颜色为红色
p.Color = 'r';

R = 90;
C = 30e-12;

% 绘制第二条曲线
H2 = 20*log10(abs(1./(-L*C.*(2*pi.*freq).^2+R*C*1i*2*pi.*freq+1)));
semilogx(freq, H2);

% 修改线条颜色为蓝色
h = gca;
h.Children(1).Color = 'b';

[m1, index1] = max(H1);
pf1 = freq(index1);
l1 = line([pf1, pf1], [-60, m1], 'linestyle', '--');
l1.Color = '#77AC30';
text(pf1, -58, strcat('pf=', num2str(pf1, 6)));

[m2, index2] = max(H2);
pf2 = freq(index2);
l2 = line([pf2, pf2], [-60, m2], 'linestyle', '--');
l2.Color = '#77AC30';
text(pf2, -58, strcat('pf=', num2str(pf2, 6)));

db1 = m1 - 3;
l3 = line([1e5, 1e7], [db1, db1], 'linestyle', '--');
l3.Color = '#77AC30';

H11 = H1(1:index1-1);
[~, index11] = min(abs(H11 - db1));
H12 = H1(index1+1:length(H1));
[~, index12] = min(abs(H12 - db1));
bw1 = -freq(index11) + freq(index12+index1);
text(freq(index1), m1, strcat('BW=', num2str(bw1, 5)));

db2 = m2 - 3;
l4 = line([1e5, 1e7], [db2, db2], 'linestyle', '--');
l4.Color = '#77AC30';

H21 = H2(1:index2-1);
[~, index21] = min(abs(H21 - db2));
H22 = H2(index2+1:length(H2));
[~, index22] = min(abs(H22 - db2));
bw2 = -freq(index21) + freq(index22+index2);
text(freq(index2), m2, strcat('BW=', num2str(bw2, 5)));

qf1 = pf1 / bw1;
qf2 = pf2 / bw2;
hold off;

ax = gca;

% 修改坐标系的范围和比例
axis([1e5 2e7 -70 70]);

ax.GridLineStyle = '--';
ax.GridColor = 'k';
ax.GridAlpha = 1;
ax.MinorGridLineStyle = '--';
ax.MinorGridColor = 'k';
ax.MinorGridAlpha = 1;

legend('C=100pF and R=20ohms', 'C=30pF and R=90ohms', 'Location', 'southwest');
xlabel('$$f/\mathrm{Hz}$$', 'Interpreter', 'latex');
ylabel('$$20\log_{10}|H(j\omega)|$$', 'Interpreter', 'latex');
