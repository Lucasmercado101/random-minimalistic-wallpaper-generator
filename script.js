const canvasDOM = document.getElementById("canvas");
const ctx = canvasDOM.getContext("2d");
let canvas = ctx.canvas;

let { width: cWidth, height: cHeight } = canvas;

let bgr = "#222831";
let palette = ["#e8e8e8", "#f05454", "#30475e"];

window.addEventListener("keypress", (ev) => {
  if (ev.key.toLowerCase() === "enter") {
    generate();
  }
});

function changeBGR() {
  bgr = "#" + document.getElementById("background-color").value;
}

function generate() {
  ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear canvas
  ctx.fillStyle = bgr;
  ctx.fillRect(0, 0, canvas.width, canvas.height); // BGR

  let times = +document.getElementById("shapes-amount").value;
  for (let i = 0; i < times; i++) {
    drawRectangleRandomly(palette[~~(Math.random() * palette.length)]);
  }
}
generate();

function drawRectangleRandomly(color) {
  let ranHeight = getRandomSize(cWidth);
  let ranWidth = getRandomSize(cWidth);
  let ranY = Math.random() * cHeight - ranHeight / 2;
  let ranX = Math.random() * cWidth - ranWidth / 2;
  let ranRotation = ~~(Math.random() * 360);

  ctx.fillStyle = color;
  drawRotatedRect(ranX, ranY, ranHeight, ranWidth, ranRotation);
}

function getRandomSize(num) {
  return Math.max(num / 10, (Math.random() * num) / 2);
}

function drawRotatedRect(x, y, width, height, degrees) {
  // first save the untranslated/unrotated context
  ctx.save();

  ctx.beginPath();
  // move the rotation point to the center of the rect
  ctx.translate(x + width / 2, y + height / 2);
  // rotate the rect
  ctx.rotate((degrees * Math.PI) / 180);

  // draw the rect on the transformed context
  // Note: after transforming [0,0] is visually [x,y]
  //       so the rect needs to be offset accordingly when drawn
  ctx.fillRect(-width / 2, -height / 2, width, height);

  // restore the context to its untranslated/unrotated state
  ctx.restore();
}
// setInterval(() => generate(), 1000);

var link = document.getElementById("link");
link.setAttribute("download", "MintyPaper.png");
link.setAttribute(
  "href",
  canvas.toDataURL("image/png").replace("image/png", "image/octet-stream")
);
link.click();

function toImage() {
  var canvas = document.getElementById("canvas");
  document.getElementById("theimage").src = canvas.toDataURL();
  // Canvas2Image.saveAsImage(canvas);
  // Canvas2Image.saveAsImage(canvas, width, height, type)
}

/*
#e8e8e8
#f05454
#30475e
#222831
*/
