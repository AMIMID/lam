

(
Window.closeAll;
w=Window.new("gui", Rect.new(750,50,500,200));
w.front;
w.alwaysOnTop_(true);

~slider = Slider.new(w.view, Rect.new(20,20,150,30))
.background_(Color.blue(1.0))
.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,220,10000).postln;
	if(
		x.isPlaying
		{x.set(\cutt,cf)};
	)
});

~button = Button(w, Rect(430,20,50,30))
.states_([
	["OFF",Color.black,Color.gray(0.8)],
	["ON",Color.white,Color(0.2,0.75,0.95)]
])
.font_(Font("Monaco",18))
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
x=Synth.new(\oa, [n: 12, out: [(0..1).rotate(2.rand)], cutt:~slider.value.linexp(220,10000)]).register;
		},
		{x.free}
	)
})
)

(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=12,harm=3,t=2,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=32;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env=EnvGen.ar(Env.perc(attack.rand,decay,pitch.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:2pi/(detune1.theta)),(m/bank)),
		detune1.real.round(0.0001));


x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )),cutt.lag(0.5)));


	};
}).add;
)