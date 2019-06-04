freq=2450e6;
Pt=25e-6;
Gt=2.14;
Gr=db2pow(11.04);
S11=rfparam(sparameters(h,freq),1,1);
S22=1;
c=299792458;
lambda=c/freq;

k=2*pi/lambda;

PL=( (1-abs(S11)^2)*(1-abs(S22)^2)*lambda^2*Gt*Gr*exp(-alpha*R )/(4)*...
   Etx^2/2 );


Ereceived=RayleighScattering(Xreceiver,Xorb,aOrb,Eincident)
Ereceived=air2sand(Xreceiver,Xtransmitter,geometry,Eincident)