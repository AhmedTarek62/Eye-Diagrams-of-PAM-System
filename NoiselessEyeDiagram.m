function [OutSignal] = NoiselessEyeDiagram(Signal,Ptype,WSize,PulseWidth)
%%Ptype is the pulse shape either 'PRZ', 'PNRZ', 'RCos' or 'Sinc'
%%WSize is the window size in the eye diagram either 1 or 2
%%Signal is PAM stream generated by sampling then quantisation to N Levels
upsampledsignal=upsample(Signal,PulseWidth);
Tp=PulseWidth;
if strcmp(Ptype,'PRZ')
    Pulse = PolarReturntoZero(PulseWidth);
    PRZSignal= conv(upsampledsignal,Pulse);
    PRZSignal=PRZSignal(1:end-Tp+1);
    OutSignal=PRZSignal(1:end-Tp+1);
    if WSize==1
    eyediagram(PRZSignal,WSize*Tp,Tp,Tp/2);
    else
    eyediagram(PRZSignal,WSize*Tp,Tp);
    end
elseif strcmp(Ptype,'PNRZ')
    Pulse=PolarNonReturntoZero(PulseWidth);
    PNRZSignal= conv(upsampledsignal,Pulse);
    PNRZSignal=PNRZSignal(1:end-Tp+1);
    OutSignal=PNRZSignal(1:end-Tp+1);
    if WSize==1
    eyediagram(PNRZSignal,WSize*Tp,Tp,Tp/2);
    else
    eyediagram(PNRZSignal,WSize*Tp,Tp);
    end
elseif strcmp(Ptype,'RCos')
    Pulse=RaisedCosine(0.5,8,PulseWidth);
    RCosSignal= conv(upsampledsignal,Pulse);
    RCosSignal=RCosSignal(2*8*Tp:end-2*8*Tp+1);
    OutSignal=RCosSignal(2*8*Tp:end-2*8*Tp+1);
    if WSize==1
    eyediagram(RCosSignal,WSize*Tp,Tp,Tp/2);
    else
    eyediagram(RCosSignal,WSize*Tp,Tp);
    end
elseif strcmp(Ptype,'Sinc')
    Pulse=IdealNyquist(8,PulseWidth);
    SincSignal= conv(upsampledsignal,Pulse);
    SincSignal=SincSignal(2*8*Tp:end-2*8*Tp+1);
    OutSignal=SincSignal(2*8*Tp:end-2*8*Tp+1);
    if WSize==1
    eyediagram(SincSignal,WSize*Tp,Tp,Tp/2);
    else
    eyediagram(SincSignal,WSize*Tp,Tp);
    end
end
end

