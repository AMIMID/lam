
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
)

(

var angle1=0, detune1, m=1, x=0;
{
	1000.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		detune1=exp(Complex(0,1)*(angle1.degrad));

Out.ar(0,Pan4.ar(SinOsc.ar(110*m,
			mul:m.reciprocal,
			phase:detune1.theta),
	detune1.real.round(0.001),detune1.imag.round(0.001)));

x=x+1;
	m=x+1;
	m.postln;

	};
}.play;
)



(

var angle1=0, detune1, m=1, x=0;
{
	100.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		Out.ar(0,Pan4.ar(SinOsc.ar(1100.rand.postln,
			mul:0.1,
			phase:detune1.theta),
	detune1.real.round(0.001),detune1.imag.round(0.001)));

x=x+1;
	m=x+1;

	};
}.play;
)



Buffer.freeAll
(
	var angle1=1,detune1;

~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!100);
~ph=100.collect{
	angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad).theta;
	};

b= Buffer.alloc(s,2048);

~sig = Signal.sineFill(1024, ~amps,
	~ph
);

~sig.plot;
~wt= ~sig.asWavetable;
b.loadCollection(~wt);
)


{(Osc.ar(b,440,mul:1!2))}.play;