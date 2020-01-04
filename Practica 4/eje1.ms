ball = sphere radius:6 wireColor:blue

posiciones = #([-100,0,0],[-50,40,0],[0,0,40],[50,-40,0],[100,0,0])
i=1

animate on for t in 0 to 80 by 20 do
( 
	at time t
	(
		ball.pos = posiciones[i]
		i=1+i
	)
)

i=1

b2 = sphere radius:4 wireColor:red
animate on for t in 10 to 90 by 20 do(
	at time 0 b2.pos = posiciones[1]
	at time t 
	(
		b2.pos = posiciones[i] 
		i=1+i
	)
)

i=1

b3 = sphere radius:2 wireColor:green
animate on for t in 15 to 95 by 20 do(
	at time 0 b3.pos = posiciones[1]
	at time t 
	(
		b3.pos = posiciones[i] 
		i=1+i
	)
)
