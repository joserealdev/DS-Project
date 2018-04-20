$(document).ready(function() {
  let html = "";
  for (let x = 1; x < 31; x++) {
    if (x < 10) html += '<button class="btn-selq">' + x + "</button>";
    else if (x < 20)
      html +=
        '<button style="width:55px!important" class="btn-selq">' +
        x +
        "</button>";
    else
      html +=
        '<button style="width:54px!important" class="btn-selq">' +
        x +
        "</button>";
  }
  document.getElementById("btns").innerHTML = html;
  $(".owl-carousel").owlCarousel({
    center: true,
    loop: true,
    rewind: true,
    dots: false,
    nav: false,
    margin: 0,
    responsiveClass: true,
    responsive: {
      0: {
        items: 1
      },
      600: {
        items: 3
      },
      1000: {
        items: 5,
        loop: false
      }
    }
  });
});
