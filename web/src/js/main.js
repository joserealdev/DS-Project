let preguntas = new Array();
preguntas.push("");
let usersanswers = new Array();

function buildButtons(total) {
  let html = "";
  for (let x = 1; x < total.length; x++) {
    if (x != 1)
      html += '<button id="' + x + '" class="btn-selq">' + x + "</button>";
    else html += '<button id="' + x + '" class="btn-selq selected">1</button>';
  }
  document.getElementById("btns").innerHTML = html;
}

function changeQuestion(btnQuestion) {
  $(".selected").removeClass("selected");
  let num = $(btnQuestion).attr("id");
  $("#number").html(num + ".-");
  $("#question").html(preguntas[num][1]);
  let idquestion=preguntas[num][0];
  let json = JSON.parse(preguntas[num][2]);
  $(btnQuestion).addClass("selected");
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html +=
      '<input type="radio" name="' +
      idquestion +
      '" value="' +
      json.answers[x].idanswer +
      '">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  if (usersanswers[idquestion] != undefined) {
    $("input[value=" + usersanswers[idquestion] + "]").attr("checked", true);
  }
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
    let btn = $(".selected").attr("id");
    if ($(this).parent()[0].className == "rightarrow") btn++;
    else btn--;

    if (btn < 1) {
      btn = preguntas.length;
      btn--;
    }
    if (btn == preguntas.length) {
      btn = 1;
    }
    changeQuestion($("button#" + btn));
  });
  $("#question").html(preguntas[1][1]);
  let json = JSON.parse(preguntas[1][2]);
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html +=
      '<input type="radio" name="'+preguntas[1][0]+'" value="' + json.answers[x].idanswer + '">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  $(".btn-selq").click(function(e) {
    changeQuestion($(this));
  });

  $(document).on("click", "input[type=radio]", function(e) {
    usersanswers[$(this).attr("name")] = $(this).val();
    $(".selected").addClass("answered");
  });
  $("#loader").remove();
});
