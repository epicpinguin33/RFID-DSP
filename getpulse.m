function [response] = getpulse(pulsetype)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N=50;
switch pulsetype
    case 'Impulse'
        response=[1;zeros(N-1,1)];
    case 'short pulse'
        response=[1;1;1;1;zeros(N-4,1)];
end

