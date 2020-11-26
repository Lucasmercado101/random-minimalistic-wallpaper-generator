
canvasDOM = document.getElementById("canvas") 
ctx = canvasDOM.getContext("2d") 
canvas = ctx.canvas 

{ width: cWidth, height: cHeight } = canvas 

getRandomSize = (num) -> Math.max(num / 10, (Math.random() * num) / 2)

export drawRectangleRandomly = (color) -> 
  ranHeight = getRandomSize(cWidth) 
  ranWidth = getRandomSize(cWidth) 
  ranY = Math.random() * cHeight - ranHeight / 2 
  ranX = Math.random() * cWidth - ranWidth / 2 
  ranRotation = ~~(Math.random() * 360) 
  ctx.fillStyle = color 
  drawRotatedRect(ranX, ranY, ranHeight, ranWidth, ranRotation) 


drawRotatedRect = (x, y, width, height, degrees) ->
  # first save the untranslated/unrotated context
  ctx.save() 

  ctx.beginPath() 
  # move the rotation point to the center of the rect
  ctx.translate(x + width / 2, y + height / 2) 
  # rotate the rect
  ctx.rotate((degrees * Math.PI) / 180) 

  # draw the rect on the transformed context
  # Note: after transforming [0,0] is visually [x,y]
  #       so the rect needs to be offset accordingly when drawn
  ctx.fillRect(-width / 2, -height / 2, width, height) 

  # restore the context to its untranslated/unrotated state
  ctx.restore() 

export drawCircleRandomly = (color) ->
  ranHeight = getRandomSize(cWidth) 
  ranWidth = getRandomSize(cWidth) 
  ranY = Math.random() * cHeight - ranHeight / 2
  ranX = Math.random() * cWidth - ranWidth / 2 
  ranRotation = ~~(Math.random() * 360) 
  ctx.fillStyle = color 
  ctx.beginPath();
  ctx.arc(ranX, ranY, ranHeight, 0, 2 * Math.PI);
  ctx.fill();   
