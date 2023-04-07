s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*32;

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;
~a= Buffer.readChannel(s,path:"/Users/petrostatsiopoulos/Desktop/album/analogue dreams.wav",channels:0);
~b= Buffer.readChannel(s,path:"/Users/petrostatsiopoulos/Desktop/album/analogue dreams.wav",channels:1);
b=Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/m.mp3");
b.play
(
SynthDef.new(\o, {
	var detune, detune1;
	var osc_1, osc_2;
	var angle, angle1;

	angle=90;
	angle1=0;
	detune=1;
	detune1=1;

	100.do {
		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		osc_1 = Pan2.ar(FreeVerb.ar(PlayBuf.ar(1,0,BufRateScale.kr(0)),room:1),pos:SinOsc.ar(detune.imag*PlayBuf.ar(1,0,BufRateScale.kr(0)),phase:detune.theta+90.degrad));

		osc_2 = Pan2.ar(FreeVerb.ar(PlayBuf.ar(1,1,BufRateScale.kr(1)),room:1),pos:SinOsc.ar(detune1.real*PlayBuf.ar(1,1,BufRateScale.kr(1)),phase:detune1.theta));
	};
        Out.ar(0,osc_1);
		Out.ar(0,osc_2);
}).add;
)


Synth.new(\o);

///

((4*128)-1)*((4*128)/2);
////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
