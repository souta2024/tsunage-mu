// 現在いるページを強調表示
// var links = jQuery(".header-items > a");

// document.addEventListener('turbolinks:load', function () {
//   links.each(function () {
//     if (this.href === location.href) {
//       jQuery(this).closest(".header-items").addClass("current");
//     }
//   })
// })

//ハンバーガーメニューの切り替え
$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    // $('#sp-menu').fadeToggle();
    $('#sp-menu').toggleClass('menu-active');
    event.preventDefault();
  })
})