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
//= require jquery.validate
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

$(function() {
  // Valida os campos.
  var validator = $("#new_content").validate({
    rules: {
      "content[name]": {
        required: true
      },
      "content[link]": {
        required: true,
        url: true
      }
    },
    messages: {
      "content[name]": {
        required: "O campo de título é obrigatório."
      },
      "content[link]": {
        required: "O campo do link é obrigatório.",
        url: "Digite um link válido."
      }
    }
  });

  // Preenche os campos de título e descrição se não estiverem preenchidos e existir dados do embedly.
  var $contentLink = $("#content_link");
  $contentLink.on("keyup", function() {
    var inputValue = $(this).val();

    if (validator.element($(this))) {
      $.ajax({
        cache: false,
        url: "http://api.embed.ly/1/oembed?key=8a81dcc53f774d599d80f7ccfe7aca96&url=" + inputValue,
        dataType: "jsonp",
        success: function(json) {
          var $contentTitle = $("#content_name");
          if ($contentTitle.val() === "" && json.title !== null) {
            $contentTitle.val(json.title);
          }

          var $contentDescription = $("#content_description");
          if ($contentDescription.val() === "" && json.description !== null) {
            $contentDescription.val(json.description);
          }
        }
      });
    }
  });

  // Habilita o botão de submissão e os campos estão validados.
  $("#content_link,#content_name").on("focusout", function() {
    var $contentLink = $("#content_link");
    var $contentName = $("#content_name");
    var $submit = $("#new_content input:submit");

    if (validator.element($contentLink) && validator.element($contentName)) {
      $submit.prop("disabled", false);
    } else {
      $submit.prop("disabled", true);
    }
  });
});
