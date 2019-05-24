function plotBlockResponse(app,block,sampleRate)
%PLOTRESPONSE used to plot a systemBlock struct into the impulseresponse,
%amplituderepsonse and phase response figures.
response=app.systemStruct.(block).gResponse();
plot(app.impulseResponse,linspace(0, length(response) / sampleRate , length(response)),response,'*','MarkerIndices',1:5:length(response))

freqResponse=app.systemStruct.(block).gFFT();
plot(app.amplitudeResponse,abs(freqResponse))
plot(app.phaseResponse,angle(freqResponse))
end

