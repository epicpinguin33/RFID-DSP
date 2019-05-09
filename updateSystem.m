function s = updateSystem(app,s)
s.geometry.d=app.dEditField.Value;
s.geometry.R=app.REditField.Value;
s.geometry.R0=app.R0EditField.Value;

s.Delay_d=getDelay(s.geometry.d,s.sampleRate);
s.Delay_R=getDelay(s.geometry.R,s.sampleRate);
s.Delay_R0=getDelay(s.geometry.R0,s.sampleRate);

s.T=s.TX_antenna.gOutput(s.a,s.sampleRate);

s.D=s.Coupling.gOutput(s.T,s.sampleRate);
s.D_d=s.Delay_d.gOutput(s.D,s.sampleRate);

s.T_R=s.Delay_R.gOutput(s.T,s.sampleRate);
s.C=s.Tag.gOutput(s.T_R,s.sampleRate);
s.C_R=s.Delay_R.gOutput(s.C,s.sampleRate);

s.T_R0=s.Delay_R0.gOutput(s.T,s.sampleRate);
s.O=s.Background.gOutput(s.T_R0,s.sampleRate);
s.O_R0=s.Delay_R0.gOutput(s.O,s.sampleRate);

paddingLength=max([length(s.D_d.vertical) length(s.C_R.vertical) length(s.O_R0.vertical)]);
s.D_d.vertical=zeroPad(s.D_d.vertical,paddingLength);
s.C_R.vertical=zeroPad(s.C_R.vertical,paddingLength);
s.O_R0.vertical=zeroPad(s.O_R0.vertical,paddingLength); 
end
