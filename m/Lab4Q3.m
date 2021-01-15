clc
clear 
close all

%% Q3

%Aluminum properties
E = 10000000;
sigyield = 35000;

%Define new lengths
Ldiff = 7.5;
Ldiff2 = 8.5;
Ldiff3 = 5;

%Properties of square beam
ts = 0.0625;
hs = 0.25;
ws = 0.25;
Ls = 10.25-Ldiff:0.25:10.25+Ldiff;
Ls2 = 10.25-Ldiff3:0.25:10.25+Ldiff;

%Properties of rectangular beam
wr = 1;
hr = 0.125;
Lr = 10.75-Ldiff:0.25:10.75+Ldiff;
Lr2 = 10.25-Ldiff2:0.25:10.25+Ldiff;

%Calculate moment of inertia
Is = 1/12*hs^3*ws - 1/12*(ws-2*ts)*(hs-2*ts)^3;
Ir = 1/12*hr^3*wr;

%Buckling load
Pcrs2_ss = (pi^2*E*Is)./(Ls.^2);
Pcrr2_ss = (pi^2*E*Ir)./(Lr2.^2);
Pcrs2_ff = (pi^2*E*Is)./((Ls2/2).^2);
Pcrr2_ff = (pi^2*E*Ir)./((Lr/2).^2);

%Yielding
As = 2*(hs*ts) + 2*((ws-(2*ts))*ts);
Ar = wr*hr;
sigmacrs = zeros(1,length(Ls))+sigyield*As;
sigmacrr = zeros(1,length(Lr2))+sigyield*Ar;

%Plot
figure(1)
hold on
grid on
plot(Ls,Pcrs2_ss,Ls2,Pcrs2_ff,Ls,sigmacrs,'linewidth',2)
title('Force vs Beam Length of Hollow Square Beam')
xlabel('Beam Length (in)')
ylabel('Force (lb)')
legend('simply supported','fixed-fixed',['yielding force = ' num2str(sigmacrs(1))],'location','best')
hold off

figure(2)
hold on
grid on
plot(Lr2,Pcrr2_ss,Lr,Pcrr2_ff,Lr2,sigmacrr,'linewidth',2)
title('Force vs Beam Length of Rectangular Beam')
xlabel('Beam Length (in)')
ylabel('Force (lb)')
legend('simply supported','fixed-fixed',['yielding force = ' num2str(sigmacrr(1))],'location','best')
hold off
