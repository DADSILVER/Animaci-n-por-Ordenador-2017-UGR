

fn interpolacionLineal x obj1 obj2=
(
	V1 = (obj2-obj1)	
	POS = obj1 + ((normalize V1)*(((length V1)/100)*x))
	
	return POS
)


fn interpolacionCuadratica x obj1 obj2 obj3= 
(
	Inter1=interpolacionLineal x obj1 obj2
	Inter2=interpolacionLineal x obj2 obj3

	return interpolacionLineal x Inter1 Inter2
)

fn animacionInterpolacion obj1 obj2 obj3 obj4=
(
	animate on
	(
		for t in 0 to 100 by 1 do
		(
			at time t
			(
				obj4.pos= interpolacionCuadratica t obj1 obj2 obj3
			)
		)
	)
)

animacionInterpolacion $Box001.pos $Box002.pos $Box003.pos $Ball