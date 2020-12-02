isValidHexColor = (color) -> return /^#(?:[0-9a-fA-F]{3}){1,2}$/.test(color) 

$(".expand-menu-btn:first").click(() ->
    $(".expand-menu-btn:first").toggleClass("expand-menu-btn--expanded")
    $(".expand-menu-btn__triangle:first").toggleClass("expand-menu-btn__triangle--expanded")
    $(".menu:first").toggleClass("menu--hidden")
)

$("#width-picker").on("input", () -> 
    window.siteSettings.resolution["width"] = $(@).val()
)

$("#height-picker").on("input", () -> 
    window.siteSettings.resolution["height"] = $(@).val()
)

$(".color-input").on("input", () ->
    color = "#" + $(@).val()
    if isValidHexColor(color) 
        li = $(@).parents('.color-item').first()
        num = li.attr("data-color-number")
        type = li.attr("data-color-type")
        window.siteSettings[type]["color" + num] = color;
        $(li).find(".color-preview").css("background", color)
)

$("#amount-of-shapes").on("input", () ->
    amount = $(@).val()
    isNumber = !isNaN(amount)
    if isNumber then window.siteSettings.shapes.amount = amount
)

$("#shapes-type").change(() ->
    window.siteSettings.shapes.type = $("#shapes-type option:selected").text().toLowerCase()
)
