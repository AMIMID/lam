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
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=496;
	var rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1,rotation7=1,rotation8=1;
	var frequency=8,detune1,detune2;
	var osc1,osc2,osc3,osc4;
	var freq1,freq2,env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [1, 4, 3, 5]);  // multiple buses!


	frequency=1;
	bank=4;
	angle1=0;
	angle2=90;
	//angle3=45;
	pitch=2.pow(n/12);

	freq1 =(((4*8)-1)*((4*8)/2));
	freq1=freq1/3;
	freq2 =(((4*8)-1)*((4*8)/2));
	freq2=freq2/2;


	rotation1=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation2=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation3=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation4=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation5=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation6=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation7=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation8=TExpRand.ar(0.1,10,Dust.ar(0.1));


env=EnvGen.ar(Env.perc(0.01,3,pitch.reciprocal*0.5),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);





osc1=Pan4.ar(SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1*detune1.real,phase:detune1.theta),SinOsc.ar(rotation3*detune1.imag,phase:detune1.theta));

osc2=Pan4.ar(SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2*detune2.real,phase:detune2.theta),SinOsc.ar(rotation4*detune2.imag,phase:detune2.theta));

osc3=Pan4.ar(SinOsc.ar((freq2*over)*pitch,mul:over.reciprocal,phase:detune1.theta),SinOsc.ar(rotation5*detune1.real,phase:detune1.theta),SinOsc.ar(rotation6*detune1.imag,phase:detune1.theta));

osc4=Pan4.ar(SinOsc.ar((freq2*over)*pitch,mul:over.reciprocal,phase:detune2.theta),SinOsc.ar(rotation7*detune2.real,phase:detune2.theta),SinOsc.ar(rotation8*detune2.imag,phase:detune2.theta));


	wrappedOut.value(out1, LeakDC.ar(LPF.ar(osc1 * env * (2/3), cutt)));
	wrappedOut.value(out2, LeakDC.ar(LPF.ar(osc2 * env * (2/3), cutt)));
	wrappedOut.value(out1, LeakDC.ar(LPF.ar(osc3 * env * (1/2), cutt)));
    wrappedOut.value(out2, LeakDC.ar(LPF.ar(osc4 * env * (1/2), cutt)));

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
	Synth(\oa, [n: num - 48, out1: [0, 1, 2, 3].rotate(4.rand), out2: [1, 4, 3, 5].rotate(4.rand)]);
}, noteNum: (36..96))
)
s.record(numChannels:6) ;



