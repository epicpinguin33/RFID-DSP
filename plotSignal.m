function plotSignal(app,signal)
%PLOTSIGNAL used to plot a signal struct into the impulseresponse,
%amplituderepsonse and phase response figures.
plot(app.impulseResponse,app.systemStruct.(signal).gTimeAxis(),app.systemStruct.(signal).gAbs())

freqResponse=fftshift(app.systemStruct.(signal).gFFT());
f=(-length(freqResponse)/2:length(freqResponse)/2-1)/length(freqResponse)*app.systemStruct.(signal).gSampleRate();
freqResponse=freqResponse(f>=0);
f=f(f>=0);

plot(app.amplitudeResponse,f,20*log10(abs(freqResponse)))
plot(app.phaseResponse,f,angle(freqResponse))
end