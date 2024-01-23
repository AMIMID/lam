
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.options.device_("ASIO : ASIO4ALL v2");
s.reboot
Server.killAll
Buffer.freeAll


(
	var angle1=0,detune1;
~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!12);

~ph=12.collect{
	angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad).theta;
	};

b= Buffer.alloc(s,2048);

~sig = Signal.sineFill(1025, ~amps,~ph);

~sig.plot;
~wt=b.loadCollection(~sig.asWavetableNoWrap);
)



(
(SynthDef.new(\oa, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(2/1)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\ob, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=8,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(3/2)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\oc, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=9,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(4/3)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\od, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=12,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\oe, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(2)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\of, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=8,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(3/2)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\og, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=9,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*(4/3)),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);

(SynthDef.new(\oh, {
	arg  n1=1,n2=1, cutt=1300,decay=6,harm=12,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env1,env2,m=1,x=0;
	var bank, pitch1,pitch2;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		//env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));

		//
		// osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		// 	mul:LFNoise1.kr(1,m.reciprocal),
		// 	phase:detune1.theta))),
		// detune1.real.round(0.0001));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1,m.reciprocal),
			phase:detune1.theta))),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));*/

			 osc1=PanAz.ar(2,FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
		 	mul:LFNoise1.kr(1,m.reciprocal),
		 	phase:detune1.theta))),
		LFSaw.ar(0.999.rand));


//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)*0.3*1),cutt));

		//trig = TDelay.ar(trig, 0.1);


	};
}).add;);




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
	Synth(\oa, [n1: num - 48, out: [(0..1).rotate(2.rand)]]);

}, noteNum: (36..96))
)


(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\harm,Prand([6,8,9,12],inf),
\n1,Prand([
		/*7,14,19,21,22,19,
		5,12,17,19,21,17,
		7,14,19,21,22,19,
		5,12,17,19,21,17,

	    7,14,19,21,22,19,
		5,12,17,19,21,17,
		7,14,19,21,22,19,
		5,12,17,19,21,17,

		7,14,19,22,19,22,
		9,14,18,21,18,21,
		7,14,19,22,19,22,
		9,14,18,21,18,21,

		7,14,19,22,19,22,
		9,14,18,21,18,21,
		7,14,19,22,19,22,
		9,14,18,21,18,21,*/

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19




	],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
))
)

a.play;
a.stop;

s.record(numChannels:4)



s.record(numChannels:4);

