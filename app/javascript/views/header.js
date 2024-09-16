$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    // $('#sp-menu').fadeToggle();
    $('#sp-menu').toggleClass('menu-active');
    event.preventDefault();
  })
})