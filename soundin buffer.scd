//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
Server.killAll
({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

(
SynthDef.new(\si, {
	var n1=1,n2=1,gain=0.01;
	var detune1,detune2;
	var osc1,osc2;
	var env;
	var bank, angle1,angle2;
	var pitch1, pitch2;
	var fund=(((4*2)-1)*((4*2)/2));

	bank=100;
	angle1=0;
	angle2=90;
	//n1=TRand.ar(1,12,PlayBuf.ar(1,0,BufRateScale.kr(0),loop:0)).round;
	//n2=TRand.ar(1,12,PlayBuf.ar(1,1,BufRateScale.kr(1),loop:0)).round;

	n1=TRand.ar(1,12,SinOsc.ar(1/2)).round;
	n2=TRand.ar(1,12,SinOsc.ar(1/2)).round;

	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);


osc1=Pan4.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),loop:0),SinOsc.ar(pitch1,phase:detune1.real.degrad,mul:pitch1.reciprocal),SinOsc.ar(pitch2,phase:detune1.imag.degrad,mul:pitch2.reciprocal));
osc2=Pan4.ar(PlayBuf.ar(1,1,BufRateScale.kr(1),loop:0),SinOsc.ar(pitch1,phase:detune2.real.degrad,mul:pitch1.reciprocal),SinOsc.ar(pitch2,phase:detune2.imag.degrad,mul:pitch2.reciprocal));

	Out.ar(0,LeakDC.ar(osc1*gain));
	Out.ar(0,LeakDC.ar(osc2*gain));

	};
}).add;
)

Synth.new(\si);

s.record(numChannels:4) ;


(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/p.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/p.wav",channels:1);
)

(
{Out.ar(0,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf,rate:1))}.play;
{Out.ar(1,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf,rate:1))}.play;
)
