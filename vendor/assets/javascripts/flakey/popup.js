// Used to make Facebook Share dialogs and Custom Tweet dialogs open in a
// dialog rather than taking the user to a new tab.

if (typeof jQuery === "undefined") {
  throw "Flakey popup requires jQuery";
};

(function($) {
  // Function for opening popups.
  var openPopup = function(url, name, options){
    options || (options = {});

    var width  = options.width || 575;
    var height = options.height || 400;
    var left   = ($(window).width() - width) / 2;
    var top    = ($(window).height() - height) / 2;
    var opts   = "status=1,width=" + width + ',height=' + height + ',top=' + top + ',left=' + left;
      
    return window.open(url, name, opts);
  };

  var linkClicked = function(e) {
    e.preventDefault();
    var opts = {},
        $link = $(e.target).closest('a');

    if (typeof $link.data('flakey-width') !== "undefined") { 
      opts.width = parseFloat($link.data('flakey-width'));
    };

    if (typeof $link.data('flakey-height') !== "undefined") { 
      opts.height = parseFloat($link.data('flakey-height'));
    };

    var win = openPopup($link.attr('href'), 'share', opts);
  };

  var clickTargets = [
    '.custom-tweet-button', 
    '.facebook-share-button', 
    '.flakey-popup'
  ].join(', ');

  var ready = function() {
    $(clickTargets).on('click', linkClicked);
  };

  if (window.Turbolinks) {
    $(document).on('page:change', ready);
  } else {
    $(ready);
  }
})(jQuery);
