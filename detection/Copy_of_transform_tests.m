clear all;
close all;

fs=10e9;
t=0:1/fs:3e6/fs;

f(1)=3.2e9;
f(2)=2.6e9;
f(3)=2.4e9;
f(4)=2e9;

% a(1)=.4;
% a(2)=1;
% a(3)=0.89;
% a(4)=.65;

a(1)=1;
a(2)=1;
a(3)=1;
a(4)=1;

% d(1)=70;
% d(2)=50;
% d(3)=90;
% d(4)=80;

d(1)=0;
d(2)=0;
d(3)=0;
d(4)=0;

for i=1:4
    x(i,:)=a(i)*exp(-d(i)*t).*cos(2*pi*f(i)*t);
end
y = 0;
y=x(1,:)+x(3,:)+x(4,:);

%y = chirp(t,1000,2,4000);
y=[zeros(1,2000000) y];
%t=0:1/fs:3;

y = awgn(y,-25,'measured');


f(3)=2.3e9;

t = linspace(0, length(y)/fs, length(y));
%plot(t,y);

for i=1:4
    mixer_in(i,:)=exp(-j*t*f(i)*2*pi);
end

mixer_out = y .* mixer_in;

fcuts = [100e6 150e6];
mags = [1 0];
devs = [0.05 0.01];

[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
n = n + rem(n,2);
hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
HH = fft(hh, size(mixer_out,2));
%HH = [HH zeros(1,size(mixer_out,2) - length(HH))];

% for i=1:4
%     lp_out(i,:) = conv(mixer_out(i,:), hh);
% end
for i=1:4
    lp_out(i,:) = ifft(fft(mixer_out(i,:)) .* HH);
end

window_reach = ceil(fs/(2 * 100));
window_reach = 800000;
mean_L = length(lp_out) - 2*window_reach;
mean_out = zeros(4, floor(mean_L/(window_reach/4)));

for k = 1:1:4
    for i = 1:1:floor(mean_L/(window_reach/4))
        set = abs(lp_out(k,i*(window_reach/4):i*(window_reach/4)+2*window_reach));
        mean_out(k,i) = mean(set);
    end
end

MINUS = min(min(mean_out));
MAXUS = max(max(mean_out));
mean_out = mean_out / MAXUS;
threshold_line = [2.32 2.32]/MAXUS;
MINUS = min(min(mean_out));
MAXUS = max(max(mean_out));



figure;

for k = 1:1:4
        hold on 
        plot(mean_out(k,:));
        plot([1,size(mean_out,2)],threshold_line, 'r' )
        plot([.4*(size(mean_out,2)) .4*(size(mean_out,2))],[MINUS,MAXUS], 'b' )

        ylim([MINUS MAXUS]);
end
legend('1000Hz','2000Hz','3000Hz','4000Hz','Threshold','Turn on time','location','northwest');
xlabel('Samples')
ylabel('Normalized power')





  %  mean_out = mean_out/(max(mean_out));



% rms_out = sqrt(sum(real(lp_out).^2,2)/size(lp_out,2));
% rms_out = rms_out / (max(rms_out))

% plot(abs(lp_out(1,:)))

% win = kaiser(120,2);
% t_incr = 40;
% %[f_out,ampl] = stft_wrap(y, fs, win, 40, (3)/4, 1/(2.7));
% 
% wins = length(win);
% overlap =  wins - t_incr;
% [s] = stft(y,fs,'Window',win ,'OverlapLength',overlap,'FFTLength',wins);
% 
% figure; imagesc(abs(s));
% 
% t2=1/fs:1/fs:length(win)/fs;
% for i=1:4
%     exp_freq(:,i)=fft(a(i)*exp(-d(i)*t2).*cos(2*pi*f(i)*t2).*win');
% end
% 
% figure;plot(abs(exp_freq));
% 
% for i=1:1:size(s,2)
%    div(:,i) = s(:,i)./exp_freq(:,1);
% end
% 
% figure; imagesc(abs(div));





%plot(abs(fft(exp_freq(1,:),2000,1)));
