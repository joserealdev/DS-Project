$(document).ready(function() {
  document
    .getElementsByClassName("drag-controls")[0]
    .addEventListener("touchstart", handleTouchStart, false);
  document
    .getElementsByClassName("drag-controls")[0]
    .addEventListener("touchmove", handleTouchMove, false);

  var xDown = null;
  var yDown = null;

  function handleTouchStart(evt) {
    xDown = evt.touches[0].clientX;
    yDown = evt.touches[0].clientY;
  }

  function handleTouchMove(evt) {
    if (!xDown || !yDown) {
      return;
    }

    var xUp = evt.touches[0].clientX;
    var yUp = evt.touches[0].clientY;

    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if (Math.abs(xDiff) > Math.abs(yDiff)) {
      /*most significant*/
      if (xDiff > 0) {
        /* left swipe */
        $(".rightarrow")
          .children(".arrowbtn")
          .click();
      } else {
        /* right swipe */
        $(".leftarrow")
          .children(".arrowbtn")
          .click();
      }
    }
    /* reset values */
    xDown = null;
    yDown = null;
  }
});
