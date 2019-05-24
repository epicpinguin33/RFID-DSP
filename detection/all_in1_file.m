clear all;
close all;

fs=5005;
t=0:1/fs:(fs/10)/fs;

f(1)=1700;
f(2)=1300;
f(3)=900;
f(4)=501;

a(1)=1;
a(2)=1;
a(3)=1;
a(4)=1;

d(1)=0;
d(2)=0;
d(3)=0;
d(4)=0;

for i=1:4
    x(i,:)=a(i)*exp(-d(i)*t).*cos(2*pi*f(i)*t);
end
y=x(1,:)+x(2,:)+x(3,:)+x(4,:);



t_incr = 20;
lenght = 50;
win = hamming(lenght,'periodic');

wins = length(win);
overlap =  wins - t_incr;
[s,f,t] = stft(y,'Window',win ,'OverlapLength',overlap,'FFTLength',wins);
sabs = abs(s);
figure;
subplot(3,1,1);
imagesc(t,(f * fs)/(2*pi),sabs);

f_out_ind = 0;

fful = (f .* fs)./(2*pi);
for j = 1:1:size(sabs,2)
    vector = sabs(:,j);
    peak_thr = max(vector)*(2/3);
    res_loc = find(vector >= peak_thr);
    nr_res = length(res_loc);
    
    
    for i = 1:1:nr_res
        f_out_ind = f_out_ind + 1;
        f_out(1,f_out_ind) = fful(res_loc(i));
        f_out(2,f_out_ind) = j;
    end
       
 end
% 
subplot(3,1,2);
scatter(f_out(1,1:f_out_ind), f_out(2,1:f_out_ind));
%   


%%
t_incr = 5;
lenght = 50;
signf = 1;
win = kaiser(lenght,2.5);

wins = length(win);
N = length(y);
L = ceil((5/12) * wins);
threshold = 10^(-signf);

nr_oincr = ceil((N - wins)/t_incr);
total_size = wins + (nr_oincr * t_incr);
y = [y zeros(1,total_size - N)]; 

Y = zeros(wins - L, L + 1);
f_out = zeros(2, L + nr_oincr + 1);
Matz = zeros(wins, L);

f_out_ind = 0;

for j=0:1:nr_oincr
    
    data = y(1+(j*t_incr):wins+(j*t_incr)) .* win';
    
    for i=1:1:(wins-L)
        Y(i,:)=data(i:(i+L));
    end

    [U,S,V] = svd(Y);
    D=diag(S);

    m=0;
    l=length(D);
    for i=1:l
        if( abs(D(i)/D(1)) >= threshold)
            m=m+1;
        else
           break; 
        end
    end

    Ss=S(:,1:m);
    Vnew=V(:,1:m);

    Y1=U*Ss*((Vnew(1:end - 1,:))');
    Y2=U*Ss*((Vnew(2:end,:))');

    D_fil=(pinv(Y1))*Y2;
    z = eig(D_fil);
    l=length(z);
    
    for i = 1:1:wins
        Matz(i,:) = z.^(i-1);
    end

    spec = abs(pinv(Matz) * data'); %abs of residues
    peak_thr = max(spec)*(3/4);
    res_loc = find(spec >= peak_thr);
    nr_res = length(res_loc);
    for i =1:1:nr_res
        f_out_ind = f_out_ind + 1;
        f_out(1,f_out_ind) = (angle(z(res_loc(i)))*fs)/(2*pi);
        f_out(2,f_out_ind) = j;
    end
end

subplot(3,1,3);
scatter(f_out(1,1:f_out_ind), f_out(2,1:f_out_ind));

