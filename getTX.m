function [response] = getTX(transmittersetup)
%GETTX Summary of this function goes here
%   Detailed explanation goes here
N=50;
switch transmittersetup
    case 'gain (1x)'
        response=ifft(ones(N,1));
    case 'gain (2x)'
        response=ifft(2*ones(N,1));
end

