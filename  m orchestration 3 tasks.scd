s.record(numChannels:4);

(
(
Tdef.new(\h,{loop({
//////////////////////////////////////////////////////////////////////////////////////////f

Synth(\oa, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;


	}
)})
);

(
Tdef.new(\i,{loop({
//////////////////////////////////////////////////////////////////////////////////////////

Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;



	}
)})
);

(
Tdef.new(\j,{loop({
//////////////////////////////////////////////////////////////////////////////////////////


Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(6).wait;
Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;
Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(6).wait;
Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(6).wait;



	}
)})
);
)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sine

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
////////////////////4th
Tdef(\i).stop;
Tdef(\i).play;
Tdef(\i).clear;
/////////////////5th
Tdef(\j).stop;
Tdef(\j).play;
Tdef(\j).clear;
//////////////////6th
Tdef(\k).stop;
Tdef(\k).play;
Tdef(\k).clear;

/////////////////////////////////////sine

Tdef(\l).stop;
Tdef(\l).play;
Tdef(\l).clear;
////////////////////4th
Tdef(\m).stop;
Tdef(\m).play;
Tdef(\m).clear;
/////////////////5th
Tdef(\n).stop;
Tdef(\n).play;
Tdef(\n).clear;
//////////////////6th
Tdef(\o).stop;
Tdef(\o).play;
Tdef(\o).clear;

(
Tdef.new(\oo,{

	Tdef(\h).play;
	Tdef(\i).play;(4).wait;
	Tdef(\j).play;
}
)
)

Tdef(\oo).stop;
Tdef(\oo).play;
Tdef(\oo).clear;