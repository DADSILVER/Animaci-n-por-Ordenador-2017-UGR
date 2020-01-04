
fn pol1 x =
(
	x=x/(100*1.0)
	return (-(x*x*x)+(3*(x*x))-(3*x)+1 )
)

fn pol2 x =
(
	x=x/(100*1.0)
	return ((3*(x*x*x))-(6*(x*x))+(3*x) )
)

fn pol3 x =
(
	x=x/(100*1.0)
	return (-(3*(x*x*x))+(3*(x*x)) )
)


fn pol4 x =
(
	x=x/(100*1.0)
	return (x*x*x )
)


fn interpolacionCubica obj1 obj2 obj3 obj4 obj5=
(
	animate on
	(
		for t in 0 to 100 by 1 do
		(
			at time t
			(
				obj5.pos= pol1 t * obj1 + pol2 t * obj2 + pol3 t * obj3 + pol4 t * obj4
			)
		)
	)
)


interpolacionCubica $Box001.pos $Box002.pos $Box003.pos  $Box004.pos $Ball
