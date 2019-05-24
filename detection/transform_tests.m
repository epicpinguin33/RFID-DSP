clear all;
close all;

fs=8500;
t=0:1/fs:2;

f(1)=4000;
f(2)=3000;
f(3)=2000;
f(4)=1000;

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
y=x(1,:)+x(2,:)+x(4,:);
%y = chirp(t,1000,2,4000);
y=[y zeros(1,1*fs)];
y = awgn(y,-10,'measured');

%[f_out] = stmpm(y, fs, kaiser(150,2), 50, .1, (3)/4);
[f_out,~] = stft_wrap(y, fs, kaiser(150,2.5), 50, (3)/4, 1/(2.4));

figure
subplot(1,3,1)
scatter(f_out(1,:), f_out(2,:))

%filter
freq_reach = 450;
group_reach = 10;

freq_reach2 = 300;
freq_reach22 = 200;
group_reach2 = 10;

bin_reach = 500;
mean_offset = 200;
max_var = 60;

freq_v = [1000, 2000, 3000, 4000];
freq_l = zeros(1, size(freq_v,2));
tag_v = [1 0;2 0;3 0;1 2; 1 3;2 3];

f_out = abs(f_out);

%%%%%%%%%%%%%%%%%
% for i = 1:1:f_out(2,end)
%     group = f_out(1, ( (f_out(2,:) >= (i - group_reach2))& (f_out(2,:) <= i + group_reach2) ));
%     group = group(1, (group(1,:) ~=0 ) );
%     group = sort(group);
%     group_s = size(group,2) - 1;
%     avg_v = zeros(1,group_s);
%     zzeros = 0;
%     for j = 1:1:group_s
%         dif = group(j+1) - group(j);
%         if dif == 0
%             zzeros = zzeros + 1;
%         end
%         avg_v(j) = dif;
%     end
%     avg = sum(avg_v)/(group_s - zzeros);
%     if(avg <= freq_reach2)
%        f_out(1, ((f_out(2,:) >= (i - group_reach2))&(f_out(2,:) <= i + group_reach2)) ) = 0;
%     end
% end
%%%%%%%%%%%%%%%%%


for i = 1:1:size(f_out,2)
   if min((abs(freq_v - f_out(1,i)) ) > freq_reach22)
       f_out(1,i) = -100000;
   end
end
f_out = f_out(:, (f_out(1,:) > 0 ));

subplot(1,3,2)
scatter(f_out(1,:), f_out(2,:))

for i = group_reach2:(2*group_reach2 + 1):f_out(2,end)-group_reach2
    for k = 1:1:length(freq_v)
      ind_1 = find( (f_out(2,:) >= (i - group_reach2))&(f_out(2,:) <= (i + group_reach2))&(f_out(1,:) >= (freq_v(k) - freq_reach22))&(f_out(1,:) <= (freq_v(k) + freq_reach22))  );

      group = f_out([1 3],ind_1);
      group = group(:, (group(1,:) > 0 ) );

      if(std(group(1,:), group(2,:)) > 80)
            f_out(1, ind_1) = 0;
      else
          l_g = length(group);

          if l_g ~= 0
              lg_ind = ceil(l_g * 1/3):ceil(l_g * 2/3);
              f_out(1, ind_1) = wmean( group(1,lg_ind), group(2,lg_ind)  );
          end
      end
    end
end

f_out = f_out(:, (f_out(1,:) ~=0 ));

subplot(1,3,3)
scatter(f_out(1,:), f_out(2,:))


for i = 1:1:length(freq_v)
    bin = f_out(1, ((f_out(1,:) >= (freq_v(i) - bin_reach))&(f_out(1,:) <= (freq_v(i) + bin_reach))) );
    if ((abs(mean(bin) - freq_v(i)) <= bin_reach) & (std(bin) <= max_var)) 
        freq_l(i) = true;
    end
%     [~, at_t] = unique(bin(2,:));
%     bin = bin(:, at_t);
%     kn = 0;
%     ka = 0;
%     prev_ind = bin(2,1) ;
%     size(bin,2)
%     for j = 1:1:size(bin,2)
%         if bin(2,j) - prev_ind <= 10
%             kn = kn + 1;
%         else
%             if kn > 50
%                ka = ka + kn;
%             end
%             kn = 0
%         end
%         prev_ind = bin(1,j);
%     end
%     if kn > ka
%         ka = ka + kn;
%     end
%     if ka > 200
%         freq_l(i) = true;
%     end
%     ka
end

freq_l
% end