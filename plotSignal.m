function plotSignal(app,signalName,sampleRate)
%PLOTSIGNAL used to plot a signal struct into the impulseresponse,
%amplituderepsonse and phase response figures.
assignin('base','sig',signalName)
plot(app.impulseResponse,app.systemStruct.simTime,zeroPad(app.systemStruct.(signalName).gAbs(),length(app.systemStruct.simTime)))

freqResponse=fftshift(app.systemStruct.(signalName).gFFT());
f=(-length(freqResponse)/2:length(freqResponse)/2-1)/length(freqResponse)*sampleRate;
freqResponse=freqResponse(f>=0);
f=f(f>=0);

plot(app.amplitudeResponse,f,20*log10(abs(freqResponse)))
plot(app.phaseResponse,f,angle(freqResponse))
end