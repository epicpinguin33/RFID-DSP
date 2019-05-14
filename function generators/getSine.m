function [timeSeries,timeAxis] = getSine(frequency,dampingCoef,Samples,Samplerate)
%getSine returns a sampled exponentially decaying sine funtion
t=linspace(0,Samples/Samplerate,Samples);
sig=exp(-dampingCoef*t).*sin(frequency*t);
timeSeries=signal(sig);
%timeSeries.setTimeAxis(t);
timeAxis=t;
end

