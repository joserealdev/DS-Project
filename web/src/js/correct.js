$(document).ready(function() {
    $(".btn-corr").click(function() {
        showCorrect($('.selected'));
        correctTest();
        usersanswers.unshift("");
        $('input').attr('disabled', true);
        $('.btn-corr').remove();
        $('.user').html('<a href="index.jsp">Salir</a>');
        $(".arrowbtn").off('click');
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
            showCorrect($("button#" + btn));
        });
        let corr = 0;
        let fall=0;
        let blank=0;
        let botones=$('.btn-selq');
        for (let x = 1; x < preguntas.length; x++) {
          let jsondata = preguntas[x][2];
          if (jsondata.correct == usersanswers[x]) {
            corr++;
            x--;
            //$('button#'+x).addClass('correct');
            botones[x].className+=' correct';
          }
          else if(parseInt(usersanswers[x])!=0 && jsondata.correct != usersanswers[x]) {
            fall++;
            x--;
            //$('button#'+x).addClass('fail');
            botones[x].className+=' fail';
          }
          else {
            blank++;
            x--;
            //$('button#'+x).addClass('blank');
            botones[x].className+=' blank';
          }
          x++;
        }
        console.log('correctas: '+corr+', falladas: '+fall+', en blanco: '+blank);
        $('.btn-selq').off('click');
        $('.btn-selq').click(function(e){
          showCorrect($(this));
        })
        fillModal(corr, fall, blank);
    });
});

function showCorrect(btnQuestion){
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
    html += '<input type="radio" id="'+num+'" value="' +json.answers[x].idanswer +'" disabled>';
    html += json.answers[x].answer;
    html += '<span class="checkmark"></span></label></li>';
  }
  html += "</ul>";
  $(".answers").html(html);
  if (usersanswers[num] != undefined && usersanswers[num] != json.correct) {
    $("input[value=" + usersanswers[num] + "]").attr("checked", true);
    $("input[value=" + usersanswers[num] + "]").parent().find('span').addClass('incorrect')
  }
  $("input[value=" + json.correct + "]").attr("checked", true);
  if (usersanswers[num] != undefined && usersanswers[num] == json.correct) {
    $("input[value=" + json.correct + "]").parent().find('span').addClass('correctcorrect')
  }else{
    $("input[value=" + json.correct + "]").parent().find('span').addClass('correct')
  }
}

function correctTest(){
    usersanswers.shift();

    $.ajax({
        data: 'usersanswers=' + usersanswers,
        url: 'correctTest.jsp',
        type: 'post',
        success: function(data){
            //console.log(data)
        }
    });
}

function fillModal(corr, fall, blank){
    let total=parseInt($('#numbquestions').html());
    $('#success').html(corr);
    $('#fail').html(fall);
    $('#blank').html(blank);
    $('#succent').html((corr*100)/total+"%");
    $('#falcent').html((fall*100)/total+"%");
    $('#blacent').html((blank*100)/total+"%");
    if(((corr*100)/total)>=80) {
        $('#resultado').html('aprobado');
        $('.modal-footer').css({"background-color":"#3ba15f", "color":"white"})
    }else{
        $('#resultado').html('suspenso');
        $('.modal-footer').css({"background-color":"red", "color":"white"})
    }
    $('.estadisticasmodal').modal();
}