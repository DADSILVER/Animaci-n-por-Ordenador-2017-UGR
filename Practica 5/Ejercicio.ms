
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



Function Lineal Traveler objs Inicio Fin aScalemin aScalemax =
(	
	dif= (Fin-Inicio)/(objs.count-1) 
	difParte=dif/5
	
	height1=0
	if objs[1].height >0 do
	(
		height1=objs[1].height
	)
	animate on
	(
		at time 0
		(
			Traveler.pos=objs[1].pos+[0,0,height1]
		)
		at time inicio
		(
			Traveler.pos=objs[1].pos+[0,0,height1]
		)
		for i in 2 to objs.count by 1 do
		(	
			height1=0
			height2=0
			if objs[i-1].height >0 do
			(
					height1=objs[i-1].height
				
			)	
			if objs[i].height >0 do
			(
					height2=objs[i].height
				
			)	
			
			obj2=(objs[i-1].pos+objs[i].pos)/2.00 + [0,0,((distance objs[i-1] objs[i])/3) + objs[i-1].pos.z/2+objs[i].pos.z/2+height1+height2]
			
			
			for t in 0 to dif-(difParte*0.8 +2) by 1 do
			(
				at time ((t+(i-2)*dif)+ Inicio+difParte*0.8 +1)	
				(
					pos1=objs[i-1].pos+[0,0,height1]
					pos2=objs[i].pos+[0,0,height2]
					Traveler.pos= interpolacionCuadratica t pos1 obj2 pos2 (dif-(difParte*0.8 +2))
					--Traveler.dir=objs[i].pos
					Traveler.rotation.z_rotation =atan((objs[i].pos.y-objs[i-1].pos.y) / (objs[i].pos.x-objs[i-1].pos.x))	
					--dir o directtion
				)
			)
			
				at time ((0+(i-2)*dif)+ Inicio)
				(
					Traveler.scale=[1,1,1]
				)
				at time ((difParte*0.8 +1+(i-2)*dif)+ Inicio)
				(
					Traveler.scale=[1,1,aScalemin]
				)
				at time ((difParte*2+(i-2)*dif)+ Inicio)
				(
					Traveler.scale=[1,1,aScalemax]
				)
				at time ((difParte*3+(i-2)*dif)+ Inicio)
				(
					Traveler.scale=[1,1,1]
				)
			
		)
	)
)

rollout Salto "Salto"
(
	global objs=#()
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	
	label EAddObj "Add objects:" 
	pickbutton UI_EAddObj "Selecciona obj"
	
	listbox AllObjects "Objects:" items:(for o in objs collect o)
	button removeFromList "Remove Current Item" 

	
	spinner UI_IF "Comienzo" range:[0,100,0] type:#Integer
	spinner UI_FF "Duracion" range:[5,200,100] type:#Integer
	spinner UI_SCALEmin "Escalado minimo" range:[0.5,1,0.6] type:#Float
	spinner UI_SCALEmax "Escalado maximo" range:[1,2,1.5] type:#Float
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
				  
   	          Lineal Traveler objs UI_IF.value (UI_IF.value+UI_FF.value) UI_SCALEmin.value UI_SCALEmax.value
			  Traveler.showtrajectory = on
		  )
    )
	
)	

animationRange = interval 0 200
frameRate = 25

createDialog Salto