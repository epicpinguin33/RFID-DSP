function outputArg1 = adcSimulation(sig,simrate,samplerate,ADCrange,ADCbits)
%ADCSIMULATION Summary of this function goes here
%   Detailed explanation goes here
sigvertical=sig.vertical;
Nsamples=length(sigvertical)/simrate*samplerate; % amount of samples taken from the signal
sampleTimeVector=floor(linspace(1,length(sigvertical),Nsamples));
assignin('base','sampevector',sigvertical(sampleTimeVector));
outputArg1=signal();
outputArg1.vertical=adc([-5 5],6,sigvertical(sampleTimeVector)); % clipping values and bits should be function inputs
outputArg1.sampleRate=samplerate;
end

