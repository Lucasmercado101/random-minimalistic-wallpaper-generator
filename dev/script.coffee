import defaultSettings from "./defaultGlobalSettings.js"
window.siteSettings = defaultSettings
import "./menu.js"
import { drawRectangleRandomly, drawCircleRandomly } from "./shapes.js";



canvasDOM = document.getElementById("canvas") 
ctx = canvasDOM.getContext("2d") 
canvas = ctx.canvas 

# chances = [100, 100, 100] # TODO:

# randexec = (chances) ->
#   ar = chances.map((percentage) => percentage / 100.0) 

#   r = Math.random()  # returns [0,1]

#   result = [] 
#   ar.forEach((el, i) => el >= r and result.push(palette[i])) 
#   return result 

generate = () -> 
  $("#canvas").attr("height", window.siteSettings.resolution.height)
  $("#canvas").attr("width", window.siteSettings.resolution.width)


  ctx.clearRect(0, 0, canvas.width, canvas.height)  # Clear canvas
  ctx.fillStyle = window.siteSettings.mainPalette.color0
  ctx.fillRect(0, 0, canvas.width, canvas.height)  # BGR

  times = window.siteSettings.shapes.amount 

  # colors = randexec(chances) # TODO:
  colors = Object.values(window.siteSettings.mainPalette)[1..]

  temp = () ->
    color = colors[~~(Math.random() * colors.length)];
    switch window.siteSettings.shapes.type
      when "rectangles" then drawRectangleRandomly(color);
      when "circles" then drawCircleRandomly(color);

  temp() for x in [1..times]
  return


# Generate on ENTER
window.addEventListener("keypress", (ev) ->
	if ev.key.toLowerCase() is "enter" then generate())

# TODO:
# $(".color-chance").on("input", () -> 
#   indexItem = $(this).attr("data-color") 
#   value = $(this).val() 
#   chances[indexItem] = value 
#   $("#color-chance-label-#{indexItem} p").text(value + "%") 
# ) 

$("#generate-new").click(generate)

# TODO: 
#  - manually change the variation in size of shapes
#  - Fit the whole canvas without overflow
#  - fix the % chance of each shape being generated

generate() 
