webpackJsonp([0],[
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Sprite, globalSprite, inject_sprite;

Sprite = __webpack_require__(66);

globalSprite = new Sprite();

inject_sprite = function inject_sprite() {
  return globalSprite.elem = globalSprite.render(document.body);
};

document.addEventListener('DOMContentLoaded', inject_sprite, false);

document.addEventListener('page:load', inject_sprite, false);

module.exports = globalSprite;

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(Buffer) {/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
module.exports = function(useSourceMap) {
	var list = [];

	// return the list of modules as css string
	list.toString = function toString() {
		return this.map(function (item) {
			var content = cssWithMappingToString(item, useSourceMap);
			if(item[2]) {
				return "@media " + item[2] + "{" + content + "}";
			} else {
				return content;
			}
		}).join("");
	};

	// import a list of modules into the list
	list.i = function(modules, mediaQuery) {
		if(typeof modules === "string")
			modules = [[null, modules, ""]];
		var alreadyImportedModules = {};
		for(var i = 0; i < this.length; i++) {
			var id = this[i][0];
			if(typeof id === "number")
				alreadyImportedModules[id] = true;
		}
		for(i = 0; i < modules.length; i++) {
			var item = modules[i];
			// skip already imported module
			// this implementation is not 100% perfect for weird media query combinations
			//  when a module is imported multiple times with different media queries.
			//  I hope this will never occur (Hey this way we have smaller bundles)
			if(typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
				if(mediaQuery && !item[2]) {
					item[2] = mediaQuery;
				} else if(mediaQuery) {
					item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
				}
				list.push(item);
			}
		}
	};
	return list;
};

function cssWithMappingToString(item, useSourceMap) {
	var content = item[1] || '';
	var cssMapping = item[3];
	if (!cssMapping) {
		return content;
	}

	if (useSourceMap) {
		var sourceMapping = toComment(cssMapping);
		var sourceURLs = cssMapping.sources.map(function (source) {
			return '/*# sourceURL=' + cssMapping.sourceRoot + source + ' */'
		});

		return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
	}

	return [content].join('\n');
}

// Adapted from convert-source-map (MIT)
function toComment(sourceMap) {
  var base64 = new Buffer(JSON.stringify(sourceMap)).toString('base64');
  var data = 'sourceMappingURL=data:application/json;charset=utf-8;base64,' + base64;

  return '/*# ' + data + ' */';
}

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(24).Buffer))

/***/ }),
/* 2 */,
/* 3 */,
/* 4 */,
/* 5 */,
/* 6 */,
/* 7 */,
/* 8 */,
/* 9 */,
/* 10 */,
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(39);

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _modernizrrc = __webpack_require__(35);

var _modernizrrc2 = _interopRequireDefault(_modernizrrc);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var Arrow, Collapse, Dismiss, Rules, StoryInjection, Tab, TextInput, ToTop, Toggle, ref, ref1, sprites;

__webpack_require__(6);

__webpack_require__(5);

__webpack_require__(4);

__webpack_require__(3);

__webpack_require__(8);

__webpack_require__(9);

__webpack_require__(2);

__webpack_require__(7);

ref = __webpack_require__(19), Collapse = ref.Collapse, StoryInjection = ref.StoryInjection;

ref1 = __webpack_require__(22), Toggle = ref1.Toggle, Dismiss = ref1.Dismiss;

TextInput = __webpack_require__(17).TextInput;

Rules = __webpack_require__(18);

ToTop = __webpack_require__(21);

Tab = __webpack_require__(20);

Arrow = __webpack_require__(16);

__webpack_require__(15);

sprites = __webpack_require__(14);

sprites.keys().forEach(sprites);

Turbolinks.enableProgressBar();

Turbolinks.enableTransitionCache();

new TextInput();

new StoryInjection('[data-story-inject]');

new Collapse('#story-collapse-toggle');

new Tab('[data-tab-content]');

new Rules();

$(document).on('ready page:load', function () {
  $("input.datepicker").each(function (input) {
    return $(this).datepicker({
      dateFormat: "yy-mm-dd",
      altField: $(this).next(),
      onClose: function onClose() {
        return $(this).trigger('blur');
      }
    });
  });
  new Toggle('.switch');
  new Dismiss('[data-dismiss]');
  $('select').chosen({
    no_results_text: '沒有選項符合',
    search_contains: true
  });
  $('.popover-trigger').webuiPopover();
  new ToTop('#to-top');
  return $('#base-hero-carousel').slick({
    dots: false,
    infinite: true,
    speed: 300,
    fade: true,
    cssEase: 'linear',
    adaptiveHeight: false,
    slidesToShow: 1,
    autoplay: true,
    autoplaySpeed: 5000,
    appendArrows: '.base-hero',
    prevArrow: Arrow.prev('base-hero-carousel'),
    nextArrow: Arrow.next('base-hero-carousel')
  });
});

$(document).on("page:change", function () {
  var $main_header;
  $('input.form-control:not([autofocus], :hidden)').trigger('blur');
  Waypoint.destroyAll();
  $main_header = $('#main-header');
  return $('.base-hero-carousel__cell .heading, .card__heading, .character-selector__heading, .profile__avatar, .billboard__heading').waypoint({
    handler: function handler(direction) {
      if (direction === 'down') {
        return $main_header.addClass('has-background');
      } else {
        return $main_header.removeClass('has-background');
      }
    },
    offset: function offset() {
      return $main_header.height();
    }
  });
});

/**
 * 評分星星
 */

$(document).on('mouseenter', '.form-group--score [type="radio"]', function (e) {
  return $(this).addClass('hover');
}).on('mouseleave', '.form-group--score [type="radio"]', function (e) {
  return $(this).removeClass('hover');
});

/**
 * 評鑑紀錄 table
 */

$(document).on('click', '.story-list__table tbody tr', function (e) {
  return Turbolinks.visit($('td:last a', e.currentTarget).attr('href'));
});

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


__webpack_require__(31);

__webpack_require__(29);

__webpack_require__(30);

__webpack_require__(28);

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"./arrow-last.svg": 40,
	"./arrow-next.svg": 41,
	"./avatar-lawyer.svg": 42,
	"./avatar-observer.svg": 43,
	"./avatar-party.svg": 44,
	"./chart.svg": 45,
	"./close.svg": 46,
	"./envelop.svg": 47,
	"./exit.svg": 48,
	"./file-search.svg": 49,
	"./forwards.svg": 50,
	"./info.svg": 51,
	"./judge-avatar.svg": 52,
	"./key.svg": 53,
	"./medal.svg": 54,
	"./menu.svg": 55,
	"./pencil.svg": 56,
	"./phone.svg": 57,
	"./plus-circle-o.svg": 58,
	"./profile.svg": 59,
	"./prosecutor-avatar.svg": 60,
	"./star-full.svg": 61,
	"./star-half.svg": 62,
	"./star-o.svg": 63,
	"./star.svg": 64,
	"./user.svg": 65
};
function webpackContext(req) {
	return __webpack_require__(webpackContextResolve(req));
};
function webpackContextResolve(req) {
	var id = map[req];
	if(!(id + 1)) // check for number or string
		throw new Error("Cannot find module '" + req + "'.");
	return id;
};
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = 14;

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


$(document).on('ready page:load', function () {
  $('.card--article img').each(function () {
    $(this).wrap("<div class='image-wrapper'></div>");
  });
});

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var next, prev;

prev = function prev(class_name) {
  return "<button type='button' class='" + class_name + "__prev appearance-none'>\n  <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>\n</button>";
};

next = function next(class_name) {
  return "<button type='button' class='" + class_name + "__next appearance-none'>\n  <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>\n</button>";
};

module.exports = {
  prev: prev,
  next: next
};

/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var TextInput;

TextInput = function () {
  function TextInput() {
    $(document).on('focus', 'input.form-control, .text.form-control', function (_this) {
      return function (e) {
        return _this.focus(e.currentTarget);
      };
    }(this)).on('blur', 'input.form-control, .text.form-control', function (_this) {
      return function (e) {
        if ($(e.currentTarget).val().length > 0) {
          return _this.focus(e.currentTarget);
        } else {
          return _this.blur(e.currentTarget);
        }
      };
    }(this));
  }

  TextInput.prototype.focus = function (el) {
    return $(el).parent().addClass('is-focused');
  };

  TextInput.prototype.blur = function (el) {
    return $(el).parent().removeClass('is-focused');
  };

  return TextInput;
}();

module.exports = {
  TextInput: TextInput
};

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Cookies, Rules;

Cookies = __webpack_require__(34);

Rules = function () {
  function Rules() {
    $(document).on('click', '#appeal-to-schedule', function (_this) {
      return function (e) {
        return _this.check_cookie(e, 'schedule');
      };
    }(this));
    $(document).on('click', '#appeal-to-verdict', function (_this) {
      return function (e) {
        return _this.check_cookie(e, 'verdict');
      };
    }(this));
    $(document).on('click', '#confirmed-schedule-rules', function (_this) {
      return function (e) {
        return _this.set_cookie_and_go(e, 'schedule');
      };
    }(this));
    $(document).on('click', '#confirmed-verdict-rules', function (_this) {
      return function (e) {
        return _this.set_cookie_and_go(e, 'verdict');
      };
    }(this));
  }

  Rules.prototype.check_cookie = function (e, type) {
    var role;
    e.preventDefault();
    role = $(e.target).data('role');
    if (Cookies.get(role + "_has_seen_" + type + "_rules")) {
      return Turbolinks.visit(e.target.href);
    } else {
      return Turbolinks.visit("/" + role + "/score/" + type + "s/rule");
    }
  };

  Rules.prototype.set_cookie_and_go = function (e, type) {
    var role;
    e.preventDefault();
    role = $(e.target).data('role');
    Cookies.set(role + "_has_seen_" + type + "_rules", true, {
      expires: 7
    });
    return Turbolinks.visit(e.target.href);
  };

  return Rules;
}();

module.exports = Rules;

/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Collapse, StoryInjection;

StoryInjection = function () {
  function StoryInjection(query) {
    this.query = query;
    $(document).on("ready page:load", function (_this) {
      return function () {
        var $container;
        $container = $(_this.query);
        return $.getJSON($container.data("story-inject"), function (res) {
          var filteredContent;
          filteredContent = getReJDocString(res.main_content);
          return $container.html(filteredContent).removeClass("hidden").next(".loading").remove();
        });
      };
    }(this));
  }

  return StoryInjection;
}();

Collapse = function () {
  function Collapse(query) {
    this.query = query;
    $(document).on('page:change', function (_this) {
      return function () {
        _this.toggle = $(_this.query);
        _this.toggle_wrapper = _this.toggle.parent();
        return _this.toggle_target = $(_this.toggle.data('collapse'));
      };
    }(this));
    $(document).on('click', this.query, function (_this) {
      return function (e) {
        _this.toggle.toggleClass('active');
        _this.toggle_wrapper.toggleClass('extracted');
        return _this.toggle_target.slideToggle(300);
      };
    }(this));
  }

  return Collapse;
}();

module.exports = {
  Collapse: Collapse,
  StoryInjection: StoryInjection
};

/***/ }),
/* 20 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Tab;

Tab = function () {
  function Tab(query) {
    this.query = query;
    $(document).on("click", this.query, function (_this) {
      return function (e) {
        var $this;
        $this = $(e.currentTarget);
        if (!$this.hasClass('active')) {
          _this.update_active($this);
          return _this.update_active($($this.data('tab-content')));
        }
      };
    }(this));
  }

  Tab.prototype.update_active = function (el) {
    return el.addClass('active').siblings().removeClass('active');
  };

  return Tab;
}();

module.exports = Tab;

/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var ToTop;

ToTop = function () {
  function ToTop(query) {
    var $to_top;
    this.query = query;
    $to_top = $(this.query);
    $to_top.on('click', function () {
      $('html, body').animate({
        scrollTop: 0
      }, 500);
      return false;
    });
    $(window).on('scroll', function () {
      return requestAnimationFrame(function () {
        if ($(window).scrollTop() > 100) {
          return $to_top.addClass('active');
        } else {
          return $to_top.removeClass('active');
        }
      });
    });
  }

  return ToTop;
}();

module.exports = ToTop;

/***/ }),
/* 22 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Dismiss, Toggle;

Toggle = function () {
  function Toggle(query) {
    this.query = query;
    $(this.query).on('click', function (_this) {
      return function (e) {
        var $this, off_targets, on_targets;
        $this = $(e.currentTarget);
        on_targets = $this.data('switch-on');
        off_targets = $this.data('switch-off');
        if (on_targets != null) {
          _this.enable(on_targets);
        }
        if (off_targets != null) {
          return _this.disable(off_targets);
        }
      };
    }(this));
  }

  Toggle.prototype.enable = function (targets) {
    var i, len, results, target;
    if (targets.length > 1) {
      results = [];
      for (i = 0, len = targets.length; i < len; i++) {
        target = targets[i];
        results.push($(target).addClass('active'));
      }
      return results;
    } else {
      return $(targets).addClass('active');
    }
  };

  Toggle.prototype.disable = function (targets) {
    var i, len, results, target;
    if (targets.length > 1) {
      results = [];
      for (i = 0, len = targets.length; i < len; i++) {
        target = targets[i];
        results.push($(target).removeClass('active'));
      }
      return results;
    } else {
      return $(targets).removeClass('active');
    }
  };

  return Toggle;
}();

Dismiss = function () {
  function Dismiss(query) {
    this.query = query;
    $(this.query).on('click', function (e) {
      var $this;
      $this = $(this);
      switch ($this.data('dismiss')) {
        case 'alert':
          return $this.parent().slideUp();
      }
    });
  }

  return Dismiss;
}();

module.exports = {
  Toggle: Toggle,
  Dismiss: Dismiss
};

/***/ }),
/* 23 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


exports.byteLength = byteLength
exports.toByteArray = toByteArray
exports.fromByteArray = fromByteArray

var lookup = []
var revLookup = []
var Arr = typeof Uint8Array !== 'undefined' ? Uint8Array : Array

var code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
for (var i = 0, len = code.length; i < len; ++i) {
  lookup[i] = code[i]
  revLookup[code.charCodeAt(i)] = i
}

revLookup['-'.charCodeAt(0)] = 62
revLookup['_'.charCodeAt(0)] = 63

function placeHoldersCount (b64) {
  var len = b64.length
  if (len % 4 > 0) {
    throw new Error('Invalid string. Length must be a multiple of 4')
  }

  // the number of equal signs (place holders)
  // if there are two placeholders, than the two characters before it
  // represent one byte
  // if there is only one, then the three characters before it represent 2 bytes
  // this is just a cheap hack to not do indexOf twice
  return b64[len - 2] === '=' ? 2 : b64[len - 1] === '=' ? 1 : 0
}

function byteLength (b64) {
  // base64 is 4/3 + up to two characters of the original data
  return b64.length * 3 / 4 - placeHoldersCount(b64)
}

function toByteArray (b64) {
  var i, j, l, tmp, placeHolders, arr
  var len = b64.length
  placeHolders = placeHoldersCount(b64)

  arr = new Arr(len * 3 / 4 - placeHolders)

  // if there are placeholders, only get up to the last complete 4 chars
  l = placeHolders > 0 ? len - 4 : len

  var L = 0

  for (i = 0, j = 0; i < l; i += 4, j += 3) {
    tmp = (revLookup[b64.charCodeAt(i)] << 18) | (revLookup[b64.charCodeAt(i + 1)] << 12) | (revLookup[b64.charCodeAt(i + 2)] << 6) | revLookup[b64.charCodeAt(i + 3)]
    arr[L++] = (tmp >> 16) & 0xFF
    arr[L++] = (tmp >> 8) & 0xFF
    arr[L++] = tmp & 0xFF
  }

  if (placeHolders === 2) {
    tmp = (revLookup[b64.charCodeAt(i)] << 2) | (revLookup[b64.charCodeAt(i + 1)] >> 4)
    arr[L++] = tmp & 0xFF
  } else if (placeHolders === 1) {
    tmp = (revLookup[b64.charCodeAt(i)] << 10) | (revLookup[b64.charCodeAt(i + 1)] << 4) | (revLookup[b64.charCodeAt(i + 2)] >> 2)
    arr[L++] = (tmp >> 8) & 0xFF
    arr[L++] = tmp & 0xFF
  }

  return arr
}

function tripletToBase64 (num) {
  return lookup[num >> 18 & 0x3F] + lookup[num >> 12 & 0x3F] + lookup[num >> 6 & 0x3F] + lookup[num & 0x3F]
}

function encodeChunk (uint8, start, end) {
  var tmp
  var output = []
  for (var i = start; i < end; i += 3) {
    tmp = (uint8[i] << 16) + (uint8[i + 1] << 8) + (uint8[i + 2])
    output.push(tripletToBase64(tmp))
  }
  return output.join('')
}

function fromByteArray (uint8) {
  var tmp
  var len = uint8.length
  var extraBytes = len % 3 // if we have 1 byte left, pad 2 bytes
  var output = ''
  var parts = []
  var maxChunkLength = 16383 // must be multiple of 3

  // go through the array every three bytes, we'll deal with trailing stuff later
  for (var i = 0, len2 = len - extraBytes; i < len2; i += maxChunkLength) {
    parts.push(encodeChunk(uint8, i, (i + maxChunkLength) > len2 ? len2 : (i + maxChunkLength)))
  }

  // pad the end with zeros, but make sure to not forget the extra bytes
  if (extraBytes === 1) {
    tmp = uint8[len - 1]
    output += lookup[tmp >> 2]
    output += lookup[(tmp << 4) & 0x3F]
    output += '=='
  } else if (extraBytes === 2) {
    tmp = (uint8[len - 2] << 8) + (uint8[len - 1])
    output += lookup[tmp >> 10]
    output += lookup[(tmp >> 4) & 0x3F]
    output += lookup[(tmp << 2) & 0x3F]
    output += '='
  }

  parts.push(output)

  return parts.join('')
}


/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(global) {/*!
 * The buffer module from node.js, for the browser.
 *
 * @author   Feross Aboukhadijeh <feross@feross.org> <http://feross.org>
 * @license  MIT
 */
/* eslint-disable no-proto */



var base64 = __webpack_require__(23)
var ieee754 = __webpack_require__(32)
var isArray = __webpack_require__(33)

exports.Buffer = Buffer
exports.SlowBuffer = SlowBuffer
exports.INSPECT_MAX_BYTES = 50

/**
 * If `Buffer.TYPED_ARRAY_SUPPORT`:
 *   === true    Use Uint8Array implementation (fastest)
 *   === false   Use Object implementation (most compatible, even IE6)
 *
 * Browsers that support typed arrays are IE 10+, Firefox 4+, Chrome 7+, Safari 5.1+,
 * Opera 11.6+, iOS 4.2+.
 *
 * Due to various browser bugs, sometimes the Object implementation will be used even
 * when the browser supports typed arrays.
 *
 * Note:
 *
 *   - Firefox 4-29 lacks support for adding new properties to `Uint8Array` instances,
 *     See: https://bugzilla.mozilla.org/show_bug.cgi?id=695438.
 *
 *   - Chrome 9-10 is missing the `TypedArray.prototype.subarray` function.
 *
 *   - IE10 has a broken `TypedArray.prototype.subarray` function which returns arrays of
 *     incorrect length in some situations.

 * We detect these buggy browsers and set `Buffer.TYPED_ARRAY_SUPPORT` to `false` so they
 * get the Object implementation, which is slower but behaves correctly.
 */
