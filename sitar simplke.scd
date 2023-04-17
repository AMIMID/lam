(
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:0.degrad),SinOsc.ar(1,phase:90.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:0.degrad),SinOsc.ar(1,phase:90.neg.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:90.degrad),SinOsc.ar(1,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:90.neg.degrad),SinOsc.ar(1,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:45.degrad),SinOsc.ar(1,phase:135.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(6,phase:45.neg.degrad),SinOsc.ar(1,phase:135.neg.degrad))}.play;
)


{(SinOsc.ar((10)+SinOsc.ar(440,mul:440)))}.play