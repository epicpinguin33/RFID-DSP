function [s] = systeminit(app)

addpath('function generators')

s.simSampleRate = 100;
s.digSampleRate = 10;
s.geometry.d = 0.1;
s.geometry.R = 1;
s.geometry.R0= 2;
s.geometry.GroundDepth=0.4;
s.geometry.tempWidth=1;
s.geometry.TxHeight=.3;
s.geometry.RxHeight=.32;
s.geometry.scatterers.y=[];
s.geometry.scatterers.x=[];
s.geometry.Tags=repmat([0;-2*s.geometry.GroundDepth],1,8);

s.a=getSine(20*pi,2,300,s.simSampleRate);

s.Source=systemBlock(1,1);
s.TX_antenna=systemBlock(2);
s.Tx=s.TX_antenna.gOutput(s.a,s.simSampleRate);

s.Coupling=systemBlock(.2);
s.D=s.Coupling.gOutput(s.Tx,s.simSampleRate);
s.d=getDelay(s.geometry.d,s.simSampleRate);
s.D_d=s.d.gOutput(s.D,s.simSampleRate);

s.R=getDelay(s.geometry.R,s.simSampleRate);
s.T_R=s.R.gOutput(s.Tx,s.simSampleRate);
s.Tag=systemBlock(0.01);
s.C=s.Tag.gOutput(s.T_R,s.simSampleRate);
s.C_R=s.R.gOutput(s.C,s.simSampleRate);

s.R0=getDelay(s.geometry.R0,s.simSampleRate);
s.T_R0=s.R0.gOutput(s.Tx,s.simSampleRate);
s.Background=systemBlock(.5);
s.O=s.Background.gOutput(s.T_R0,s.simSampleRate);
s.O_R0=s.R0.gOutput(s.O,s.simSampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength);
%s.b=signal;
s.Rx=s.D_d+s.C_R+s.O_R0;
s.RX_antenna=systemBlock(5);
s.b=s.RX_antenna.gOutput(s.Rx,s.simSampleRate);
s.simTime = linspace(0, paddingLength / s.simSampleRate , paddingLength);
%noise addition
if nargin()>0
   
    app.dEditField.Value=s.geometry.d;
    app.REditField.Value=s.geometry.R;
    app.R0EditField.Value=s.geometry.R0;
    app.analogsimrateEditField.Value=s.simSampleRate;
    app.GroundDepthEditField.Value=s.geometry.GroundDepth;
    app.sampleRateEditField.Value=s.digSampleRate;
    plotSideView(app.systemSideView,s.geometry)
    
end
end
