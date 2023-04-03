~e1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/1.wav");
~e2 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/2.wav");
~e3 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/3.wav");
~e4 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/4.wav");

s.options.numOutputBusChannels=8;
(
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,1,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,2,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
{Out.ar(0,PanAz.ar(8,PlayBuf.ar(1,3,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(0.1),width:2))}.play;
)




s.record(numChannels:8) ;