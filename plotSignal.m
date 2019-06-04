function plotSignal(app,signalName,sampleRate)
%PLOTSIGNAL used to plot a signal struct into the impulseresponse,
%amplituderepsonse and phase response figures.
%assignin('base','sig',signalName)
if strcmp(app.plotLinearLog.Value,'Lin')
    plot(app.impulseResponse,app.systemStruct.simTime,zeroPad(app.systemStruct.(signalName).gAbs(),length(app.systemStruct.simTime)))
    app.impulseResponse.YLimMode='auto';
else
    responsedB=20*log(zeroPad(app.systemStruct.(signalName).gAbs(),length(app.systemStruct.simTime)));
    assignin('base','db',responsedB)
    plot(app.impulseResponse,app.systemStruct.simTime,responsedB)
    app.impulseResponse.YLim=[max(abs(responsedB))-30 max(abs(responsedB))+5];
end
freqResponse=fftshift(app.systemStruct.(signalName).gFFT());
f=(-length(freqResponse)/2:length(freqResponse)/2-1)/length(freqResponse)*sampleRate;
freqResponse=freqResponse(f>=0);
f=f(f>=0);

plot(app.amplitudeResponse,f,20*log10(abs(freqResponse)))
plot(app.phaseResponse,f,angle(freqResponse))
end