function [s] = systeminit(app)

addpath('function generators')

s.simSampleRate = 100;
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

s.a=getSine(2*pi,2,300,s.simSampleRate);

s.Source=systemBlock(1,1);
s.TX_antenna=systemBlock(2);
s.T=s.TX_antenna.gOutput(s.a,s.simSampleRate);

s.Coupling=systemBlock(.2);
s.D=s.Coupling.gOutput(s.T,s.simSampleRate);
s.Delay_d=getDelay(s.geometry.d,s.simSampleRate);
s.D_d=s.Delay_d.gOutput(s.D,s.simSampleRate);

s.Delay_R=getDelay(s.geometry.R,s.simSampleRate);
s.T_R=s.Delay_R.gOutput(s.T,s.simSampleRate);
s.Tag=systemBlock(0.01);
s.C=s.Tag.gOutput(s.T_R,s.simSampleRate);
s.C_R=s.Delay_R.gOutput(s.C,s.simSampleRate);

s.Delay_R0=getDelay(s.geometry.R0,s.simSampleRate);
s.T_R0=s.Delay_R0.gOutput(s.T,s.simSampleRate);
s.Background=systemBlock(.5);
s.O=s.Background.gOutput(s.T_R0,s.simSampleRate);
s.O_R0=s.Delay_R0.gOutput(s.O,s.simSampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength);
s.b=signal;
s.b=s.D_d+s.C_R+s.O+s.R0;
%noise addition
s.simTime = linspace(0, paddingLength / s.simSampleRate , paddingLength);

if nargin()>0
   
    app.dEditField.Value=s.geometry.d;
    app.REditField.Value=s.geometry.R;
    app.R0EditField.Value=s.geometry.R0;
    app.analogsimrateEditField.Value=s.simSampleRate;
    app.GroundDepthEditField.Value=s.geometry.GroundDepth;
    plotSideView(app.systemSideView,s.geometry)
    
    % app.Plots.Title='a';
    %plotSignal(app,app.Plots.Title,s.simSampleRate)
end
end
