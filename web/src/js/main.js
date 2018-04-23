$(document).ready(function() {
  let html = '<button class="btn-selq answered">1</button>';
  for (let x = 2; x < 31; x++) {
    html += '<button class="btn-selq">' + x + "</button>";
  }
  document.getElementById("btns").innerHTML = html;
  $(".owl-carousel").owlCarousel({
    dots: false,
    nav: false,
    autoWidth: true,
    margin: 5
  });
  $(".arrowbtn").click(function() {
    console.log($(this).parent()[0].className);
  });
});
