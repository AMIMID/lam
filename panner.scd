~e1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/1.wav");
~e2 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/2.wav");
~e3 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/3.wav");
~e4 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/4.wav");

s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
(
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,1,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,2,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,3,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
)


~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/RECORDING2.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/RECORDING2.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/RECORDING2.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/RECORDING2.wav",channels:3);

s.options.numOutputBusChannels=8;


(
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,1,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,2,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,3,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
)





s.record(numChannels:8) ;