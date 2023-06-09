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
s.options.numOutputBusChannels=16;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

(

(~tf=Array.fill(32,{
	var amps,phases;
	amps = [1] ++ ({[exprand(0.1,1),exprand(0.1,1)].choose}!rrand(3,12));
	phases = [1] ++ ({[exprand(pi,2pi),exprand(pi,2pi)].choose}!rrand(3,12));
	Signal.sineFill(1025, amps,[0]).asWavetableNoWrap;
});
);

~tBuf = Buffer.allocConsecutive(32,s,2048);

(
~tBuf.do({
	arg buf, i;
	buf.loadCollection(~tf[i]);
});
)
)


(
// 3D
a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [-90, 45],[0, -45], [90, -45], [180, -45], [-90, -45],[0, 0], [45, 0], [90, 0], [135, 0],[180, 0], [-135, 0], [-90, 0], [-45,0]]); // torus geo dome
~b = Buffer.loadCollection(s, a.getSetsAndMatrices);
)
Buffer.freeAll
~c= Buffer.alloc(s,2048);
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=10000,decay=12;
	var amps,tf,tfBuf=0;
	var detune1,detune2;
	var osc1,osc2;
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
	var out1 = NamedControl.kr(\out1, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);  // multiple buses!

bank=12;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*4;
	freq1=freq1*(1/1);


	bank=24;
	angle1=0;
	//angle3=45;
	pitch=2.pow(n/12);

	freq1 = fund*2;
	freq1=freq1*(1/1);




	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);
	//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);






		osc1=VBAP.ar(16,LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.01,0.1,Dust.kr(0.1))),mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),phase:((detune1.real)*pi).mod(2pi)))),~b.bufnum,detune1.real.raddeg.wrap(-180,180),detune1.imag.raddeg.wrap(-90,90));

	tfBuf=tfBuf+1;

	wrappedOut.value(out1, LeakDC.ar(LPF.ar(osc1 * env * (1/1), cutt)));


		m = m+1;
		over = over + (m+1)/1;

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
	Synth(\oa, [n: num - 48, out1: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].rotate(16.rand)]);
}, noteNum: (36..96))
)

s.record(numChannels:16) ;




(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,1,
	\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);