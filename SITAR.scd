//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*16;

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot
(
(
SynthDef.new(\oa, {
	arg rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1, cf=8, theta=45;
	var frequency,detune1,detune2,detune3;
	var osc1,osc2,osc3;
	var freq;
	var bank, angle1,angle2,angle3,scale;
    var fundamental;

	frequency=1;
	bank=100;
	angle1=0;
	angle2=90;
	angle3=45;

	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	rotation1=TExpRand.ar(1,10,Dust.ar(10));
	rotation2=TExpRand.ar(1,10,Dust.ar(10));
	rotation3=TExpRand.ar(1,10,Dust.ar(10));
	rotation4=TExpRand.ar(1,10,Dust.ar(10));
	rotation5=TExpRand.ar(1,10,Dust.ar(10));
	rotation6=TExpRand.ar(1,10,Dust.ar(10));

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);

		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune3=exp(Complex(0,1)*angle3);




osc1=Pan4.ar(SinOsc.ar(freq,mul:bank.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1*detune1.real,phase:0.degrad),SinOsc.ar(rotation4*detune1.imag,phase:0.degrad));

osc2=Pan4.ar(SinOsc.ar(freq,mul:bank.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2*detune2.real,phase:90.degrad),SinOsc.ar(rotation5*detune2.imag,phase:90.degrad));

osc3=Pan4.ar(SinOsc.ar(freq,mul:bank.reciprocal,phase:detune3.theta),SinOsc.ar(rotation3*detune3.real,phase:45.degrad),SinOsc.ar(rotation6*detune3.imag,phase:45.neg.degrad));


		Out.ar(0,LeakDC.ar(osc1));
		Out.ar(0,LeakDC.ar(osc2));
		Out.ar(0,LeakDC.ar(osc3));

	};

}).add;
);
)


/////////////////////////////////Synth Patterns(generators)
(
Synth.new(\oa);
s.record(numChannels:4) ;
)


(
(
Pdef(\1, Pbind(\instrument, \oa, \dur,Pexprand(2,2,12*8),
	\cf,Prand([1],12*8,),
	\n1,Pseq(Array.fill(12*8, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(12*8, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(12*8, { arg i; i + 1 }),1),
	\rotation1,Pexprand(0.1,1,inf),
	\rotation2,Pexprand(0.1,1,inf),
	\rotation3,Pexprand(0.1,1,inf),
	\theta,Pexprand(45,45,inf);
)).play(quant:1);
);
s.record(numChannels:4) ;
)


////record in 6 channels beggining to end of pattern definition duration

////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
////CHANNELS:BLRF_LR


/////channel recordings will be downmixed in stereo under the above sequence for use in the Granulator.
////Granulator uses the left and right mono individual channels from the resulting mix, as buffers

