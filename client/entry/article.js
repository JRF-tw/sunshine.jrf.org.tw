$(document).on('ready page:load', () => {
  $('.card--article img').each(function () {
    $(this).wrap("<div class='image-wrapper'></div>");
  });
});
