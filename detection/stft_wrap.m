function [f_out, ampl] = stft_wrap(y, fs, win, t_incr, peak_factor, mm_ratio)

wins = length(win);
overlap =  wins - t_incr;
[s,f,t] = stft(y,fs,'Window',win ,'OverlapLength',overlap,'FFTLength',wins* 2);
sabs = abs(s);

imagesc(t,f,sabs)

f_out = zeros(2,size(sabs,1)*size(sabs,2));
ampl = zeros(1, size(f_out,2));
f_out_ind = 0;

% 
% %reading in the image
% A=sabs;
% figure;imagesc(A);colormap gray;colorbar
% %applying fouire transform shift to zero postion and fouire transform for
% %2D
% D = fftshift(fft2(A));
% %defing the filter, Low pass filter
% h1 = (1/9).*[1,1;1,1;1,1];
% %apllying filter to the freqencey domian
% B1=filter2(h1,D);
% B1 = uint8(round(B1));
% G=ifft2(B1);
% E=(log((abs(G))));
% figure;imagesc(E);colormap gray;colorbar
% figure;imagesc(double(A)-E);colormap gray;colorbar



 for j = 1:1:size(sabs,2)
    vector = sabs(:,j);
    L = length(vector);
%    nr_of_points = 8;
    max_v = max(vector);
%     
%     
%     [vector, vector_ind] = sort(vector, 'descend');
%     
%     
%     for i = 1:1:min(L,nr_of_points)
%         f_out_ind = f_out_ind + 1;
%         f_out(1,f_out_ind) = f(vector_ind(i));
%         f_out(2,f_out_ind) = j;
%         ampl(f_out_ind) = sabs(vector_ind(i),j);
%     end
%     
    
    
    
    if max_v * mm_ratio >= mean( vector( ceil(L/3):floor((2*L)/3) ))
        
        peak_thr = max_v*peak_factor;
        res_loc = find(vector >= peak_thr);
        nr_res = length(res_loc);
        
        
        for i = 1:1:nr_res
            f_out_ind = f_out_ind + 1;
            f_out(1,f_out_ind) = f(res_loc(i));
            f_out(2,f_out_ind) = j;
            ampl(f_out_ind) = sabs(res_loc(i),j);
        end
        
    end
    

       
  end
% 

f_out = f_out(:,1:f_out_ind);
ampl = ampl(1:f_out_ind);

f_out = [f_out;ampl];

end

