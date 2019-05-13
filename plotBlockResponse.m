function plotBlockResponse(app,block)
%PLOTRESPONSE used to plot a systemBlock struct into the impulseresponse,
%amplituderepsonse and phase response figures.
plot(app.impulseResponse,app.systemStruct.(block).gResponse())

freqResponse=app.systemStruct.(block).gFFT();
plot(app.amplitudeResponse,abs(freqResponse))
plot(app.phaseResponse,angle(freqResponse))
end