Buffer.TYPED_ARRAY_SUPPORT = global.TYPED_ARRAY_SUPPORT !== undefined
  ? global.TYPED_ARRAY_SUPPORT
  : typedArraySupport()

/*
 * Export kMaxLength after typed array support is determined.
 */
exports.kMaxLength = kMaxLength()

function typedArraySupport () {
  try {
    var arr = new Uint8Array(1)
    arr.__proto__ = {__proto__: Uint8Array.prototype, foo: function () { return 42 }}
    return arr.foo() === 42 && // typed array instances can be augmented
        typeof arr.subarray === 'function' && // chrome 9-10 lack `subarray`
        arr.subarray(1, 1).byteLength === 0 // ie10 has broken `subarray`
  } catch (e) {
    return false
  }
}

function kMaxLength () {
  return Buffer.TYPED_ARRAY_SUPPORT
    ? 0x7fffffff
    : 0x3fffffff
}

function createBuffer (that, length) {
  if (kMaxLength() < length) {
    throw new RangeError('Invalid typed array length')
  }
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    // Return an augmented `Uint8Array` instance, for best performance
    that = new Uint8Array(length)
    that.__proto__ = Buffer.prototype
  } else {
    // Fallback: Return an object instance of the Buffer class
    if (that === null) {
      that = new Buffer(length)
    }
    that.length = length
  }

  return that
}

/**
 * The Buffer constructor returns instances of `Uint8Array` that have their
 * prototype changed to `Buffer.prototype`. Furthermore, `Buffer` is a subclass of
 * `Uint8Array`, so the returned instances will have all the node `Buffer` methods
 * and the `Uint8Array` methods. Square bracket notation works as expected -- it
 * returns a single octet.
 *
 * The `Uint8Array` prototype remains unmodified.
 */

function Buffer (arg, encodingOrOffset, length) {
  if (!Buffer.TYPED_ARRAY_SUPPORT && !(this instanceof Buffer)) {
    return new Buffer(arg, encodingOrOffset, length)
  }

  // Common case.
  if (typeof arg === 'number') {
    if (typeof encodingOrOffset === 'string') {
      throw new Error(
        'If encoding is specified then the first argument must be a string'
      )
    }
    return allocUnsafe(this, arg)
  }
  return from(this, arg, encodingOrOffset, length)
}

Buffer.poolSize = 8192 // not used by this implementation

// TODO: Legacy, not needed anymore. Remove in next major version.
Buffer._augment = function (arr) {
  arr.__proto__ = Buffer.prototype
  return arr
}

function from (that, value, encodingOrOffset, length) {
  if (typeof value === 'number') {
    throw new TypeError('"value" argument must not be a number')
  }

  if (typeof ArrayBuffer !== 'undefined' && value instanceof ArrayBuffer) {
    return fromArrayBuffer(that, value, encodingOrOffset, length)
  }

  if (typeof value === 'string') {
    return fromString(that, value, encodingOrOffset)
  }

  return fromObject(that, value)
}

/**
 * Functionally equivalent to Buffer(arg, encoding) but throws a TypeError
 * if value is a number.
 * Buffer.from(str[, encoding])
 * Buffer.from(array)
 * Buffer.from(buffer)
 * Buffer.from(arrayBuffer[, byteOffset[, length]])
 **/
Buffer.from = function (value, encodingOrOffset, length) {
  return from(null, value, encodingOrOffset, length)
}

if (Buffer.TYPED_ARRAY_SUPPORT) {
  Buffer.prototype.__proto__ = Uint8Array.prototype
  Buffer.__proto__ = Uint8Array
  if (typeof Symbol !== 'undefined' && Symbol.species &&
      Buffer[Symbol.species] === Buffer) {
    // Fix subarray() in ES2016. See: https://github.com/feross/buffer/pull/97
    Object.defineProperty(Buffer, Symbol.species, {
      value: null,
      configurable: true
    })
  }
}

function assertSize (size) {
  if (typeof size !== 'number') {
    throw new TypeError('"size" argument must be a number')
  } else if (size < 0) {
    throw new RangeError('"size" argument must not be negative')
  }
}

function alloc (that, size, fill, encoding) {
  assertSize(size)
  if (size <= 0) {
    return createBuffer(that, size)
  }
  if (fill !== undefined) {
    // Only pay attention to encoding if it's a string. This
    // prevents accidentally sending in a number that would
    // be interpretted as a start offset.
    return typeof encoding === 'string'
      ? createBuffer(that, size).fill(fill, encoding)
      : createBuffer(that, size).fill(fill)
  }
  return createBuffer(that, size)
}

/**
 * Creates a new filled Buffer instance.
 * alloc(size[, fill[, encoding]])
 **/
Buffer.alloc = function (size, fill, encoding) {
  return alloc(null, size, fill, encoding)
}

function allocUnsafe (that, size) {
  assertSize(size)
  that = createBuffer(that, size < 0 ? 0 : checked(size) | 0)
  if (!Buffer.TYPED_ARRAY_SUPPORT) {
    for (var i = 0; i < size; ++i) {
      that[i] = 0
    }
  }
  return that
}

/**
 * Equivalent to Buffer(num), by default creates a non-zero-filled Buffer instance.
 * */
Buffer.allocUnsafe = function (size) {
  return allocUnsafe(null, size)
}
/**
 * Equivalent to SlowBuffer(num), by default creates a non-zero-filled Buffer instance.
 */
Buffer.allocUnsafeSlow = function (size) {
  return allocUnsafe(null, size)
}

function fromString (that, string, encoding) {
  if (typeof encoding !== 'string' || encoding === '') {
    encoding = 'utf8'
  }

  if (!Buffer.isEncoding(encoding)) {
    throw new TypeError('"encoding" must be a valid string encoding')
  }

  var length = byteLength(string, encoding) | 0
  that = createBuffer(that, length)

  var actual = that.write(string, encoding)

  if (actual !== length) {
    // Writing a hex string, for example, that contains invalid characters will
    // cause everything after the first invalid character to be ignored. (e.g.
    // 'abxxcd' will be treated as 'ab')
    that = that.slice(0, actual)
  }

  return that
}

function fromArrayLike (that, array) {
  var length = array.length < 0 ? 0 : checked(array.length) | 0
  that = createBuffer(that, length)
  for (var i = 0; i < length; i += 1) {
    that[i] = array[i] & 255
  }
  return that
}

function fromArrayBuffer (that, array, byteOffset, length) {
  array.byteLength // this throws if `array` is not a valid ArrayBuffer

  if (byteOffset < 0 || array.byteLength < byteOffset) {
    throw new RangeError('\'offset\' is out of bounds')
  }

  if (array.byteLength < byteOffset + (length || 0)) {
    throw new RangeError('\'length\' is out of bounds')
  }

  if (byteOffset === undefined && length === undefined) {
    array = new Uint8Array(array)
  } else if (length === undefined) {
    array = new Uint8Array(array, byteOffset)
  } else {
    array = new Uint8Array(array, byteOffset, length)
  }

  if (Buffer.TYPED_ARRAY_SUPPORT) {
    // Return an augmented `Uint8Array` instance, for best performance
    that = array
    that.__proto__ = Buffer.prototype
  } else {
    // Fallback: Return an object instance of the Buffer class
    that = fromArrayLike(that, array)
  }
  return that
}

function fromObject (that, obj) {
  if (Buffer.isBuffer(obj)) {
    var len = checked(obj.length) | 0
    that = createBuffer(that, len)

    if (that.length === 0) {
      return that
    }

    obj.copy(that, 0, 0, len)
    return that
  }

  if (obj) {
    if ((typeof ArrayBuffer !== 'undefined' &&
        obj.buffer instanceof ArrayBuffer) || 'length' in obj) {
      if (typeof obj.length !== 'number' || isnan(obj.length)) {
        return createBuffer(that, 0)
      }
      return fromArrayLike(that, obj)
    }

    if (obj.type === 'Buffer' && isArray(obj.data)) {
      return fromArrayLike(that, obj.data)
    }
  }

  throw new TypeError('First argument must be a string, Buffer, ArrayBuffer, Array, or array-like object.')
}

function checked (length) {
  // Note: cannot use `length < kMaxLength()` here because that fails when
  // length is NaN (which is otherwise coerced to zero.)
  if (length >= kMaxLength()) {
    throw new RangeError('Attempt to allocate Buffer larger than maximum ' +
                         'size: 0x' + kMaxLength().toString(16) + ' bytes')
  }
  return length | 0
}

function SlowBuffer (length) {
  if (+length != length) { // eslint-disable-line eqeqeq
    length = 0
  }
  return Buffer.alloc(+length)
}

Buffer.isBuffer = function isBuffer (b) {
  return !!(b != null && b._isBuffer)
}

Buffer.compare = function compare (a, b) {
  if (!Buffer.isBuffer(a) || !Buffer.isBuffer(b)) {
    throw new TypeError('Arguments must be Buffers')
  }

  if (a === b) return 0

  var x = a.length
  var y = b.length

  for (var i = 0, len = Math.min(x, y); i < len; ++i) {
    if (a[i] !== b[i]) {
      x = a[i]
      y = b[i]
      break
    }
  }

  if (x < y) return -1
  if (y < x) return 1
  return 0
}

Buffer.isEncoding = function isEncoding (encoding) {
  switch (String(encoding).toLowerCase()) {
    case 'hex':
    case 'utf8':
    case 'utf-8':
    case 'ascii':
    case 'latin1':
    case 'binary':
    case 'base64':
    case 'ucs2':
    case 'ucs-2':
    case 'utf16le':
    case 'utf-16le':
      return true
    default:
      return false
  }
}

Buffer.concat = function concat (list, length) {
  if (!isArray(list)) {
    throw new TypeError('"list" argument must be an Array of Buffers')
  }

  if (list.length === 0) {
    return Buffer.alloc(0)
  }

  var i
  if (length === undefined) {
    length = 0
    for (i = 0; i < list.length; ++i) {
      length += list[i].length
    }
  }

  var buffer = Buffer.allocUnsafe(length)
  var pos = 0
  for (i = 0; i < list.length; ++i) {
    var buf = list[i]
    if (!Buffer.isBuffer(buf)) {
      throw new TypeError('"list" argument must be an Array of Buffers')
    }
    buf.copy(buffer, pos)
    pos += buf.length
  }
  return buffer
}

function byteLength (string, encoding) {
  if (Buffer.isBuffer(string)) {
    return string.length
  }
  if (typeof ArrayBuffer !== 'undefined' && typeof ArrayBuffer.isView === 'function' &&
      (ArrayBuffer.isView(string) || string instanceof ArrayBuffer)) {
    return string.byteLength
  }
  if (typeof string !== 'string') {
    string = '' + string
  }

  var len = string.length
  if (len === 0) return 0

  // Use a for loop to avoid recursion
  var loweredCase = false
  for (;;) {
    switch (encoding) {
      case 'ascii':
      case 'latin1':
      case 'binary':
        return len
      case 'utf8':
      case 'utf-8':
      case undefined:
        return utf8ToBytes(string).length
      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return len * 2
      case 'hex':
        return len >>> 1
      case 'base64':
        return base64ToBytes(string).length
      default:
        if (loweredCase) return utf8ToBytes(string).length // assume utf8
        encoding = ('' + encoding).toLowerCase()
        loweredCase = true
    }
  }
}
Buffer.byteLength = byteLength

function slowToString (encoding, start, end) {
  var loweredCase = false

  // No need to verify that "this.length <= MAX_UINT32" since it's a read-only
  // property of a typed array.

  // This behaves neither like String nor Uint8Array in that we set start/end
  // to their upper/lower bounds if the value passed is out of range.
  // undefined is handled specially as per ECMA-262 6th Edition,
  // Section 13.3.3.7 Runtime Semantics: KeyedBindingInitialization.
  if (start === undefined || start < 0) {
    start = 0
  }
  // Return early if start > this.length. Done here to prevent potential uint32
  // coercion fail below.
  if (start > this.length) {
    return ''
  }

  if (end === undefined || end > this.length) {
    end = this.length
  }

  if (end <= 0) {
    return ''
  }

  // Force coersion to uint32. This will also coerce falsey/NaN values to 0.
  end >>>= 0
  start >>>= 0

  if (end <= start) {
    return ''
  }

  if (!encoding) encoding = 'utf8'

  while (true) {
    switch (encoding) {
      case 'hex':
        return hexSlice(this, start, end)

      case 'utf8':
      case 'utf-8':
        return utf8Slice(this, start, end)

      case 'ascii':
        return asciiSlice(this, start, end)

      case 'latin1':
      case 'binary':
        return latin1Slice(this, start, end)

      case 'base64':
        return base64Slice(this, start, end)

      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return utf16leSlice(this, start, end)

      default:
        if (loweredCase) throw new TypeError('Unknown encoding: ' + encoding)
        encoding = (encoding + '').toLowerCase()
        loweredCase = true
    }
  }
}

// The property is used by `Buffer.isBuffer` and `is-buffer` (in Safari 5-7) to detect
// Buffer instances.
Buffer.prototype._isBuffer = true

function swap (b, n, m) {
  var i = b[n]
  b[n] = b[m]
  b[m] = i
}

Buffer.prototype.swap16 = function swap16 () {
  var len = this.length
  if (len % 2 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 16-bits')
  }
  for (var i = 0; i < len; i += 2) {
    swap(this, i, i + 1)
  }
  return this
}

Buffer.prototype.swap32 = function swap32 () {
  var len = this.length
  if (len % 4 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 32-bits')
  }
  for (var i = 0; i < len; i += 4) {
    swap(this, i, i + 3)
    swap(this, i + 1, i + 2)
  }
  return this
}

Buffer.prototype.swap64 = function swap64 () {
  var len = this.length
  if (len % 8 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 64-bits')
  }
  for (var i = 0; i < len; i += 8) {
    swap(this, i, i + 7)
    swap(this, i + 1, i + 6)
    swap(this, i + 2, i + 5)
    swap(this, i + 3, i + 4)
  }
  return this
}

Buffer.prototype.toString = function toString () {
  var length = this.length | 0
  if (length === 0) return ''
  if (arguments.length === 0) return utf8Slice(this, 0, length)
  return slowToString.apply(this, arguments)
}

Buffer.prototype.equals = function equals (b) {
  if (!Buffer.isBuffer(b)) throw new TypeError('Argument must be a Buffer')
  if (this === b) return true
  return Buffer.compare(this, b) === 0
}

Buffer.prototype.inspect = function inspect () {
  var str = ''
  var max = exports.INSPECT_MAX_BYTES
  if (this.length > 0) {
    str = this.toString('hex', 0, max).match(/.{2}/g).join(' ')
    if (this.length > max) str += ' ... '
  }
  return '<Buffer ' + str + '>'
}

Buffer.prototype.compare = function compare (target, start, end, thisStart, thisEnd) {
  if (!Buffer.isBuffer(target)) {
    throw new TypeError('Argument must be a Buffer')
  }

  if (start === undefined) {
    start = 0
  }
  if (end === undefined) {
    end = target ? target.length : 0
  }
  if (thisStart === undefined) {
    thisStart = 0
  }
  if (thisEnd === undefined) {
    thisEnd = this.length
  }

  if (start < 0 || end > target.length || thisStart < 0 || thisEnd > this.length) {
    throw new RangeError('out of range index')
  }

  if (thisStart >= thisEnd && start >= end) {
    return 0
  }
  if (thisStart >= thisEnd) {
    return -1
  }
  if (start >= end) {
    return 1
  }

  start >>>= 0
  end >>>= 0
  thisStart >>>= 0
  thisEnd >>>= 0

  if (this === target) return 0

  var x = thisEnd - thisStart
  var y = end - start
  var len = Math.min(x, y)

  var thisCopy = this.slice(thisStart, thisEnd)
  var targetCopy = target.slice(start, end)

  for (var i = 0; i < len; ++i) {
    if (thisCopy[i] !== targetCopy[i]) {
      x = thisCopy[i]
      y = targetCopy[i]
      break
    }
  }

  if (x < y) return -1
  if (y < x) return 1
  return 0
}

// Finds either the first index of `val` in `buffer` at offset >= `byteOffset`,
// OR the last index of `val` in `buffer` at offset <= `byteOffset`.
//
// Arguments:
// - buffer - a Buffer to search
// - val - a string, Buffer, or number
// - byteOffset - an index into `buffer`; will be clamped to an int32
// - encoding - an optional encoding, relevant is val is a string
// - dir - true for indexOf, false for lastIndexOf
function bidirectionalIndexOf (buffer, val, byteOffset, encoding, dir) {
  // Empty buffer means no match
  if (buffer.length === 0) return -1

  // Normalize byteOffset
  if (typeof byteOffset === 'string') {
    encoding = byteOffset
    byteOffset = 0
  } else if (byteOffset > 0x7fffffff) {
    byteOffset = 0x7fffffff
  } else if (byteOffset < -0x80000000) {
    byteOffset = -0x80000000
  }
  byteOffset = +byteOffset  // Coerce to Number.
  if (isNaN(byteOffset)) {
    // byteOffset: it it's undefined, null, NaN, "foo", etc, search whole buffer
    byteOffset = dir ? 0 : (buffer.length - 1)
  }

  // Normalize byteOffset: negative offsets start from the end of the buffer
  if (byteOffset < 0) byteOffset = buffer.length + byteOffset
  if (byteOffset >= buffer.length) {
    if (dir) return -1
    else byteOffset = buffer.length - 1
  } else if (byteOffset < 0) {
    if (dir) byteOffset = 0
    else return -1
  }

  // Normalize val
  if (typeof val === 'string') {
    val = Buffer.from(val, encoding)
  }

  // Finally, search either indexOf (if dir is true) or lastIndexOf
  if (Buffer.isBuffer(val)) {
    // Special case: looking for empty string/buffer always fails
    if (val.length === 0) {
      return -1
    }
    return arrayIndexOf(buffer, val, byteOffset, encoding, dir)
  } else if (typeof val === 'number') {
    val = val & 0xFF // Search for a byte value [0-255]
    if (Buffer.TYPED_ARRAY_SUPPORT &&
        typeof Uint8Array.prototype.indexOf === 'function') {
      if (dir) {
        return Uint8Array.prototype.indexOf.call(buffer, val, byteOffset)
      } else {
        return Uint8Array.prototype.lastIndexOf.call(buffer, val, byteOffset)
      }
    }
    return arrayIndexOf(buffer, [ val ], byteOffset, encoding, dir)
  }

  throw new TypeError('val must be string, number or Buffer')
}

function arrayIndexOf (arr, val, byteOffset, encoding, dir) {
  var indexSize = 1
  var arrLength = arr.length
  var valLength = val.length

  if (encoding !== undefined) {
    encoding = String(encoding).toLowerCase()
    if (encoding === 'ucs2' || encoding === 'ucs-2' ||
        encoding === 'utf16le' || encoding === 'utf-16le') {
      if (arr.length < 2 || val.length < 2) {
        return -1
      }
      indexSize = 2
      arrLength /= 2
      valLength /= 2
      byteOffset /= 2
    }
  }

  function read (buf, i) {
    if (indexSize === 1) {
      return buf[i]
    } else {
      return buf.readUInt16BE(i * indexSize)
    }
  }

  var i
  if (dir) {
    var foundIndex = -1
    for (i = byteOffset; i < arrLength; i++) {
      if (read(arr, i) === read(val, foundIndex === -1 ? 0 : i - foundIndex)) {
        if (foundIndex === -1) foundIndex = i
        if (i - foundIndex + 1 === valLength) return foundIndex * indexSize
      } else {
        if (foundIndex !== -1) i -= i - foundIndex
        foundIndex = -1
      }
    }
  } else {
    if (byteOffset + valLength > arrLength) byteOffset = arrLength - valLength
    for (i = byteOffset; i >= 0; i--) {
      var found = true
      for (var j = 0; j < valLength; j++) {
        if (read(arr, i + j) !== read(val, j)) {
          found = false
          break
        }
      }
      if (found) return i
    }
  }

  return -1
}

