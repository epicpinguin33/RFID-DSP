function [f_out] = stmpm(y, fs, win, t_incr, signf, peak_factor)

win_l = length(win);
N = length(y);
L = ceil((5/12) * win_l);
threshold = 10^(-signf);

nr_oincr = ceil((N - win_l)/t_incr);
total_size = win_l + (nr_oincr * t_incr);
y = [y zeros(1,total_size - N)];

Y = zeros(win_l - L, L + 1);
f_out = zeros(3, L + nr_oincr + 1);
Matz = zeros(win_l, L);

f_out_ind = 0;
for j=0:1:nr_oincr
    
    data = y(1+(j*t_incr):win_l+(j*t_incr)) .* win';
    
    for i=1:1:(win_l-L)
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
    
    for i = 1:1:win_l
        Matz(i,:) = z.^(i-1);
    end
    
    spec = abs(pinv(Matz) * data'); %abs of residues
    peak_thr = max(spec)*peak_factor;
    res_loc = find(spec >= peak_thr);
    nr_res = length(res_loc);
    for i =1:1:nr_res
        f_out_ind = f_out_ind + 1;
        f_out(1,f_out_ind) = (angle(z(res_loc(i)))*fs)/(2*pi);
        f_out(2,f_out_ind) = j;
        f_out(3,f_out_ind) = spec(res_loc(i));
    end
end

f_out = f_out(:,1:f_out_ind);
end

