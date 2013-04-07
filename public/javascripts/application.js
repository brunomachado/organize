// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.cachedScript = function(url) {
  options = {
    dataType: "script",
    cache: true,
    url: url
  };

  return $.ajax(options);
};

$.cachedScript("http://use.typekit.com/lpo4rgu.js").done(function() {
  try {
    Typekit.load();
    $(".typekit-badge").css("left", "0");
  }catch(e){}
});