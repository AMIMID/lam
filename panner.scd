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


~E1 = Buffer.readChannel(s,,channels:0);
~E2 = Buffer.readChannel(s,,channels:1);
~E3 = Buffer.readChannel(s,,channels:2);
~E4 = Buffer.readChannel(s,,channels:3);

~K1 = Buffer.readChannel(s,,channels:0);
~K2 = Buffer.readChannel(s,,channels:1);
~K3 = Buffer.readChannel(s,,channels:2);
~K4 = Buffer.readChannel(s,,channels:3);

~L1 = Buffer.readChannel(s,,channels:0);
~L2 = Buffer.readChannel(s,,channels:1);
~L3 = Buffer.readChannel(s,,channels:2);
~L4 = Buffer.readChannel(s,,channels:3);

~M1 = Buffer.readChannel(s,,channels:0);
~M2 = Buffer.readChannel(s,,channels:1);
~M3 = Buffer.readChannel(s,,channels:2);
~M4 = Buffer.readChannel(s,,channels:3);

s.options.numOutputBusChannels=8;


(
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;

{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,4,BufRateScale.kr(4),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,5,BufRateScale.kr(5),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,6,BufRateScale.kr(6),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,6,BufRateScale.kr(7),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;

{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,8,BufRateScale.kr(8),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,9,BufRateScale.kr(9),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,10,BufRateScale.kr(10),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,11,BufRateScale.kr(11),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;

{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,12,BufRateScale.kr(12),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,13,BufRateScale.kr(13),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,14,BufRateScale.kr(15),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,15,BufRateScale.kr(16),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
)





s.record(numChannels:8) ;