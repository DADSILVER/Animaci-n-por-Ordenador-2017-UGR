
posiciones = #([-100,0,0],[-50,40,0],[0,0,40],[50,-40,0],[100,0,0])

i=1

b2 = sphere radius:6 wireColor:red
animate on 
(
	at time 0 b2.pos =[-80,-100,0]
	at time 90 b2.pos =[-80,100,0]
)


i=1
ball = sphere radius:6 wireColor:blue
animate on for t in 60 to 100 by 1 do
( 
	at time 0 ball.pos = [-100,0,0]
	at time 49 ball.pos = [-100,0,0]
	at time t 
	(
		ball.pos= at time (t-10) b2.pos+ [-20,0,0]
	)
)

i=1


b3 = sphere radius:3 wireColor:green
animate on for t in 0 to 90 by 1 do(
	at time 0 b3.pos=  [-80,0,0]
	at time 42 b3.pos=  [-80,0,0]

	at time t 
	(
		p1 = at time t b3.pos
		p2 = at time t b2.pos
		distance p2 p1 
		if at time t distance p2 p1 < 10 then b3.pos= b2.pos + [0,10,0]
		
	)
)