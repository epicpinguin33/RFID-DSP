function [r] = getDelay(R,sampleRate)
%GETDELAY NS simulator
attenuation=R^(-2);
r=systemBlock([zeros(1,R*sampleRate) attenuation]);
end