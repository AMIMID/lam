

(
Window.closeAll;
w=Window.new("gui", Rect.new(750,50,500,200));
w.front;
w.alwaysOnTop_(true);

~slider = Slider.new(w.view, Rect.new(20,20,150,30));
~slider.background_(Color.blue(1.0));
~slider.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,220,10000).postln;
	x.set(\cutt,cf);
});
)