jQuery(document).ready(function () {

  function getDefaultFontSize(parentElement) {
      parentElement = parentElement || document.body;
      var div = document.createElement('div');
      div.style.width = "1000em";
      parentElement.appendChild(div);
      var pixels = div.offsetWidth / 1000;
      parentElement.removeChild(div);
      return pixels;
  }

  //STICKY NAV
  var menuTopSpace = getDefaultFontSize(jQuery('#floating_menu')[0])*2;
  var top = jQuery('#floating_menu').offset().top - parseFloat(jQuery('#floating_menu').css('marginTop').replace(/auto/, 100));
  jQuery(window).scroll(function (event) {
    // what the y position of the scroll is
    var y = jQuery(this).scrollTop();

    // whether that's below the form
    if (y >= top - menuTopSpace) {
      // if so, ad the fixed class
      jQuery('#floating_menu').addClass('fixed');
    } else {
      // otherwise remove it
      jQuery('#floating_menu').removeClass('fixed');
    }
  });

  function executeDemoAnim() {

    var demoHandWidth = 35;
    var demoHandHeight = 46;
    var demoHandWidthClick = demoHandWidth*0.8;
    var demoHandHeightClick = demoHandHeight*0.8;
    jQuery("img.demo_hand")
      .stop(true, true)
      .clearQueue()
      .css({
        "left": 460,
        "top": 300,
        "width": demoHandWidth,
        "height": demoHandHeight,
        "opacity": 0
      })
      .delay(5000)
      .animate({
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "left": 30,
        "top": 160
      }, { duration: 1500 })
      .delay(1000)
      .animate({
        "width": demoHandWidthClick,
        "height": demoHandHeightClick
      }, { duration: 100 })
      .animate({
        "width": demoHandWidth,
        "height": demoHandHeight
      }, { duration: 100 })
      .queue(function (next) {
        jQuery("span.demo_url").text("mysite.com/slide2");
        next();
      })
      .delay(500)
      // 8200ms
      .animate({
        "opacity": 0
      }, { duration: 1000 })
      .delay(8000)
      .animate({
        "left": 460,
        "top": 300,
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "left": 370,
        "top": 250
      }, { duration: 1000 })
      .delay(1000)
      .animate({
        "width": demoHandWidthClick,
        "height": demoHandHeightClick
      }, { duration: 100 })
      .animate({
        "width": demoHandWidth,
        "height": demoHandHeight
      }, { duration: 100 })
      .queue(function (next) {
        jQuery("span.demo_url").text("mysite.com/slide3");
        next();
      })
      .delay(500)
      // 19900ms
      .animate({
        "opacity": 0
      }, { duration: 1000 })
      .delay(7000)
      .animate({
        "left": 460,
        "top": 300,
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "left": 70,
        "top": 60
      }, { duration: 1500 })
      .delay(1000)
      .animate({
        "width": demoHandWidthClick,
        "height": demoHandHeightClick
      }, { duration: 100 })
      .animate({
        "width": demoHandWidth,
        "height": demoHandHeight
      }, { duration: 100 })
      .queue(function (next) {
        jQuery("span.demo_url").text("mysite.com/");
        next();
      })
      .delay(500)
      // 31100ms
      .animate({
        "opacity": 0
      }, { duration: 1000 });
      // 32100ms

    jQuery("div.demo_window_1")
      .stop(true, true)
      .clearQueue()
      .show(0)
      .delay(8200)
      .hide(0)
      .delay(22900)
      .show(0);
    jQuery("div.demo_window_2")
      .stop(true, true)
      .clearQueue()
      .hide(0)
      .delay(8200)
      .show(0)
      .delay(11700)
      .hide(0);
    jQuery("div.demo_window_3")
      .stop(true, true)
      .clearQueue()
      .hide(0)
      .delay(19900)
      .show(0)
      .delay(11200)
      .hide(0);
      // 31100ms

    jQuery("div.demo_highlight_window, div.demo_highlight_url, div.demo_highlight_center")
      .stop(true, true)
      .clearQueue()
      .css({
        "opacity": 0
      })
      .delay(8200)
      .animate({
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "opacity": 0
      }, { duration: 7000 })
      .delay(4700)
      .animate({
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "opacity": 0
      }, { duration: 7000 })
      .delay(4200)
      .animate({
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "opacity": 0
      }, { duration: 7000 })
      .queue(function (next) {
        executeDemoAnim();
      });
      // 38100ms

    jQuery("div.demo_highlight_right")
      .stop(true, true)
      .clearQueue()
      .css({
        "opacity": 0
      })
      .delay(19900)
      .animate({
        "opacity": 1
      }, { duration: 1 })
      .animate({
        "opacity": 0
      }, { duration: 7000 });
      // 26900ms

  }

  executeDemoAnim();

});
