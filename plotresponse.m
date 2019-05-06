function plotresponse(app,r)
%PLOTRESPONSE Summary of this function goes here
%   Detailed explanation goes here
plot(app.impulseResponse,r)
R=fft(r);
plot(app.amplitudeResponse,abs(R))
plot(app.phaseResponse,angle(R))
end

