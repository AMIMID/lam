(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms21pattern.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms21pattern.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms21pattern.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms21pattern.wav",channels:3);

~e5 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms20 pattern cont.wav",channels:0);
~e6 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms20 pattern cont.wav",channels:1);
~e7 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms20 pattern cont.wav",channels:2);
~e8 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms20 pattern cont.wav",channels:3);
)

(
var freq1, freq2, freq3, freq4;

{Out.ar(0,FreqShift.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf,rate:1),100.neg))}.play;
{Out.ar(1,FreqShift.ar(PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf,rate:1),100.neg))}.play;
{Out.ar(2,FreqShift.ar(PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf,rate:1),100.neg))}.play;
{Out.ar(3,FreqShift.ar(PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf,rate:1),100.neg))}.play;

)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*32;
s.waitForBoot
)

(
SynthDef.new(\machine,{
	//arg tempo;
	//var env;
    var freq1, freq2, freq3, freq4;

	//env=EnvGen.ar(Env.sine(60,tempo.reciprocal), doneAction: 2);



	freq1=Pitch.kr(in: PlayBuf.ar(1,4,BufRateScale.kr(4),startPos:0,loop:inf,rate:1),

		initFreq: 0, minFreq: 2.pow(1/(2*496)), maxFreq: 2.pow((2*496)/(2*496)), execFreq: 1, maxBinsPerOctave: 16, median: 1, ampThreshold: 0.01, peakThreshold: 0.5, downSample: 1, clar: 1);


	freq2=Pitch.kr(in: PlayBuf.ar(1,5,BufRateScale.kr(5),startPos:0,loop:inf,rate:1),

		initFreq: 0, minFreq: 2.pow(1/(2*496)), maxFreq: 2.pow((2*496)/(2*496)), execFreq: 1, maxBinsPerOctave: 16, median: 1, ampThreshold: 0.01, peakThreshold: 0.5, downSample: 1, clar: 1);


	freq3=Pitch.kr(in: PlayBuf.ar(1,6,BufRateScale.kr(6),startPos:0,loop:inf,rate:1),

		initFreq: 0, minFreq: 2.pow(1/(2*496)), maxFreq: 2.pow((2*496)/(2*496)), execFreq: 1, maxBinsPerOctave: 16, median: 1, ampThreshold: 0.01, peakThreshold: 0.5, downSample: 1, clar: 1);


	freq4=Pitch.kr(in: PlayBuf.ar(1,7,BufRateScale.kr(7),startPos:0,loop:inf,rate:1),

		initFreq: 0, minFreq:2.pow(1/(2*496)), maxFreq: 2.pow((2*496)/(2*496)), execFreq: 1, maxBinsPerOctave: 16, median: 1, ampThreshold: 0.01, peakThreshold: 0.5, downSample: 1, clar: 1);

freq1.poll;

	Out.ar(0,FreqShift.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf,rate:1),freq1));

	Out.ar(1,FreqShift.ar(PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf,rate:1),freq2));

	Out.ar(2,FreqShift.ar(PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf,rate:1),freq3));

	Out.ar(3,FreqShift.ar(PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf,rate:1),freq4));


}).add;
)

Synth.new(\machine)

s.record(numChannels:4) ;