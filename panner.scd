~e1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/e1.wav");
~e2 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/e2.wav");
~e3 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/e3.wav");
~e4 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/e4.wav");

s.options.numOutputBusChannels=8;
(
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e1.numFrames.rand,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e2.numFrames.rand,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e3.numFrames.rand,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e4.numFrames.rand,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
)




s.record(numChannels:8) ;