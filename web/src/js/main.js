let preguntas = new Array();//ESTE ARRAY SE RELLENA EN getQuestions.jsp
preguntas.push("");//FILL THE POSITION 0
let usersanswers = new Array();

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
  
  if(preguntas[1][3]!="null")
    $('#imgquestion').attr('src',preguntas[1][3]);
  else
    $('#imgquestion').attr('src','src/uploaded/images/default.jpg');

  let json = preguntas[1][2];
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html +=
      '<input type="radio" name="'+preguntas[1][0]+'" id="'+$(".selected").attr("id")+'" value="' + json.answers[x].idanswer + '">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  
  $(".btn-selq").click(function(e) {
    changeQuestion($(this));
  });

  //KEEP THE EVENT WHEN REBUILD THE QUESTION
  $(document).on("click", "input[type=radio]", function(e) {
    usersanswers[$(this).attr("id")] = $(this).val();
    $(".selected").addClass("answered");
  });
  //CAPTURE 404 IN IMAGES
  window.addEventListener('error', function(e) {
    $('#imgquestion').attr('src','src/uploaded/images/default.jpg');
  }, true);
  //Remove loader tag
  $("#loader").remove();
});

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
  if(preguntas[num][3]!="null")
    $('#imgquestion').attr('src',preguntas[num][3]);
  else
    $('#imgquestion').attr('src','src/uploaded/images/default.jpg');  
  let idquestion=preguntas[num][0];
  let json = preguntas[num][2];
  $(btnQuestion).addClass("selected");
  let html = "";
  html += "<ul>";
  for (let x = 0; x < json.answers.length; x++) {
    html += '<li><label class="containerrb">';
    html += '<input type="radio" name="'+ idquestion +'" id="'+num+'" value="' +json.answers[x].idanswer +'">';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  if (usersanswers[num] != 0) {
    $("input[value=" + usersanswers[num] + "]").attr("checked", true);
  }
}
