layerBG = new BackgroundLayer({backgroundColor:"#AEE1E0" })
layerStatus = new Layer
	width:740
	height:22
	y:6 
	image:"images/Status Bar Black.png"

layerTime = new Layer
	width:298
	height:100
	image:"images/25-00.png"
	x:76
	y:175
layerStatus.centerX()
layerPomo = new Layer
	width:450
	height:450
	image:"images/Po0.png"
layerPomo.center()
layerPomo.centerY(-60)
px = layerPomo.x
py = layerPomo.y
layerMenu = new Layer
	width:2000
	height:1800
	image:"images/Menu.png"
	y:1150
layerMenu.centerX()
mx = layerMenu.x	
my = layerMenu.y
layerPo1 = new Layer
	width:225
	height:450
	image:"images/Po1.png"
	originX:1
layerPomo.addSubLayer(layerPo1)
layerPomo.addSubLayer(layerTime)
layerPo1.animate 
	properties:
		rotation: 360
	curve: "spring(200,30,0)"
layerSwak = new Layer
	width:370
	height:42
	image:"images/swak.png"
layerSwak.center()
layerSwak.centerY(+580)
layerAdd = new Layer
	width:225
	height:97
	image:"images/add.jpg"
	x:500
	y:500
	opacity:0
layerList = new Layer
	width:750
	height:681
	image:"images/List.jpg"
	y:650
	opacity:0
layerSwak.on Events.Click, ->
	layerSwak.animate
		properties:
			opacity:0
			curve: "ease"
		time: 0.3
	layerMenu.animate
		properties:
			y:300
			x:-300
		curve:"ease-in-out"
		time: 0.5
	layerPomo.animate
		properties:
			scale:0.55
			x:-20
			y:0
		curve:"ease-in-out"
		time: 0.5
	layerAdd.animate
		properties:
			opacity:1
		delay:0.3
		time: 0.3
	layerList.animate
		properties:
			opacity:1
		delay:0.3
		time: 0.3
layerPomo.on Events.Click, ->
	layerSwak.animate
		properties:
			opacity:1
			curve: "ease"
		time: 0.3
		delay:0.3
	layerMenu.animate
		properties:
			y:my
			x:mx
		curve:"ease-in-out"
		time: 0.5
		delay:0.3
	layerPomo.animate
		properties:
			scale:1
			x:px
			y:py
		curve:"ease-in-out"
		time: 0.5
		delay:0.3
	layerAdd.animate
		properties:
			opacity:0
		time: 0.3
	layerList.animate
		properties:
			opacity:0
		time: 0.3
