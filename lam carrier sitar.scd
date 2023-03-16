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

s.options.numOutputBusChannels=12;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.waitForBoot

/////////////////////////////synths that produce spatialized in cubic space an additive synthesis. 6 synths in total, 4 for azimuth in quad sound and two for elevation in stereo. Each synth has 3 oscillators that occupy 4*18 partials in the additive synthesis. The additive synthesis utilized Fm synthesis for scaling the tone frequency spectrum to the required speaker driver range. Envelopes are a sine window and notes are produced in sequence with the use of patterns in the scale tone=freq*2^(n/28). The scale reach is variable. Output channel sequence is BACK,LEFT,RIGHT,FRONT,UP(elevetion:1),DOWN(elevation:-1)

(
(
SynthDef.new(\oa, {
	arg n1=1, n2=1, n3=1,rotation=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope, envelopex, envelopey, envelopez;
	var osc_1, osc_2, osc_3;
	var over1, over2, over3, over4, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var l1,f2,l2;
	var modamp;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var modfreq;

	over1=1;
	over2=2;
	over3=3;
	over4=4;
	m=0;
	frequency=1;
	bank=18;
	angle=0;
	detune=1;
	modamp=1;
	modfreq=2;
	scale=modamp.reciprocal;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.01,8,scale), doneAction: 2);
	//envelope=  EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	//envelope= EnvGen.ar(Env.new([0,scale,0],[2],curve:[-4,4]), doneAction: 2);

	freq =(((4*2)-1)*((4*2)/2));
	l1=(v/freq);
	l2=l1/modfreq;
	f2=(v/l2);


	bank.do{

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar((SinOsc.ar(freq:((note1*f2)*over1)+detune.real,mul:((cf*note1)*over1).reciprocal,phase:(94.757+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over1)+detune.real,mul:(((cf*note1)*over1).reciprocal)*modamp,phase:(94.757+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:(131.747+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over3)+detune.real,mul:(((cf*note1)*over3).reciprocal)*modamp,phase:(131.747+angle).degrad)))
		+
		(SinOsc.ar(freq:((note1*f2)*over2)+detune.real,mul:((cf*note1)*over2).reciprocal,phase:(82.338+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over2)+detune.real,mul:(((cf*note1)*over2).reciprocal)*modamp,phase:(82.338+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over4)+detune.real,mul:((cf*note1)*over4).reciprocal,phase:(67.938+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over4)+detune.real,mul:(((cf*note1)*over4).reciprocal)*modamp,phase:(67.938+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_2 = (Pan4.ar((SinOsc.ar(freq:((note2*f2)*over1)+detune.real,mul:((cf*note2)*over1).reciprocal,phase:(94.757+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over1)+detune.real,mul:(((cf*note2)*over1).reciprocal)*modamp,phase:(94.757+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over3)+detune.real,mul:((cf*note2)*over3).reciprocal,phase:(131.747+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over3)+detune.real,mul:(((cf*note2)*over3).reciprocal)*modamp,phase:(131.747+angle).degrad)))
		+
		(SinOsc.ar(freq:((note2*f2)*over2)+detune.real,mul:((cf*note2)*over2).reciprocal,phase:(82.338+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over2)+detune.real,mul:(((cf*note2)*over2).reciprocal)*modamp,phase:(82.338+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over4)+detune.real,mul:((cf*note2)*over4).reciprocal,phase:(67.938+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over4)+detune.real,mul:(((cf*note2)*over4).reciprocal)*modamp,phase:(67.938+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_3 = (Pan4.ar((SinOsc.ar(freq:((note3*f2)*over1)+detune.real,mul:((cf*note3)*over1).reciprocal,phase:(94.757+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over1)+detune.real,mul:(((cf*note3)*over1).reciprocal)*modamp,phase:(94.757+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:(131.747+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over3)+detune.real,mul:(((cf*note3)*over3).reciprocal)*modamp,phase:(131.747+angle).degrad)))
		+
		(SinOsc.ar(freq:((note3*f2)*over2)+detune.real,mul:((cf*note3)*over2).reciprocal,phase:(82.338+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over2)+detune.real,mul:(((cf*note3)*over2).reciprocal)*modamp,phase:(82.338+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over4)+detune.real,mul:((cf*note3)*over4).reciprocal,phase:(67.938+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over4)+detune.real,mul:(((cf*note3)*over4).reciprocal)*modamp,phase:(67.938+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;

		Out.ar(0,osc_1);
		Out.ar(0,osc_2);
	    Out.ar(0,osc_3);

		m = m+1;
		over1 = over1 + (m+1)/1;
		over2 = over2 + (m+1)/1;
		over3 = over3 + (m+1)/1;
		over4 = over4 + (m+1)/1;

	};

}).add;
);

///////////////////////////////////////////////

(
SynthDef.new(\ob, {
	arg n1=1, n2=1, n3=1,rotation=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope, envelopex, envelopey, envelopez;
	var osc_1, osc_2, osc_3;
	var over1, over2, over3, over4, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var l1,f2,l2;
	var modamp;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var modfreq;

	over1=1;
	over2=2;
	over3=3;
	over4=4;
	m=0;
	frequency=1;
	bank=18;
	angle=0;
	detune=1;
	modamp=1;
	modfreq=2;
	modfreq=2;
	scale=modamp.reciprocal;

fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.01,8,scale), doneAction: 2);
	//envelope=  EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	//envelope= EnvGen.ar(Env.new([0,scale,0],[2],curve:[-4,4]), doneAction: 2);

	freq =(((4*2)-1)*((4*2)/2));
	l1=(v/freq);
	l2=l1/modfreq;
	f2=(v/l2);


	bank.do{

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

		osc_1 = (Pan4.ar((SinOsc.ar(freq:((note1*f2)*over1)+detune.real,mul:((cf*note1)*over1).reciprocal,phase:((94.757+90)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over1)+detune.real,mul:(((cf*note1)*over1).reciprocal)*modamp,phase:((94.757+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:((131.747+90)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over3)+detune.real,mul:(((cf*note1)*over3).reciprocal)*modamp,phase:((131.747+90)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note1*f2)*over2)+detune.real,mul:((cf*note1)*over2).reciprocal,phase:((82.338+90)+angle).degrad,
			add:SinOsc.ar(freq:((note1*freq)*over2)+detune.real,mul:(((cf*note1)*over2).reciprocal)*modamp,phase:((82.338+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over4)+detune.real,mul:((cf*note1)*over4).reciprocal,phase:((67.938+90)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over4)+detune.real,mul:(((cf*note1)*over4).reciprocal)*modamp,phase:((67.938+90)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_2 = (Pan4.ar((SinOsc.ar(freq:((note2*f2)*over1)+detune.real,mul:((cf*note2)*over1).reciprocal,phase:(94.757+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over1)+detune.real,mul:(((cf*note2)*over1).reciprocal)*modamp,phase:((94.757+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over3)+detune.real,mul:((cf*note2)*over3).reciprocal,phase:((131.747+90)+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over3)+detune.real,mul:(((cf*note2)*over3).reciprocal)*modamp,phase:((131.747+90)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note2*f2)*over2)+detune.real,mul:((cf*note2)*over2).reciprocal,phase:((82.338+90)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over2)+detune.real,mul:(((cf*note2)*over2).reciprocal)*modamp,phase:((82.338+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over4)+detune.real,mul:((cf*note2)*over4).reciprocal,phase:((67.938+90)+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over4)+detune.real,mul:(((cf*note2)*over4).reciprocal)*modamp,phase:((67.938+90)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_3 = (Pan4.ar((SinOsc.ar(freq:((note3*f2)*over1)+detune.real,mul:((cf*note3)*over1).reciprocal,phase:((94.757+90)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over1)+detune.real,mul:(((cf*note3)*over1).reciprocal)*modamp,phase:((94.757+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:((131.747+90)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over3)+detune.real,mul:(((cf*note3)*over3).reciprocal)*modamp,phase:((131.747+90)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note3*f2)*over2)+detune.real,mul:((cf*note3)*over2).reciprocal,phase:((82.338+90)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over2)+detune.real,mul:(((cf*note3)*over2).reciprocal)*modamp,phase:((82.338+90)+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over4)+detune.real,mul:((cf*note3)*over4).reciprocal,phase:((67.938+90)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over4)+detune.real,mul:(((cf*note3)*over4).reciprocal)*modamp,phase:((67.938+90)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

		osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;

		Out.ar(0,osc_1);
		Out.ar(0,osc_2);
	    Out.ar(0,osc_3);

		m = m+1;
		over1 = over1 + (m+1)/1;
		over2 = over2 + (m+1)/1;
		over3 = over3 + (m+1)/1;
		over4 = over4 + (m+1)/1;

	};



}).add;
);

//////////////////////////////////////////////////////////

(
SynthDef.new(\oc, {
	arg n1=1, n2=1, n3=1,rotation=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope, envelopex, envelopey, envelopez;
	var osc_1, osc_2, osc_3;
	var over1, over2, over3, over4, m;
	var freq;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var l1,f2,l2;
	var modamp;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var modfreq;

	over1=1;
	over2=2;
	over3=3;
	over4=4;
	m=0;
	frequency=1;
	bank=18;
	angle=0;
	detune=1;
	modamp=1;
	modfreq=2;
	scale=modamp.reciprocal;

		 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	//envelope=  EnvGen.ar(Env.perc(0.01,8,scale), doneAction: 2);
	//envelope=  EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	envelope= EnvGen.ar(Env.sine(6,scale), doneAction: 2);
	//envelope= EnvGen.ar(Env.new([0,scale,0],[2],curve:[-4,4]), doneAction: 2);

	freq =(((4*2)-1)*((4*2)/2));
	l1=(v/freq);
	l2=l1/modfreq;
	f2=(v/l2);


	bank.do{

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

osc_1 = (Pan4.ar((SinOsc.ar(freq:((note1*f2)*over1)+detune.real,mul:((cf*note1)*over1).reciprocal,phase:((94.757+45)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over1)+detune.real,mul:(((cf*note1)*over1).reciprocal)*modamp,phase:((94.757+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:((131.747+45)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over3)+detune.real,mul:(((cf*note1)*over3).reciprocal)*modamp,phase:((131.747+45)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note1*f2)*over2)+detune.real,mul:((cf*note1)*over2).reciprocal,phase:((82.338+45)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over2)+detune.real,mul:(((cf*note1)*over2).reciprocal)*modamp,phase:((82.338+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note1*f2)*over4)+detune.real,mul:((cf*note1)*over4).reciprocal,phase:((67.938+45)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over4)+detune.real,mul:(((cf*note1)*over4).reciprocal)*modamp,phase:((67.938+45)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_2 = (Pan4.ar((SinOsc.ar(freq:((note2*f2)*over1)+detune.real,mul:((cf*note2)*over1).reciprocal,phase:((94.757+45)+angle).degrad,
		add:SinOsc.ar(freq:((note1*freq)*over1)+detune.real,mul:(((cf*note2)*over1).reciprocal)*modamp,phase:((94.757+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over3)+detune.real,mul:((cf*note2)*over3).reciprocal,phase:((131.747+45)+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over3)+detune.real,mul:(((cf*note2)*over3).reciprocal)*modamp,phase:((131.747+45)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note2*f2)*over2)+detune.real,mul:((cf*note2)*over2).reciprocal,phase:((82.338+45)+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over2)+detune.real,mul:(((cf*note2)*over2).reciprocal)*modamp,phase:((82.338+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note2*f2)*over4)+detune.real,mul:((cf*note2)*over4).reciprocal,phase:((67.938+45)+angle).degrad,
		add:SinOsc.ar(freq:((note2*freq)*over4)+detune.real,mul:(((cf*note2)*over4).reciprocal)*modamp,phase:((67.938+45)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

osc_3 = (Pan4.ar((SinOsc.ar(freq:((note3*f2)*over1)+detune.real,mul:((cf*note3)*over1).reciprocal,phase:((94.757+45)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over1)+detune.real,mul:(((cf*note3)*over1).reciprocal)*modamp,phase:((94.757+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over3)+detune.real,mul:((cf*note1)*over3).reciprocal,phase:((131.747+45)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over3)+detune.real,mul:(((cf*note3)*over3).reciprocal)*modamp,phase:((131.747+45)+angle).degrad)))
		+
		(SinOsc.ar(freq:((note3*f2)*over2)+detune.real,mul:((cf*note3)*over2).reciprocal,phase:((82.338+45)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over2)+detune.real,mul:(((cf*note3)*over2).reciprocal)*modamp,phase:((82.338+45)+angle).degrad))
		*
		SinOsc.ar(freq:((note3*f2)*over4)+detune.real,mul:((cf*note3)*over4).reciprocal,phase:((67.938+45)+angle).degrad,
		add:SinOsc.ar(freq:((note3*freq)*over4)+detune.real,mul:(((cf*note3)*over4).reciprocal)*modamp,phase:((67.938+45)+angle).degrad)))

,xpos:SinOsc.ar(detune.real,phase:detune.theta+0.degrad),ypos:SinOsc.ar(detune.imag,phase:detune.theta+90.degrad)));

			osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;

		Out.ar(0,osc_1);
		Out.ar(0,osc_2);
	    Out.ar(0,osc_3);

		m = m+1;
		over1 = over1 + (m+1)/1;
		over2 = over2 + (m+1)/1;
		over3 = over3 + (m+1)/1;
		over4 = over4 + (m+1)/1;

	};



}).add;
);


)

/////////////////////////////////Synth Patterns(generators)
(
Pdef(\1, Pbind(\instrument, \oa, \dur,Pexprand(6,6,28*4),
	\cf,Prand([2],28*4,),
	\n1,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
   \n2,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
  	\n3,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
	\rotation,Pexprand(1,6,28*4,);
)).play(quant:1);
Pdef(\2, Pbind(\instrument, \ob, \dur,Pexprand(6,6,28*4),
	\cf,Prand([2],28*4,),
	\n1,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
   \n2,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
  	\n3,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
	\rotation,Pexprand(1,6,28*4,);
)).play(quant:1);

Pdef(\3, Pbind(\instrument, \oc, \dur,Pexprand(6,6,28*4),
	\cf,Prand([2],28*4,),
	\n1,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
   \n2,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
  	\n3,Pseq(Array.fill(28*4, { arg i; i + 2 }),1),
	\rotation,Pexprand(1,6,28*4,);
)).play(quant:1);
)

////record in 6 channels beggining to end of pattern definition duration
s.record(numChannels:4) ;

////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
////CHANNELS:BLRF_LR


/////channel recordings will be downmixed in stereo under the above sequence for use in the Granulator.
////Granulator uses the left and right mono individual channels from the resulting mix, as buffers

