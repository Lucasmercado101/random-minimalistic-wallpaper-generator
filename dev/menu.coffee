isValidHexColor = (color) -> return /^#(?:[0-9a-fA-F]{3}){1,2}$/.test(color) 


$(".expand-menu-btn:first").click(() ->
    placement = window.siteSettings.menuPlacement
    if placement == "right"
        $(".expand-menu-btn:first").toggleClass("expand-menu-btn--expanded")
        $(".expand-menu-btn__triangle:first").toggleClass("expand-menu-btn__triangle--expanded")
        $(".menu:first").toggleClass("menu--hidden")

    if placement == "left"
        $(".expand-menu-btn:first").toggleClass("expand-menu-btn--expanded-left")
        $(".expand-menu-btn__triangle:first").toggleClass("expand-menu-btn__triangle--expanded-left")
        $(".menu:first").toggleClass("menu--left-hidden")
)

$("#main-settings-tab").click(() ->
    $("#site-settings-tab").removeClass("menu__tab--selected")
    $(@).addClass("menu__tab--selected")
    $("#site-settings-menu-content").hide()
    $("#main-settings-menu-content").show()
)

$("#site-settings-tab").click(() -> 
    $("#main-settings-tab").removeClass("menu__tab--selected")
    $(@).addClass("menu__tab--selected")
    $("#main-settings-menu-content").hide()
    $("#site-settings-menu-content").show()
)

$(".color-input").on("input", () ->
    colorHex = "#" + $(@).val()
    if isValidHexColor(colorHex) 
        li = $(@).parents('.color-item').first()
        num = li.attr("data-color-number")
        type = li.attr("data-color-type")
        colorType = "color" + num
        window.siteSettings[type][colorType] = colorHex;
        $(li).find(".color-preview").css("background", colorHex)
        if type == "sitePalette"
            root = document.querySelector(':root')
            switch colorType
                when "color0" then color = "bgr"
                when "color1" then color = "primary"
                when "color2" then color = "accent"
            root.style.setProperty("--" + color, colorHex)
)

# ---------------- main settings ----------------

$("#width-picker").on("input", () -> 
    window.siteSettings.resolution["width"] = $(@).val()
)

$("#height-picker").on("input", () -> 
    window.siteSettings.resolution["height"] = $(@).val()
)


$("#amount-of-shapes").on("input", () ->
    amount = $(@).val()
    isNumber = !isNaN(amount)
    if isNumber then window.siteSettings.shapes.amount = amount
)

$("#shapes-type").change(() ->
    window.siteSettings.shapes.type = $("#shapes-type option:selected").text().toLowerCase()
)

# --------- site settings ---------------

$("#menu-placement").change(() ->
    placement = $("#menu-placement option:selected").text().toLowerCase()    
    window.siteSettings.menuPlacement = placement
    if placement == "left"
        $(".expand-menu-btn:first").addClass("expand-menu-btn--left")
        $(".expand-menu-btn:first").addClass("expand-menu-btn--expanded-left")
        $(".expand-menu-btn__triangle:first").addClass("expand-menu-btn__triangle--left")
        $(".menu:first").addClass("menu--left")

    if placement == "right"
        $(".expand-menu-btn:first").removeClass("expand-menu-btn--expanded-left")
        $(".expand-menu-btn:first").removeClass("expand-menu-btn--left")
        $(".expand-menu-btn__triangle:first").removeClass("expand-menu-btn__triangle--left")
        $(".menu:first").removeClass("menu--left")
)