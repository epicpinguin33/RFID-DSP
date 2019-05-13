function [s] = systeminit(app)

addpath('function generators')

s.sampleRate = 100;
s.geometry.d = 0.1;
s.geometry.R = 1;
s.geometry.R0= 2;

s.a=getSine(2*pi,2,300,s.sampleRate);

s.Source=systemBlock(1,1,'a');
s.TX_antenna=systemBlock(2);
s.T=s.TX_antenna.gOutput(s.a,s.sampleRate);

s.Coupling=systemBlock(.2);
s.D=s.Coupling.gOutput(s.T,s.sampleRate);
s.Delay_d=getDelay(s.geometry.d,s.sampleRate);
s.D_d=s.Delay_d.gOutput(s.D,s.sampleRate);

s.Delay_R=getDelay(s.geometry.R,s.sampleRate);
s.T_R=s.Delay_R.gOutput(s.T,s.sampleRate);
s.Tag=systemBlock(0.01);
s.C=s.Tag.gOutput(s.T_R,s.sampleRate);
s.C_R=s.Delay_R.gOutput(s.C,s.sampleRate);

s.Delay_R0=getDelay(s.geometry.R0,s.sampleRate);
s.T_R0=s.Delay_R0.gOutput(s.T,s.sampleRate);
s.Background=systemBlock(.5);
s.O=s.Background.gOutput(s.T_R0,s.sampleRate);
s.O_R0=s.Delay_R0.gOutput(s.O,s.sampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength);

%noise addition


if nargin()>0
    app.dEditField.Value=s.geometry.d;
    app.REditField.Value=s.geometry.R;
    app.R0EditField.Value=s.geometry.R0;
    
    plot(app.systemSideView,[-5 5],[0 0])
end
end
