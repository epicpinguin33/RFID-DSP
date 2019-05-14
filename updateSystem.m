function s = updateSystem(app,s)
s.geometry.d=app.dEditField.Value;
s.geometry.R=app.REditField.Value;
s.geometry.R0=app.R0EditField.Value;
s.geometry.GroundDepth=app.GroundDepthEditField;

s.Delay_d=getDelay(s.geometry.d,s.simSampleRate);
s.Delay_R=getDelay(s.geometry.R,s.simSampleRate);
s.Delay_R0=getDelay(s.geometry.R0,s.simSampleRate);

s.T=s.TX_antenna.gOutput(s.a,s.simSampleRate);

s.D=s.Coupling.gOutput(s.T,s.simSampleRate);
s.D_d=s.Delay_d.gOutput(s.D,s.simSampleRate);

s.T_R=s.Delay_R.gOutput(s.T,s.simSampleRate);
s.C=s.Tag.gOutput(s.T_R,s.simSampleRate);
s.C_R=s.Delay_R.gOutput(s.C,s.simSampleRate);

s.T_R0=s.Delay_R0.gOutput(s.T,s.simSampleRate);
s.O=s.Background.gOutput(s.T_R0,s.simSampleRate);
s.O_R0=s.Delay_R0.gOutput(s.O,s.simSampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength); 

plotSignal(app,app.Plots.Title,s.simSampleRate)
end
