webpackJsonp([0],[
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(1);


/***/ }),
/* 1 */
/***/ (function(module, exports) {

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
	


/***/ })
]);
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vLi9wdWJsaWMvc3JjL2pzL21haW4uanMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7Ozs7QUFBQSxxQjtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxVQUFTO0FBQ1Q7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLFVBQVM7QUFDVDtBQUNBO0FBQ0E7QUFDQSxnRDtBQUNBOztBQUVBO0FBQ0E7QUFDQSxnRDtBQUNBOztBQUVBO0FBQ0E7QUFDQSwrQztBQUNBO0FBQ0E7QUFDQTtBQUNBLCtDO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsK0M7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBLG1CO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLElBQUc7O0FBRUg7QUFDQSxtQjtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsU0FBUTtBQUNSO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLE1BQUs7QUFDTCxJQUFHO0FBQ0g7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsTUFBSztBQUNMO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsTUFBSztBQUNMO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLE1BQUs7QUFDTDtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLElBQUc7QUFDSDtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7QUFDQTtBQUNBO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxVQUFTO0FBQ1Q7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIO0FBQ0E7QUFDQSxJQUFHO0FBQ0g7QUFDQTtBQUNBO0FBQ0EsSUFBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLEVBQUMiLCJmaWxlIjoiYXBwLmpzIiwic291cmNlc0NvbnRlbnQiOlsiZnVuY3Rpb24gcGFyYWxsYXgoKXsgXG4gIGZ1bmN0aW9uIHNldFRyYW5zZm9ybShsZWZ0LHJpZ2h0KSB7XG4gICAgcmV0dXJuIHtcbiAgICAgICd0cmFuc2Zvcm0nOiAndHJhbnNsYXRlKCcrIGxlZnQgKycsICcgKyByaWdodCArICcpJyxcbiAgICAgICctd2Via2l0LXRyYW5zZm9ybSc6ICd0cmFuc2xhdGUoJysgbGVmdCArJywgJyArIHJpZ2h0ICsgJyknLFxuICAgICAgJ3RyYW5zZm9ybSc6ICd0cmFuc2xhdGUzZCgnKyBsZWZ0ICsnLCAnICsgcmlnaHQgKyAnLCAwKScsXG4gICAgICAnLXdlYmtpdC10cmFuc2Zvcm0nOiAndHJhbnNsYXRlM2QoJysgbGVmdCArJywgJyArIHJpZ2h0ICsgJywgMCknXG4gICAgfVxuICB9XG4gIGZ1bmN0aW9uIHNldENzcygkJCwgc2Nyb2xsLCBpbml0KSB7XG4gICAgdmFyIG1vZGUgPSAkJC5kYXRhKCdtb2RlJyk7XG4gICAgdmFyIG9wdHMgPSB7XG4gICAgICAnc3RhcnQnOiAkJC5vZmZzZXQoKS50b3AsXG4gICAgICAnc3RvcCc6ICQkLm9mZnNldCgpLnRvcCArICQkLmhlaWdodCgpLFxuICAgIH07XG4gICAgLy9jb25zb2xlLmxvZyhvcHRzKTtcbiAgICBpZigoKCBvcHRzLnN0YXJ0IDw9IHNjcm9sbC5ib3R0b20pICYmIChvcHRzLnN0b3AgPj0gc2Nyb2xsLnRvcCkpfHwgaW5pdCApIHtcbiAgICAgIGlmKG1vZGUgPT0gJ3NsaWRlJykge1xuICAgICAgICBuZXdDb29yZCA9IChzY3JvbGwudG9wLW9wdHMuc3RhcnQpICogMC4xNTtcbiAgICAgICAgJCQuY3NzKHtcbiAgICAgICAgICAnYmFja2dyb3VuZC1wb3NpdGlvbic6ICc1MCUgJysgbmV3Q29vcmQgKyAncHgnXG4gICAgICAgIH0pO1xuICAgICAgfVxuICAgICAgZWxzZSBpZihtb2RlID09ICdmcm9udCcpIHtcbiAgICAgICAgbmV3Q29vcmQgPSAoc2Nyb2xsLmJvdHRvbS1vcHRzLnN0b3ApICogMC4xNTtcbiAgICAgICAgJCQuY3NzKHtcbiAgICAgICAgICAnYmFja2dyb3VuZC1wb3NpdGlvbic6ICc1MCUgJysgbmV3Q29vcmQgKyAncHgnXG4gICAgICAgIH0pO1xuICAgICAgfVxuICAgICAgZWxzZSBpZihtb2RlID09ICdncmF5LWJhY2tncm91bmQnKSB7XG4gICAgICAgIG5ld0Nvb3JkID0gKHNjcm9sbC50b3Atb3B0cy5zdGFydCkgKiAwLjE1O1xuICAgICAgICAkJC5jc3Moc2V0VHJhbnNmb3JtKDAsIG5ld0Nvb3JkKydweCcpKTsgXG4gICAgICB9XG5cbiAgICAgIGVsc2UgaWYobW9kZSA9PSAndHJpYW5nbGUnKSB7XG4gICAgICAgIG5ld0Nvb3JkID0gKHNjcm9sbC50b3Atb3B0cy5zdGFydCkgKiAwLjE7XG4gICAgICAgICQkLmNzcyhzZXRUcmFuc2Zvcm0oMCwgbmV3Q29vcmQrJ3B4JykpOyBcbiAgICAgIH1cblxuICAgICAgZWxzZSBpZihtb2RlID09ICdsaWdodCcpIHtcbiAgICAgICAgbmV3Q29vcmQgPSAoc2Nyb2xsLmJvdHRvbS1vcHRzLnN0b3ApKjAuMTtcbiAgICAgICAgJCQuY3NzKHNldFRyYW5zZm9ybShuZXdDb29yZCsncHgnLDApKTsgXG4gICAgICB9XG4gICAgICBlbHNlIGlmKG1vZGUgPT0gJ3Bob3RvJykge1xuICAgICAgICBuZXdDb29yZCA9IChzY3JvbGwuYm90dG9tLW9wdHMuc3RvcCkqLTAuMDI7XG4gICAgICAgICQkLmNzcyhzZXRUcmFuc2Zvcm0obmV3Q29vcmQrJ3B4JywwKSk7IFxuICAgICAgfVxuICAgICAgZWxzZSBpZihtb2RlID09ICdwcmludGVyJykge1xuICAgICAgICBuZXdDb29yZCA9IChzY3JvbGwuYm90dG9tLW9wdHMuc3RvcCkqLTAuMTtcbiAgICAgICAgJCQuY3NzKHNldFRyYW5zZm9ybShuZXdDb29yZCsncHgnLDApKTsgXG4gICAgICB9XG4gICAgfVxuICB9XG4gIHZhciBsYXN0U2Nyb2xsVG9wID0gMDtcblxuICAkKCcucGFyYWxsYXgnKS5lYWNoKGZ1bmN0aW9uKCkge1xuICAgIHZhciBzY3JvbGwgPSB7IFxuICAgICAgdG9wIDogJCh3aW5kb3cpLnNjcm9sbFRvcCgpLFxuICAgICAgaGVpZ2h0IDogJCh3aW5kb3cpLmhlaWdodCgpLFxuICAgICAgYm90dG9tOiAkKHdpbmRvdykuc2Nyb2xsVG9wKCkgKyAkKHdpbmRvdykuaGVpZ2h0KClcbiAgICB9O1xuICAgIHNldENzcygkKHRoaXMpLCBzY3JvbGwsIHRydWUpO1xuICB9KTtcblxuICAkKHdpbmRvdykuYmluZCgnc2Nyb2xsJywgZnVuY3Rpb24oKSB7XG4gICAgdmFyIHNjcm9sbCA9IHsgXG4gICAgICB0b3AgOiAkKHdpbmRvdykuc2Nyb2xsVG9wKCksXG4gICAgICBoZWlnaHQgOiAkKHdpbmRvdykuaGVpZ2h0KCksXG4gICAgICBib3R0b206ICQod2luZG93KS5zY3JvbGxUb3AoKSArICQod2luZG93KS5oZWlnaHQoKVxuICAgIH07XG5cbiAgICAvLyBpZiAoc2Nyb2xsLnRvcCA+IGxhc3RTY3JvbGxUb3Ape1xuICAgIC8vICAgc2Nyb2xsLmRpciA9ICdkb3duJztcbiAgICAvLyAgICQoJyNtcC1tZW51Om5vdCgubmFycm93KScpLmFkZENsYXNzKCduYXJyb3cnKTtcbiAgICAvLyAgICQoJy5zY3JvbGxlcjpub3QoLm5hdi1uYXJyb3cpJykuYWRkQ2xhc3MoJ25hdi1uYXJyb3cnKTtcbiAgICAvLyB9IGVsc2Uge1xuICAgIC8vICAgc2Nyb2xsLmRpciA9ICd1cCc7XG4gICAgLy8gICAkKCcjbXAtbWVudS5uYXJyb3cnKS5yZW1vdmVDbGFzcygnbmFycm93Jyk7XG4gICAgLy8gICAkKCcuc2Nyb2xsZXIubmF2LW5hcnJvdycpLnJlbW92ZUNsYXNzKCduYXYtbmFycm93Jyk7XG4gICAgLy8gfVxuICAgIC8vIGxhc3RTY3JvbGxUb3AgPSBzY3JvbGwudG9wO1xuXG4gICAgJCgnLnBhcmFsbGF4JykuZWFjaChmdW5jdGlvbigpe1xuICAgICAgc2V0Q3NzKCQodGhpcyksc2Nyb2xsLCBmYWxzZSk7XG4gICAgfSk7XG4gIH0pO1xufVxuXG5mdW5jdGlvbiBpbnN0YWdyYW0oKXtcbiAkLmFqYXgoe1xuICAgIHVybDogXCJodHRwczovL2lnYXBpLmdhL2V4cGxvcmUvdGFncy9ib2R5Ynlyb2JiaWUvbWVkaWFcIixcbiAgICBkYXRhVHlwZTogXCJqc29ucFwiLFxuICAgIGRhdGE6IHtcbiAgICAgIGNvdW50OiA0XG4gICAgfSxcbiAgICBzdWNjZXNzOiBmdW5jdGlvbihqc29uKSB7XG4gICAgICBjb25zb2xlLmxvZyhqc29uKTtcbiAgICAgIHZhciBpID0gMDtcbiAgICAgIHdoaWxlIChpPDMgJiYgaSA8IGpzb24ucG9zdHMubGVuZ3RoKSB7XG4gICAgICAgIHZhciBpbWcgPSBkb2N1bWVudC5jcmVhdGVFbGVtZW50KFwiSU1HXCIpO1xuICAgICAgICBpbWcuc3JjID0ganNvbi5wb3N0c1tpXS5kaXNwbGF5X3VybDtcbiAgICAgICAgaW1nLmNsYXNzTmFtZSA9ICdjb2wteHMtMyc7XG4gICAgICAgICQoJyNpbnN0YWdyYW0gLnJvdycpLmFwcGVuZChpbWcpO1xuICAgICAgICBpKys7XG4gICAgICB9XG4gICAgfVxuICB9KTtcbn1cblxuZnVuY3Rpb24gc2xpZGVzKHBhcmVudCl7XG4gIHZhciBsZW4gPSAkKHBhcmVudCkuZmluZCgnLnNsaWRlJykubGVuZ3RoO1xuICB2YXIgbG9jayA9IDA7XG4gIGZ1bmN0aW9uIHNldEluZGV4KGN1cnJlbnQsIG5leHQpIHtcbiAgICAkKCcuaW5kZXggc3BhbicpLmVxKGN1cnJlbnQpLnJlbW92ZUNsYXNzKCdpY29uLWljb25zX25hdmlnYXRpb25fY2lyY2xlX2Nsb3NlZCcpLmFkZENsYXNzKCdpY29uLWljb25zX25hdmlnYXRpb25fY2lyY2xlX29wZW4nKTtcbiAgICAkKCcuaW5kZXggc3BhbicpLmVxKG5leHQpLnJlbW92ZUNsYXNzKCdpY29uLWljb25zX25hdmlnYXRpb25fY2lyY2xlX29wZW4nKS5hZGRDbGFzcygnaWNvbi1pY29uc19uYXZpZ2F0aW9uX2NpcmNsZV9jbG9zZWQnKVxuICB9XG4gIGZ1bmN0aW9uIHNsaWRlTGVmdCgpIHtcbiAgICBsb2NrID0gMTtcbiAgICB2YXIgY3VycmVudCA9ICQocGFyZW50KS5maW5kKCcuc2xpZGUuYWN0aXZlJykuaW5kZXgoKTtcbiAgICB2YXIgbmV4dCA9IGN1cnJlbnQgPT0gMCA/IGxlbiAtIDEgOiBjdXJyZW50IC0gMTtcbiAgICAkKHBhcmVudCkuZmluZCgnLnNsaWRlLmFjdGl2ZScpLmFkZENsYXNzKCdyaWdodC1vdXQnKTtcbiAgICAkKHBhcmVudCkuZmluZCgnLnNsaWRlJykuZXEobmV4dCkuYWRkQ2xhc3MoJ2FjdGl2ZSBsZWZ0LWluJyk7XG4gICAgc2V0SW5kZXgoY3VycmVudCwgbmV4dCk7XG4gICAgc2V0VGltZW91dChmdW5jdGlvbigpe1xuICAgICAgbG9jayA9IDA7XG4gICAgICAkKHBhcmVudCkuZmluZCgnLnNsaWRlLnJpZ2h0LW91dCcpLnJlbW92ZUNsYXNzKCdyaWdodC1vdXQgYWN0aXZlJyk7XG4gICAgICAkKHBhcmVudCkuZmluZCgnLnNsaWRlLmxlZnQtaW4nKS5yZW1vdmVDbGFzcygnbGVmdC1pbicpO1xuICAgIH0sIDEwMDApO1xuICB9XG4gIGZ1bmN0aW9uIHNsaWRlUmlnaHQoKSB7XG4gICAgbG9jayA9IDE7XG4gICAgdmFyIGN1cnJlbnQgPSAkKHBhcmVudCkuZmluZCgnLnNsaWRlLmFjdGl2ZScpLmluZGV4KCk7XG4gICAgdmFyIG5leHQgPSBjdXJyZW50ID09IGxlbiAtIDEgPyAwIDogY3VycmVudCArIDE7XG4gICAgJChwYXJlbnQpLmZpbmQoJy5zbGlkZS5hY3RpdmUnKS5hZGRDbGFzcygnbGVmdC1vdXQnKTtcbiAgICAkKHBhcmVudCkuZmluZCgnLnNsaWRlJykuZXEobmV4dCkuYWRkQ2xhc3MoJ2FjdGl2ZSByaWdodC1pbicpO1xuICAgIHNldEluZGV4KGN1cnJlbnQsIG5leHQpO1xuICAgIHNldFRpbWVvdXQoZnVuY3Rpb24oKXtcbiAgICAgIGxvY2sgPSAwO1xuICAgICAgJChwYXJlbnQpLmZpbmQoJy5zbGlkZS5sZWZ0LW91dCcpLnJlbW92ZUNsYXNzKCdsZWZ0LW91dCBhY3RpdmUnKTtcbiAgICAgICQocGFyZW50KS5maW5kKCcuc2xpZGUucmlnaHQtaW4nKS5yZW1vdmVDbGFzcygncmlnaHQtaW4nKTtcbiAgICB9LCAxMDAwKTtcbiAgfVxuICB2YXIgc2xpZGVMb29wID0gc2V0SW50ZXJ2YWwoZnVuY3Rpb24oKSB7XG4gICAgaWYobGVuID4gMSkge1xuICAgICAgc2xpZGVSaWdodCgpO1xuICAgIH1cbiAgfSwgNTAwMCk7XG4gICQoJy5hcnJvdy5hcnJvdy1sZWZ0JykuY2xpY2soZnVuY3Rpb24oZSl7XG4gICAgLy9jbGVhckludGVydmFsKHNsaWRlTG9vcCk7XG4gICAgaWYoIWxvY2spe1xuICAgICAgc2xpZGVMZWZ0KCk7XG4gICAgfVxuICB9KTtcbiAgJCgnLmFycm93LmFycm93LXJpZ2h0JykuY2xpY2soZnVuY3Rpb24oZSl7XG4gICAgaWYoIWxvY2spe1xuICAgICAgLy9jbGVhckludGVydmFsKHNsaWRlTG9vcCk7XG4gICAgICBzbGlkZVJpZ2h0KCk7XG4gICAgfVxuICB9KTtcbiAgJChwYXJlbnQpLm9uKCBcInN3aXBlbGVmdFwiLCBmdW5jdGlvbihlKXtcbiAgICBpZighbG9jayl7XG4gICAgICAvL2NsZWFySW50ZXJ2YWwoc2xpZGVMb29wKTtcbiAgICAgIHNsaWRlUmlnaHQoKTtcbiAgICB9XG4gIH0pO1xuICAkKHBhcmVudCkub24oIFwic3dpcGVyaWdodFwiLCBmdW5jdGlvbihlKXtcbiAgICAvL2NsZWFySW50ZXJ2YWwoc2xpZGVMb29wKTtcbiAgICBpZighbG9jayl7XG4gICAgICBzbGlkZUxlZnQoKTtcbiAgICB9XG4gIH0pO1xufVxuXG5mdW5jdGlvbiBzZXJ2aWNlRGV0YWlsKCkge1xuICAkKCcudHJpZ2dlcicpLmNsaWNrKGZ1bmN0aW9uKCl7XG4gICAgaWYoJCh0aGlzKS5kYXRhKCd0eXBlJykgPT09ICd0b2dnbGUnKSB7XG4gICAgICAkKCcjJyskKHRoaXMpLmRhdGEoJ2lkJykpLnRvZ2dsZUNsYXNzKCdhY3RpdmUnKTtcbiAgICB9XG4gICAgZWxzZSB7XG4gICAgICAkKCcuJyskKHRoaXMpLmRhdGEoJ3RyaWdnZXInKSsnLmFjdGl2ZScpLnJlbW92ZUNsYXNzKCdhY3RpdmUnKTtcbiAgICAgICQoJyMnKyQodGhpcykuZGF0YSgnaWQnKSkuYWRkQ2xhc3MoJ2FjdGl2ZScpO1xuICAgIH1cbiAgfSk7XG59XG5cbmZ1bmN0aW9uIG5hdigpe1xuICB2YXIgbWVudUhlaWdodCA9ICQoJyNtcC1tZW51JykuaGVpZ2h0KCk7XG4gICQoJyN0cmlnZ2VyJykuY2xpY2soZnVuY3Rpb24oZSl7XG4gICAgJCh0aGlzKS50b2dnbGVDbGFzcygnaXMtYWN0aXZlJyk7XG4gICAgJCgnI21wLW1lbnUgdWwnKS50b2dnbGVDbGFzcygnb3BlbicpO1xuICB9KTtcbiAgJCgnLm1wLWxldmVsPnVsPmxpPmEnKS5jbGljayhmdW5jdGlvbihlKXtcbiAgICAkKCcjdHJpZ2dlcicpLnJlbW92ZUNsYXNzKCdpcy1hY3RpdmUnKTtcbiAgICAkKCcjbXAtbWVudSB1bCcpLnJlbW92ZUNsYXNzKCdvcGVuJyk7XG4gICAgbWVudUhlaWdodCA9ICQoJy5tb2JpbGUtdG9wJykuaGVpZ2h0KCk7XG4gIH0pO1xuICAkKCdhW2hyZWYqPVwiI1wiXTpub3QoW2hyZWY9XCIjXCJdKScpLmNsaWNrKGZ1bmN0aW9uKCkge1xuICAgIGlmIChsb2NhdGlvbi5wYXRobmFtZS5yZXBsYWNlKC9eXFwvLywnJykgPT0gdGhpcy5wYXRobmFtZS5yZXBsYWNlKC9eXFwvLywnJykgJiYgbG9jYXRpb24uaG9zdG5hbWUgPT0gdGhpcy5ob3N0bmFtZSkge1xuICAgICAgdmFyIHRhcmdldCA9ICQodGhpcy5oYXNoKTtcbiAgICAgIHRhcmdldCA9IHRhcmdldC5sZW5ndGggPyB0YXJnZXQgOiAkKCdbbmFtZT0nICsgdGhpcy5oYXNoLnNsaWNlKDEpICsnXScpO1xuICAgICAgaWYgKHRhcmdldC5sZW5ndGgpIHtcbiAgICAgICAgJCgnaHRtbCxib2R5JykuYW5pbWF0ZSh7XG4gICAgICAgICAgc2Nyb2xsVG9wOiB0YXJnZXQub2Zmc2V0KCkudG9wIC0gbWVudUhlaWdodFxuICAgICAgICB9LCAxMDAwKTtcbiAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgfVxuICAgIH1cbiAgfSk7XG59XG4kKGRvY3VtZW50KS5yZWFkeShmdW5jdGlvbigpIHtcbiAgJCgnLm1vYmlsZS1kcm9wZG93bicpLmNsaWNrKGZ1bmN0aW9uKGUpe1xuICAgICQodGhpcykudG9nZ2xlQ2xhc3MoJ29wZW4nKTtcbiAgfSk7XG4gICQoJy5hYm91dC1ib2R5LXRyaWdnZXInKS5jbGljayhmdW5jdGlvbihlKXtcbiAgICAkKCcuYWJvdXQtYm9keScpLnRvZ2dsZUNsYXNzKCdvcGVuJyk7XG4gIH0pO1xuICBuYXYoKTtcbiAgJCgnLnNsaWRlcy1jb250YWluZXInKS5lYWNoKGZ1bmN0aW9uKCl7XG4gICAgc2xpZGVzKHRoaXMpO1xuICB9KTtcbiAgLy9pbnN0YWdyYW0oKTtcbiAgc2VydmljZURldGFpbCgpXG4gIGlmKCFNb2Rlcm5penIudG91Y2gpe1xuICAgIHBhcmFsbGF4KCk7XG4gIH1cbiAgJCggXCIuZGF0ZXBpY2tlclwiICkuZGF0ZXBpY2tlcigpO1xufSk7XG5cblxuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vcHVibGljL3NyYy9qcy9tYWluLmpzXG4vLyBtb2R1bGUgaWQgPSAxXG4vLyBtb2R1bGUgY2h1bmtzID0gMCJdLCJzb3VyY2VSb290IjoiIn0=