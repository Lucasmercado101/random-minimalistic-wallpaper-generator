// Generated by CoffeeScript 2.5.1
(function() {
  var isValidHexColor;

  isValidHexColor = function(color) {
    return /^#(?:[0-9a-fA-F]{3}){1,2}$/.test(color);
  };

  $(".expand-menu-btn:first").click(function() {
    $(".expand-menu-btn:first").toggleClass("expand-menu-btn--expanded");
    $(".expand-menu-btn__triangle:first").toggleClass("expand-menu-btn__triangle--expanded");
    return $(".menu:first").toggleClass("menu--hidden");
  });

  $("#width-picker").on("input", function() {
    return window.siteSettings.resolution["width"] = $(this).val();
  });

  $("#height-picker").on("input", function() {
    return window.siteSettings.resolution["height"] = $(this).val();
  });

  $(".color-input").on("input", function() {
    var color, li, num, type;
    color = "#" + $(this).val();
    if (isValidHexColor(color)) {
      li = $(this).parents('.color-item').first();
      num = li.attr("data-color-number");
      type = li.attr("data-color-type");
      window.siteSettings[type]["color" + num] = color;
      return $(li).find(".color-preview").css("background", color);
    }
  });

  $("#amount-of-shapes").on("input", function() {
    var amount, isNumber;
    amount = $(this).val();
    isNumber = !isNaN(amount);
    if (isNumber) {
      return window.siteSettings.shapes.amount = amount;
    }
  });

  $("#shapes-type").change(function() {
    return window.siteSettings.shapes.type = $("#shapes-type option:selected").text().toLowerCase();
  });

}).call(this);
