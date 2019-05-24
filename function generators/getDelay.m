function [r] = getDelay(R,sampleRate)
%GETDELAY NS simulator
attenuation=R^(-2);
r=systemBlock([zeros(1,floor(R*sampleRate/299792458)) attenuation]);
end