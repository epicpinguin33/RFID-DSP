function s = updateSystem(app,s)
s.geometry.d=app.dEditField.Value;
s.geometry.R=app.REditField.Value;
s.geometry.R0=app.R0EditField.Value;
s.geometry.GroundDepth=app.GroundDepthEditField;
s.digSampleRate=app.sampleRateEditField.Value;

s.d=getDelay(s.geometry.d,s.simSampleRate);
s.R=getDelay(s.geometry.R,s.simSampleRate);
s.R0=getDelay(s.geometry.R0,s.simSampleRate);

s.Tx=s.TX_antenna.gOutput(s.a,s.simSampleRate);

s.D=s.Coupling.gOutput(s.Tx,s.simSampleRate);
s.D_d=s.d.gOutput(s.D,s.simSampleRate);

s.T_R=s.R.gOutput(s.Tx,s.simSampleRate);
s.C=s.Tag.gOutput(s.T_R,s.simSampleRate);
s.C_R=s.R.gOutput(s.C,s.simSampleRate);

s.T_R0=s.R0.gOutput(s.Tx,s.simSampleRate);
s.O=s.Background.gOutput(s.T_R0,s.simSampleRate);
s.O_R0=s.R0.gOutput(s.O,s.simSampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength); 

s.Rx=s.D_d+s.C_R+s.O_R0;
s.RX_antenna=systemBlock(5);
s.b=s.RX_antenna.gOutput(s.Rx,s.simSampleRate);
s.simTime = linspace(0, paddingLength / s.simSampleRate , paddingLength);

try 
    plotSignal(app,app.Plots.Title,s.simSampleRate)
end
%EM
s.EM.eps(1)=app.permittivity1EditField.Value;
s.EM.eps(2)=app.permittivity2EditField.Value;
s.EM.eps(3)=app.permittivity3EditField.Value;

s.EM.mu(1)=app.permeability1EditField.Value;
s.EM.mu(2)=app.permeability2EditField.Value;
s.EM.mu(3)=app.permeability3EditField.Value;

s.EM.eta=sqrt(s.EM.eps./s.EM.mu);
end
