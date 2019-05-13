function [response] = getDelay(R,sampleRate)
%GETDELAY NS simulator
response=systemBlock([zeros(1,R*sampleRate) 1]);
end