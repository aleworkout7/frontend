$(document).on('ready page:load', function () {

  $(document).on('click', '.burger', function () {
    $(".menu-mobile").removeClass('hide');
    $(".menu-mobile").removeClass('animated slideOutLeft slideInLeft');
    $('.menu-mobile').addClass("animated slideInLeft");
  });

  $(document).on('click', 'body', function (e) {
    if($(e.target).closest(".burger").length > 0 ) {
       return false;
    }
    if ($(".menu-mobile").hasClass('slideInLeft')) {
      $(".menu-mobile").removeClass('animated slideOutLeft slideInLeft');
      $('.menu-mobile').addClass("animated slideOutLeft");
    }  

  });

});