Buffer.prototype.includes = function includes (val, byteOffset, encoding) {
  return this.indexOf(val, byteOffset, encoding) !== -1
}

Buffer.prototype.indexOf = function indexOf (val, byteOffset, encoding) {
  return bidirectionalIndexOf(this, val, byteOffset, encoding, true)
}

Buffer.prototype.lastIndexOf = function lastIndexOf (val, byteOffset, encoding) {
  return bidirectionalIndexOf(this, val, byteOffset, encoding, false)
}

function hexWrite (buf, string, offset, length) {
  offset = Number(offset) || 0
  var remaining = buf.length - offset
  if (!length) {
    length = remaining
  } else {
    length = Number(length)
    if (length > remaining) {
      length = remaining
    }
  }

  // must be an even number of digits
  var strLen = string.length
  if (strLen % 2 !== 0) throw new TypeError('Invalid hex string')

  if (length > strLen / 2) {
    length = strLen / 2
  }
  for (var i = 0; i < length; ++i) {
    var parsed = parseInt(string.substr(i * 2, 2), 16)
    if (isNaN(parsed)) return i
    buf[offset + i] = parsed
  }
  return i
}

function utf8Write (buf, string, offset, length) {
  return blitBuffer(utf8ToBytes(string, buf.length - offset), buf, offset, length)
}

function asciiWrite (buf, string, offset, length) {
  return blitBuffer(asciiToBytes(string), buf, offset, length)
}

function latin1Write (buf, string, offset, length) {
  return asciiWrite(buf, string, offset, length)
}

function base64Write (buf, string, offset, length) {
  return blitBuffer(base64ToBytes(string), buf, offset, length)
}

function ucs2Write (buf, string, offset, length) {
  return blitBuffer(utf16leToBytes(string, buf.length - offset), buf, offset, length)
}

Buffer.prototype.write = function write (string, offset, length, encoding) {
  // Buffer#write(string)
  if (offset === undefined) {
    encoding = 'utf8'
    length = this.length
    offset = 0
  // Buffer#write(string, encoding)
  } else if (length === undefined && typeof offset === 'string') {
    encoding = offset
    length = this.length
    offset = 0
  // Buffer#write(string, offset[, length][, encoding])
  } else if (isFinite(offset)) {
    offset = offset | 0
    if (isFinite(length)) {
      length = length | 0
      if (encoding === undefined) encoding = 'utf8'
    } else {
      encoding = length
      length = undefined
    }
  // legacy write(string, encoding, offset, length) - remove in v0.13
  } else {
    throw new Error(
      'Buffer.write(string, encoding, offset[, length]) is no longer supported'
    )
  }

  var remaining = this.length - offset
  if (length === undefined || length > remaining) length = remaining

  if ((string.length > 0 && (length < 0 || offset < 0)) || offset > this.length) {
    throw new RangeError('Attempt to write outside buffer bounds')
  }

  if (!encoding) encoding = 'utf8'

  var loweredCase = false
  for (;;) {
    switch (encoding) {
      case 'hex':
        return hexWrite(this, string, offset, length)

      case 'utf8':
      case 'utf-8':
        return utf8Write(this, string, offset, length)

      case 'ascii':
        return asciiWrite(this, string, offset, length)

      case 'latin1':
      case 'binary':
        return latin1Write(this, string, offset, length)

      case 'base64':
        // Warning: maxLength not taken into account in base64Write
        return base64Write(this, string, offset, length)

      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return ucs2Write(this, string, offset, length)

      default:
        if (loweredCase) throw new TypeError('Unknown encoding: ' + encoding)
        encoding = ('' + encoding).toLowerCase()
        loweredCase = true
    }
  }
}

Buffer.prototype.toJSON = function toJSON () {
  return {
    type: 'Buffer',
    data: Array.prototype.slice.call(this._arr || this, 0)
  }
}

function base64Slice (buf, start, end) {
  if (start === 0 && end === buf.length) {
    return base64.fromByteArray(buf)
  } else {
    return base64.fromByteArray(buf.slice(start, end))
  }
}

function utf8Slice (buf, start, end) {
  end = Math.min(buf.length, end)
  var res = []

  var i = start
  while (i < end) {
    var firstByte = buf[i]
    var codePoint = null
    var bytesPerSequence = (firstByte > 0xEF) ? 4
      : (firstByte > 0xDF) ? 3
      : (firstByte > 0xBF) ? 2
      : 1

    if (i + bytesPerSequence <= end) {
      var secondByte, thirdByte, fourthByte, tempCodePoint

      switch (bytesPerSequence) {
        case 1:
          if (firstByte < 0x80) {
            codePoint = firstByte
          }
          break
        case 2:
          secondByte = buf[i + 1]
          if ((secondByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0x1F) << 0x6 | (secondByte & 0x3F)
            if (tempCodePoint > 0x7F) {
              codePoint = tempCodePoint
            }
          }
          break
        case 3:
          secondByte = buf[i + 1]
          thirdByte = buf[i + 2]
          if ((secondByte & 0xC0) === 0x80 && (thirdByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0xF) << 0xC | (secondByte & 0x3F) << 0x6 | (thirdByte & 0x3F)
            if (tempCodePoint > 0x7FF && (tempCodePoint < 0xD800 || tempCodePoint > 0xDFFF)) {
              codePoint = tempCodePoint
            }
          }
          break
        case 4:
          secondByte = buf[i + 1]
          thirdByte = buf[i + 2]
          fourthByte = buf[i + 3]
          if ((secondByte & 0xC0) === 0x80 && (thirdByte & 0xC0) === 0x80 && (fourthByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0xF) << 0x12 | (secondByte & 0x3F) << 0xC | (thirdByte & 0x3F) << 0x6 | (fourthByte & 0x3F)
            if (tempCodePoint > 0xFFFF && tempCodePoint < 0x110000) {
              codePoint = tempCodePoint
            }
          }
      }
    }

    if (codePoint === null) {
      // we did not generate a valid codePoint so insert a
      // replacement char (U+FFFD) and advance only 1 byte
      codePoint = 0xFFFD
      bytesPerSequence = 1
    } else if (codePoint > 0xFFFF) {
      // encode to utf16 (surrogate pair dance)
      codePoint -= 0x10000
      res.push(codePoint >>> 10 & 0x3FF | 0xD800)
      codePoint = 0xDC00 | codePoint & 0x3FF
    }

    res.push(codePoint)
    i += bytesPerSequence
  }

  return decodeCodePointsArray(res)
}

// Based on http://stackoverflow.com/a/22747272/680742, the browser with
// the lowest limit is Chrome, with 0x10000 args.
// We go 1 magnitude less, for safety
var MAX_ARGUMENTS_LENGTH = 0x1000

function decodeCodePointsArray (codePoints) {
  var len = codePoints.length
  if (len <= MAX_ARGUMENTS_LENGTH) {
    return String.fromCharCode.apply(String, codePoints) // avoid extra slice()
  }

  // Decode in chunks to avoid "call stack size exceeded".
  var res = ''
  var i = 0
  while (i < len) {
    res += String.fromCharCode.apply(
      String,
      codePoints.slice(i, i += MAX_ARGUMENTS_LENGTH)
    )
  }
  return res
}

function asciiSlice (buf, start, end) {
  var ret = ''
  end = Math.min(buf.length, end)

  for (var i = start; i < end; ++i) {
    ret += String.fromCharCode(buf[i] & 0x7F)
  }
  return ret
}

function latin1Slice (buf, start, end) {
  var ret = ''
  end = Math.min(buf.length, end)

  for (var i = start; i < end; ++i) {
    ret += String.fromCharCode(buf[i])
  }
  return ret
}

function hexSlice (buf, start, end) {
  var len = buf.length

  if (!start || start < 0) start = 0
  if (!end || end < 0 || end > len) end = len

  var out = ''
  for (var i = start; i < end; ++i) {
    out += toHex(buf[i])
  }
  return out
}

function utf16leSlice (buf, start, end) {
  var bytes = buf.slice(start, end)
  var res = ''
  for (var i = 0; i < bytes.length; i += 2) {
    res += String.fromCharCode(bytes[i] + bytes[i + 1] * 256)
  }
  return res
}

Buffer.prototype.slice = function slice (start, end) {
  var len = this.length
  start = ~~start
  end = end === undefined ? len : ~~end

  if (start < 0) {
    start += len
    if (start < 0) start = 0
  } else if (start > len) {
    start = len
  }

  if (end < 0) {
    end += len
    if (end < 0) end = 0
  } else if (end > len) {
    end = len
  }

  if (end < start) end = start

  var newBuf
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    newBuf = this.subarray(start, end)
    newBuf.__proto__ = Buffer.prototype
  } else {
    var sliceLen = end - start
    newBuf = new Buffer(sliceLen, undefined)
    for (var i = 0; i < sliceLen; ++i) {
      newBuf[i] = this[i + start]
    }
  }

  return newBuf
}

/*
 * Need to make sure that buffer isn't trying to write out of bounds.
 */
function checkOffset (offset, ext, length) {
  if ((offset % 1) !== 0 || offset < 0) throw new RangeError('offset is not uint')
  if (offset + ext > length) throw new RangeError('Trying to access beyond buffer length')
}

Buffer.prototype.readUIntLE = function readUIntLE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var val = this[offset]
  var mul = 1
  var i = 0
  while (++i < byteLength && (mul *= 0x100)) {
    val += this[offset + i] * mul
  }

  return val
}

Buffer.prototype.readUIntBE = function readUIntBE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    checkOffset(offset, byteLength, this.length)
  }

  var val = this[offset + --byteLength]
  var mul = 1
  while (byteLength > 0 && (mul *= 0x100)) {
    val += this[offset + --byteLength] * mul
  }

  return val
}

Buffer.prototype.readUInt8 = function readUInt8 (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 1, this.length)
  return this[offset]
}

Buffer.prototype.readUInt16LE = function readUInt16LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  return this[offset] | (this[offset + 1] << 8)
}

Buffer.prototype.readUInt16BE = function readUInt16BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  return (this[offset] << 8) | this[offset + 1]
}

Buffer.prototype.readUInt32LE = function readUInt32LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return ((this[offset]) |
      (this[offset + 1] << 8) |
      (this[offset + 2] << 16)) +
      (this[offset + 3] * 0x1000000)
}

Buffer.prototype.readUInt32BE = function readUInt32BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset] * 0x1000000) +
    ((this[offset + 1] << 16) |
    (this[offset + 2] << 8) |
    this[offset + 3])
}

Buffer.prototype.readIntLE = function readIntLE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var val = this[offset]
  var mul = 1
  var i = 0
  while (++i < byteLength && (mul *= 0x100)) {
    val += this[offset + i] * mul
  }
  mul *= 0x80

  if (val >= mul) val -= Math.pow(2, 8 * byteLength)

  return val
}

Buffer.prototype.readIntBE = function readIntBE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var i = byteLength
  var mul = 1
  var val = this[offset + --i]
  while (i > 0 && (mul *= 0x100)) {
    val += this[offset + --i] * mul
  }
  mul *= 0x80

  if (val >= mul) val -= Math.pow(2, 8 * byteLength)

  return val
}

Buffer.prototype.readInt8 = function readInt8 (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 1, this.length)
  if (!(this[offset] & 0x80)) return (this[offset])
  return ((0xff - this[offset] + 1) * -1)
}

Buffer.prototype.readInt16LE = function readInt16LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  var val = this[offset] | (this[offset + 1] << 8)
  return (val & 0x8000) ? val | 0xFFFF0000 : val
}

Buffer.prototype.readInt16BE = function readInt16BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  var val = this[offset + 1] | (this[offset] << 8)
  return (val & 0x8000) ? val | 0xFFFF0000 : val
}

Buffer.prototype.readInt32LE = function readInt32LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset]) |
    (this[offset + 1] << 8) |
    (this[offset + 2] << 16) |
    (this[offset + 3] << 24)
}

Buffer.prototype.readInt32BE = function readInt32BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset] << 24) |
    (this[offset + 1] << 16) |
    (this[offset + 2] << 8) |
    (this[offset + 3])
}

Buffer.prototype.readFloatLE = function readFloatLE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)
  return ieee754.read(this, offset, true, 23, 4)
}

Buffer.prototype.readFloatBE = function readFloatBE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)
  return ieee754.read(this, offset, false, 23, 4)
}

Buffer.prototype.readDoubleLE = function readDoubleLE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 8, this.length)
  return ieee754.read(this, offset, true, 52, 8)
}

Buffer.prototype.readDoubleBE = function readDoubleBE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 8, this.length)
  return ieee754.read(this, offset, false, 52, 8)
}

function checkInt (buf, value, offset, ext, max, min) {
  if (!Buffer.isBuffer(buf)) throw new TypeError('"buffer" argument must be a Buffer instance')
  if (value > max || value < min) throw new RangeError('"value" argument is out of bounds')
  if (offset + ext > buf.length) throw new RangeError('Index out of range')
}

Buffer.prototype.writeUIntLE = function writeUIntLE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    var maxBytes = Math.pow(2, 8 * byteLength) - 1
    checkInt(this, value, offset, byteLength, maxBytes, 0)
  }

  var mul = 1
  var i = 0
  this[offset] = value & 0xFF
  while (++i < byteLength && (mul *= 0x100)) {
    this[offset + i] = (value / mul) & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeUIntBE = function writeUIntBE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    var maxBytes = Math.pow(2, 8 * byteLength) - 1
    checkInt(this, value, offset, byteLength, maxBytes, 0)
  }

  var i = byteLength - 1
  var mul = 1
  this[offset + i] = value & 0xFF
  while (--i >= 0 && (mul *= 0x100)) {
    this[offset + i] = (value / mul) & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeUInt8 = function writeUInt8 (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 1, 0xff, 0)
  if (!Buffer.TYPED_ARRAY_SUPPORT) value = Math.floor(value)
  this[offset] = (value & 0xff)
  return offset + 1
}

function objectWriteUInt16 (buf, value, offset, littleEndian) {
  if (value < 0) value = 0xffff + value + 1
  for (var i = 0, j = Math.min(buf.length - offset, 2); i < j; ++i) {
    buf[offset + i] = (value & (0xff << (8 * (littleEndian ? i : 1 - i)))) >>>
      (littleEndian ? i : 1 - i) * 8
  }
}

Buffer.prototype.writeUInt16LE = function writeUInt16LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0xffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
  } else {
    objectWriteUInt16(this, value, offset, true)
  }
  return offset + 2
}

Buffer.prototype.writeUInt16BE = function writeUInt16BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0xffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 8)
    this[offset + 1] = (value & 0xff)
  } else {
    objectWriteUInt16(this, value, offset, false)
  }
  return offset + 2
}

function objectWriteUInt32 (buf, value, offset, littleEndian) {
  if (value < 0) value = 0xffffffff + value + 1
  for (var i = 0, j = Math.min(buf.length - offset, 4); i < j; ++i) {
    buf[offset + i] = (value >>> (littleEndian ? i : 3 - i) * 8) & 0xff
  }
}

Buffer.prototype.writeUInt32LE = function writeUInt32LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0xffffffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset + 3] = (value >>> 24)
    this[offset + 2] = (value >>> 16)
    this[offset + 1] = (value >>> 8)
    this[offset] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, true)
  }
  return offset + 4
}

Buffer.prototype.writeUInt32BE = function writeUInt32BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0xffffffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 24)
    this[offset + 1] = (value >>> 16)
    this[offset + 2] = (value >>> 8)
    this[offset + 3] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, false)
  }
  return offset + 4
}

Buffer.prototype.writeIntLE = function writeIntLE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) {
    var limit = Math.pow(2, 8 * byteLength - 1)

    checkInt(this, value, offset, byteLength, limit - 1, -limit)
  }

  var i = 0
  var mul = 1
  var sub = 0
  this[offset] = value & 0xFF
  while (++i < byteLength && (mul *= 0x100)) {
    if (value < 0 && sub === 0 && this[offset + i - 1] !== 0) {
      sub = 1
    }
    this[offset + i] = ((value / mul) >> 0) - sub & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeIntBE = function writeIntBE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) {
    var limit = Math.pow(2, 8 * byteLength - 1)

    checkInt(this, value, offset, byteLength, limit - 1, -limit)
  }

  var i = byteLength - 1
  var mul = 1
  var sub = 0
  this[offset + i] = value & 0xFF
  while (--i >= 0 && (mul *= 0x100)) {
    if (value < 0 && sub === 0 && this[offset + i + 1] !== 0) {
      sub = 1
    }
    this[offset + i] = ((value / mul) >> 0) - sub & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeInt8 = function writeInt8 (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 1, 0x7f, -0x80)
  if (!Buffer.TYPED_ARRAY_SUPPORT) value = Math.floor(value)
  if (value < 0) value = 0xff + value + 1
  this[offset] = (value & 0xff)
  return offset + 1
}

Buffer.prototype.writeInt16LE = function writeInt16LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0x7fff, -0x8000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
  } else {
    objectWriteUInt16(this, value, offset, true)
  }
  return offset + 2
}

Buffer.prototype.writeInt16BE = function writeInt16BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0x7fff, -0x8000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 8)
    this[offset + 1] = (value & 0xff)
  } else {
    objectWriteUInt16(this, value, offset, false)
  }
  return offset + 2
}

Buffer.prototype.writeInt32LE = function writeInt32LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0x7fffffff, -0x80000000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
    this[offset + 2] = (value >>> 16)
    this[offset + 3] = (value >>> 24)
  } else {
    objectWriteUInt32(this, value, offset, true)
  }
  return offset + 4
}

Buffer.prototype.writeInt32BE = function writeInt32BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0x7fffffff, -0x80000000)
  if (value < 0) value = 0xffffffff + value + 1
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 24)
    this[offset + 1] = (value >>> 16)
    this[offset + 2] = (value >>> 8)
    this[offset + 3] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, false)
  }
  return offset + 4
}

function checkIEEE754 (buf, value, offset, ext, max, min) {
  if (offset + ext > buf.length) throw new RangeError('Index out of range')
  if (offset < 0) throw new RangeError('Index out of range')
}

function writeFloat (buf, value, offset, littleEndian, noAssert) {
  if (!noAssert) {
    checkIEEE754(buf, value, offset, 4, 3.4028234663852886e+38, -3.4028234663852886e+38)
  }
  ieee754.write(buf, value, offset, littleEndian, 23, 4)
  return offset + 4
}

Buffer.prototype.writeFloatLE = function writeFloatLE (value, offset, noAssert) {
  return writeFloat(this, value, offset, true, noAssert)
}

Buffer.prototype.writeFloatBE = function writeFloatBE (value, offset, noAssert) {
  return writeFloat(this, value, offset, false, noAssert)
}

