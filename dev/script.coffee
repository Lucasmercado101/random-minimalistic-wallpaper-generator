import { drawRectangleRandomly, drawCircleRandomly } from "./shapes.js";
canvasDOM = document.getElementById("canvas") 
ctx = canvasDOM.getContext("2d") 
canvas = ctx.canvas 
shape = "rectangles"

bgr = "#222831" 
palette = ["#e8e8e8", "#f05454", "#30475e"] 
chances = [100, 100, 100] 


changeBGR = () -> 
  bgr = "#" + document.getElementById("background-color").value 

randexec = (chances) ->
  ar = chances.map((percentage) => percentage / 100.0) 

  # Then we get a random number and finds where it sits inside the probabilities
  # defined earlier

  r = Math.random()  # returns [0,1]

  result = [] 
  ar.forEach((el, i) => el >= r and result.push(palette[i])) 
  return result 

generate = () -> 
  colors = randexec(chances)

  ctx.clearRect(0, 0, canvas.width, canvas.height)  # Clear canvas
  ctx.fillStyle = bgr 
  ctx.fillRect(0, 0, canvas.width, canvas.height)  # BGR

  times = +document.getElementById("shapes-amount").value 
  `for (let i = 0; i < times; i++) {
    let color = colors[~~(Math.random() * colors.length)];
    console.log(shape)
    switch (shape){
      case "rectangles":
        drawRectangleRandomly(color);
        break
      case "circles":
        drawCircleRandomly(color);
        break
      default:
        throw Error();
    }
        
  }`
  return

generate() 

window.addEventListener("keypress", (ev) ->
	if ev.key.toLowerCase() is "enter" then generate())


# setInterval(() => generate(), 1000) 

$(() ->
  $("#shapes-amount").on("input", () -> 
    if (+$(this).val() > 100) then $(this).val(100)
  ) 

  $("#clear-image").click(() -> 
    $(this).attr("disabled", true)
    $("#save-inst").css("display", "none")
    $("#the-image").attr("src", "")
  ) 

  $('#shape-type').on('change', () -> 
    shape = $("#shape-type option:selected").text().toLowerCase()
);

  # Colors
  $(".color-input").on("input", () -> 
    indexItem = $(this).attr("data-color") 
    colorValue = "#" + $(this).val() 
    if isHexColorValid(colorValue)
      $("#color-demo-#{indexItem}").css("background-color", colorValue) 
      palette[indexItem] = colorValue 
  ) 

  $(".color-chance").on("input", () -> 
    indexItem = $(this).attr("data-color") 
    value = $(this).val() 
    chances[indexItem] = value 
    $("#color-chance-label-#{indexItem} p").text(value + "%") 
  ) 

  $("#bg-color-input").on("input", () -> 
    value = $(this).val() 
    background = "#" + value 
    if isHexColorValid(background)
      bgr = background 
      $("#color-demo-bg").css("background-color", bgr) 
  ) 

  $("#to-image").click(() ->
    $("#the-image").attr("src", canvas.toDataURL()) 
    $("#clear-image").attr("disabled", false) 
    $("#save-inst").css("display", "block"))

  $("#generate-new").click(generate)
) 

# TODO: change the resolution of the canvas, so different wallpaper resolution
#  - display text below save button "the bigger the resolution the longer this takes" and "right click and save to image" until i find a way to save canvas to image format directly
#  - different shapes like circles or something

###
#e8e8e8
#f05454
#30475e
#222831
###

isHexColorValid = (color) -> return /^#(?:[0-9a-fA-F]{3}){1,2}$/.test(color) 
 
