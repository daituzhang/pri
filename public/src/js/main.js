function parallax(){ 
  function setTransform(left,right) {
    return {
      'transform': 'translate('+ left +', ' + right + ')',
      '-webkit-transform': 'translate('+ left +', ' + right + ')',
      'transform': 'translate3d('+ left +', ' + right + ', 0)',
      '-webkit-transform': 'translate3d('+ left +', ' + right + ', 0)'
    }
  }
  function setCss($$, scroll, init) {
    var mode = $$.data('mode');
    var opts = {
      'start': $$.offset().top,
      'stop': $$.offset().top + $$.height(),
    };
    //console.log(opts);
    if((( opts.start <= scroll.bottom) && (opts.stop >= scroll.top))|| init ) {
      if(mode == 'slide') {
        newCoord = (scroll.top-opts.start) * 0.15;
        $$.css({
          'background-position': '50% '+ newCoord + 'px'
        });
      }
      else if(mode == 'front') {
        newCoord = (scroll.bottom-opts.stop) * 0.15;
        $$.css({
          'background-position': '50% '+ newCoord + 'px'
        });
      }
      else if(mode == 'gray-background') {
        newCoord = (scroll.top-opts.start) * 0.15;
        $$.css(setTransform(0, newCoord+'px')); 
      }

      else if(mode == 'triangle') {
        newCoord = (scroll.top-opts.start) * 0.1;
        $$.css(setTransform(0, newCoord+'px')); 
      }

      else if(mode == 'light') {
        newCoord = (scroll.bottom-opts.stop)*0.1;
        $$.css(setTransform(newCoord+'px',0)); 
      }
      else if(mode == 'photo') {
        newCoord = (scroll.bottom-opts.stop)*-0.02;
        $$.css(setTransform(newCoord+'px',0)); 
      }
      else if(mode == 'printer') {
        newCoord = (scroll.bottom-opts.stop)*-0.1;
        $$.css(setTransform(newCoord+'px',0)); 
      }
    }
  }
  var lastScrollTop = 0;

  $('.parallax').each(function() {
    var scroll = { 
      top : $(window).scrollTop(),
      height : $(window).height(),
      bottom: $(window).scrollTop() + $(window).height()
    };
    setCss($(this), scroll, true);
  });

  $(window).bind('scroll', function() {
    var scroll = { 
      top : $(window).scrollTop(),
      height : $(window).height(),
      bottom: $(window).scrollTop() + $(window).height()
    };

    // if (scroll.top > lastScrollTop){
    //   scroll.dir = 'down';
    //   $('#mp-menu:not(.narrow)').addClass('narrow');
    //   $('.scroller:not(.nav-narrow)').addClass('nav-narrow');
    // } else {
    //   scroll.dir = 'up';
    //   $('#mp-menu.narrow').removeClass('narrow');
    //   $('.scroller.nav-narrow').removeClass('nav-narrow');
    // }
    // lastScrollTop = scroll.top;

    $('.parallax').each(function(){
      setCss($(this),scroll, false);
    });
  });
}

function instagram(){
 $.ajax({
    url: "https://igapi.ga/explore/tags/bodybyrobbie/media",
    dataType: "jsonp",
    data: {
      count: 4
    },
    success: function(json) {
      console.log(json);
      var i = 0;
      while (i<3 && i < json.posts.length) {
        var img = document.createElement("IMG");
        img.src = json.posts[i].display_url;
        img.className = 'col-xs-3';
        $('#instagram .row').append(img);
        i++;
      }
    }
  });
}

function slides(parent){
  var len = $(parent).find('.slide').length;
  var lock = 0;
  function setIndex(current, next) {
    $('.index span').eq(current).removeClass('icon-icons_navigation_circle_closed').addClass('icon-icons_navigation_circle_open');
    $('.index span').eq(next).removeClass('icon-icons_navigation_circle_open').addClass('icon-icons_navigation_circle_closed')
  }
  function slideLeft() {
    lock = 1;
    var current = $(parent).find('.slide.active').index();
    var next = current == 0 ? len - 1 : current - 1;
    $(parent).find('.slide.active').addClass('right-out');
    $(parent).find('.slide').eq(next).addClass('active left-in');
    setIndex(current, next);
    setTimeout(function(){
      lock = 0;
      $(parent).find('.slide.right-out').removeClass('right-out active');
      $(parent).find('.slide.left-in').removeClass('left-in');
    }, 1000);
  }
  function slideRight() {
    lock = 1;
    var current = $(parent).find('.slide.active').index();
    var next = current == len - 1 ? 0 : current + 1;
    $(parent).find('.slide.active').addClass('left-out');
    $(parent).find('.slide').eq(next).addClass('active right-in');
    setIndex(current, next);
    setTimeout(function(){
      lock = 0;
      $(parent).find('.slide.left-out').removeClass('left-out active');
      $(parent).find('.slide.right-in').removeClass('right-in');
    }, 1000);
  }
  var slideLoop = setInterval(function() {
    if(len > 1) {
      slideRight();
    }
  }, 5000);
  $('.arrow.arrow-left').click(function(e){
    //clearInterval(slideLoop);
    if(!lock){
      slideLeft();
    }
  });
  $('.arrow.arrow-right').click(function(e){
    if(!lock){
      //clearInterval(slideLoop);
      slideRight();
    }
  });
  $(parent).on( "swipeleft", function(e){
    if(!lock){
      //clearInterval(slideLoop);
      slideRight();
    }
  });
  $(parent).on( "swiperight", function(e){
    //clearInterval(slideLoop);
    if(!lock){
      slideLeft();
    }
  });
}

function serviceDetail() {
  $('.trigger').click(function(){
    if($(this).data('type') === 'toggle') {
      $('#'+$(this).data('id')).toggleClass('active');
    }
    else {
      $('.'+$(this).data('trigger')+'.active').removeClass('active');
      $('#'+$(this).data('id')).addClass('active');
    }
  });
}

function nav(){
  var menuHeight = $('#mp-menu').height();
  $('#trigger').click(function(e){
    $(this).toggleClass('is-active');
    $('#mp-menu ul').toggleClass('open');
  });
  $('.mp-level>ul>li>a').click(function(e){
    $('#trigger').removeClass('is-active');
    $('#mp-menu ul').removeClass('open');
    menuHeight = $('.mobile-top').height();
  });
  $('a[href*="#"]:not([href="#"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top - menuHeight
        }, 1000);
        return false;
      }
    }
  });
}
$(document).ready(function() {
  $('.mobile-dropdown').click(function(e){
    $(this).toggleClass('open');
  });
  $('.about-body-trigger').click(function(e){
    $('.about-body').toggleClass('open');
  });
  nav();
  $('.slides-container').each(function(){
    slides(this);
  });
  //instagram();
  serviceDetail()
  if(!Modernizr.touch){
    parallax();
  }
  $( ".datepicker" ).datepicker();
});

