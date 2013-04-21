// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require modernizr
//= require jquery.autosize.min
//= require placeholder-polyfill.min
//= require bootstrap-redu

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