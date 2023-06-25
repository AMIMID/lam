
s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/80);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

Buffer.freeAll

(
(~tf=Array.fill(96,{
	var amps;
	amps = [1] ++ ({[exprand(0.1,1),exprand(0.1,1)].choose}!2);
	Signal.sineFill(1025, [1,1],[0.degrad,90.degrad]).asWavetableNoWrap;
});
);
~tBuf = Buffer.allocConsecutive(96,s,2048);

(
~tBuf.do({
	arg buf, i;
	buf.loadCollection(~tf[i]);
});
);
)
~tf.do({arg n,i; n.plot(~tBuf[i].bufnum.asString)});
(((4*2)-1)*((4*2)/2))
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*6;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*2),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=10;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*8;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(3/2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=20;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*9;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(4/3)),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=30;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*12;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));

		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*1),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oe, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=40;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*6;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\of, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=50;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*8;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(3/2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\og, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=60;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*9;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(4/3)),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oh, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=70;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=6;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*12;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(1)),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);


MIDIClient.init;
MIDIIn.connectAll;

/////

// MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln; ~a.set(\cutt,val.linlin(1,127,110,880))},7);
// ~a=Synth.new(\oa);
// ~a.set(\cutt,220)

MIDIdef.noteOn(\synhtone, { |val, num, chan, src|
	[val, num, chan, src].postln;
	if(num < 49) {
		num = num - 1
	};
	Synth(\oa, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\ob, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oc, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\od, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oe, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\of, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\og, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oh, [n: num - 48, out: (0..3).rotate(4.rand)]);
}, noteNum: (36..96))
)

s.record(numChannels:4);
(
(
(
Tdef.new(\h,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 6th with normal sustain
Synth(\oa, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);
Synth(\od, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);
Synth(\oe, [n: 2,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\oa, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oa, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\oa, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\oa, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\oa, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oa, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oa, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oa, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oa, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;


	}
)})
);
(
Tdef.new(\i,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 4th with normal sustain
Synth(\ob, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\ob, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\ob, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\ob, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\ob, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 7, decay:1*v,out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\ob, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\ob, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\ob, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\ob, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\ob, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
	}
)})
);
(
Tdef.new(\j,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 5th with normal sustain
Synth(\oc, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oc, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oc, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\oc, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\oc, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\oc, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oc, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oc, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oc, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oc, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

	}
)})
);
(
Tdef.new(\k,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first octave with normal sustain
Synth(\od, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\od, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\od, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\od, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\od, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\od, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\od, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\od, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\od, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\od, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
	}
)})
);
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sine
(
(
Tdef.new(\l,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 6th with normal sustain
Synth(\oe, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oe, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oe, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\oe, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\oe, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\oe, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oe, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oe, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oe, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oe, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
	}
)})
);
(
Tdef.new(\m,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 4th with normal sustain
Synth(\of, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\of, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\of, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\of, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\of, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\of, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\of, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\of, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\of, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\of, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

	}
)})
);
(
Tdef.new(\n,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 5th with normal sustain
Synth(\og, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\og, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\og, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\og, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\og, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\og, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\og, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\og, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\og, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\og, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
	}
)})
);
(
Tdef.new(\o,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first octave with normal sustain
Synth(\oh, [n: 0,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oh, [n: 7,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 10,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oh, [n: 14,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);1.wait;
Synth(\oh, [n: 12,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
Synth(\oh, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 7, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;

Synth(\oh, [n: 10,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oh, [n: 12,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 9, decay:1*exprand(2,4),out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;

Synth(\oh, [n: 2,decay:4*exprand(2,4), out: (0..3).rotate(4.rand)]);(1).wait;
Synth(\oh, [n: 9,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 5,decay:1*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/4).wait;
Synth(\oh, [n: 7,decay:2*exprand(2,4), out: (0..3).rotate(4.rand)]);(1/2).wait;
	}
)})
);
)
)

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
////////////////////4th
Tdef(\i).stop;
Tdef(\i).play;
Tdef(\i).clear;
/////////////////5th
Tdef(\j).stop;
Tdef(\j).play;
Tdef(\j).clear;
//////////////////6th
Tdef(\k).stop;
Tdef(\k).play;
Tdef(\k).clear;

/////////////////////////////////////sine

Tdef(\l).stop;
Tdef(\l).play;
Tdef(\l).clear;
////////////////////4th
Tdef(\m).stop;
Tdef(\m).play;
Tdef(\m).clear;
/////////////////5th
Tdef(\n).stop;
Tdef(\n).play;
Tdef(\n).clear;
//////////////////6th
Tdef(\o).stop;
Tdef(\o).play;
Tdef(\o).clear;

(
Tdef.new(\oo,{

	Tdef(\h).play;(10).wait;
	Tdef(\k).play;(10).wait;
	Tdef(\m).play;(30).wait;
     Tdef(\j).play;
	//Tdef(\h).stop;(1).wait;
	//Tdef(\m).stop;(1).wait;
	//Tdef(\k).stop;
	//Tdef(\j).stop;
	Tdef(\o).play;(10).wait;
	Tdef(\m).play;
	Tdef(\j).play;(30).wait;
	Tdef(\k).play;
	//Tdef(\o).stop;
	//Tdef(\m).stop;(15).wait;
	//Tdef(\j).stop;
	//Tdef(\k).stop;(10).wait;
	Tdef(\i).play;(10).wait;
	Tdef(\m).play;(10).wait;
	Tdef(\o).play;(15).wait;
	//Tdef(\m).stop;(1).wait;
	//Tdef(\i).stop;(10).wait;
	//Tdef(\o).stop;
}
)
)

Tdef(\oo).stop;
Tdef(\oo).play;
Tdef(\oo).clear;