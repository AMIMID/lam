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
s.options.memSize = 8192*16;
s.waitForBoot
(
(
SynthDef.new(\oa, {
	arg n1=1, n2=1, n3=1,rotation1=0.01,rotation2=0.01,rotation3=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope;
	var osc_1, osc_2, osc_3,osc_1neg, osc_2neg, osc_3neg;
	var over1, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;

	over1=1;
	over1=2;
	m=0;
	frequency=1;
	bank=12;
	angle=90;
	detune=1;
	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.02,8,1), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,2), doneAction: 2);

	bank.do{

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.degrad)));


osc_2 = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3 = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.degrad)));


osc_1neg = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.neg.degrad)


,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.neg.degrad)));


osc_2neg = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.neg.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3neg = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.neg.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.neg.degrad)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;
		osc_1neg=osc_1neg*envelope;
		osc_2neg=osc_2neg*envelope;
		osc_3neg=osc_3neg*envelope;


		Out.ar(0,LeakDC.ar(osc_1));
		Out.ar(0,LeakDC.ar(osc_2));
		Out.ar(0,LeakDC.ar(osc_3));
		Out.ar(0,LeakDC.ar(osc_1neg));
		Out.ar(0,LeakDC.ar(osc_2neg));
		Out.ar(0,LeakDC.ar(osc_3neg));

		m = m+1;
		over1 = over1 + (m+1)/1;

	};

}).add;
);

(
SynthDef.new(\ob, {
	arg n1=1, n2=1, n3=1,rotation1=0.01,rotation2=0.01,rotation3=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope;
	var osc_1, osc_2, osc_3,osc_1neg, osc_2neg, osc_3neg;
	var over1, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;

	over1=1;
	over1=2;
	m=0;
	frequency=1;
	bank=12;
	angle=90.neg;
	detune=1;
	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.02,8,1), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,2), doneAction: 2);

	bank.do{

		angle=(angle-(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360.neg);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.degrad)));


osc_2 = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3 = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.degrad)));


osc_1neg = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.neg.degrad)


,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.neg.degrad)));


osc_2neg = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.neg.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3neg = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.neg.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.neg.degrad)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;
		osc_1neg=osc_1neg*envelope;
		osc_2neg=osc_2neg*envelope;
		osc_3neg=osc_3neg*envelope;


		Out.ar(0,LeakDC.ar(osc_1));
		Out.ar(0,LeakDC.ar(osc_2));
		Out.ar(0,LeakDC.ar(osc_3));
		Out.ar(0,LeakDC.ar(osc_1neg));
		Out.ar(0,LeakDC.ar(osc_2neg));
		Out.ar(0,LeakDC.ar(osc_3neg));

		m = m+1;
		over1 = over1 + (m+1)/1;

	};

}).add;
);
(
SynthDef.new(\oc, {
	arg n1=1, n2=1, n3=1,rotation1=0.01,rotation2=0.01,rotation3=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope;
	var osc_1, osc_2, osc_3,osc_1neg, osc_2neg, osc_3neg;
	var over1, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;

	over1=1;
	over1=2;
	m=0;
	frequency=1;
	bank=12;
	angle=180;
	detune=1;
	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.02,8,1), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,2), doneAction: 2);

	bank.do{

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.degrad)));


osc_2 = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3 = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.degrad)));


osc_1neg = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.neg.degrad)


,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.neg.degrad)));


osc_2neg = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.neg.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3neg = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.neg.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.neg.degrad)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;
		osc_1neg=osc_1neg*envelope;
		osc_2neg=osc_2neg*envelope;
		osc_3neg=osc_3neg*envelope;


		Out.ar(0,LeakDC.ar(osc_1));
		Out.ar(0,LeakDC.ar(osc_2));
		Out.ar(0,LeakDC.ar(osc_3));
		Out.ar(0,LeakDC.ar(osc_1neg));
		Out.ar(0,LeakDC.ar(osc_2neg));
		Out.ar(0,LeakDC.ar(osc_3neg));

		m = m+1;
		over1 = over1 + (m+1)/1;

	};

}).add;
);

(
SynthDef.new(\od, {
	arg n1=1, n2=1, n3=1,rotation1=0.01,rotation2=0.01,rotation3=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope;
	var osc_1, osc_2, osc_3,osc_1neg, osc_2neg, osc_3neg;
	var over1, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;

	over1=1;
	over1=2;
	m=0;
	frequency=1;
	bank=12;
	angle=180.neg;
	detune=1;
	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.02,8,1), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,2), doneAction: 2);

	bank.do{

		angle=(angle-(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360.neg);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.degrad)));