function writeDouble (buf, value, offset, littleEndian, noAssert) {
  if (!noAssert) {
    checkIEEE754(buf, value, offset, 8, 1.7976931348623157E+308, -1.7976931348623157E+308)
  }
  ieee754.write(buf, value, offset, littleEndian, 52, 8)
  return offset + 8
}

Buffer.prototype.writeDoubleLE = function writeDoubleLE (value, offset, noAssert) {
  return writeDouble(this, value, offset, true, noAssert)
}

Buffer.prototype.writeDoubleBE = function writeDoubleBE (value, offset, noAssert) {
  return writeDouble(this, value, offset, false, noAssert)
}

// copy(targetBuffer, targetStart=0, sourceStart=0, sourceEnd=buffer.length)
Buffer.prototype.copy = function copy (target, targetStart, start, end) {
  if (!start) start = 0
  if (!end && end !== 0) end = this.length
  if (targetStart >= target.length) targetStart = target.length
  if (!targetStart) targetStart = 0
  if (end > 0 && end < start) end = start

  // Copy 0 bytes; we're done
  if (end === start) return 0
  if (target.length === 0 || this.length === 0) return 0

  // Fatal error conditions
  if (targetStart < 0) {
    throw new RangeError('targetStart out of bounds')
  }
  if (start < 0 || start >= this.length) throw new RangeError('sourceStart out of bounds')
  if (end < 0) throw new RangeError('sourceEnd out of bounds')

  // Are we oob?
  if (end > this.length) end = this.length
  if (target.length - targetStart < end - start) {
    end = target.length - targetStart + start
  }

  var len = end - start
  var i

  if (this === target && start < targetStart && targetStart < end) {
    // descending copy from end
    for (i = len - 1; i >= 0; --i) {
      target[i + targetStart] = this[i + start]
    }
  } else if (len < 1000 || !Buffer.TYPED_ARRAY_SUPPORT) {
    // ascending copy from start
    for (i = 0; i < len; ++i) {
      target[i + targetStart] = this[i + start]
    }
  } else {
    Uint8Array.prototype.set.call(
      target,
      this.subarray(start, start + len),
      targetStart
    )
  }

  return len
}

// Usage:
//    buffer.fill(number[, offset[, end]])
//    buffer.fill(buffer[, offset[, end]])
//    buffer.fill(string[, offset[, end]][, encoding])
Buffer.prototype.fill = function fill (val, start, end, encoding) {
  // Handle string cases:
  if (typeof val === 'string') {
    if (typeof start === 'string') {
      encoding = start
      start = 0
      end = this.length
    } else if (typeof end === 'string') {
      encoding = end
      end = this.length
    }
    if (val.length === 1) {
      var code = val.charCodeAt(0)
      if (code < 256) {
        val = code
      }
    }
    if (encoding !== undefined && typeof encoding !== 'string') {
      throw new TypeError('encoding must be a string')
    }
    if (typeof encoding === 'string' && !Buffer.isEncoding(encoding)) {
      throw new TypeError('Unknown encoding: ' + encoding)
    }
  } else if (typeof val === 'number') {
    val = val & 255
  }

  // Invalid ranges are not set to a default, so can range check early.
  if (start < 0 || this.length < start || this.length < end) {
    throw new RangeError('Out of range index')
  }

  if (end <= start) {
    return this
  }

  start = start >>> 0
  end = end === undefined ? this.length : end >>> 0

  if (!val) val = 0

  var i
  if (typeof val === 'number') {
    for (i = start; i < end; ++i) {
      this[i] = val
    }
  } else {
    var bytes = Buffer.isBuffer(val)
      ? val
      : utf8ToBytes(new Buffer(val, encoding).toString())
    var len = bytes.length
    for (i = 0; i < end - start; ++i) {
      this[i + start] = bytes[i % len]
    }
  }

  return this
}

// HELPER FUNCTIONS
// ================

var INVALID_BASE64_RE = /[^+\/0-9A-Za-z-_]/g

function base64clean (str) {
  // Node strips out invalid characters like \n and \t from the string, base64-js does not
  str = stringtrim(str).replace(INVALID_BASE64_RE, '')
  // Node converts strings with length < 2 to ''
  if (str.length < 2) return ''
  // Node allows for non-padded base64 strings (missing trailing ===), base64-js does not
  while (str.length % 4 !== 0) {
    str = str + '='
  }
  return str
}

function stringtrim (str) {
  if (str.trim) return str.trim()
  return str.replace(/^\s+|\s+$/g, '')
}

function toHex (n) {
  if (n < 16) return '0' + n.toString(16)
  return n.toString(16)
}

function utf8ToBytes (string, units) {
  units = units || Infinity
  var codePoint
  var length = string.length
  var leadSurrogate = null
  var bytes = []

  for (var i = 0; i < length; ++i) {
    codePoint = string.charCodeAt(i)

    // is surrogate component
    if (codePoint > 0xD7FF && codePoint < 0xE000) {
      // last char was a lead
      if (!leadSurrogate) {
        // no lead yet
        if (codePoint > 0xDBFF) {
          // unexpected trail
          if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
          continue
        } else if (i + 1 === length) {
          // unpaired lead
          if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
          continue
        }

        // valid lead
        leadSurrogate = codePoint

        continue
      }

      // 2 leads in a row
      if (codePoint < 0xDC00) {
        if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
        leadSurrogate = codePoint
        continue
      }

      // valid surrogate pair
      codePoint = (leadSurrogate - 0xD800 << 10 | codePoint - 0xDC00) + 0x10000
    } else if (leadSurrogate) {
      // valid bmp char, but last char was a lead
      if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
    }

    leadSurrogate = null

    // encode utf8
    if (codePoint < 0x80) {
      if ((units -= 1) < 0) break
      bytes.push(codePoint)
    } else if (codePoint < 0x800) {
      if ((units -= 2) < 0) break
      bytes.push(
        codePoint >> 0x6 | 0xC0,
        codePoint & 0x3F | 0x80
      )
    } else if (codePoint < 0x10000) {
      if ((units -= 3) < 0) break
      bytes.push(
        codePoint >> 0xC | 0xE0,
        codePoint >> 0x6 & 0x3F | 0x80,
        codePoint & 0x3F | 0x80
      )
    } else if (codePoint < 0x110000) {
      if ((units -= 4) < 0) break
      bytes.push(
        codePoint >> 0x12 | 0xF0,
        codePoint >> 0xC & 0x3F | 0x80,
        codePoint >> 0x6 & 0x3F | 0x80,
        codePoint & 0x3F | 0x80
      )
    } else {
      throw new Error('Invalid code point')
    }
  }

  return bytes
}

function asciiToBytes (str) {
  var byteArray = []
  for (var i = 0; i < str.length; ++i) {
    // Node's code seems to be doing this and not & 0x7F..
    byteArray.push(str.charCodeAt(i) & 0xFF)
  }
  return byteArray
}

function utf16leToBytes (str, units) {
  var c, hi, lo
  var byteArray = []
  for (var i = 0; i < str.length; ++i) {
    if ((units -= 2) < 0) break

    c = str.charCodeAt(i)
    hi = c >> 8
    lo = c % 256
    byteArray.push(lo)
    byteArray.push(hi)
  }

  return byteArray
}

function base64ToBytes (str) {
  return base64.toByteArray(base64clean(str))
}

function blitBuffer (src, dst, offset, length) {
  for (var i = 0; i < length; ++i) {
    if ((i + offset >= dst.length) || (i >= src.length)) break
    dst[i + offset] = src[i]
  }
  return i
}

function isnan (val) {
  return val !== val // eslint-disable-line no-self-compare
}

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(67)))

/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(1)(undefined);
// imports
exports.i(__webpack_require__(26), "");
exports.i(__webpack_require__(27), "");

// module
exports.push([module.i, "", ""]);

// exports


/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(1)(undefined);
// imports


// module
exports.push([module.i, ".animated {\n  animation-duration: 1s;\n  animation-fill-mode: both;\n}\n\n.animated.infinite {\n  animation-iteration-count: infinite;\n}\n\n.animated.hinge {\n  animation-duration: 2s;\n}\n\n.animated.flipOutX,\n.animated.flipOutY,\n.animated.bounceIn,\n.animated.bounceOut {\n  animation-duration: .75s;\n}\n", ""]);

// exports


/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(1)(undefined);
// imports


// module
exports.push([module.i, "@keyframes bounceIn {\n  from, 20%, 40%, 60%, 80%, to {\n    animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);\n  }\n\n  0% {\n    opacity: 0;\n    transform: scale3d(.3, .3, .3);\n  }\n\n  20% {\n    transform: scale3d(1.1, 1.1, 1.1);\n  }\n\n  40% {\n    transform: scale3d(.9, .9, .9);\n  }\n\n  60% {\n    opacity: 1;\n    transform: scale3d(1.03, 1.03, 1.03);\n  }\n\n  80% {\n    transform: scale3d(.97, .97, .97);\n  }\n\n  to {\n    opacity: 1;\n    transform: scale3d(1, 1, 1);\n  }\n}\n\n.bounceIn {\n  animation-name: bounceIn;\n}\n", ""]);

// exports


