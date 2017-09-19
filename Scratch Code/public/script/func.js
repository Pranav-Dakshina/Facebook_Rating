/*function ld_ani() {
  function msg_animate() {
    for (j = 1; j < 5; j++) {
      var b = document.getElementById("in_msg" + j);
      if (i == j) {

      } else {
        b.style.WebkitAnimation = "fadeout 4s 1";
        b.style.Animation = "fadeout 4s 1";
      }
    }
    var b = document.getElementById("in_msg" + i);
    b.style.WebkitAnimation = "fadein 4s 1";
    b.style.Animation = "fadein 4s 1";
    if (i == 4) {
      i = 0;
    }
    i++;
  }
  var i = 1;
  msg_animate();
  setInterval(msg_animate, 4000);
}*/

function rt_ld() {
  $("#rat").click(function(event) {
    event.stopPropagation();
    var $this = $(this);
    if ($this.hasClass("clicked-once")) {
      // already been clicked once, hide it
      $("#rat_inf_bx").css("visibility", "hidden");
      $this.removeClass("clicked-once");
    } else {
      // first time this is clicked, mark it
      $this.addClass("clicked-once");
      $("#rat_inf_bx").css("visibility", "visible");
    }
  });
  $(document).click(function() {
    $("#rat_inf_bx").css("visibility", "hidden");
    if ($("#rat").hasClass("clicked-once")) {
      $("#rat").removeClass("clicked-once");
    }
  });
  /*$("#img1").hover(function() {
    $("#rat_inf_hv").css("visibility","visible");
  });*/
  //$(document).ready(function() {
    //Tooltips
    /*$("#img1").each(function() {
      $(this).hover(function() {
        // assuming you give the image the class marker
        var pos = $(this).find("#img1").position();

        tip = $(this).find("#rat_inf_hv");
        var width = tip.width();
        tip.show(); //Show tooltip
        tip.css({
          "left": (pos.left + width) + "px",
          "top": pos.top + "px"
        });

      }, function() {
        tip.hide(); //Hide tooltip
      });


    });*/
  //});

}
