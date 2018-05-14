let preguntas=new Array();
function buildButtons(total){
      let html ='';
  for (let x = 0; x < total.length; x++) {
    x++;
    if(x!=1)
        html += '<button class="btn-selq">' + x + "</button>";
    else
        html+= '<button class="btn-selq answered">1</button>';
    x--;
  }
  document.getElementById("btns").innerHTML = html;
}
$(document).ready(function() {
    buildButtons(preguntas);
  $(".owl-carousel").owlCarousel({
    dots: false,
    nav: false,
    autoWidth: true,
    margin: 5
  });
  $(".arrowbtn").click(function() {
    console.log($(this).parent()[0].className);
  });
  $("#loader").remove();
});