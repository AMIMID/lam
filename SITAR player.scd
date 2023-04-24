(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:3);
)
(
{Out.ar(0,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e1.numFrames.rand,loop:inf,rate:1/2))}.play;
{Out.ar(1,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:~e2.numFrames.rand,loop:inf,rate:1/2))}.play;
{Out.ar(2,PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:~e3.numFrames.rand,loop:inf,rate:1/2))}.play;
{Out.ar(3,PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:~e4.numFrames.rand,loop:inf,rate:1/2))}.play;
)

s.record(numChannels:4) ;

(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)

(
SynthDef.new(\player,{
	arg tempo;
	var env;

	env=EnvGen.ar(Env.sine(120,tempo.reciprocal), doneAction: 2);

Out.ar(0,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e1.numFrames.rand,loop:inf,rate:tempo)*env);
Out.ar(1,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:~e2.numFrames.rand,loop:inf,rate:tempo)*env);
Out.ar(2,PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:~e3.numFrames.rand,loop:inf,rate:tempo)*env);
Out.ar(3,PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:~e4.numFrames.rand,loop:inf,rate:tempo)*env);
}).add;
)

(
Pdef(\1, Pbind(\instrument, \player,
	\dur,60,
	\tempo,Pxrand([1,3/4,2/3,1/2],inf);
)).play;
)