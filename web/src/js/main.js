$(document).ready(function() {
  let html = "";
  for (let x = 1; x < 31; x++) {
    html += '<button class="btn-selq">' + x + "</button>";
  }
  document.getElementById("btns").innerHTML = html;
  $(".owl-carousel").owlCarousel({
    dots: false,
    nav: false,
    autoWidth: true,
    margin: 5
  });
});
