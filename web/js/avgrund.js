(function($) {
  'use strict';
  $(function() {
    $('#show').avgrund({
      height: 500,
      holderClass: 'custom',
      showClose: true,
      showCloseText: 'x',
      onBlurContainer: '.container-scroller',
      template: '<p>So implement your design and place content here! If you want to close modal, please hit "Esc", click somewhere on the screen or use special button.</p>' +
        '<div>' +
        '<a href="http://twitter.com/voronianski"   class="twitter btn btn-twitter btn-block">Twitter</a>' +
        '<a href="http://dribbble.com/voronianski"   class="dribble btn btn-dribbble btn-block">Dribbble</a>' +
        '</div>' +
        '<div class="text-center mt-4">' +
        '<a href="#"   class="btn btn-success mr-2">Great!</a>' +
        '<a href="#"   class="btn btn-light">Cancel</a>' +
        '</div>'
    });
  })
})(jQuery);