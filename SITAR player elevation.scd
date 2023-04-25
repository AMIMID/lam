


(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:3);
)

(
SynthDef.new(\player,{
	arg tempo;
	var env,el1,el2,el3,el4;
	var rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1,rotation7=1,rotation8=1;
	var detune,bank=32, angle=180;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	env=EnvGen.ar(Env.sine(120,tempo.reciprocal), doneAction: 2);

	rotation1=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation2=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation3=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation4=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation5=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation6=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation7=TExpRand.ar(1,2,Dust.ar(0.1));
	rotation8=TExpRand.ar(1,2,Dust.ar(0.1));

	bank.do{

	angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

el1=Pan4.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e1.numFrames.rand,loop:inf,rate:tempo),SinOsc.ar(rotation1*detune.real,phase:detune.theta),SinOsc.ar(rotation2*detune.imag,phase:detune.theta));
		el2=Pan4.ar(PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:~e2.numFrames.rand,loop:inf,rate:tempo),SinOsc.ar(rotation3*detune.real,phase:detune.theta),SinOsc.ar(rotation4*detune.imag,phase:detune.theta));
		el3=Pan4.ar(PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:~e3.numFrames.rand,loop:inf,rate:tempo),SinOsc.ar(rotation5*detune.real,phase:detune.theta),SinOsc.ar(rotation6*detune.imag,phase:detune.theta));
		el4=Pan4.ar(PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:~e4.numFrames.rand,loop:inf,rate:tempo),SinOsc.ar(rotation7*detune.real,phase:detune.theta),SinOsc.ar(rotation8*detune.imag,phase:detune.theta));


    wrappedOut.value(out, LeakDC.ar(el1 * env));
	wrappedOut.value(out, LeakDC.ar(el2 * env));
	wrappedOut.value(out, LeakDC.ar(el3 * env));
    wrappedOut.value(out, LeakDC.ar(el4 * env));
	}
}).add;
)

(
Pdef(\1, Pbind(\instrument, \player,
	\dur,60,
	\tempo,Pxrand([1,3/4,2/3,1/2],inf);
)).play;
)



