isValidHexColor = (color) -> return /^#(?:[0-9a-fA-F]{3}){1,2}$/.test(color) 

colorNumberIndex = 3

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

$(".remove-color").click(() -> 
    li = $(@).parents('.color-item').first()
    num = li.attr("data-color-number")
    type = li.attr("data-color-type")
    colorType = "color" + num
    delete window.siteSettings[type][colorType]
    li.remove()
)

$("#amount-of-shapes").on("input", () ->
    amount = $(@).val()
    isNumber = !isNaN(amount)
    if isNumber then window.siteSettings.shapes.amount = amount
)

$("#add-main-palette-color").click((e) -> 
    e.preventDefault()
    colorNumberIndex++
    window.siteSettings["mainPalette"]["color" + colorNumberIndex] = "#30475e"
    li = '<li class="color-item"  data-color-number=' + colorNumberIndex + ' data-color-type="mainPalette" > </li>'

    xIcon = '<div><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x-circle remove-color"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg></div>'

    label = '<label class="label">
            <input
            class="input color-input"
            size="8"
            type="text"
            maxlength="6"
            placeholder="e.g: 30475e"
            pattern="([0-9a-fA-F]{3}){1,2}$"
            value="30475e"
            />
            Color
        </label>'
    
    preview = '<div
            style="background: #30475e"
            class="color-preview"
        ></div>'
    $(li).append($(label)).append($(xIcon)).append($(preview)).insertBefore($("#new-color-btn"))

    selector = ".color-item[data-color-number='" +  colorNumberIndex + "']"

    $("#{selector} input:first").on("input", () ->
        colorHex = "#" + $(@).val()
        if isValidHexColor(colorHex) 
            li = $(@).parents('.color-item').first()
            num = li.attr("data-color-number")
            type = li.attr("data-color-type")
            colorType = "color" + num
            window.siteSettings[type][colorType] = colorHex;
            $(li).find(".color-preview").css("background", colorHex)
    )

    $("#{selector} .remove-color:first").click(() -> 
        li = $(@).parents('.color-item').first()
        num = li.attr("data-color-number")
        type = li.attr("data-color-type")
        colorType = "color" + num
        delete window.siteSettings[type][colorType]
        li.remove()
    )
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