/***/ }),
/* 28 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 29 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 30 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 31 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 32 */
/***/ (function(module, exports) {

exports.read = function (buffer, offset, isLE, mLen, nBytes) {
  var e, m
  var eLen = nBytes * 8 - mLen - 1
  var eMax = (1 << eLen) - 1
  var eBias = eMax >> 1
  var nBits = -7
  var i = isLE ? (nBytes - 1) : 0
  var d = isLE ? -1 : 1
  var s = buffer[offset + i]

  i += d

  e = s & ((1 << (-nBits)) - 1)
  s >>= (-nBits)
  nBits += eLen
  for (; nBits > 0; e = e * 256 + buffer[offset + i], i += d, nBits -= 8) {}

  m = e & ((1 << (-nBits)) - 1)
  e >>= (-nBits)
  nBits += mLen
  for (; nBits > 0; m = m * 256 + buffer[offset + i], i += d, nBits -= 8) {}

  if (e === 0) {
    e = 1 - eBias
  } else if (e === eMax) {
    return m ? NaN : ((s ? -1 : 1) * Infinity)
  } else {
    m = m + Math.pow(2, mLen)
    e = e - eBias
  }
  return (s ? -1 : 1) * m * Math.pow(2, e - mLen)
}

exports.write = function (buffer, value, offset, isLE, mLen, nBytes) {
  var e, m, c
  var eLen = nBytes * 8 - mLen - 1
  var eMax = (1 << eLen) - 1
  var eBias = eMax >> 1
  var rt = (mLen === 23 ? Math.pow(2, -24) - Math.pow(2, -77) : 0)
  var i = isLE ? 0 : (nBytes - 1)
  var d = isLE ? 1 : -1
  var s = value < 0 || (value === 0 && 1 / value < 0) ? 1 : 0

  value = Math.abs(value)

  if (isNaN(value) || value === Infinity) {
    m = isNaN(value) ? 1 : 0
    e = eMax
  } else {
    e = Math.floor(Math.log(value) / Math.LN2)
    if (value * (c = Math.pow(2, -e)) < 1) {
      e--
      c *= 2
    }
    if (e + eBias >= 1) {
      value += rt / c
    } else {
      value += rt * Math.pow(2, 1 - eBias)
    }
    if (value * c >= 2) {
      e++
      c /= 2
    }

    if (e + eBias >= eMax) {
      m = 0
      e = eMax
    } else if (e + eBias >= 1) {
      m = (value * c - 1) * Math.pow(2, mLen)
      e = e + eBias
    } else {
      m = value * Math.pow(2, eBias - 1) * Math.pow(2, mLen)
      e = 0
    }
  }

  for (; mLen >= 8; buffer[offset + i] = m & 0xff, i += d, m /= 256, mLen -= 8) {}

  e = (e << mLen) | m
  eLen += mLen
  for (; eLen > 0; buffer[offset + i] = e & 0xff, i += d, e /= 256, eLen -= 8) {}

  buffer[offset + i - d] |= s * 128
}


/***/ }),
/* 33 */
/***/ (function(module, exports) {

var toString = {}.toString;

module.exports = Array.isArray || function (arr) {
  return toString.call(arr) == '[object Array]';
};


/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_RESULT__;/*!
 * JavaScript Cookie v2.1.3
 * https://github.com/js-cookie/js-cookie
 *
 * Copyright 2006, 2015 Klaus Hartl & Fagner Brack
 * Released under the MIT license
 */
;(function (factory) {
	var registeredInModuleLoader = false;
	if (true) {
		!(__WEBPACK_AMD_DEFINE_FACTORY__ = (factory),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.call(exports, __webpack_require__, exports, module)) :
				__WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
		registeredInModuleLoader = true;
	}
	if (true) {
		module.exports = factory();
		registeredInModuleLoader = true;
	}
	if (!registeredInModuleLoader) {
		var OldCookies = window.Cookies;
		var api = window.Cookies = factory();
		api.noConflict = function () {
			window.Cookies = OldCookies;
			return api;
		};
	}
}(function () {
	function extend () {
		var i = 0;
		var result = {};
		for (; i < arguments.length; i++) {
			var attributes = arguments[ i ];
			for (var key in attributes) {
				result[key] = attributes[key];
			}
		}
		return result;
	}

	function init (converter) {
		function api (key, value, attributes) {
			var result;
			if (typeof document === 'undefined') {
				return;
			}

			// Write

			if (arguments.length > 1) {
				attributes = extend({
					path: '/'
				}, api.defaults, attributes);

				if (typeof attributes.expires === 'number') {
					var expires = new Date();
					expires.setMilliseconds(expires.getMilliseconds() + attributes.expires * 864e+5);
					attributes.expires = expires;
				}

				try {
					result = JSON.stringify(value);
					if (/^[\{\[]/.test(result)) {
						value = result;
					}
				} catch (e) {}

				if (!converter.write) {
					value = encodeURIComponent(String(value))
						.replace(/%(23|24|26|2B|3A|3C|3E|3D|2F|3F|40|5B|5D|5E|60|7B|7D|7C)/g, decodeURIComponent);
				} else {
					value = converter.write(value, key);
				}

				key = encodeURIComponent(String(key));
				key = key.replace(/%(23|24|26|2B|5E|60|7C)/g, decodeURIComponent);
				key = key.replace(/[\(\)]/g, escape);

				return (document.cookie = [
					key, '=', value,
					attributes.expires ? '; expires=' + attributes.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
					attributes.path ? '; path=' + attributes.path : '',
					attributes.domain ? '; domain=' + attributes.domain : '',
					attributes.secure ? '; secure' : ''
				].join(''));
			}

			// Read

			if (!key) {
				result = {};
			}

			// To prevent the for loop in the first place assign an empty array
			// in case there are no cookies at all. Also prevents odd result when
			// calling "get()"
			var cookies = document.cookie ? document.cookie.split('; ') : [];
			var rdecode = /(%[0-9A-Z]{2})+/g;
			var i = 0;

			for (; i < cookies.length; i++) {
				var parts = cookies[i].split('=');
				var cookie = parts.slice(1).join('=');

				if (cookie.charAt(0) === '"') {
					cookie = cookie.slice(1, -1);
				}

				try {
					var name = parts[0].replace(rdecode, decodeURIComponent);
					cookie = converter.read ?
						converter.read(cookie, name) : converter(cookie, name) ||
						cookie.replace(rdecode, decodeURIComponent);

					if (this.json) {
						try {
							cookie = JSON.parse(cookie);
						} catch (e) {}
					}

					if (key === name) {
						result = cookie;
						break;
					}

					if (!key) {
						result[name] = cookie;
					}
				} catch (e) {}
			}

			return result;
		}

		api.set = api;
		api.get = function (key) {
			return api.call(api, key);
		};
		api.getJSON = function () {
			return api.apply({
				json: true
			}, [].slice.call(arguments));
		};
		api.defaults = {};

		api.remove = function (key, attributes) {
			api(key, '', extend(attributes, {
				expires: -1
			}));
		};

		api.withConverter = init;

		return api;
	}

	return init(function () {});
}));


/***/ }),
/* 35 */
/***/ (function(module, exports) {

;(function(window){
var hadGlobal = 'Modernizr' in window;
var oldGlobal = window.Modernizr;
/*!
 * modernizr v3.5.0
 * Build https://modernizr.com/download?-appearance-setclasses-dontmin
 *
 * Copyright (c)
 *  Faruk Ates
 *  Paul Irish
 *  Alex Sexton
 *  Ryan Seddon
 *  Patrick Kettner
 *  Stu Cox
 *  Richard Herrera

 * MIT License
 */

/*
 * Modernizr tests which native CSS3 and HTML5 features are available in the
 * current UA and makes the results available to you in two ways: as properties on
 * a global `Modernizr` object, and as classes on the `<html>` element. This
 * information allows you to progressively enhance your pages with a granular level
 * of control over the experience.
*/

;(function(window, document, undefined){
  var tests = [];
  

  /**
   *
   * ModernizrProto is the constructor for Modernizr
   *
   * @class
   * @access public
   */

  var ModernizrProto = {
    // The current version, dummy
    _version: '3.5.0',

    // Any settings that don't work as separate modules
    // can go in here as configuration.
    _config: {
      'classPrefix': '',
      'enableClasses': true,
      'enableJSClass': true,
      'usePrefixes': true
    },

    // Queue of tests
    _q: [],

    // Stub these for people who are listening
    on: function(test, cb) {
      // I don't really think people should do this, but we can
      // safe guard it a bit.
      // -- NOTE:: this gets WAY overridden in src/addTest for actual async tests.
      // This is in case people listen to synchronous tests. I would leave it out,
      // but the code to *disallow* sync tests in the real version of this
      // function is actually larger than this.
      var self = this;
      setTimeout(function() {
        cb(self[test]);
      }, 0);
    },

    addTest: function(name, fn, options) {
      tests.push({name: name, fn: fn, options: options});
    },

    addAsyncTest: function(fn) {
      tests.push({name: null, fn: fn});
    }
  };

  

  // Fake some of Object.create so we can force non test results to be non "own" properties.
  var Modernizr = function() {};
  Modernizr.prototype = ModernizrProto;

  // Leak modernizr globally when you `require` it rather than force it here.
  // Overwrite name so constructor name is nicer :D
  Modernizr = new Modernizr();

  

  var classes = [];
  

  /**
   * is returns a boolean if the typeof an obj is exactly type.
   *
   * @access private
   * @function is
   * @param {*} obj - A thing we want to check the type of
   * @param {string} type - A string to compare the typeof against
   * @returns {boolean}
   */

  function is(obj, type) {
    return typeof obj === type;
  }
  ;

  /**
   * Run through all tests and detect their support in the current UA.
   *
   * @access private
   */

  function testRunner() {
    var featureNames;
    var feature;
    var aliasIdx;
    var result;
    var nameIdx;
    var featureName;
    var featureNameSplit;

    for (var featureIdx in tests) {
      if (tests.hasOwnProperty(featureIdx)) {
        featureNames = [];
        feature = tests[featureIdx];
        // run the test, throw the return value into the Modernizr,
        // then based on that boolean, define an appropriate className
        // and push it into an array of classes we'll join later.
        //
        // If there is no name, it's an 'async' test that is run,
        // but not directly added to the object. That should
        // be done with a post-run addTest call.
        if (feature.name) {
          featureNames.push(feature.name.toLowerCase());

          if (feature.options && feature.options.aliases && feature.options.aliases.length) {
            // Add all the aliases into the names list
            for (aliasIdx = 0; aliasIdx < feature.options.aliases.length; aliasIdx++) {
              featureNames.push(feature.options.aliases[aliasIdx].toLowerCase());
            }
          }
        }

        // Run the test, or use the raw value if it's not a function
        result = is(feature.fn, 'function') ? feature.fn() : feature.fn;


        // Set each of the names on the Modernizr object
        for (nameIdx = 0; nameIdx < featureNames.length; nameIdx++) {
          featureName = featureNames[nameIdx];
          // Support dot properties as sub tests. We don't do checking to make sure
          // that the implied parent tests have been added. You must call them in
          // order (either in the test, or make the parent test a dependency).
          //
          // Cap it to TWO to make the logic simple and because who needs that kind of subtesting
          // hashtag famous last words
          featureNameSplit = featureName.split('.');

          if (featureNameSplit.length === 1) {
            Modernizr[featureNameSplit[0]] = result;
          } else {
            // cast to a Boolean, if not one already
            if (Modernizr[featureNameSplit[0]] && !(Modernizr[featureNameSplit[0]] instanceof Boolean)) {
              Modernizr[featureNameSplit[0]] = new Boolean(Modernizr[featureNameSplit[0]]);
            }

            Modernizr[featureNameSplit[0]][featureNameSplit[1]] = result;
          }

          classes.push((result ? '' : 'no-') + featureNameSplit.join('-'));
        }
      }
    }
  }
  ;

  /**
   * docElement is a convenience wrapper to grab the root element of the document
   *
   * @access private
   * @returns {HTMLElement|SVGElement} The root element of the document
   */

  var docElement = document.documentElement;
  

  /**
   * A convenience helper to check if the document we are running in is an SVG document
   *
   * @access private
   * @returns {boolean}
   */

  var isSVG = docElement.nodeName.toLowerCase() === 'svg';
  

  /**
   * setClasses takes an array of class names and adds them to the root element
   *
   * @access private
   * @function setClasses
   * @param {string[]} classes - Array of class names
   */

  // Pass in an and array of class names, e.g.:
  //  ['no-webp', 'borderradius', ...]
  function setClasses(classes) {
    var className = docElement.className;
    var classPrefix = Modernizr._config.classPrefix || '';

    if (isSVG) {
      className = className.baseVal;
    }

    // Change `no-js` to `js` (independently of the `enableClasses` option)
    // Handle classPrefix on this too
    if (Modernizr._config.enableJSClass) {
      var reJS = new RegExp('(^|\\s)' + classPrefix + 'no-js(\\s|$)');
      className = className.replace(reJS, '$1' + classPrefix + 'js$2');
    }

    if (Modernizr._config.enableClasses) {
      // Add the new classes
      className += ' ' + classPrefix + classes.join(' ' + classPrefix);
      if (isSVG) {
        docElement.className.baseVal = className;
      } else {
        docElement.className = className;
      }
    }

  }

  ;

  /**
   * If the browsers follow the spec, then they would expose vendor-specific styles as:
   *   elem.style.WebkitBorderRadius
   * instead of something like the following (which is technically incorrect):
   *   elem.style.webkitBorderRadius

   * WebKit ghosts their properties in lowercase but Opera & Moz do not.
   * Microsoft uses a lowercase `ms` instead of the correct `Ms` in IE8+
   *   erik.eae.net/archives/2008/03/10/21.48.10/

   * More here: github.com/Modernizr/Modernizr/issues/issue/21
   *
   * @access private
   * @returns {string} The string representing the vendor-specific style properties
   */

  var omPrefixes = 'Moz O ms Webkit';
  

  var cssomPrefixes = (ModernizrProto._config.usePrefixes ? omPrefixes.split(' ') : []);
  ModernizrProto._cssomPrefixes = cssomPrefixes;
  


  /**
   * contains checks to see if a string contains another string
   *
   * @access private
   * @function contains
   * @param {string} str - The string we want to check for substrings
   * @param {string} substr - The substring we want to search the first string for
   * @returns {boolean}
   */

  function contains(str, substr) {
    return !!~('' + str).indexOf(substr);
  }

  ;

  /**
   * createElement is a convenience wrapper around document.createElement. Since we
   * use createElement all over the place, this allows for (slightly) smaller code
   * as well as abstracting away issues with creating elements in contexts other than
   * HTML documents (e.g. SVG documents).
   *
   * @access private
   * @function createElement
   * @returns {HTMLElement|SVGElement} An HTML or SVG element
   */

  function createElement() {
    if (typeof document.createElement !== 'function') {
      // This is the case in IE7, where the type of createElement is "object".
      // For this reason, we cannot call apply() as Object is not a Function.
      return document.createElement(arguments[0]);
    } else if (isSVG) {
      return document.createElementNS.call(document, 'http://www.w3.org/2000/svg', arguments[0]);
    } else {
      return document.createElement.apply(document, arguments);
    }
  }

  ;

  /**
   * Create our "modernizr" element that we do most feature tests on.
   *
   * @access private
   */

  var modElem = {
    elem: createElement('modernizr')
  };

  // Clean up this element
  Modernizr._q.push(function() {
    delete modElem.elem;
  });

  

  var mStyle = {
    style: modElem.elem.style
  };

  // kill ref for gc, must happen before mod.elem is removed, so we unshift on to
  // the front of the queue.
  Modernizr._q.unshift(function() {
    delete mStyle.style;
  });

  

  /**
   * getBody returns the body of a document, or an element that can stand in for
   * the body if a real body does not exist
   *
   * @access private
   * @function getBody
   * @returns {HTMLElement|SVGElement} Returns the real body of a document, or an
   * artificially created element that stands in for the body
   */

  function getBody() {
    // After page load injecting a fake body doesn't work so check if body exists
    var body = document.body;

    if (!body) {
      // Can't use the real body create a fake one.
      body = createElement(isSVG ? 'svg' : 'body');
      body.fake = true;
    }

    return body;
  }

  ;

  /**
   * injectElementWithStyles injects an element with style element and some CSS rules
   *
   * @access private
   * @function injectElementWithStyles
   * @param {string} rule - String representing a css rule
   * @param {function} callback - A function that is used to test the injected element
   * @param {number} [nodes] - An integer representing the number of additional nodes you want injected
   * @param {string[]} [testnames] - An array of strings that are used as ids for the additional nodes
   * @returns {boolean}
   */

  function injectElementWithStyles(rule, callback, nodes, testnames) {
    var mod = 'modernizr';
    var style;
    var ret;
    var node;
    var docOverflow;
    var div = createElement('div');
    var body = getBody();

    if (parseInt(nodes, 10)) {
      // In order not to give false positives we create a node for each test
      // This also allows the method to scale for unspecified uses
      while (nodes--) {
        node = createElement('div');
        node.id = testnames ? testnames[nodes] : mod + (nodes + 1);
        div.appendChild(node);
      }
    }

    style = createElement('style');
    style.type = 'text/css';
    style.id = 's' + mod;

    // IE6 will false positive on some tests due to the style element inside the test div somehow interfering offsetHeight, so insert it into body or fakebody.
    // Opera will act all quirky when injecting elements in documentElement when page is served as xml, needs fakebody too. #270
    (!body.fake ? div : body).appendChild(style);
    body.appendChild(div);

    if (style.styleSheet) {
      style.styleSheet.cssText = rule;
    } else {
      style.appendChild(document.createTextNode(rule));
    }
    div.id = mod;

    if (body.fake) {
      //avoid crashing IE8, if background image is used
      body.style.background = '';
      //Safari 5.13/5.1.4 OSX stops loading if ::-webkit-scrollbar is used and scrollbars are visible
      body.style.overflow = 'hidden';
      docOverflow = docElement.style.overflow;
      docElement.style.overflow = 'hidden';
      docElement.appendChild(body);
    }

    ret = callback(div, rule);
    // If this is done after page load we don't want to remove the body so check if body exists
    if (body.fake) {
      body.parentNode.removeChild(body);
      docElement.style.overflow = docOverflow;
      // Trigger layout so kinetic scrolling isn't disabled in iOS6+
      // eslint-disable-next-line
      docElement.offsetHeight;
    } else {
      div.parentNode.removeChild(div);
    }

    return !!ret;

  }

  ;

  /**
   * domToCSS takes a camelCase string and converts it to kebab-case
   * e.g. boxSizing -> box-sizing
   *
   * @access private
   * @function domToCSS
   * @param {string} name - String name of camelCase prop we want to convert
   * @returns {string} The kebab-case version of the supplied name
   */

  function domToCSS(name) {
    return name.replace(/([A-Z])/g, function(str, m1) {
      return '-' + m1.toLowerCase();
    }).replace(/^ms-/, '-ms-');
  }
  ;


  /**
   * wrapper around getComputedStyle, to fix issues with Firefox returning null when
   * called inside of a hidden iframe
   *
   * @access private
   * @function computedStyle
   * @param {HTMLElement|SVGElement} - The element we want to find the computed styles of
   * @param {string|null} [pseudoSelector]- An optional pseudo element selector (e.g. :before), of null if none
   * @returns {CSSStyleDeclaration}
   */

  function computedStyle(elem, pseudo, prop) {
    var result;

    if ('getComputedStyle' in window) {
      result = getComputedStyle.call(window, elem, pseudo);
      var console = window.console;

      if (result !== null) {
        if (prop) {
          result = result.getPropertyValue(prop);
        }
      } else {
        if (console) {
          var method = console.error ? 'error' : 'log';
          console[method].call(console, 'getComputedStyle returning null, its possible modernizr test results are inaccurate');
        }
      }
    } else {
      result = !pseudo && elem.currentStyle && elem.currentStyle[prop];
    }

    return result;
  }

  ;

  /**
   * nativeTestProps allows for us to use native feature detection functionality if available.
   * some prefixed form, or false, in the case of an unsupported rule
   *
   * @access private
   * @function nativeTestProps
   * @param {array} props - An array of property names
   * @param {string} value - A string representing the value we want to check via @supports
   * @returns {boolean|undefined} A boolean when @supports exists, undefined otherwise
   */

  // Accepts a list of property names and a single value
  // Returns `undefined` if native detection not available
  function nativeTestProps(props, value) {
    var i = props.length;
    // Start with the JS API: http://www.w3.org/TR/css3-conditional/#the-css-interface
    if ('CSS' in window && 'supports' in window.CSS) {
      // Try every prefixed variant of the property
      while (i--) {
        if (window.CSS.supports(domToCSS(props[i]), value)) {
          return true;
        }
      }
      return false;
    }
    // Otherwise fall back to at-rule (for Opera 12.x)
    else if ('CSSSupportsRule' in window) {
      // Build a condition string for every prefixed variant
      var conditionText = [];
      while (i--) {
        conditionText.push('(' + domToCSS(props[i]) + ':' + value + ')');
      }
      conditionText = conditionText.join(' or ');
      return injectElementWithStyles('@supports (' + conditionText + ') { #modernizr { position: absolute; } }', function(node) {
        return computedStyle(node, null, 'position') == 'absolute';
      });
    }
    return undefined;
  }
  ;

  /**
   * cssToDOM takes a kebab-case string and converts it to camelCase
   * e.g. box-sizing -> boxSizing
   *
   * @access private
   * @function cssToDOM
   * @param {string} name - String name of kebab-case prop we want to convert
   * @returns {string} The camelCase version of the supplied name
   */

  function cssToDOM(name) {
    return name.replace(/([a-z])-([a-z])/g, function(str, m1, m2) {
      return m1 + m2.toUpperCase();
    }).replace(/^-/, '');
  }
  ;

  // testProps is a generic CSS / DOM property test.

  // In testing support for a given CSS property, it's legit to test:
  //    `elem.style[styleName] !== undefined`
  // If the property is supported it will return an empty string,
  // if unsupported it will return undefined.

  // We'll take advantage of this quick test and skip setting a style
  // on our modernizr element, but instead just testing undefined vs
  // empty string.

  // Property names can be provided in either camelCase or kebab-case.

  function testProps(props, prefixed, value, skipValueTest) {
    skipValueTest = is(skipValueTest, 'undefined') ? false : skipValueTest;

    // Try native detect first
    if (!is(value, 'undefined')) {
      var result = nativeTestProps(props, value);
      if (!is(result, 'undefined')) {
        return result;
      }
    }

    // Otherwise do it properly
    var afterInit, i, propsLength, prop, before;

    // If we don't have a style element, that means we're running async or after
    // the core tests, so we'll need to create our own elements to use

    // inside of an SVG element, in certain browsers, the `style` element is only
    // defined for valid tags. Therefore, if `modernizr` does not have one, we
    // fall back to a less used element and hope for the best.
    // for strict XHTML browsers the hardly used samp element is used
    var elems = ['modernizr', 'tspan', 'samp'];
    while (!mStyle.style && elems.length) {
      afterInit = true;
      mStyle.modElem = createElement(elems.shift());
      mStyle.style = mStyle.modElem.style;
    }

    // Delete the objects if we created them.
    function cleanElems() {
      if (afterInit) {
        delete mStyle.style;
        delete mStyle.modElem;
      }
    }

    propsLength = props.length;
    for (i = 0; i < propsLength; i++) {
      prop = props[i];
      before = mStyle.style[prop];

      if (contains(prop, '-')) {
        prop = cssToDOM(prop);
      }

      if (mStyle.style[prop] !== undefined) {

        // If value to test has been passed in, do a set-and-check test.
        // 0 (integer) is a valid property value, so check that `value` isn't
        // undefined, rather than just checking it's truthy.
        if (!skipValueTest && !is(value, 'undefined')) {

          // Needs a try catch block because of old IE. This is slow, but will
          // be avoided in most cases because `skipValueTest` will be used.
          try {
            mStyle.style[prop] = value;
          } catch (e) {}

          // If the property value has changed, we assume the value used is
          // supported. If `value` is empty string, it'll fail here (because
          // it hasn't changed), which matches how browsers have implemented
          // CSS.supports()
          if (mStyle.style[prop] != before) {
            cleanElems();
            return prefixed == 'pfx' ? prop : true;
          }
        }
        // Otherwise just return true, or the property name if this is a
        // `prefixed()` call
        else {
          cleanElems();
          return prefixed == 'pfx' ? prop : true;
        }
      }
    }
    cleanElems();
    return false;
  }

  ;

  /**
   * List of JavaScript DOM values used for tests
   *
   * @memberof Modernizr
   * @name Modernizr._domPrefixes
   * @optionName Modernizr._domPrefixes
   * @optionProp domPrefixes
   * @access public
   * @example
   *
   * Modernizr._domPrefixes is exactly the same as [_prefixes](#modernizr-_prefixes), but rather
   * than kebab-case properties, all properties are their Capitalized variant
   *
   * ```js
   * Modernizr._domPrefixes === [ "Moz", "O", "ms", "Webkit" ];
   * ```
   */

  var domPrefixes = (ModernizrProto._config.usePrefixes ? omPrefixes.toLowerCase().split(' ') : []);
  ModernizrProto._domPrefixes = domPrefixes;
  

  /**
   * fnBind is a super small [bind](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind) polyfill.
   *
   * @access private
   * @function fnBind
   * @param {function} fn - a function you want to change `this` reference to
   * @param {object} that - the `this` you want to call the function with
   * @returns {function} The wrapped version of the supplied function
   */

  function fnBind(fn, that) {
    return function() {
      return fn.apply(that, arguments);
    };
  }

  ;

  /**
   * testDOMProps is a generic DOM property test; if a browser supports
   *   a certain property, it won't return undefined for it.
   *
   * @access private
   * @function testDOMProps
   * @param {array.<string>} props - An array of properties to test for
   * @param {object} obj - An object or Element you want to use to test the parameters again
   * @param {boolean|object} elem - An Element to bind the property lookup again. Use `false` to prevent the check
   * @returns {false|*} returns false if the prop is unsupported, otherwise the value that is supported
   */
  function testDOMProps(props, obj, elem) {
    var item;

    for (var i in props) {
      if (props[i] in obj) {

        // return the property name as a string
        if (elem === false) {
          return props[i];
        }

        item = obj[props[i]];

        // let's bind a function
        if (is(item, 'function')) {
          // bind to obj unless overriden
          return fnBind(item, elem || obj);
        }

        // return the unbound function or obj or value
        return item;
      }
    }
    return false;
  }

  ;

  /**
   * testPropsAll tests a list of DOM properties we want to check against.
   * We specify literally ALL possible (known and/or likely) properties on
   * the element including the non-vendor prefixed one, for forward-
   * compatibility.
   *
   * @access private
   * @function testPropsAll
   * @param {string} prop - A string of the property to test for
   * @param {string|object} [prefixed] - An object to check the prefixed properties on. Use a string to skip
   * @param {HTMLElement|SVGElement} [elem] - An element used to test the property and value against
   * @param {string} [value] - A string of a css value
   * @param {boolean} [skipValueTest] - An boolean representing if you want to test if value sticks when set
   * @returns {false|string} returns the string version of the property, or false if it is unsupported
   */
  function testPropsAll(prop, prefixed, elem, value, skipValueTest) {

    var ucProp = prop.charAt(0).toUpperCase() + prop.slice(1),
      props = (prop + ' ' + cssomPrefixes.join(ucProp + ' ') + ucProp).split(' ');

    // did they call .prefixed('boxSizing') or are we just testing a prop?
    if (is(prefixed, 'string') || is(prefixed, 'undefined')) {
      return testProps(props, prefixed, value, skipValueTest);

      // otherwise, they called .prefixed('requestAnimationFrame', window[, elem])
    } else {
      props = (prop + ' ' + (domPrefixes).join(ucProp + ' ') + ucProp).split(' ');
      return testDOMProps(props, prefixed, elem);
    }
  }

  // Modernizr.testAllProps() investigates whether a given style property,
  // or any of its vendor-prefixed variants, is recognized
  //
  // Note that the property names must be provided in the camelCase variant.
  // Modernizr.testAllProps('boxSizing')
  ModernizrProto.testAllProps = testPropsAll;

  

  /**
   * testAllProps determines whether a given CSS property is supported in the browser
   *
   * @memberof Modernizr
   * @name Modernizr.testAllProps
   * @optionName Modernizr.testAllProps()
   * @optionProp testAllProps
   * @access public
   * @function testAllProps
   * @param {string} prop - String naming the property to test (either camelCase or kebab-case)
   * @param {string} [value] - String of the value to test
   * @param {boolean} [skipValueTest=false] - Whether to skip testing that the value is supported when using non-native detection
   * @example
   *
   * testAllProps determines whether a given CSS property, in some prefixed form,
   * is supported by the browser.
   *
   * ```js
   * testAllProps('boxSizing')  // true
   * ```
   *
   * It can optionally be given a CSS value in string form to test if a property
   * value is valid
   *
   * ```js
   * testAllProps('display', 'block') // true
   * testAllProps('display', 'penguin') // false
   * ```
   *
   * A boolean can be passed as a third parameter to skip the value check when
   * native detection (@supports) isn't available.
   *
   * ```js
   * testAllProps('shapeOutside', 'content-box', true);
   * ```
   */

  function testAllProps(prop, value, skipValueTest) {
    return testPropsAll(prop, undefined, undefined, value, skipValueTest);
  }
  ModernizrProto.testAllProps = testAllProps;
  
/*!
{
  "name": "Appearance",
  "property": "appearance",
  "caniuse": "css-appearance",
  "tags": ["css"],
  "notes": [{
    "name": "MDN documentation",
    "href": "https://developer.mozilla.org/en-US/docs/Web/CSS/-moz-appearance"
  },{
    "name": "CSS-Tricks CSS Almanac: appearance",
    "href": "https://css-tricks.com/almanac/properties/a/appearance/"
  }]
}
!*/
/* DOC
Detects support for the `appearance` css property, which is used to make an
element inherit the style of a standard user interface element. It can also be
used to remove the default styles of an element, such as input and buttons.
*/

  Modernizr.addTest('appearance', testAllProps('appearance'));


  // Run each test
  testRunner();

  // Remove the "no-js" class if it exists
  setClasses(classes);

  delete ModernizrProto.addTest;
  delete ModernizrProto.addAsyncTest;

  // Run the things that are supposed to run after the tests
  for (var i = 0; i < Modernizr._q.length; i++) {
    Modernizr._q[i]();
  }

  // Leak Modernizr namespace
  window.Modernizr = Modernizr;


;

})(window, document);
module.exports = window.Modernizr;
if (hadGlobal) { window.Modernizr = oldGlobal; }
else { delete window.Modernizr; }
})(window);

/***/ }),
/* 36 */
/***/ (function(module, exports) {

(function(host) {

  var properties = {
    browser: [
      [/msie ([\.\_\d]+)/, "ie"],
      [/trident\/.*?rv:([\.\_\d]+)/, "ie"],
      [/firefox\/([\.\_\d]+)/, "firefox"],
      [/chrome\/([\.\_\d]+)/, "chrome"],
      [/version\/([\.\_\d]+).*?safari/, "safari"],
      [/mobile safari ([\.\_\d]+)/, "safari"],
      [/android.*?version\/([\.\_\d]+).*?safari/, "com.android.browser"],
      [/crios\/([\.\_\d]+).*?safari/, "chrome"],
      [/opera/, "opera"],
      [/opera\/([\.\_\d]+)/, "opera"],
      [/opera ([\.\_\d]+)/, "opera"],
      [/opera mini.*?version\/([\.\_\d]+)/, "opera.mini"],
      [/opios\/([a-z\.\_\d]+)/, "opera"],
      [/blackberry/, "blackberry"],
      [/blackberry.*?version\/([\.\_\d]+)/, "blackberry"],
      [/bb\d+.*?version\/([\.\_\d]+)/, "blackberry"],
      [/rim.*?version\/([\.\_\d]+)/, "blackberry"],
      [/iceweasel\/([\.\_\d]+)/, "iceweasel"],
      [/edge\/([\.\d]+)/, "edge"]
    ],
    os: [
      [/linux ()([a-z\.\_\d]+)/, "linux"],
      [/mac os x/, "macos"],
      [/mac os x.*?([\.\_\d]+)/, "macos"],
      [/os ([\.\_\d]+) like mac os/, "ios"],
      [/openbsd ()([a-z\.\_\d]+)/, "openbsd"],
      [/android/, "android"],
      [/android ([a-z\.\_\d]+);/, "android"],
      [/mozilla\/[a-z\.\_\d]+ \((?:mobile)|(?:tablet)/, "firefoxos"],
      [/windows\s*(?:nt)?\s*([\.\_\d]+)/, "windows"],
      [/windows phone.*?([\.\_\d]+)/, "windows.phone"],
      [/windows mobile/, "windows.mobile"],
      [/blackberry/, "blackberryos"],
      [/bb\d+/, "blackberryos"],
      [/rim.*?os\s*([\.\_\d]+)/, "blackberryos"]
    ],
    device: [
      [/ipad/, "ipad"],
      [/iphone/, "iphone"],
      [/lumia/, "lumia"],
      [/htc/, "htc"],
      [/nexus/, "nexus"],
      [/galaxy nexus/, "galaxy.nexus"],
      [/nokia/, "nokia"],
      [/ gt\-/, "galaxy"],
      [/ sm\-/, "galaxy"],
      [/xbox/, "xbox"],
      [/(?:bb\d+)|(?:blackberry)|(?: rim )/, "blackberry"]
    ]
  };

  var UNKNOWN = "Unknown";

  var propertyNames = Object.keys(properties);

  function Sniffr() {
    var self = this;

    propertyNames.forEach(function(propertyName) {
      self[propertyName] = {
        name: UNKNOWN,
        version: [],
        versionString: UNKNOWN
      };
    });
  }

  function determineProperty(self, propertyName, userAgent) {
    properties[propertyName].forEach(function(propertyMatcher) {
      var propertyRegex = propertyMatcher[0];
      var propertyValue = propertyMatcher[1];

      var match = userAgent.match(propertyRegex);

      if (match) {
        self[propertyName].name = propertyValue;

        if (match[2]) {
          self[propertyName].versionString = match[2];
          self[propertyName].version = [];
        } else if (match[1]) {
          self[propertyName].versionString = match[1].replace(/_/g, ".");
          self[propertyName].version = parseVersion(match[1]);
        } else {
          self[propertyName].versionString = UNKNOWN;
          self[propertyName].version = [];
        }
      }
    });
  }

  function parseVersion(versionString) {
    return versionString.split(/[\._]/).map(function(versionPart) {
      return parseInt(versionPart);
    });
  }

  Sniffr.prototype.sniff = function(userAgentString) {
    var self = this;
    var userAgent = (userAgentString || navigator.userAgent || "").toLowerCase();

    propertyNames.forEach(function(propertyName) {
      determineProperty(self, propertyName, userAgent);
    });
  };


  if (typeof module !== 'undefined' && module.exports) {
    module.exports = Sniffr;
  } else {
    host.Sniffr = new Sniffr();
    host.Sniffr.sniff(navigator.userAgent);
  }
})(this);


/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
var stylesInDom = {},
	memoize = function(fn) {
		var memo;
		return function () {
			if (typeof memo === "undefined") memo = fn.apply(this, arguments);
			return memo;
		};
	},
	isOldIE = memoize(function() {
		// Test for IE <= 9 as proposed by Browserhacks
		// @see http://browserhacks.com/#hack-e71d8692f65334173fee715c222cb805
		// Tests for existence of standard globals is to allow style-loader 
		// to operate correctly into non-standard environments
		// @see https://github.com/webpack-contrib/style-loader/issues/177
		return window && document && document.all && !window.atob;
	}),
	getElement = (function(fn) {
		var memo = {};
		return function(selector) {
			if (typeof memo[selector] === "undefined") {
				memo[selector] = fn.call(this, selector);
			}
			return memo[selector]
		};
	})(function (styleTarget) {
		return document.querySelector(styleTarget)
	}),
	singletonElement = null,
	singletonCounter = 0,
	styleElementsInsertedAtTop = [],
	fixUrls = __webpack_require__(38);

module.exports = function(list, options) {
	if(typeof DEBUG !== "undefined" && DEBUG) {
		if(typeof document !== "object") throw new Error("The style-loader cannot be used in a non-browser environment");
	}

	options = options || {};
	options.attrs = typeof options.attrs === "object" ? options.attrs : {};

	// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
	// tags it will allow on a page
	if (typeof options.singleton === "undefined") options.singleton = isOldIE();

	// By default, add <style> tags to the <head> element
	if (typeof options.insertInto === "undefined") options.insertInto = "head";

	// By default, add <style> tags to the bottom of the target
	if (typeof options.insertAt === "undefined") options.insertAt = "bottom";

	var styles = listToStyles(list);
	addStylesToDom(styles, options);

	return function update(newList) {
		var mayRemove = [];
		for(var i = 0; i < styles.length; i++) {
			var item = styles[i];
			var domStyle = stylesInDom[item.id];
			domStyle.refs--;
			mayRemove.push(domStyle);
		}
		if(newList) {
			var newStyles = listToStyles(newList);
			addStylesToDom(newStyles, options);
		}
		for(var i = 0; i < mayRemove.length; i++) {
			var domStyle = mayRemove[i];
			if(domStyle.refs === 0) {
				for(var j = 0; j < domStyle.parts.length; j++)
					domStyle.parts[j]();
				delete stylesInDom[domStyle.id];
			}
		}
	};
};

function addStylesToDom(styles, options) {
	for(var i = 0; i < styles.length; i++) {
		var item = styles[i];
		var domStyle = stylesInDom[item.id];
		if(domStyle) {
			domStyle.refs++;
			for(var j = 0; j < domStyle.parts.length; j++) {
				domStyle.parts[j](item.parts[j]);
			}
			for(; j < item.parts.length; j++) {
				domStyle.parts.push(addStyle(item.parts[j], options));
			}
		} else {
			var parts = [];
			for(var j = 0; j < item.parts.length; j++) {
				parts.push(addStyle(item.parts[j], options));
			}
			stylesInDom[item.id] = {id: item.id, refs: 1, parts: parts};
		}
	}
}

function listToStyles(list) {
	var styles = [];
	var newStyles = {};
	for(var i = 0; i < list.length; i++) {
		var item = list[i];
		var id = item[0];
		var css = item[1];
		var media = item[2];
		var sourceMap = item[3];
		var part = {css: css, media: media, sourceMap: sourceMap};
		if(!newStyles[id])
			styles.push(newStyles[id] = {id: id, parts: [part]});
		else
			newStyles[id].parts.push(part);
	}
	return styles;
}

function insertStyleElement(options, styleElement) {
	var styleTarget = getElement(options.insertInto)
	if (!styleTarget) {
		throw new Error("Couldn't find a style target. This probably means that the value for the 'insertInto' parameter is invalid.");
	}
	var lastStyleElementInsertedAtTop = styleElementsInsertedAtTop[styleElementsInsertedAtTop.length - 1];
	if (options.insertAt === "top") {
		if(!lastStyleElementInsertedAtTop) {
			styleTarget.insertBefore(styleElement, styleTarget.firstChild);
		} else if(lastStyleElementInsertedAtTop.nextSibling) {
			styleTarget.insertBefore(styleElement, lastStyleElementInsertedAtTop.nextSibling);
		} else {
			styleTarget.appendChild(styleElement);
		}
		styleElementsInsertedAtTop.push(styleElement);
	} else if (options.insertAt === "bottom") {
		styleTarget.appendChild(styleElement);
	} else {
		throw new Error("Invalid value for parameter 'insertAt'. Must be 'top' or 'bottom'.");
	}
}

function removeStyleElement(styleElement) {
	styleElement.parentNode.removeChild(styleElement);
	var idx = styleElementsInsertedAtTop.indexOf(styleElement);
	if(idx >= 0) {
		styleElementsInsertedAtTop.splice(idx, 1);
	}
}

function createStyleElement(options) {
	var styleElement = document.createElement("style");
	options.attrs.type = "text/css";

	attachTagAttrs(styleElement, options.attrs);
	insertStyleElement(options, styleElement);
	return styleElement;
}

function createLinkElement(options) {
	var linkElement = document.createElement("link");
	options.attrs.type = "text/css";
	options.attrs.rel = "stylesheet";

	attachTagAttrs(linkElement, options.attrs);
	insertStyleElement(options, linkElement);
	return linkElement;
}

function attachTagAttrs(element, attrs) {
	Object.keys(attrs).forEach(function (key) {
		element.setAttribute(key, attrs[key]);
	});
}

function addStyle(obj, options) {
	var styleElement, update, remove;

	if (options.singleton) {
		var styleIndex = singletonCounter++;
		styleElement = singletonElement || (singletonElement = createStyleElement(options));
		update = applyToSingletonTag.bind(null, styleElement, styleIndex, false);
		remove = applyToSingletonTag.bind(null, styleElement, styleIndex, true);
	} else if(obj.sourceMap &&
		typeof URL === "function" &&
		typeof URL.createObjectURL === "function" &&
		typeof URL.revokeObjectURL === "function" &&
		typeof Blob === "function" &&
		typeof btoa === "function") {
		styleElement = createLinkElement(options);
		update = updateLink.bind(null, styleElement, options);
		remove = function() {
			removeStyleElement(styleElement);
			if(styleElement.href)
				URL.revokeObjectURL(styleElement.href);
		};
	} else {
		styleElement = createStyleElement(options);
		update = applyToTag.bind(null, styleElement);
		remove = function() {
			removeStyleElement(styleElement);
		};
	}

	update(obj);

	return function updateStyle(newObj) {
		if(newObj) {
			if(newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap)
				return;
			update(obj = newObj);
		} else {
			remove();
		}
	};
}

var replaceText = (function () {
	var textStore = [];

	return function (index, replacement) {
		textStore[index] = replacement;
		return textStore.filter(Boolean).join('\n');
	};
})();

function applyToSingletonTag(styleElement, index, remove, obj) {
	var css = remove ? "" : obj.css;

	if (styleElement.styleSheet) {
		styleElement.styleSheet.cssText = replaceText(index, css);
	} else {
		var cssNode = document.createTextNode(css);
		var childNodes = styleElement.childNodes;
		if (childNodes[index]) styleElement.removeChild(childNodes[index]);
		if (childNodes.length) {
			styleElement.insertBefore(cssNode, childNodes[index]);
		} else {
			styleElement.appendChild(cssNode);
		}
	}
}

function applyToTag(styleElement, obj) {
	var css = obj.css;
	var media = obj.media;

	if(media) {
		styleElement.setAttribute("media", media)
	}

	if(styleElement.styleSheet) {
		styleElement.styleSheet.cssText = css;
	} else {
		while(styleElement.firstChild) {
			styleElement.removeChild(styleElement.firstChild);
		}
		styleElement.appendChild(document.createTextNode(css));
	}
}

function updateLink(linkElement, options, obj) {
	var css = obj.css;
	var sourceMap = obj.sourceMap;

	/* If convertToAbsoluteUrls isn't defined, but sourcemaps are enabled
	and there is no publicPath defined then lets turn convertToAbsoluteUrls
	on by default.  Otherwise default to the convertToAbsoluteUrls option
	directly
	*/
	var autoFixUrls = options.convertToAbsoluteUrls === undefined && sourceMap;

	if (options.convertToAbsoluteUrls || autoFixUrls){
		css = fixUrls(css);
	}

	if(sourceMap) {
		// http://stackoverflow.com/a/26603875
		css += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + " */";
	}

	var blob = new Blob([css], { type: "text/css" });

	var oldSrc = linkElement.href;

	linkElement.href = URL.createObjectURL(blob);

	if(oldSrc)
		URL.revokeObjectURL(oldSrc);
}


/***/ }),
/* 38 */
/***/ (function(module, exports) {


/**
 * When source maps are enabled, `style-loader` uses a link element with a data-uri to
 * embed the css on the page. This breaks all relative urls because now they are relative to a
 * bundle instead of the current page.
 *
 * One solution is to only use full urls, but that may be impossible.
 *
 * Instead, this function "fixes" the relative urls to be absolute according to the current page location.
 *
 * A rudimentary test suite is located at `test/fixUrls.js` and can be run via the `npm test` command.
 *
 */

module.exports = function (css) {
  // get current location
  var location = typeof window !== "undefined" && window.location;

  if (!location) {
    throw new Error("fixUrls requires window.location");
  }

	// blank or null?
	if (!css || typeof css !== "string") {
	  return css;
  }

  var baseUrl = location.protocol + "//" + location.host;
  var currentDir = baseUrl + location.pathname.replace(/\/[^\/]*$/, "/");

	// convert each url(...)
	/*
	This regular expression is just a way to recursively match brackets within
	a string.

	 /url\s*\(  = Match on the word "url" with any whitespace after it and then a parens
	   (  = Start a capturing group
	     (?:  = Start a non-capturing group
	         [^)(]  = Match anything that isn't a parentheses
	         |  = OR
	         \(  = Match a start parentheses
	             (?:  = Start another non-capturing groups
	                 [^)(]+  = Match anything that isn't a parentheses
	                 |  = OR
	                 \(  = Match a start parentheses
	                     [^)(]*  = Match anything that isn't a parentheses
	                 \)  = Match a end parentheses
	             )  = End Group
              *\) = Match anything and then a close parens
          )  = Close non-capturing group
          *  = Match anything
       )  = Close capturing group
	 \)  = Match a close parens

	 /gi  = Get all matches, not the first.  Be case insensitive.
	 */
	var fixedCss = css.replace(/url\s*\(((?:[^)(]|\((?:[^)(]+|\([^)(]*\))*\))*)\)/gi, function(fullMatch, origUrl) {
		// strip quotes (if they exist)
		var unquotedOrigUrl = origUrl
			.trim()
			.replace(/^"(.*)"$/, function(o, $1){ return $1; })
			.replace(/^'(.*)'$/, function(o, $1){ return $1; });

		// already a full url? no change
		if (/^(#|data:|http:\/\/|https:\/\/|file:\/\/\/)/i.test(unquotedOrigUrl)) {
		  return fullMatch;
		}

		// convert the url to a full url
		var newUrl;

		if (unquotedOrigUrl.indexOf("//") === 0) {
		  	//TODO: should we add protocol?
			newUrl = unquotedOrigUrl;
		} else if (unquotedOrigUrl.indexOf("/") === 0) {
			// path should be relative to the base url
			newUrl = baseUrl + unquotedOrigUrl; // already starts with '/'
		} else {
			// path should be relative to current directory
			newUrl = currentDir + unquotedOrigUrl.replace(/^\.\//, ""); // Strip leading './'
		}

		// send back the fixed url(...)
		return "url(" + JSON.stringify(newUrl) + ")";
	});

	// send back the fixed css
	return fixedCss;
};


/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(25);
if(typeof content === 'string') content = [[module.i, content, '']];
// add the styles to the DOM
var update = __webpack_require__(37)(content, {});
if(content.locals) module.exports = content.locals;
// Hot Module Replacement
if(false) {
	// When the styles change, update the <style> tags
	if(!content.locals) {
		module.hot.accept("!!../../node_modules/css-loader/index.js!../../node_modules/animate-css-webpack/animate-css-styles.loader.js!./animate-css.js", function() {
			var newContent = require("!!../../node_modules/css-loader/index.js!../../node_modules/animate-css-webpack/animate-css-styles.loader.js!./animate-css.js");
			if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
			update(newContent);
		});
	}
	// When the module is disposed, remove the <style> tags
	module.hot.dispose(function() { update(); });
}

/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-arrow-last\" ><path d=\"M20.034 11.407l-6.346-7.045c-.54-.483-1.07-.483-1.587 0-.517.483-.506.988.034 1.515l5.738 6.32-5.738 6.256c-.225.22-.338.472-.338.757 0 .285.113.538.338.757.495.527 1.013.527 1.553 0l6.346-7.045c.225-.22.337-.472.337-.757a1.03 1.03 0 0 0-.337-.758zM4.37 19.967c.495.505 1.013.494 1.553-.033l6.414-7.045c.18-.22.27-.461.27-.724 0-.308-.09-.571-.27-.79L5.924 4.328a1.08 1.08 0 0 0-1.553 0c-.495.483-.495.988 0 1.515l5.739 6.32-5.74 6.257c-.495.527-.495 1.042 0 1.547z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-arrow-last");

/***/ }),
/* 41 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-arrow-next\" ><path d=\"M16.312 11.407L9.966 4.362c-.54-.483-1.068-.483-1.586 0s-.506.988.034 1.515l5.738 6.32-5.738 6.256c-.225.22-.338.472-.338.757 0 .285.113.538.338.757.495.527 1.012.527 1.552 0l6.346-7.045c.225-.22.338-.472.338-.757 0-.286-.113-.538-.338-.758z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-arrow-next");

/***/ }),
/* 42 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 183.08 70.95\" id=\"icon-avatar-lawyer\" ><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M29.88 15.19s24 26.25 24 29.25v24.5m100-53.75s-24 26.25-24 29.25v24.5\"/><path d=\"M.27 20.94l24.11-6.66V9.94s-.91-2.15 3.52-3.14S53.75 1 56.51 1c3.76 0 30.57 34.94 30.3 39.38-.16 2.61-.09 30.56-.09 30.56m96.09-50l-24.43-6.66V9.94s1.23-2.15-3.2-3.14S129.48 1 126.72 1C123 1 96.23 35.94 96.5 40.38c.16 2.61 0 30.56 0 30.56\"/></g></symbol>";
module.exports = sprite.add(image, "icon-avatar-lawyer");

/***/ }),
/* 43 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 141.8 57.5\" id=\"icon-avatar-observer\" ><g fill=\"none\" data-name=\"Layer 4\"><circle cx=\"33.59\" cy=\"28.75\" r=\"27.75\"/><circle cx=\"109.48\" cy=\"28.75\" r=\"27.75\"/><path d=\"M56.84 20.75s14.5-7.25 29 0m47.16-.07s7.37-1.82 7.87 0m-132.03 0s-7.37-1.82-7.87 0\"/></g></symbol>";
module.exports = sprite.add(image, "icon-avatar-observer");

/***/ }),
/* 44 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 72.21 94.12\" id=\"icon-avatar-party\" ><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M57.53 93.47s12.3-14.59 12.3-17.75 3.08-25.25 0-33.25c-1.26-3.27-12-2-12-2L52 56s-15.81 2.69-21.81 25.75m.15-78.28v41m13-41v41\"/><path d=\"M57.71 41s.82-17.19-1-28.5c-.86-5.31-6.8-8.26-13.49-9.41-7.78-4.38-12.75-.51-13.37 0h-.07c-7.33 1.39-11 3.55-11.93 7.38-.66 2.79-.92 26.73-1 36.55V21.71c0-4.56-6.24-2.89-7.85-1-7.76 9.1-8 47-8 47l9.06 23.73\"/></g></symbol>";
module.exports = sprite.add(image, "icon-avatar-party");

/***/ }),
/* 45 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 56 57\" id=\"icon-chart\" ><path d=\"M43.604 44.469V31.927h-6.27V44.47h6.27zm-12.541 0V13.26h-6.125v31.21h6.125zm-12.396 0V22.594h-6.271v21.875h6.27zM49.729.865c1.653 0 3.111.632 4.375 1.895C55.368 4.024 56 5.483 56 7.135v43.459c0 1.653-.632 3.11-1.896 4.375-1.264 1.264-2.722 1.896-4.375 1.896H6.271c-1.653 0-3.111-.632-4.375-1.896C.632 53.705 0 52.247 0 50.594V7.135c0-1.652.632-3.11 1.896-4.375C3.16 1.497 4.618.865 6.27.865h43.458z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-chart");

/***/ }),
/* 46 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 8 8\" id=\"icon-close\" ><path d=\"M8 .805L4.805 4 8 7.195 7.195 8 4 4.805.805 8 0 7.195 3.195 4 0 .805.805 0 4 3.195 7.195 0z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-close");

/***/ }),
/* 47 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-envelop\" ><path d=\"M18.737 8H5.263C4.567 8 4 8.56 4 9.25v7.5c0 .69.567 1.25 1.263 1.25h13.474c.696 0 1.263-.56 1.263-1.25v-7.5C20 8.56 19.433 8 18.737 8zm0 .833a.44.44 0 0 1 .073.007l-6.343 4.184c-.244.161-.69.161-.934 0L5.191 8.84a.42.42 0 0 1 .073-.007h13.474-.001zm0 8.334H5.263a.419.419 0 0 1-.42-.417V9.612l6.223 4.105c.262.173.598.26.934.26.336 0 .672-.087.934-.26l6.224-4.105v7.138a.42.42 0 0 1-.421.417z\" fill=\"currentColor\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-envelop");

/***/ }),
/* 48 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-exit\" ><path d=\"M14.208 0c.473 0 .89.18 1.25.542.361.36.542.777.542 1.25v12.416c0 .473-.18.89-.542 1.25-.36.361-.777.542-1.25.542H1.792c-.5 0-.924-.18-1.271-.542-.347-.36-.521-.777-.521-1.25v-3.541h1.792v3.541h12.416V1.792H1.792v3.541H0V1.792c0-.473.174-.89.52-1.25A1.7 1.7 0 0 1 1.793 0h12.416zM6.292 11.738l2.291-2.355H0V7.617h8.583L6.292 5.262 7.542 4 12 8.5 7.542 13l-1.25-1.262z\" fill-rule=\"evenodd\" fill-opacity=\".87\"/></symbol>";
module.exports = sprite.add(image, "icon-exit");

/***/ }),
/* 49 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-file-search\" ><g fill=\"currentColor\" fill-rule=\"evenodd\"><path d=\"M18.881 7.912l-3.656-3.79A.399.399 0 0 0 14.937 4H7.22C6.547 4 6 4.567 6 5.263v13.474C6 19.433 6.547 20 7.219 20H17.78c.672 0 1.219-.567 1.219-1.263V8.21a.432.432 0 0 0-.119-.299zm-.862.299h-2.675a.414.414 0 0 1-.407-.422V5.016l3.082 3.195zm-.238 10.947H7.22a.414.414 0 0 1-.407-.421V5.263c0-.232.182-.42.407-.42h6.906v2.946c0 .697.547 1.264 1.219 1.264h2.844v9.684a.414.414 0 0 1-.407.42z\"/><path d=\"M16.467 17.623l-2.387-2.924c.532-.6.857-1.4.857-2.278 0-1.858-1.457-3.368-3.25-3.368-1.792 0-3.25 1.51-3.25 3.368 0 1.858 1.458 3.368 3.25 3.368.654 0 1.262-.2 1.773-.545l2.386 2.923a.4.4 0 0 0 .573.05.432.432 0 0 0 .048-.594zM9.25 12.42c0-1.393 1.094-2.526 2.438-2.526 1.343 0 2.437 1.133 2.437 2.526 0 1.393-1.094 2.526-2.438 2.526-1.343 0-2.437-1.133-2.437-2.526z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-file-search");

/***/ }),
/* 50 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 18 18\" id=\"icon-forwards\" ><g fill-rule=\"evenodd\"><path d=\"M17.429 8.929a8.5 8.5 0 1 0-17 0 8.5 8.5 0 0 0 17 0zm-15.867 0a7.367 7.367 0 1 1 14.733 0 7.367 7.367 0 0 1-14.733 0z\"/><path d=\"M9 5l4 4-4 4-.702-.702 2.784-2.807H5V8.51h6.082L8.298 5.702z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-forwards");

/***/ }),
/* 51 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 12 12\" id=\"icon-info\" ><path d=\"M5.408 4.183V2.972h1.184v1.211H5.408zM6 10.803c1.315 0 2.446-.474 3.394-1.423.949-.948 1.423-2.08 1.423-3.394 0-1.315-.474-2.446-1.423-3.394C8.446 1.643 7.314 1.169 6 1.169c-1.315 0-2.446.474-3.394 1.423-.949.948-1.423 2.08-1.423 3.394s.474 2.446 1.423 3.394c.948.949 2.08 1.423 3.394 1.423zM6-.014c1.653 0 3.066.587 4.24 1.76C11.412 2.92 12 4.333 12 5.986s-.587 3.066-1.76 4.24c-1.174 1.173-2.587 1.76-4.24 1.76s-3.066-.587-4.24-1.76C.588 9.051 0 7.638 0 5.985s.587-3.066 1.76-4.24C2.935.573 4.348-.014 6-.014zM5.408 9V5.394h1.184V9H5.408z\" fill-rule=\"evenodd\" fill-opacity=\".7\"/></symbol>";
module.exports = sprite.add(image, "icon-info");

/***/ }),
/* 52 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 500 500\" id=\"icon-judge-avatar\" ><g data-name=\"Layer 4\"><path d=\"M182.37 351.77h-1.79v-44c0-3.67-26.29-33.79-42.86-51.92l1.33-1.21c7.24 7.91 43.33 47.67 43.33 53.13zm136.48 0h-1.79v-44c0-5.46 36.1-45.22 43.33-53.13l1.33 1.21c-16.57 18.13-42.86 48.25-42.86 51.92z\"/><path d=\"M244.69 355.37h-6c0-2.05.22-50.33.51-55-.57-7.45-44.25-64.28-51.9-67.53-3.66.19-23.44 4.21-50.92 10.34-3.58.8-4.7 2-4.87 2.43v10.34l-44.59 12.51-1.63-5.77 40.22-11.35v-5.52c-.05-1.66.59-6.56 9.57-8.56 17.56-3.92 47.73-10.5 52.48-10.5 1.75 0 4.1.7 11.94 9 13.14 14 46.21 56.38 45.69 64.86-.19 3.69-.42 37.38-.5 54.75zm-57.54-122.66zM262.2 355.4l-6-.08c.23-17.32.61-51 .39-54.65-.52-8.6 32.88-51.78 45.65-65.37 7.39-7.87 9.68-8.53 11.39-8.53 4.19 0 26.37 4.88 47.53 9.65l3.77.85c4.17.93 6.62 2.59 7.49 5.06a5.64 5.64 0 0 1-.29 4.31v4.67l42.55 11.37-1.55 5.8-47-12.56v-11.34l.41-.4a8.52 8.52 0 0 0-2.91-1.06l-3.79-.85c-10.23-2.31-41-9.24-45.95-9.49-7.6 3.26-50.77 60.08-51.31 67.62.29 4.6-.35 52.94-.38 55zm-76.88-208.52h5.4v28c0 11.11-5.46 14.52-12.66 14.52a17.49 17.49 0 0 1-5.77-1l.81-4.41a12.87 12.87 0 0 0 4.53.81c4.84 0 7.69-2.17 7.69-10.36zm39.34 33.62c0 3.1.06 5.83.25 8.19h-4.84l-.31-4.9h-.12a11.3 11.3 0 0 1-9.93 5.58c-4.71 0-10.36-2.61-10.36-13.15v-17.56h5.46v16.63c0 5.71 1.74 9.55 6.7 9.55a7.89 7.89 0 0 0 7.2-5 8 8 0 0 0 .5-2.79v-18.39h5.46zm34.99-35.86v36.29c0 2.67.06 5.71.25 7.76H255l-.25-5.21h-.12a11.11 11.11 0 0 1-10.24 5.89c-7.26 0-12.84-6.14-12.84-15.26-.06-10 6.14-16.13 13.46-16.13 4.59 0 7.69 2.17 9.06 4.59h.12v-17.93zm-5.46 26.24a9.61 9.61 0 0 0-.25-2.3 8 8 0 0 0-7.88-6.33c-5.65 0-9 5-9 11.6 0 6.08 3 11.11 8.87 11.11a8.21 8.21 0 0 0 8-6.51 9.47 9.47 0 0 0 .25-2.36zm40.39-12.22c-.12 2.17-.25 4.59-.25 8.25v17.43c0 6.89-1.36 11.11-4.28 13.71s-7.14 3.6-10.92 3.6c-3.6 0-7.57-.87-10-2.48l1.37-4.17a16.93 16.93 0 0 0 8.81 2.36c5.58 0 9.68-2.92 9.68-10.49v-3.35h-.12a10.72 10.72 0 0 1-9.55 5c-7.45 0-12.78-6.33-12.78-14.64 0-10.17 6.64-15.94 13.53-15.94 5.21 0 8.07 2.73 9.37 5.21h.12l.25-4.53zm-5.65 11.85a7.78 7.78 0 0 0-.31-2.48 7.86 7.86 0 0 0-7.63-5.77c-5.21 0-8.93 4.41-8.93 11.35 0 5.89 3 10.8 8.87 10.8a8 8 0 0 0 7.57-5.58 9.49 9.49 0 0 0 .43-2.92zm17.5 4.16c.12 7.38 4.84 10.42 10.3 10.42a19.74 19.74 0 0 0 8.31-1.55l.93 3.91a24.32 24.32 0 0 1-10 1.86c-9.25 0-14.77-6.08-14.77-15.14S306.55 158 315.3 158c9.8 0 12.41 8.62 12.41 14.15a20.49 20.49 0 0 1-.19 2.54zm16-3.91c.06-3.47-1.43-8.87-7.57-8.87-5.52 0-7.94 5.09-8.38 8.87z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-judge-avatar");

/***/ }),
/* 53 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 17 16\" id=\"icon-key\" ><g fill-rule=\"evenodd\"><path d=\"M7.564 7.349a.26.26 0 0 0 .17-.062l5.83-4.961-.34-.376-5.83 4.96a.245.245 0 0 0-.024.353.26.26 0 0 0 .194.086z\"/><path d=\"M5.248 16c3.164 0 5.055-2.415 5.055-4.75 0-.673-.166-1.415-.411-1.896l2.33-1.13A.25.25 0 0 0 12.363 8V6h1.545l.058-.003c.343-.022.446-.128.457-.497v-2h1.546c.066 0 .112.007.143.011.062.01.179.027.28-.06.104-.09.1-.204.095-.305-.001-.036-.003-.083-.003-.146V.735A.747.747 0 0 0 15.728 0h-1.996a.776.776 0 0 0-.5.182L6.44 5.962c-.334-.065-.84-.15-1.191-.15C2.354 5.813 0 8.098 0 10.907 0 13.714 2.354 16 5.248 16zm0-9.688c.258 0 .7.06 1.213.164a.26.26 0 0 0 .223-.056L13.572.559a.249.249 0 0 1 .16-.059h1.996c.134 0 .242.105.242.235V3h-1.803a.254.254 0 0 0-.258.25V5.5h-1.803a.254.254 0 0 0-.258.25v2.096l-2.433 1.18a.252.252 0 0 0-.135.165.244.244 0 0 0 .041.205c.227.304.467 1.057.467 1.854 0 2.089-1.698 4.25-4.54 4.25-2.61 0-4.733-2.061-4.733-4.594 0-2.533 2.124-4.594 4.733-4.594z\"/><path d=\"M4.379 13.5c.994 0 1.803-.785 1.803-1.75S5.373 10 4.379 10c-.994 0-1.803.785-1.803 1.75s.809 1.75 1.803 1.75zm0-3c.71 0 1.288.561 1.288 1.25S5.089 13 4.379 13c-.71 0-1.288-.561-1.288-1.25s.578-1.25 1.288-1.25z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-key");

/***/ }),
/* 54 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-medal\" ><path d=\"M15.618 5.628l-.528-1.625h-1.708L12 3l-1.382 1.003H8.91l-.528 1.625L7 6.632l.528 1.624L7 9.881l1.382 1.003.314.964v8.68a.474.474 0 0 0 .733.393L12 19.207l2.57 1.714a.47.47 0 0 0 .485.023.47.47 0 0 0 .25-.416v-8.68l.313-.964L17 9.881l-.528-1.625L17 6.632l-1.382-1.004zm-.803 4.673l-.408 1.26h-.046l-1.285.003-1.075.78-1.075-.78H9.597l-.41-1.264-1.076-.78.41-1.265-.41-1.264 1.076-.78.41-1.264h1.329L12 4.166l1.075.78h1.329l.41 1.265 1.076.78-.411 1.264.41 1.264-1.075.782z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-medal");

/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 18 12\" id=\"icon-menu\" ><path d=\"M0 12h18v-2H0v2zm0-5h18V5H0v2zm0-7v2h18V0H0z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-menu");

/***/ }),
/* 56 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-pencil\" ><g fill-rule=\"evenodd\"><path d=\"M2.8 13.6a.4.4 0 0 1-.376-.537l1.6-4.4a.408.408 0 0 1 .093-.146l8.4-8.4a.4.4 0 0 1 .565 0l2.8 2.8a.4.4 0 0 1 0 .565l-8.4 8.4a.397.397 0 0 1-.146.093l-4.4 1.6a.404.404 0 0 1-.137.024l.001.001zm1.946-4.58l-1.277 3.511 3.511-1.277L15.034 3.2 12.8.966 4.746 9.02z\"/><path d=\"M14 16H1.2C.538 16 0 15.462 0 14.8V2C0 1.338.538.8 1.2.8h8a.4.4 0 0 1 0 .8h-8a.4.4 0 0 0-.4.4v12.8c0 .22.18.4.4.4H14a.4.4 0 0 0 .4-.4v-8a.4.4 0 0 1 .8 0v8c0 .662-.538 1.2-1.2 1.2z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-pencil");

/***/ }),
/* 57 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-phone\" ><g fill=\"currentColor\" fill-rule=\"evenodd\"><path d=\"M15.781 20H8.47a1.211 1.211 0 0 1-1.219-1.2V14c0-.22.182-.4.406-.4.225 0 .407.18.407.4v4.8c0 .22.181.4.406.4h7.312c.224 0 .406-.18.406-.4V5.2c0-.22-.182-.4-.406-.4h-3.25a.403.403 0 0 1-.406-.4c0-.22.182-.4.406-.4h3.25A1.21 1.21 0 0 1 17 5.2v13.6c0 .662-.547 1.2-1.219 1.2z\"/><path d=\"M14.969 16.8H9.28a.403.403 0 0 1-.406-.4V14c0-.22.182-.4.406-.4.224 0 .406.18.406.4v2h4.876V6.4h-.407a.403.403 0 0 1-.406-.4c0-.22.182-.4.406-.4h.813c.224 0 .406.18.406.4v10.4c0 .22-.182.4-.406.4zm-2.438 1.6h-.812a.403.403 0 0 1-.406-.4c0-.22.181-.4.406-.4h.812c.224 0 .406.18.406.4 0 .22-.181.4-.406.4z\"/><path d=\"M8.469 12.8C6.004 12.8 4 10.826 4 8.4S6.004 4 8.469 4c2.464 0 4.469 1.974 4.469 4.4s-2.005 4.4-4.47 4.4zm0-8c-2.016 0-3.656 1.615-3.656 3.6S6.452 12 8.469 12s3.656-1.615 3.656-3.6-1.64-3.6-3.656-3.6z\"/><path d=\"M8.469 7.2a.403.403 0 0 1-.406-.4V6c0-.22.181-.4.406-.4.224 0 .406.18.406.4v.8c0 .22-.182.4-.406.4zm0 4a.403.403 0 0 1-.406-.4V8.4c0-.22.181-.4.406-.4.224 0 .406.18.406.4v2.4c0 .22-.182.4-.406.4z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-phone");

/***/ }),
/* 58 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-plus-circle-o\" ><path d=\"M8 14.404c1.753 0 3.261-.632 4.526-1.897 1.264-1.264 1.897-2.773 1.897-4.526 0-1.753-.633-3.261-1.897-4.526C11.26 2.191 9.753 1.56 8 1.56c-1.753 0-3.261.632-4.526 1.896C2.21 4.72 1.577 6.228 1.577 7.981c0 1.753.633 3.262 1.897 4.526C4.74 13.772 6.247 14.404 8 14.404zM8-.02c2.203 0 4.088.783 5.653 2.348C15.218 3.894 16 5.778 16 7.98c0 2.204-.782 4.088-2.347 5.653-1.565 1.565-3.45 2.347-5.653 2.347-2.203 0-4.088-.782-5.653-2.347C.782 12.069 0 10.184 0 7.98c0-2.202.782-4.086 2.347-5.65C3.912.764 5.797-.02 8-.02zm.789 3.981v3.23h3.23V8.77h-3.23V12H7.21V8.77H3.98V7.192h3.23v-3.23h1.58z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-plus-circle-o");

/***/ }),
/* 59 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 18 16\" id=\"icon-profile\" ><path d=\"M.187 15.992a.253.253 0 0 0 .308-.177c.519-1.922 2.627-2.42 3.887-2.718.316-.074.565-.133.727-.203 1.435-.618 1.903-1.614 2.043-2.34a.25.25 0 0 0-.083-.236c-.747-.64-1.378-1.602-1.776-2.709a.246.246 0 0 0-.051-.085c-.527-.568-.829-1.169-.829-1.647 0-.28.106-.467.346-.609a.25.25 0 0 0 .122-.204C4.992 2.517 6.819.512 9.061.5l.053.003c2.252.031 4.068 2.08 4.133 4.663a.248.248 0 0 0 .09.184c.157.133.23.3.23.529 0 .4-.214.893-.604 1.386a.26.26 0 0 0-.042.079c-.403 1.268-1.126 2.388-1.984 3.073a.25.25 0 0 0-.09.241c.14.726.609 1.72 2.044 2.34.17.073.433.13.767.202 1.247.268 3.335.717 3.847 2.616a.252.252 0 0 0 .486-.13c-.591-2.194-2.956-2.702-4.226-2.975-.295-.064-.55-.118-.673-.172-.937-.404-1.514-1.02-1.718-1.833.87-.742 1.597-1.886 2.013-3.17.442-.57.685-1.156.685-1.658 0-.334-.109-.613-.324-.831C13.628 2.243 11.614.036 9.114 0H9.04C6.585.013 4.563 2.162 4.386 4.916c-.315.23-.475.552-.475.962 0 .591.336 1.299.926 1.948.408 1.112 1.04 2.088 1.791 2.772-.203.816-.78 1.434-1.72 1.838-.12.053-.362.11-.642.176-1.28.302-3.661.865-4.257 3.074a.25.25 0 0 0 .178.306z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-profile");

/***/ }),
/* 60 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 500 500\" id=\"icon-prosecutor-avatar\" ><g data-name=\"Layer 4\"><path d=\"M182.37 347.46h-1.79v-44c0-3.67-26.29-33.79-42.86-51.92l1.33-1.21c7.24 7.91 43.33 47.67 43.33 53.13zm136.48 0h-1.79v-44c0-5.46 36.1-45.21 43.33-53.13l1.33 1.21c-16.57 18.13-42.86 48.25-42.86 51.92z\"/><path d=\"M244.69 351.06h-6c0-2.05.22-50.33.51-55-.57-7.45-44.25-64.28-51.9-67.53-3.67.19-23 4.11-50.92 10.34-3.58.8-4.7 2-4.87 2.43v10.34l-44.59 12.51-1.63-5.78L125.5 247v-5.52c-.05-1.66.59-6.56 9.57-8.56 17.57-3.92 47.74-10.5 52.48-10.5 1.75 0 4.11.7 11.94 9 13.14 14 46.21 56.38 45.7 64.87-.19 3.71-.42 37.44-.5 54.77zM131.48 241.31zm55.67-12.9zm75.05 122.68l-6-.08c.23-17.32.61-51 .39-54.65-.52-8.61 32.88-51.79 45.65-65.37 7.39-7.87 9.68-8.53 11.38-8.53 4.18 0 26.35 4.87 47.49 9.64l3.81.86c4.17.93 6.62 2.59 7.49 5.06a5.64 5.64 0 0 1-.29 4.31V247l42.55 11.37-1.55 5.8-47-12.56v-11.34l.41-.4a8.53 8.53 0 0 0-2.91-1.06l-3.82-.86c-10.22-2.31-40.95-9.23-45.91-9.48-7.6 3.26-50.77 60.08-51.31 67.62.29 4.64-.35 52.91-.38 55zM135.17 149.63a52.81 52.81 0 0 1 8.74-.68c4.5 0 7.8 1 9.89 2.93a9.48 9.48 0 0 1 3.09 7.38 10.38 10.38 0 0 1-2.72 7.54c-2.41 2.56-6.33 3.87-10.78 3.87a15.7 15.7 0 0 1-3.66-.31v14.13h-4.55zm4.55 17a15.25 15.25 0 0 0 3.77.37c5.5 0 8.84-2.67 8.84-7.54 0-4.66-3.3-6.91-8.32-6.91a19.11 19.11 0 0 0-4.29.37zm22.28.43c0-3-.05-5.55-.21-7.9h4l.16 5h.21c1.15-3.4 3.93-5.55 7-5.55a5 5 0 0 1 1.31.16v4.34a6.92 6.92 0 0 0-1.57-.16c-3.24 0-5.55 2.46-6.18 5.91a13 13 0 0 0-.21 2.15v13.5H162zm39.54 4.55c0 9.37-6.49 13.45-12.61 13.45-6.86 0-12.14-5-12.14-13 0-8.48 5.55-13.45 12.56-13.45 7.27-.03 12.19 5.26 12.19 13zm-20.1.26c0 5.55 3.19 9.73 7.69 9.73s7.69-4.13 7.69-9.84c0-4.29-2.15-9.73-7.59-9.73s-7.79 5.03-7.79 9.85zm25.28 7.91a12.07 12.07 0 0 0 6.07 1.83c3.35 0 4.92-1.67 4.92-3.77s-1.31-3.4-4.71-4.66c-4.55-1.62-6.7-4.13-6.7-7.17 0-4.08 3.3-7.43 8.74-7.43a12.65 12.65 0 0 1 6.23 1.57l-1.15 3.35a9.86 9.86 0 0 0-5.18-1.47c-2.72 0-4.24 1.57-4.24 3.45 0 2.09 1.52 3 4.81 4.29 4.4 1.67 6.65 3.87 6.65 7.64 0 4.45-3.45 7.59-9.47 7.59a14.44 14.44 0 0 1-7.12-1.73zm23.92-7.12c.1 6.23 4.08 8.79 8.69 8.79a16.65 16.65 0 0 0 7-1.31l.79 3.3a20.52 20.52 0 0 1-8.42 1.56c-7.8 0-12.46-5.13-12.46-12.77s4.5-13.66 11.88-13.66c8.27 0 10.47 7.27 10.47 11.93a17.28 17.28 0 0 1-.16 2.15zm13.5-3.3c.05-2.93-1.2-7.48-6.39-7.48-4.66 0-6.7 4.29-7.07 7.48zm28.21 14.19a17 17 0 0 1-7.27 1.47c-7.64 0-12.61-5.18-12.61-12.93s5.34-13.45 13.61-13.45a15.4 15.4 0 0 1 6.39 1.31l-1 3.56a10.69 10.69 0 0 0-5.34-1.2c-5.81 0-8.95 4.29-8.95 9.58 0 5.86 3.77 9.47 8.79 9.47a13.09 13.09 0 0 0 5.65-1.26zm26.58-5.97c0 2.62.05 4.92.21 6.91h-4.08l-.26-4.13h-.1a9.53 9.53 0 0 1-8.37 4.71c-4 0-8.74-2.2-8.74-11.1v-14.81h4.61v14c0 4.81 1.47 8.06 5.65 8.06a6.66 6.66 0 0 0 6.07-4.19 6.73 6.73 0 0 0 .42-2.36v-15.51h4.61zm13.19-25.7v7.27h6.59v3.51h-6.59v13.66c0 3.14.89 4.92 3.45 4.92a10.23 10.23 0 0 0 2.67-.31l.21 3.45a11.27 11.27 0 0 1-4.08.63 6.38 6.38 0 0 1-5-1.94c-1.31-1.36-1.78-3.61-1.78-6.59v-13.82h-3.89v-3.51h3.92v-6.07zm34.39 19.73c0 9.37-6.49 13.45-12.61 13.45-6.86 0-12.14-5-12.14-13 0-8.48 5.55-13.45 12.56-13.45 7.27-.03 12.19 5.26 12.19 13zm-20.1.26c0 5.55 3.19 9.73 7.69 9.73s7.69-4.13 7.69-9.84c0-4.29-2.15-9.73-7.59-9.73s-7.79 5.03-7.79 9.85zm25.91-4.81c0-3-.05-5.55-.21-7.9h4l.16 5h.21c1.15-3.4 3.93-5.55 7-5.55a5 5 0 0 1 1.31.16v4.34a6.92 6.92 0 0 0-1.57-.16c-3.24 0-5.55 2.46-6.18 5.91a13 13 0 0 0-.21 2.15v13.5h-4.55z\"/></g></symbol>";
module.exports = sprite.add(image, "icon-prosecutor-avatar");

/***/ }),
/* 61 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-full\" ><path d=\"M17 25.679L6.465 32l2.793-11.852L0 12.168l12.211-1.027L17 0l4.789 11.14L34 12.169l-9.258 7.98L27.535 32z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-star-full");

/***/ }),
/* 62 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-half\" ><path d=\"M17 22.542l6.385 3.862-1.676-7.172 5.667-4.887-7.503-.63L17 6.935v15.606zm17-10.325l-9.258 7.96L27.535 32 17 25.695 6.465 32l2.793-11.823L0 12.217l12.211-1.025L17 0l4.789 11.192L34 12.217z\" fill=\"currentColor\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-star-half");

/***/ }),
/* 63 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-o\" ><path d=\"M17 22.598l6.385 3.792-1.676-7.19 5.667-4.899-7.503-.632L17 6.874l-2.873 6.795-7.503.632 5.667 4.899-1.676 7.19L17 22.598zm17-10.43l-9.258 7.98L27.535 32 17 25.679 6.465 32l2.793-11.852L0 12.168l12.211-1.027L17 0l4.789 11.14L34 12.169z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-star-o");

/***/ }),
/* 64 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 60 56\" id=\"icon-star\" ><path d=\"M30 44.938L11.408 56l4.93-20.74L0 21.293l21.55-1.798L30 0l8.45 19.496L60 21.294 43.662 35.259 48.592 56z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-star");

/***/ }),
/* 65 */
/***/ (function(module, exports, __webpack_require__) {


var sprite = __webpack_require__(0);
var image = "<symbol viewBox=\"0 0 56 57\" id=\"icon-user\" ><path d=\"M28 35.082c5.895 0 12.035 1.283 18.421 3.848C52.807 41.495 56 44.852 56 49v7.04H0V49c0-4.148 3.193-7.505 9.579-10.07 6.386-2.565 12.526-3.848 18.421-3.848zm0-7.041c-3.82 0-7.096-1.365-9.825-4.094-2.729-2.729-4.093-6.004-4.093-9.824 0-3.82 1.364-7.123 4.093-9.907C20.905 1.433 24.18.041 28 .041c3.82 0 7.096 1.392 9.825 4.175 2.729 2.784 4.093 6.086 4.093 9.907 0 3.82-1.364 7.095-4.093 9.824-2.73 2.73-6.004 4.094-9.825 4.094z\" fill-rule=\"evenodd\"/></symbol>";
module.exports = sprite.add(image, "icon-user");

/***/ }),
/* 66 */
/***/ (function(module, exports, __webpack_require__) {

var Sniffr = __webpack_require__(36);

/**
 * List of SVG attributes to fix url target in them
 * @type {string[]}
 */
var fixAttributes = [
  'clipPath',
  'colorProfile',
  'src',
  'cursor',
  'fill',
  'filter',
  'marker',
  'markerStart',
  'markerMid',
  'markerEnd',
  'mask',
  'stroke'
];

/**
 * Query to find'em
 * @type {string}
 */
var fixAttributesQuery = '[' + fixAttributes.join('],[') + ']';
/**
 * @type {RegExp}
 */
var URI_FUNC_REGEX = /^url\((.*)\)$/;

/**
 * Convert array-like to array
 * @param {Object} arrayLike
 * @returns {Array.<*>}
 */
function arrayFrom(arrayLike) {
  return Array.prototype.slice.call(arrayLike, 0);
}

/**
 * Handles forbidden symbols which cannot be directly used inside attributes with url(...) content.
 * Adds leading slash for the brackets
 * @param {string} url
 * @return {string} encoded url
 */
function encodeUrlForEmbedding(url) {
  return url.replace(/\(|\)/g, "\\$&");
}

/**
 * Replaces prefix in `url()` functions
 * @param {Element} svg
 * @param {string} currentUrlPrefix
 * @param {string} newUrlPrefix
 */
function baseUrlWorkAround(svg, currentUrlPrefix, newUrlPrefix) {
  var nodes = svg.querySelectorAll(fixAttributesQuery);

  if (!nodes) {
    return;
  }

  arrayFrom(nodes).forEach(function (node) {
    if (!node.attributes) {
      return;
    }

    arrayFrom(node.attributes).forEach(function (attribute) {
      var attributeName = attribute.localName.toLowerCase();

      if (fixAttributes.indexOf(attributeName) !== -1) {
        var match = URI_FUNC_REGEX.exec(node.getAttribute(attributeName));

        // Do not touch urls with unexpected prefix
        if (match && match[1].indexOf(currentUrlPrefix) === 0) {
          var referenceUrl = encodeUrlForEmbedding(newUrlPrefix + match[1].split(currentUrlPrefix)[1]);
          node.setAttribute(attributeName, 'url(' + referenceUrl + ')');
        }
      }
    });
  });
}

/**
 * Because of Firefox bug #353575 gradients and patterns don't work if they are within a symbol.
 * To workaround this we move the gradient definition outside the symbol element
 * @see https://bugzilla.mozilla.org/show_bug.cgi?id=353575
 * @param {Element} svg
 */
var FirefoxSymbolBugWorkaround = function (svg) {
  var defs = svg.querySelector('defs');

  var moveToDefsElems = svg.querySelectorAll('symbol linearGradient, symbol radialGradient, symbol pattern');
  for (var i = 0, len = moveToDefsElems.length; i < len; i++) {
    defs.appendChild(moveToDefsElems[i]);
  }
};

/**
 * Fix for browser (IE, maybe other too) which are throwing 'WrongDocumentError'
 * if you insert an element which is not part of the document
 * @see http://stackoverflow.com/questions/7981100/how-do-i-dynamically-insert-an-svg-image-into-html#7986519
 * @param {Element} svg
 */
function importSvg(svg) {
  try {
    if (document.importNode) {
      return document.importNode(svg, true);
    }
  } catch(e) {}

  return svg;
}

/**
 * @type {string}
 */
var DEFAULT_URI_PREFIX = '#';

/**
 * @type {string}
 */
var xLinkHref = 'xlink:href';
/**
 * @type {string}
 */
var xLinkNS = 'http://www.w3.org/1999/xlink';
/**
 * @type {string}
 */
var svgOpening = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="' + xLinkNS + '"';
/**
 * @type {string}
 */
var svgClosing = '</svg>';
/**
 * @type {string}
 */
var contentPlaceHolder = '{content}';

/**
 * Representation of SVG sprite
 * @constructor
 */
function Sprite() {
  var baseElement = document.getElementsByTagName('base')[0];
  var currentUrl = window.location.href.split('#')[0];
  var baseUrl = baseElement && baseElement.href;
  this.urlPrefix = baseUrl && baseUrl !== currentUrl ? currentUrl + DEFAULT_URI_PREFIX : DEFAULT_URI_PREFIX;

  var sniffr = new Sniffr();
  sniffr.sniff();
  this.browser = sniffr.browser;
  this.content = [];

  if (this.browser.name !== 'ie' && baseUrl) {
    window.addEventListener('spriteLoaderLocationUpdated', function (e) {
      var currentPrefix = this.urlPrefix;
      var newUrlPrefix = e.detail.newUrl.split(DEFAULT_URI_PREFIX)[0] + DEFAULT_URI_PREFIX;
      baseUrlWorkAround(this.svg, currentPrefix, newUrlPrefix);
      this.urlPrefix = newUrlPrefix;

      // Don't update <use>s only for Chrome lower than 49
      if (this.browser.name !== 'chrome' || this.browser.version[0] >= 49) {
        var nodes = arrayFrom(document.querySelectorAll('use[*|href]'));
        nodes.forEach(function (node) {
          var href = node.getAttribute(xLinkHref);
          if (href && href.indexOf(currentPrefix) === 0) {
            node.setAttributeNS(xLinkNS, xLinkHref, newUrlPrefix + href.split(DEFAULT_URI_PREFIX)[1]);
          }
        });
      }
    }.bind(this));
  }
}

Sprite.styles = ['position:absolute', 'width:0', 'height:0'];

Sprite.spriteTemplate = function(){ return svgOpening + ' style="'+ Sprite.styles.join(';') +'"><defs>' + contentPlaceHolder + '</defs>' + svgClosing; }
Sprite.symbolTemplate = function() { return svgOpening + '>' + contentPlaceHolder + svgClosing; }

/**
 * @type {Array<String>}
 */
Sprite.prototype.content = null;

/**
 * @param {String} content
 * @param {String} id
 */
Sprite.prototype.add = function (content, id) {
  if (this.svg) {
    this.appendSymbol(content);
  }

  this.content.push(content);

  return DEFAULT_URI_PREFIX + id;
};

/**
 *
 * @param content
 * @param template
 * @returns {Element}
 */
Sprite.prototype.wrapSVG = function (content, template) {
  var svgString = template.replace(contentPlaceHolder, content);

  var svg = new DOMParser().parseFromString(svgString, 'image/svg+xml').documentElement;
  var importedSvg = importSvg(svg);

  if (this.browser.name !== 'ie' && this.urlPrefix) {
    baseUrlWorkAround(importedSvg, DEFAULT_URI_PREFIX, this.urlPrefix);
  }

  return importedSvg;
};

Sprite.prototype.appendSymbol = function (content) {
  var symbol = this.wrapSVG(content, Sprite.symbolTemplate()).childNodes[0];

  this.svg.querySelector('defs').appendChild(symbol);
  if (this.browser.name === 'firefox') {
    FirefoxSymbolBugWorkaround(this.svg);
  }
};

/**
 * @returns {String}
 */
Sprite.prototype.toString = function () {
  var wrapper = document.createElement('div');
  wrapper.appendChild(this.render());
  return wrapper.innerHTML;
};

/**
 * @param {HTMLElement} [target]
 * @param {Boolean} [prepend=true]
 * @returns {HTMLElement} Rendered sprite node
 */
Sprite.prototype.render = function (target, prepend) {
  target = target || null;
  prepend = typeof prepend === 'boolean' ? prepend : true;

  var svg = this.wrapSVG(this.content.join(''), Sprite.spriteTemplate());

  if (this.browser.name === 'firefox') {
    FirefoxSymbolBugWorkaround(svg);
  }

  if (target) {
    if (prepend && target.childNodes[0]) {
      target.insertBefore(svg, target.childNodes[0]);
    } else {
      target.appendChild(svg);
    }
  }

  this.svg = svg;

  return svg;
};

module.exports = Sprite;


/***/ }),
/* 67 */
/***/ (function(module, exports) {

var g;

// This works in non-strict mode
g = (function() {
	return this;
})();

try {
	// This works if eval is allowed (see CSP)
	g = g || Function("return this")() || (1,eval)("this");
} catch(e) {
	// This works if the window reference is available
	if(typeof window === "object")
		g = window;
}

// g can still be undefined, but nothing to do about it...
// We return undefined, instead of nothing here, so it's
// easier to handle this case. if(!global) { ...}

module.exports = g;


/***/ }),
/* 68 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(11);
__webpack_require__(13);
module.exports = __webpack_require__(12);


/***/ })
],[68]);