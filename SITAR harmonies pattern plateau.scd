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
(
SynthDef.new(\oa, {
	arg  n=1, cutt=220,decay=6,rot=1;
	var detune1,detune2;
	var osc1;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1;
	var cf=8, fund=(((4*2)-1)*((4*2)/2));
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=24;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*4;
	freq1=freq1*(1/1);

env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal*0.5),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);




osc1=Pan4.ar(SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune1.theta),SinOsc.ar(over*pitch,phase:detune1.real.degrad,mul:over.reciprocal*pitch.reciprocal),SinOsc.ar(over*pitch,phase:detune1.imag.degrad,mul:over.reciprocal*pitch.reciprocal));

	wrappedOut.value(out, LeakDC.ar(LPF.ar(osc1 * env * (1/1), cutt)));

		m = m+1;
		over = over + (m+1)/1;

	};
	out=(0..3).rotate(4.rand);
}).add;
);
)


(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pbrown(1/2,2,1/2,inf),
	\n,Pbrown(992.neg,992,1,inf),
	\cutt,Pexprand(248,248,inf),
	\decay,Pbrown(4,6,1,inf);
)).play;
)
s.record(numChannels:4) ;

(
(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Prand([3,8,11,15,11,8,3,8,11,15,11,8,3,10,8,22,20,15,11,10,8,10,8,22,20,15,11,10,8,15,10,11,20,\rest,\rest,\rest,20,\rest,15,\rest,\rest,\rest,20,\rest],inf),
	\cutt,Pbrown(220,440,1,inf),
	\decay,Pbrown(6,8,1,inf);
)).play;
);
(
Pdef(\2, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Prand([20,\rest,\rest,\rest,20,\rest,15,\rest,\rest,\rest,20,\rest,15,3,8,11,15,11,8,3,8,11,15,11,8,3,10,8,22,20,15,11,10,8,10,8,22,20,15,11,10,8,15,10,11],inf),
	\cutt,Pbrown(220,440,1,inf),
	\decay,Pbrown(6,8,1,inf);
)).play;
)
)



