(
var y1,y2,y3,y4,y5,y6,y7,y8;
var	p1,p2,p3,p4;
var run = true;
var x1=0,x2=0,x3=0,x4=0;
var ray=0;
var rad1=1,rad2=1,rad3=1,rad4=1,rad5=1,rad6=1,rad7=1,rad8=1;


///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
~v.animate;
~v.drawFunc ={
Pen.translate(400,300);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
2000.do{

		x1=x1+(1*(0.00001));
		p1= (x1)/1;
		x2=x2+(1*(0.00001));
		p2= (x2)/1;
		//x3=x3+(1*(~c*0.001));
		//p3= (x3)/1;
		//x4=x4+(1*(~d*0.001));
		//p4= (x4)/1;


		y=exp(Complex(0,1)*(ray.degrad));
		y1=exp(Complex(0,1)*(ray.degrad+p1));
		y2=exp(Complex(0,1)*(ray.degrad+p2));
		//y3=exp(Complex(0,1)*(angle.degrad+p3));
		//y4=exp(Complex(0,1)*(angle.degrad+p4));

			Pen.width=0.1;
			rad1=y1.real*200;
		    rad2=y1.imag*200;
		    rad3=y2.real*200;
		    rad4=y2.imag*200;
		   // rad5=y3.real*300;
		   // rad6=y3.imag*300;
		   // rad7=y4.real*300;
		   // rad8=y4.imag*300;


		Color(red:1,green:1,blue:1,alpha:1).set;

		//Pen.addOval(Rect.new(Polar.new(200,2pi/y.theta).asPoint.x,Polar.new(200,2pi/y1.theta).asPoint.y,1,1));

		//Pen.addOval(Rect.new(Polar.new(200,2pi/y.theta).asPoint.x,Polar.new(200,2pi/y2.theta).asPoint.y,1,1));

		//Pen.addOval(Rect.new(Polar.new(rad5,y.theta).asPoint.x,Polar.new(rad6,y3.theta).asPoint.y,~c*10,~c*10));
//
		//Pen.addOval(Rect.new(Polar.new(rad7,y.theta).asPoint.x,Polar.new(rad8,y4.theta).asPoint.y,~d*10,~d*10));





		Pen.line(Point.new(Polar.new(rad1,2pi/(y.theta)).asPoint.x,Polar.new(rad2,2pi/(y1.theta)).asPoint.y));
		//Pen.line(Point.new(Polar.new(rad3,(y.theta)*pi).asPoint.x,Polar.new(rad4,(y2.theta)*pi).asPoint.y));
		//Pen.line(Point.new(Polar.new(rad5,y5.theta).asPoint.x,Polar.new(rad6,y6.theta).asPoint.y));
		//Pen.line(Point.new(Polar.new(rad7,y7.theta).asPoint.x,Polar.new(rad8,y8.theta).asPoint.y));

		Pen.rotate(2pi/2);
		Pen.stroke;~v.refresh;

ray=(ray+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);


			};

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/100).wait } }.fork(AppClock);
)