clear all
close all;

P_t = 0.5e-3;
r = 4;
clut_dis = 3;
freq = 6 * 10^9;
RCS = 10^(-45/10);
G_t = 10^(4/10);
Qfactor = 100;
Pfreq = 1e3;
osc_time = Pfreq * 20e-9;
pulse_time = Pfreq * 5e-12;

c = 3e8;
k = 1.381e-23;

T = 100 + 273;

e1 = 1;
e2 = 3;

refl = (sqrt(e1) - sqrt(e2))/(sqrt(e1) + sqrt(e2));
trm = 1 + refl;

lab = c/freq;
B = freq/Qfactor;
B = 12e9;

Pr_osc = ((P_t * G_t)/(4 * pi * r^2)) * (6.3*3.2e-6*.8)  * (1/(4 * pi * r^2)) * ((lab^2)/(4 * pi)) * G_t * trm^2;
Pr_osc = Pr_osc / osc_time;

%Pr_ref = (P_t * G_t^2 * RCS)/((4*pi*r^2)^2);
Pr_ref = (P_t * G_t^2 * lab^2 *RCS * trm^2)/((4*pi)^3 * r ^4);
Pr_ref = Pr_ref/pulse_time;

%Pclut = abs(refl)^2 * P_t * G_t^2 *(1/(4*pi*(2*clut_dis)^2));
Pclut = (P_t * G_t^2 * lab^2 * (pi * clut_dis^2 * (tand(45/2))^2 ) * abs(refl)^2)/((4*pi)^3 * clut_dis ^4)
Pclut = Pclut/pulse_time;

PnoiseT = (4*k*T*B);

SNR_osc = 10 * log10(Pr_osc / (PnoiseT))
SNR_ref = 10 * log10(Pr_ref / (PnoiseT + Pclut))
