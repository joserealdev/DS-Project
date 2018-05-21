$(document).ready(function() {
  $(".btn-corr").click(function() {
    let corr = 0;
    for (let x = 1; x < preguntas.length; x++) {
      let jsondata = JSON.parse(preguntas[x][2]);
      if (jsondata.correct == usersanswers[preguntas[x][0]]) corr++;
    }
    console.log(corr);
  });
});
