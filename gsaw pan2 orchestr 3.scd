
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/50);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
Server.killAll
Buffer.freeAll


(
	var angle1=0,detune1;

~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!6);
~ph=6.collect{
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
	arg  n1=1,n2=1, cutt=1300,decay=3,harm=3,t=2,attack=0.01,angle1;
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
	bank=24;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
	pitch2=2.pow(n2/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trig,doneAction:2);
		env2=EnvGen.ar(Env.perc(attack,decay,pitch2.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(Shaper.ar(~wt.bufnum, SinOsc.ar((freq1*m)*pitch1,
						mul:LFNoise1.kr(1),
			phase:detune1.theta))),
		SinOsc.ar(detune1.real.round(0.0001)));

	/*	osc2=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch2,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.imag.round(0.0001));*/


		/*osc1=Pan4.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:(detune1.theta)+LFNoise1.ar(m)),(m/bank)),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));
*/

//x=x+1;
	m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1*env1)),cutt));

		//trig = TDelay.ar(trig, 0.01);


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
\n1,Pseq([
		7,14,19,21,22,19,
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
		9,14,18,21,18,21,




	],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,6,1,inf);
))
)

a.play;
a.stop;

s.record(numChannels:4)