osc_2 = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3 = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.degrad)));


osc_1neg = (Pan4.ar(SinOsc.ar(freq:((note1*freq)*over1)*detune.real,mul:((cf*note1)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note1*freq)*over1)*detune.imag,mul:((cf*note1)*over1).reciprocal,phase:detune.theta+90.neg.degrad)


,xpos:SinOsc.ar(rotation1*detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(rotation1*detune.imag,phase:detune.theta+90.neg.degrad)));


osc_2neg = (Pan4.ar(SinOsc.ar(freq:((note2*freq)*over1)*detune.real,mul:((cf*note2)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note2*freq)*over1)*detune.imag,mul:((cf*note2)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation2*detune.real,phase:detune.theta+90.neg.degrad),ypos:SinOsc.ar(rotation2*detune.imag,phase:detune.theta+0.degrad)));


osc_3neg = (Pan4.ar(SinOsc.ar(freq:((note3*freq)*over1)*detune.real,mul:((cf*note3)*over1).reciprocal,phase:detune.theta)
		*
		SinOsc.ar(freq:((note3*freq)*over1)*detune.imag,mul:((cf*note3)*over1).reciprocal,phase:detune.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation3*detune.real,phase:detune.theta+45.neg.degrad),ypos:SinOsc.ar(rotation3*detune.imag,phase:detune.theta+135.neg.degrad)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;
		osc_1neg=osc_1neg*envelope;
		osc_2neg=osc_2neg*envelope;
		osc_3neg=osc_3neg*envelope;


		Out.ar(0,LeakDC.ar(osc_1));
		Out.ar(0,LeakDC.ar(osc_2));
		Out.ar(0,LeakDC.ar(osc_3));
		Out.ar(0,LeakDC.ar(osc_1neg));
		Out.ar(0,LeakDC.ar(osc_2neg));
		Out.ar(0,LeakDC.ar(osc_3neg));

		m = m+1;
		over1 = over1 + (m+1)/1;

	};

}).add;
)
)


/////////////////////////////////Synth Patterns(generators)
(
(
Pdef(\1, Pbind(\instrument, \oa, \dur,Pexprand(2,2,28*2),
	\cf,Prand([2],28*2,),
	\n1,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
	\rotation1,Prand([1,3/2,4/3,2],inf),
	\rotation2,Prand([1,3/2,4/3,2],inf),
	\rotation3,Prand([1,3/2,4/3,2],inf);
)).play(quant:1);
);
(
Pdef(\2, Pbind(\instrument, \ob, \dur,Pexprand(2,2,28*2),
	\cf,Prand([2],28*2,),
	\n1,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
	\rotation1,Prand([1,3/2,4/3,2],inf),
	\rotation2,Prand([1,3/2,4/3,2],inf),
	\rotation3,Prand([1,3/2,4/3,2],inf);
)).play(quant:1);
);
(
Pdef(\3, Pbind(\instrument, \oc, \dur,Pexprand(2,2,28*2),
	\cf,Prand([2],28*2,),
	\n1,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
	\rotation1,Prand([1,3/2,4/3,2],inf),
	\rotation2,Prand([1,3/2,4/3,2],inf),
	\rotation3,Prand([1,3/2,4/3,2],inf);
)).play(quant:1);
);
(
Pdef(\4, Pbind(\instrument, \od, \dur,Pexprand(2,2,28*2),
	\cf,Prand([2],28*2,),
	\n1,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(28*2, { arg i; i + 1 }),1),
	\rotation1,Prand([1,3/2,4/3,2],inf),
	\rotation2,Prand([1,3/2,4/3,2],inf),
	\rotation3,Prand([1,3/2,4/3,2],inf);
)).play(quant:1);
)
)

(
Pdef(\1, Pbind(\instrument, \oa, \dur,Pexprand(1,2,inf),
	\cf,Prand([2],inf),
	\n1,Prand(Array.fill(28*4, { arg i; i + 1 }),inf),
   \n2,Prand(Array.fill(28*4, { arg i; i + 1 }),inf),
  	\n3,Prand(Array.fill(28*4, { arg i; i + 1 }),inf),
	\rotation1,Prand([1,2],inf),
	\rotation2,Prand([1,2],inf),
	\rotation3,Prand([1,2],inf);
)).play(quant:1);
);

////record in 6 channels beggining to end of pattern definition duration
s.record(numChannels:4) ;

////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
////CHANNELS:BLRF_LR


/////channel recordings will be downmixed in stereo under the above sequence for use in the Granulator.
////Granulator uses the left and right mono individual channels from the resulting mix, as buffers