(
(
(
Tdef.new(\h,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 6th with normal sustain
Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 6th with 2x sustain
Synth(\oa, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oa, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 6th with normal sustain and octave

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 6th and fifth

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 6th and sine octave and 4th

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 6th and sine 5th

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 6th and sine 6th

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 6th and sine 4th

Synth(\oa, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oa, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oa, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;



	}
)})
);
(
Tdef.new(\i,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 4th with normal sustain
Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 4th with 2x sustain
Synth(\ob, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\ob, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 4th with normal sustain and octave

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 4th and fifth

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 4th and sine octave and 4th

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 4th and sine 5th

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 4th and sine 6th

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 4th and sine 4th

Synth(\ob, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\ob, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\ob, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\ob, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\ob, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	}
)})
);
(
Tdef.new(\j,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 5th with normal sustain
Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 5th with 2x sustain
Synth(\oc, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oc, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 5th with normal sustain and octave

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 5th and fifth

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 5th and sine octave and 4th

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 5th and sine 5th

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 5th and sine 6th

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 5th and sine 4th

Synth(\oc, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oc, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oc, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oc, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;



	}
)})
);
(
Tdef.new(\k,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first octave with normal sustain
Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second octave with 2x sustain
Synth(\od, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\od, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third octave with normal sustain and octave

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth octave and fifth

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth octave and sine octave and 4th

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth octave and sine 5th

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh octave and sine 6th

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth octave and sine 4th

Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\od, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\od, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	}
)})
);
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sine
(
(
Tdef.new(\l,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 6th with normal sustain
Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 6th with 2x sustain
Synth(\oe, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oe, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 6th with normal sustain and octave

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 6th and fifth

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 6th and sine octave and 4th

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 6th and sine 5th

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 6th and sine 6th

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 6th and sine 4th

Synth(\oe, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oe, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oe, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oe, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;



	}
)})
);
(
Tdef.new(\m,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 4th with normal sustain
Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 4th with 2x sustain
Synth(\of, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\of, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 4th with normal sustain and octave

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 4th and fifth

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 4th and sine octave and 4th

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 4th and sine 5th

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 4th and sine 6th

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 4th and sine 4th

Synth(\of, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\of, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\of, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\of, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	}
)})
);
(
Tdef.new(\n,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first 5th with normal sustain
Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second 5th with 2x sustain
Synth(\og, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\og, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third 5th with normal sustain and octave

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth 5th and fifth

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth 5th and sine octave and 4th

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth 5th and sine 5th

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh 5th and sine 6th

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth 5th and sine 4th

Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\og, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\og, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;



	}
)})
);
(
Tdef.new(\o,{loop({
//////////////////////////////////////////////////////////////////////////////////////////first octave with normal sustain
Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////////////////////////second octave with 2x sustain
Synth(\oh, [n1: 0,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*4, out: (0..1).rotate(2.rand)]);1.wait;
Synth(\oh, [n1: 12,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*4,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*4, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*4, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*4, out: (0..1).rotate(2.rand)]);(1/2).wait;

////////////////////////////////////////////////////////////////////////////////////////third octave with normal sustain and octave

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////fourth octave and fifth

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

//////////////////////////////////////////////////////////////////////////////////////	fifth octave and sine octave and 4th

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

	//////////////////////////////////////////////////////////////////////////////////////	sixth octave and sine 5th

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	seventh octave and sine 6th

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

		//////////////////////////////////////////////////////////////////////////////////////	eighth octave and sine 4th

Synth(\oh, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 10,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 14,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;

Synth(\oh, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 10,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 12,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 9, decay:1*2,out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oh, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\og, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);Synth(\od, [n1: 2,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oh, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oc, [n1: 9,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\oe, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);Synth(\ob, [n1: 5,decay:1*2, out: (0..1).rotate(2.rand)]);(1/4).wait;
Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\of, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);Synth(\oh, [n1: 7,decay:2*2, out: (0..1).rotate(2.rand)]);(1/2).wait;

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

	Tdef(\h).play;(20).wait;
	Tdef(\k).play;(20).wait;
	Tdef(\m).play;(40).wait;
     Tdef(\j).play;
	Tdef(\h).stop;(10).wait;
	Tdef(\m).stop;(10).wait;
	Tdef(\k).stop;
	Tdef(\j).stop;
	Tdef(\o).play;(20).wait;
	Tdef(\m).play;
	Tdef(\j).play;(40).wait;
	Tdef(\k).play;
	Tdef(\o).stop;
	Tdef(\m).stop;(20).wait;
	Tdef(\j).stop;
	Tdef(\k).stop;(20).wait;
	Tdef(\i).play;(20).wait;
	Tdef(\m).play;(20).wait;
	Tdef(\o).play;(25).wait;
	Tdef(\m).stop;(10).wait;
	Tdef(\i).stop;(20).wait;
	Tdef(\o).stop;
	Tdef(\k).play;(40).wait;
	Tdef(\o).play;(40).wait;
	Tdef(\j).play;(20).wait;
	Tdef(\k).stop;
	Tdef(\o).stop;
	Tdef(\n).play;(40).wait;
	Tdef(\j).stop;(20).wait;
	Tdef(\n).stop;
}
)
)
s.record(numChannels:4)
Tdef(\oo).stop;
Tdef(\oo).play;
Tdef(\oo).clear;
Tdef(\oo).pause;