
b= Buffer.alloc(s,2048);

Buffer.freeAll


////////////first approch
(

~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!8);


~sig = Signal.sineFill(1024, ~amps,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764]
);

~sig.plot;
~wt= ~sig.asWavetable;
b.loadCollection(~wt);
)
//////////////second approach
(
b.sine3(
	({exprand(0.75,40)}!8).sort,
	({exprand(0.01,1)}!8).sort,
	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764], asWavetable:true).plot
)

(
b.sine3(
	[2.pow(12/12)],
	[(2.pow(12/12)).reciprocal],
	[0], asWavetable:true).plot
)

/////////third aproach
(
var env,sig,wt,numSegs;
numSegs = rrand(4,20);
env = Env(
	{rrand(-1.0,1.0)}!(numSegs+1) * [1,-1].scramble,
	{exprand(1,20)}!numSegs,
	{rrand(-20,20)}!numSegs
);
sig=env.asSignal(1024);
wt = sig.asWavetable;
b.loadCollection(wt);
sig.plot;
)
////////////////////osc

{Osc.ar(b,220,mul:0.2!2)}.play;


///SHAPER

Buffer.freeAll
b= Buffer.alloc(s,2048);
c= Buffer.alloc(s,2048);

(

~amps1 = [1] ++ ({[0,exprand(0.01,1)].choose}!8);
~amps2 = [1] ++ ({[0,exprand(0.01,1)].choose}!8);


~tf1 = Signal.sineFill(1025, ~amps1,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764]
);

~tf2 = Signal.sineFill(1025, ~amps2,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764]
);

~tf1.plot;
~tf2.plot;
~tf1Buf=b.loadCollection(~tf1.asWavetableNoWrap);
~tf2Buf=c.loadCollection(~tf2.asWavetableNoWrap);
)

{LeakDC.ar(Shaper.ar(~tf1Buf, SinOsc.ar(220)*LFNoise1.kr(1).range(0,1))!2)}.play


//////VOSC



{LeakDC.ar(VOsc.ar(LFNoise1.kr(1), 220!2))}.play

///////////////array data
(
~angle1=0;
16.do{
	~angle1=(~angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	~detune1=exp(Complex(0,1)*~angle1).theta.postln;

	};
)