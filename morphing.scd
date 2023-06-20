//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln//////////////////////////////////synth server and audio settings
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
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

Buffer.freeAll



~b= Buffer.alloc(s,2048);
(
/*	(~tf=Array.fill(32,{
	var numSegs = rrand(4,20);
Env(
[0]++
		(({rrand(0.0,1.0)}!(numSegs-1))*[1,-1]).scramble++[0],
{exprand(1,20)}!numSegs,
{rrand(-20,20)}!numSegs).asSignal(1025).asWavetableNoWrap;
});
);*/

(~tf=Array.fill(64,{
	var amps,phases;
	amps = [1] ++ ({[exprand(0.01,1),exprand(0.1,1)].choose}!rrand(6,12));
	phases = [1] ++ ({[exprand(pi,2pi),exprand(pi,2pi)].choose}!rrand(6,12));
	Signal.sineFill(1025, amps,phases).asWavetableNoWrap;
});
);

~tBuf = Buffer.allocConsecutive(64,s,2048);

(
~tBuf.do({
	arg buf, i;
	buf.loadCollection(~tf[i]);
});
)
)
~tf.do({arg n,i; n.plot(~tBuf[i].bufnum.asString)});

(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=2;
	var amps,tf,tfBuf=0;
	var detune1,detune2;
	var osc1,osc2;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1,ch;
	var cf=8, fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=24;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*2;
	freq1=freq1*(1/1);


/*amps = [1] ++ ({[exprand(0.01,1),exprand(0.01,1)].choose}!8);
tf = Signal.sineFill(1025, amps,0!8);
tf.plot;
tfBuf=~b.loadCollection(tf.asWavetableNoWrap);*/


	bank.do{

		env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);





		osc1=Pan2.ar(
				Shaper.ar(~tBuf[tfBuf].bufnum,
					SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(1))),
						mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
					phase:detune1.theta)),
			LFNoise1.ar(((detune1.theta)*pi).mod(2pi)));

		/*osc1=Pan2.ar(
			LeakDC.ar(
				Shaper.ar(~tBuf[tfBuf].bufnum,
					SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Impulse.kr(1))),
						mul:LFNoise1.kr(TExpRand.ar(0.1,10,Impulse.kr(0.1))),
						phase:((detune1.real.round(0.001))*pi).mod(2pi)))),
			EnvGen.ar(Env.new([detune1.imag.round(0.001),detune1.real.round(0.001)],[decay])));
	    osc2=Pan2.ar(
				LeakDC.ar(
					Shaper.ar(~tBuf[tfBuf].bufnum,
					SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Impulse.kr(1))),
						mul:LFNoise1.kr(TExpRand.ar(0.1,10,Impulse.kr(0.1))),
						phase:((detune1.imag.round(0.001))*pi).mod(2pi)))),
		EnvGen.ar(Env.new([detune1.real.round(0.001),detune1.imag.round(0.001)],[decay])));
		*/



		tfBuf=tfBuf+1;

			m = m+1;
		over = over + m;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env),cutt));
	//wrappedOut.value(out, LPF.ar(LeakDC.ar((osc2 )* env),cutt));

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
	Synth(\oa, [n: num - 48, out: (0..1).rotate(2.rand)]);
}, noteNum: (36..96))
)


(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,6,
	\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20,18,15,22,11,23,20,8,22,23,15,25,11,23,20],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(12,12,1,inf);
)).play;
);

(
Pdef(\2, Pbind(\instrument, \oa,
	\dur,1/3,
	\n,Pseq([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20,18,15,22,11,23,20,8,22,23,15,25,11,23,20],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(4,6,1,inf);
)).play;
);


