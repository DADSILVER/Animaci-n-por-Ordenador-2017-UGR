ball = sphere radius:5 wireColor:blue pos:[6,0,6]
plano = plane  length:200 width:200 wireColor:red 

-- Posición de un objeto
--$Objeto.pos

-- Vector 'orientación' de un objeto (depende del sistema de coordenadas 'pivote')
--$Objeto.dir

-- Producto vectorial
--v3 = cross v1 v2

-- Creación de un rayo
--Rayo = ray posicionOrigen direccionRayo

-- Calculo de colisión
--Colision = IntersectRay ObjetoIntersecado Rayo

-- Cuaternio A [x y x]
--Quaternion = quat RotAngle (normalize RotVector)

-- Uso de Cuaternios
--RotEuler = QuatToEuler Quaternion
--rotate ObjToRotate RotEuler


fn SetAltura obj =
(
	pos=obj.pos+[0,0,1000]
	RayAlt = ray pos [0,0,0]
	RayAlt.dir=[0,0,-1]
	Colision = IntersectRay plano RayAlt
	

	return Colision.pos+[0,0,obj.radius]
)

fn interpolacionLineal x obj1 obj2 dif =
(
	V1 = (obj2-obj1)	
	POS = obj1 + ((normalize V1)*(((length V1)/(dif))*(x)))
	
	return POS
)


fn interpolacionCuadratica x obj1 obj2 obj3 dif = 
(
	Inter1=interpolacionLineal x obj1 obj2 dif
	Inter2=interpolacionLineal x obj2 obj3 dif

	return interpolacionLineal x Inter1 Inter2 dif
)

Function Lineal Traveler objs Inicio Fin =
(	
	dif= (Fin-Inicio)/(objs.count-1) 
	perimetro=2* pi * Traveler.radius
	animate on
	(
		at time 0
		(
			Traveler.pos=objs[1].pos
			Traveler.pos= SetAltura Traveler
		)
		at time inicio
		(
			Traveler.pos=objs[1].pos
			Traveler.pos= SetAltura Traveler
		)
		for i in 2 to objs.count by 1 do
		(	
			
			
			obj2=(objs[i-1].pos+objs[i].pos)/2
			dis=(distance objs[i-1].pos objs[i].pos)/dif
			
			
			Rayo1 = ray objs[i-1].pos objs[i].pos 
			RotAngle=(dis*360.00)/perimetro
			Quaternion = quat RotAngle (normalize Rayo1.dir)
			
			for t in 0 to dif by 1 do
			(
				at time ((t+(i-2)*dif)+ Inicio)	
				(
					pos1=objs[i-1].pos
					pos2=objs[i].pos
					Traveler.pos= interpolacionCuadratica t pos1 obj2 pos2 dif
					Traveler.pos=SetAltura Traveler
					
					
					
					RotEuler = QuatToEuler Quaternion
					rotate Traveler RotEuler
					
				)
			)
		)
	)
)


rollout Salto "Salto"
(
	global objs=#()
	label EActor "Bola:" 
	pickbutton UI_SelectorActor "Selecciona Bola"
	
	label EAddObj "Add objects:" 
	pickbutton UI_EAddObj "Selecciona obj"
	
	listbox AllObjects "Objects:" items:(for o in objs collect o)
	button removeFromList "Remove Current Item" 

	
	spinner UI_IF "Comienzo" range:[0,100,0] type:#Integer
	spinner UI_FF "Duracion" range:[5,200,100] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	
	on UI_EAddObj picked obj do
	(
		append objs obj
		AllObjects.items = append AllObjects.items (obj.name as string)
	)
	
	on removeFromList pressed do
	(
	  
	  if AllObjects.items.count > 0 and AllObjects.selection > 0 do
	  (
		deleteItem objs AllObjects.selection
		AllObjects.items = deleteItem AllObjects.items AllObjects.selection
	
	  )
	)

	
	on UI_CrearSalto pressed do
	(
		  if Traveler!= undefined do
		  (
			  deletekeys Traveler
			  Traveler.dir = [0,0,1]
				  
   	          Lineal Traveler objs UI_IF.value (UI_IF.value+UI_FF.value) 
			  Traveler.showtrajectory = on
		  )
    )
	
)	

animationRange = interval 0 200
frameRate = 25





createDialog Salto











--ball.pos= [10,10,-11]
--ball.pos= SetAltura ball


--RayoDir = ray ball.pos ball3.pos
--RayAlt = ray ball.pos ball2.pos
--RayoDir.dir.z=0
--Colision = IntersectRay ball3 RayoDir
--RayoDir