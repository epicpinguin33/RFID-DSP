clear all;
close all;

fs=5005;
t=0:1/fs:(fs/10)/fs;

f(1)=2000;
f(2)=1300;
f(3)=900;
f(4)=30;

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
y=x(1,:)+x(2,:)+x(3,:)+x(4,:);


% [f d] = mpencil(y)

% function [f d] = mpencil(y)

%construct hankel matrix

    
N = size(y,2);
    L1 = ceil(1/3 * N);
    L2 = floor(2/3 * N);
    L = ceil((L1 + L2) / 2);

    for i=1:1:(N-L)
        Y(i,:)=y(i:(i+L));
    end

    [U,S,V] = svd(Y);
    D=diag(S);
    signf = 2;
    
    m=0;
    l=length(D);
    for i=1:l
        if( abs(D(i)/D(1)) >= 10^(-signf))
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
    for i=1:2:l
        f((i+1)/2)= (angle(z(i))*fs)/(2*pi);
    end
    
    Matz = zeros(N, l);
    
    for i = 1:1:N
        Matz(i,:) = z.^(i-1);
    end
    
    res = pinv(Matz) * y';
    
% end