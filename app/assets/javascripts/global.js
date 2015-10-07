(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var accordions, carousel, mobile_nav, modernizr, tab, to_top, turbolinks;

carousel = require('./carousel');

mobile_nav = require('./mobile_nav');

to_top = require('./to_top');

accordions = require('./accordions');

modernizr = require('./modernizr');

tab = require('./tab');

turbolinks = require('./turbolinks');

$(document).on('page:change', function() {
  modernizr();
  carousel();
  mobile_nav();
  to_top();
  accordions();
  tab();
  return turbolinks();
});



},{"./accordions":2,"./carousel":3,"./mobile_nav":4,"./modernizr":5,"./tab":6,"./to_top":7,"./turbolinks":8}],2:[function(require,module,exports){
module.exports = function() {
  var SuitProcedureAccordion;
  SuitProcedureAccordion = (function() {
    function SuitProcedureAccordion(button) {
      this.button = button;
      this.list = this.button.parent().find('.list--suit-process__cell');
      this.rest_list = this.list.not(':last-child');
      this["default"] = this.button.data('default');
      this.button.on('click', (function(_this) {
        return function(e) {
          if ($(e.currentTarget).hasClass('close')) {
            _this.close();
          } else {
            _this.open();
          }
          return false;
        };
      })(this));
      this.init();
    }

    SuitProcedureAccordion.prototype.open = function() {
      this.rest_list.slideDown(300);
      return this.change_method('close');
    };

    SuitProcedureAccordion.prototype.close = function() {
      this.rest_list.slideUp(300);
      return this.change_method('open');
    };

    SuitProcedureAccordion.prototype.change_method = function(order) {
      if (order !== 'open') {
        return this.button.removeClass('open').addClass('close').text('關閉');
      } else {
        return this.button.removeClass('close').addClass('open').text('展開');
      }
    };

    SuitProcedureAccordion.prototype.init = function() {
      if (this.list.length <= 1) {
        this.button.remove();
        return this.list.css({
          "border-bottom": "none"
        });
      } else {
        if (this["default"] !== 'open') {
          return this.change_method('close');
        } else {
          this.change_method('open');
          return this.rest_list.hide();
        }
      }
    };

    return SuitProcedureAccordion;

  })();
  return $('.list--suit-process-toggle').each(function() {
    return new SuitProcedureAccordion($(this));
  });
};



},{}],3:[function(require,module,exports){
module.exports = function() {
  $('#hero-carousel').slick({
    dots: false,
    infinite: true,
    speed: 300,
    fade: true,
    cssEase: 'linear',
    adaptiveHeight: false,
    slidesToShow: 1,
    autoplay: true,
    autoplaySpeed: 3000,
    arrows: false
  });
  $('#carousel').slick({
    fade: true,
    dots: true,
    infinite: true,
    speed: 300,
    cssEase: 'linear',
    adaptiveHeight: false,
    slidesToShow: 1,
    autoplay: true,
    autoplaySpeed: 8000,
    arrows: false
  });
  return $('#profile-carousel').slick({
    dots: true,
    infinite: true,
    speed: 300,
    cssEase: 'linear',
    adaptiveHeight: false,
    slidesToShow: 1,
    autoplay: true,
    autoplaySpeed: 8000,
    arrows: false
  });
};



},{}],4:[function(require,module,exports){
module.exports = function() {
  var MobileNav;
  MobileNav = (function() {
    function MobileNav(nav, toggle) {
      this.nav = nav;
      this.toggle = toggle;
      this.nav.hide();
      this.toggle.on('click', (function(_this) {
        return function(e) {
          $(e.currentTarget).toggleClass('active');
          _this.nav.slideToggle(300);
          return false;
        };
      })(this));
    }

    return MobileNav;

  })();
  return new MobileNav($('#mb-nav'), $('#mb-nav-toggle'));
};



},{}],5:[function(require,module,exports){
module.exports = function() {
  if (!Modernizr.testAllProps("appearance")) {
    return $("html").addClass("no-css-appearance");
  }
};



},{}],6:[function(require,module,exports){
module.exports = function() {
  var SearchTab;
  SearchTab = (function() {
    function SearchTab(toggle) {
      this.toggle = toggle;
      this.content = $(this.toggle.data('content'));
      this.init();
    }

    SearchTab.prototype.init = function() {
      this.content.not(':first-child').hide();
      return this.toggle.on('click', (function(_this) {
        return function(e) {
          if (!$(e.currentTarget).hasClass('active')) {
            _this.toggle.parent().siblings().removeClass('active').end().addClass('active');
            return _this.content.siblings().hide().end().show();
          }
        };
      })(this));
    };

    return SearchTab;

  })();
  return $('.search-tab__cell').each(function() {
    return new SearchTab($(this));
  });
};



},{}],7:[function(require,module,exports){
module.exports = function() {
  var $document, $to_top;
  $to_top = $('#to-top').hide();
  $document = $(window);
  $to_top.on('click', function() {
    $('html, body').animate({
      scrollTop: 0
    }, 500);
    return false;
  });
  return $document.on('scroll', $.throttle(1000 / 10, function() {
    if ($document.scrollTop() > 100) {
      return $to_top.fadeIn(300);
    } else {
      return $to_top.fadeOut(300);
    }
  }));
};



},{}],8:[function(require,module,exports){
module.exports = function() {
  Turbolinks.enableTransitionCache();
  return Turbolinks.enableProgressBar();
};



},{}]},{},[1]);
