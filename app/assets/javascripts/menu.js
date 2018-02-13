$(document).on('ready page:load', function () {

  $(document).on('click', '.burger', function () {
    $(".menu-mobile").removeClass('hide');
    $(".menu-mobile").removeClass('animated slideOutRight slideInRight');
    $('.menu-mobile').addClass("animated slideInRight");
  });

  $(document).on('click', 'body', function (e) {
    if($(e.target).closest(".burger").length > 0 ) {
       return false;
    }
    if ($(".menu-mobile").hasClass('slideInRight')) {
      $(".menu-mobile").removeClass('animated slideOutRight slideInRight');
      $('.menu-mobile').addClass("animated slideOutRight");
    }
  });

  $(document).on('click', '.btn-avanzar', function (e) {
    $(".block-mail").addClass('hide');
    $(".block-pass").removeClass('hide');
    $(".block-pass").addClass('animated slideInRight');
  });

  $(document).on('click', '.backLogin', function (e) {
    $(".block-pass").addClass('hide');
    $(".block-mail").removeClass('hide');
    $(".block-mail").addClass('animated slideInLeft');
  });

});
