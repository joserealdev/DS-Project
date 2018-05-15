var preguntas = new Array();
preguntas.push("");
let cont = 1;
let cont2 = 2;
let cont3 = 3;
for (let x = 1; x <= 30; x++) {
  let pregunta = new Array();
  pregunta.push("Esta es la pregunta " + x);
  let question =
    '{"idquestion":"' +
    x +
    '","answers":[{"idanswer":"' +
    cont +
    '","answer":"esto es una respuesta' +
    cont +
    '"},{"idanswer":"' +
    cont2 +
    '","answer":"esto es una respuesta' +
    cont2 +
    '"},{"idanswer":"' +
    cont3 +
    '","answer":"esto es una respuesta' +
    cont3 +
    '"}],"correct":"1"}';
  pregunta.push(question);
  pregunta.push("null");
  preguntas.push(pregunta);
  cont += 3;
  cont2 += 3;
  cont3 += 3;
}
function buildButtons(total) {
  let html = "";
  for (let x = 1; x < total.length; x++) {
    if (x != 1)
      html += '<button id="' + x + '" class="btn-selq">' + x + "</button>";
    else html += '<button id="1" class="btn-selq answered">1</button>';
  }
  document.getElementById("btns").innerHTML = html;
}

function changeQuestion(btnQuestion) {
  $(".btn-selq").attr("class", "btn-selq");
  let num = btnQuestion[0].innerHTML;
  $("#question").html(preguntas[num][0]);
  let json = JSON.parse(preguntas[num][1]);
  $(btnQuestion).attr("class", "btn-selq answered");
  console.log($(btnQuestion));
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html +=
      '<input type="radio" name="1" value="' + json.answers[x].idanswer + '">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
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
    let btn = $(".answered").attr("id");
    if ($(this).parent()[0].className == "rightarrow") btn++;
    else btn--;

    if (btn < 1) {
      btn = preguntas.length;
      btn--;
    }
    if (btn == preguntas.length) {
      btn = 1;
    }
    console.log(preguntas.length);

    changeQuestion($("button#" + btn));
  });
  $("#question").html(preguntas[1][0]);
  let json = JSON.parse(preguntas[1][1]);
  console.log(json);
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html +=
      '<input type="radio" name="1" value="' + json.answers[x].idanswer + '">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  $(".btn-selq").click(function(e) {
    changeQuestion($(this));
  });
  //$("#loader").remove();
});
