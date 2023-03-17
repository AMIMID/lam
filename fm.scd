
(
    var v=343;
    var modfreq=0.01;
	var freq =(((4*2)-1)*((4*2)/2))*10;
	var l1=(v/freq);
	var l2=l1*modfreq;
	var f2=(v/l2);


{Out.ar(0,SinOsc.ar(f2,add:SinOsc.ar(freq)))}.play;

)

(
    var v=343;
    var modfreq=0.01;
	var freq =(((4*2)-1)*((4*2)/2))*10;
	var l1=(v/freq);
	var l2=l1*modfreq;
	var f2=(v/l2);


{Out.ar(0,SinOsc.ar(f2)+SinOsc.ar(freq))}.play;

)