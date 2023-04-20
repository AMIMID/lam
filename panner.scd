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
///////////////////////////////////////////////////////////
(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_6.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_6.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_6.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_6.wav",channels:3);

~k1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_8.wav",channels:0);
~k2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_8.wav",channels:1);
~k3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_8.wav",channels:2);
~k4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_8.wav",channels:3);

~l1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_9.wav",channels:0);
~l2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_9.wav",channels:1);
~l3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_9.wav",channels:2);
~l4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_9.wav",channels:3);

~m1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_12.wav",channels:0);
~m2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_12.wav",channels:1);
~m3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_12.wav",channels:2);
~m4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/R_12.wav",channels:3);
)
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


///////////////////////////////////////////////////////////////////
(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms 4.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms 4.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms 4.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms 4.wav",channels:3);
)
(
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf),LFNoise1.ar(1),width:2))}.play;
)




s.record(numChannels:4) ;