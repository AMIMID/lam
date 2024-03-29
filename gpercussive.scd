
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/80);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
Server.killAll
Buffer.freeAll

(
(
SynthDef.new(\base, {
	arg  n=1, cutt=20000,decay=3,harm=1.5,t=2,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=12;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);
	bank.do{

		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,add:BrownNoise.ar(0.05),
			mul:m.reciprocal,
			phase:(detune1.theta)+LFNoise1.ar(m)),(m/bank)),
		detune1.imag.round(0.0001));


x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*2),cutt));
//trig = TDelay.ar(trig, 0.001);

	};
}).add;
);

(
SynthDef.new(\noise1, {
	arg  n=1, cutt=20000,decay=6,harm=6,t=2,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=12;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);
	bank.do{

		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(WhiteNoise.ar(mul:m.reciprocal),m/bank),detune1.real.round(0.0001));


x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*1),cutt));
//trig = TDelay.ar(trig, 0.001);

	};
}).add;
);

(
SynthDef.new(\impulse1, {
	arg  n=1, cutt=20000,decay=6,harm=6,t=2,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=12;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);
	bank.do{

		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(Impulse.ar((freq1)*pitch,
			mul:1,
			phase:(detune1.theta)+LFNoise1.ar(m)),m/bank),detune1.real.round(0.0001));


x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*2),cutt));
//trig = TDelay.ar(trig, 0.001);

	};
}).add;
);

(
x=Pdef(\noise1_pattern, Pbind(\instrument, \noise1,
	\dur,Pseq([1/4,1/2,1/2,1/4,1/2],inf),
	//\harm,Prand([6,8,9,12],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
//\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(220,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,1,0.1,inf),
	\decay,Pbrown(0.1,0.3,0.1,inf);
))
);

(
z=Pdef(\base_pattern, Pbind(\instrument, \base,
	\dur,Pseq([1,1/2,1/2,1,1/2],inf),
	//\harm,Prand([6,8,9,12],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
//\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(220,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,1,0.1,inf),
	\decay,Pbrown(0.1,0.5,0.1,inf);
))
);
(
y=Pdef(\impulse1_pattern, Pbind(\instrument, \impulse1,
	\dur,Pseq([1/4,1/4,1/4,1/4,1/4],inf),
	//\harm,Prand([6,8,9,12],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
//\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(220,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,1,0.1,inf),
	\decay,Pbrown(0.1,0.3,0.1,inf);
))
)
)
(
y.play;
x.play;
z.play;
a.play;
)