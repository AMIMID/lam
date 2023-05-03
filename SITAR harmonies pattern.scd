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
	arg  n=1, cutt=220,decay=6;
	var rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1,rotation7=1,rotation8=1;
	var frequency=8,detune1,detune2;
	var osc1,osc2,osc3,osc4,osc5,osc6,osc7,osc8;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!


	frequency=1;
	bank=8;
	angle1=0;
	angle2=90;
	//angle3=45;
	pitch=2.pow(n/(2*496));

	freq1 =(((4*8)-1)*((4*8)/2));
	freq1=freq1*(1/1);
	freq2 =(((4*8)-1)*((4*8)/2));
	freq2=freq2*(3/2);
	freq3 =(((4*8)-1)*((4*8)/2));
	freq3=freq3*(4/3);
	freq4 =(((4*8)-1)*((4*8)/2));
	freq4=freq4*(2/1);


	rotation1=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation2=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation3=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation4=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation5=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation6=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation7=TExpRand.ar(0.01,1,Dust.ar(0.1));
	rotation8=TExpRand.ar(0.01,1,Dust.ar(0.1));


env=EnvGen.ar(Env.sine(decay,pitch.reciprocal*0.5),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);





osc1=Pan4.ar(SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1,phase:detune1.real.degrad),SinOsc.ar(rotation3,phase:detune1.imag.degrad));

osc2=Pan4.ar(SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2,phase:detune2.real.degrad),SinOsc.ar(rotation4,phase:detune2.imag.degrad));

osc3=Pan4.ar(SinOsc.ar((freq2*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune1.theta),SinOsc.ar(rotation5,phase:detune1.real.degrad),SinOsc.ar(rotation6,phase:detune1.imag.degrad));

osc4=Pan4.ar(SinOsc.ar((freq2*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune2.theta),SinOsc.ar(rotation7,phase:detune2.real.degrad),SinOsc.ar(rotation8,phase:detune2.imag.degrad));

osc5=Pan4.ar(SinOsc.ar((freq3*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune1.theta),SinOsc.ar(rotation5,phase:detune1.real.degrad),SinOsc.ar(rotation6,phase:detune1.imag.degrad));

osc6=Pan4.ar(SinOsc.ar((freq3*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune2.theta),SinOsc.ar(rotation7,phase:detune2.real.degrad),SinOsc.ar(rotation8,phase:detune2.imag.degrad));

osc7=Pan4.ar(SinOsc.ar((freq4*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune1.theta),SinOsc.ar(rotation5,phase:detune1.real.degrad),SinOsc.ar(rotation6,phase:detune1.imag.degrad));

osc8=Pan4.ar(SinOsc.ar((freq4*over)*pitch,mul:over.reciprocal*pitch.reciprocal,phase:detune2.theta),SinOsc.ar(rotation7,phase:detune2.real.degrad),SinOsc.ar(rotation8,phase:detune2.imag.degrad));

	wrappedOut.value(out, LeakDC.ar(LPF.ar(osc1 * env * (1/1), cutt)));
	wrappedOut.value(out, LeakDC.ar(LPF.ar(osc2 * env * (1/1), cutt)));
	wrappedOut.value(out, LeakDC.ar(LPF.ar(osc3 * env * (2/3), cutt)));
    wrappedOut.value(out, LeakDC.ar(LPF.ar(osc4 * env * (2/3), cutt)));
	wrappedOut.value(out, LeakDC.ar(LPF.ar(osc5 * env * (3/4), cutt)));
    wrappedOut.value(out, LeakDC.ar(LPF.ar(osc6 * env * (3/4), cutt)));
		wrappedOut.value(out, LeakDC.ar(LPF.ar(osc7 * env * (1/2), cutt)));
    wrappedOut.value(out, LeakDC.ar(LPF.ar(osc8 * env * (1/2), cutt)));

		m = m+1;
		over = over + (m+1)/1;

	};
}).add;
);
)


(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pexprand(1,2,inf),
	\n,Pbrown(1,992,1,inf),
	\cutt,Pexprand(248,2480,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
)
s.record(numChannels:4) ;



