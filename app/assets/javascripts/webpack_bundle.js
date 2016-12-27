/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/assets/";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ((function(modules) {
	// Check all modules for deduplicated modules
	for(var i in modules) {
		if(Object.prototype.hasOwnProperty.call(modules, i)) {
			switch(typeof modules[i]) {
			case "function": break;
			case "object":
				// Module can be created from a template
				modules[i] = (function(_m) {
					var args = _m.slice(1), fn = modules[_m[0]];
					return function (a,b,c) {
						fn.apply(this, [a,b,c].concat(args));
					};
				}(modules[i]));
				break;
			default:
				// Module is a copy of another module
				modules[i] = modules[modules[i]];
				break;
			}
		}
	}
	return modules;
}([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(8);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(2);

/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	// style-loader: Adds some css to the DOM by adding a <style> tag

	// load the styles
	var content = __webpack_require__(3);
	if(typeof content === 'string') content = [[module.id, content, '']];
	// add the styles to the DOM
	var update = __webpack_require__(7)(content, {});
	if(content.locals) module.exports = content.locals;
	// Hot Module Replacement
	if(false) {
		// When the styles change, update the <style> tags
		if(!content.locals) {
			module.hot.accept("!!./../../node_modules/css-loader/index.js!./../../node_modules/animate-css-webpack/animate-css-styles.loader.js!./animate-css.js", function() {
				var newContent = require("!!./../../node_modules/css-loader/index.js!./../../node_modules/animate-css-webpack/animate-css-styles.loader.js!./animate-css.js");
				if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
				update(newContent);
			});
		}
		// When the module is disposed, remove the <style> tags
		module.hot.dispose(function() { update(); });
	}

/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports
	exports.i(__webpack_require__(5), "");
	exports.i(__webpack_require__(6), "");

	// module
	exports.push([module.id, "", ""]);

	// exports


/***/ },
/* 4 */
/***/ function(module, exports) {

	/*
		MIT License http://www.opensource.org/licenses/mit-license.php
		Author Tobias Koppers @sokra
	*/
	// css base code, injected by the css-loader
	module.exports = function() {
		var list = [];

		// return the list of modules as css string
		list.toString = function toString() {
			var result = [];
			for(var i = 0; i < this.length; i++) {
				var item = this[i];
				if(item[2]) {
					result.push("@media " + item[2] + "{" + item[1] + "}");
				} else {
					result.push(item[1]);
				}
			}
			return result.join("");
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


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports


	// module
	exports.push([module.id, ".animated {\n  animation-duration: 1s;\n  animation-fill-mode: both;\n}\n\n.animated.infinite {\n  animation-iteration-count: infinite;\n}\n\n.animated.hinge {\n  animation-duration: 2s;\n}\n\n.animated.flipOutX,\n.animated.flipOutY,\n.animated.bounceIn,\n.animated.bounceOut {\n  animation-duration: .75s;\n}\n", ""]);

	// exports


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports


	// module
	exports.push([module.id, "@keyframes bounceIn {\n  from, 20%, 40%, 60%, 80%, to {\n    animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);\n  }\n\n  0% {\n    opacity: 0;\n    transform: scale3d(.3, .3, .3);\n  }\n\n  20% {\n    transform: scale3d(1.1, 1.1, 1.1);\n  }\n\n  40% {\n    transform: scale3d(.9, .9, .9);\n  }\n\n  60% {\n    opacity: 1;\n    transform: scale3d(1.03, 1.03, 1.03);\n  }\n\n  80% {\n    transform: scale3d(.97, .97, .97);\n  }\n\n  to {\n    opacity: 1;\n    transform: scale3d(1, 1, 1);\n  }\n}\n\n.bounceIn {\n  animation-name: bounceIn;\n}\n", ""]);

	// exports


/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

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
			return /msie [6-9]\b/.test(window.navigator.userAgent.toLowerCase());
		}),
		getHeadElement = memoize(function () {
			return document.head || document.getElementsByTagName("head")[0];
		}),
		singletonElement = null,
		singletonCounter = 0,
		styleElementsInsertedAtTop = [];

	module.exports = function(list, options) {
		if(false) {
			if(typeof document !== "object") throw new Error("The style-loader cannot be used in a non-browser environment");
		}

		options = options || {};
		// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
		// tags it will allow on a page
		if (typeof options.singleton === "undefined") options.singleton = isOldIE();

		// By default, add <style> tags to the bottom of <head>.
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
	}

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
		var head = getHeadElement();
		var lastStyleElementInsertedAtTop = styleElementsInsertedAtTop[styleElementsInsertedAtTop.length - 1];
		if (options.insertAt === "top") {
			if(!lastStyleElementInsertedAtTop) {
				head.insertBefore(styleElement, head.firstChild);
			} else if(lastStyleElementInsertedAtTop.nextSibling) {
				head.insertBefore(styleElement, lastStyleElementInsertedAtTop.nextSibling);
			} else {
				head.appendChild(styleElement);
			}
			styleElementsInsertedAtTop.push(styleElement);
		} else if (options.insertAt === "bottom") {
			head.appendChild(styleElement);
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
		styleElement.type = "text/css";
		insertStyleElement(options, styleElement);
		return styleElement;
	}

	function createLinkElement(options) {
		var linkElement = document.createElement("link");
		linkElement.rel = "stylesheet";
		insertStyleElement(options, linkElement);
		return linkElement;
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
			update = updateLink.bind(null, styleElement);
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

	function updateLink(linkElement, obj) {
		var css = obj.css;
		var sourceMap = obj.sourceMap;

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


/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	var Arrow, Dismiss, Rules, StoryCollapse, Tab, TextInput, ToTop, Toggle, ref, sprites;

	__webpack_require__(9);

	__webpack_require__(44);

	__webpack_require__(45);

	__webpack_require__(46);

	__webpack_require__(48);

	__webpack_require__(49);

	ref = __webpack_require__(50), Toggle = ref.Toggle, Dismiss = ref.Dismiss;

	TextInput = __webpack_require__(51).TextInput;

	StoryCollapse = __webpack_require__(52);

	Rules = __webpack_require__(53);

	ToTop = __webpack_require__(55);

	Tab = __webpack_require__(56);

	Arrow = __webpack_require__(57);

	__webpack_require__(58);

	sprites = __webpack_require__(59);

	sprites.keys().forEach(sprites);

	Turbolinks.enableProgressBar();

	Turbolinks.enableTransitionCache();

	new TextInput();

	new StoryCollapse('#story-collapse-toggle');

	new Toggle('.switch');

	new Tab('[data-tab-content]');

	new Dismiss('[data-dismiss]');

	new Rules();

	$(document).on('ready page:load', function() {
	  $("input.datepicker").each(function(input) {
	    return $(this).datepicker({
	      dateFormat: "yy-mm-dd",
	      altField: $(this).next(),
	      onClose: function() {
	        return $(this).trigger('blur');
	      }
	    });
	  });
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

	$(document).on("page:change", function() {
	  var $main_header;
	  $('input.form-control:not([autofocus], :hidden)').trigger('blur');
	  Waypoint.destroyAll();
	  $main_header = $('#main-header');
	  return $('.base-hero-carousel__cell .heading, .card__heading, .character-selector__heading, .profile__avatar, .billboard__heading').waypoint({
	    handler: function(direction) {
	      if (direction === 'down') {
	        return $main_header.addClass('has-background');
	      } else {
	        return $main_header.removeClass('has-background');
	      }
	    },
	    offset: function() {
	      return $main_header.height();
	    }
	  });
	});


	/**
	 * 評分星星
	 */

	$(document).on('mouseenter', '.form-group--score [type="radio"]', function(e) {
	  return $(this).addClass('hover');
	}).on('mouseleave', '.form-group--score [type="radio"]', function(e) {
	  return $(this).removeClass('hover');
	});


	/**
	 * 評鑑紀錄 table
	 */

	$(document).on('click', '.story-list__table tbody tr', function(e) {
	  return Turbolinks.visit($('td:last a', e.currentTarget).attr('href'));
	});


/***/ },
/* 9 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(10);

	__webpack_require__(11);

	__webpack_require__(12);

	__webpack_require__(13);

	__webpack_require__(14);

	__webpack_require__(15);

	__webpack_require__(16);

	__webpack_require__(17);

	__webpack_require__(18);

	__webpack_require__(19);

	__webpack_require__(20);

	__webpack_require__(21);

	__webpack_require__(22);

	__webpack_require__(23);

	__webpack_require__(24);

	__webpack_require__(25);

	__webpack_require__(26);

	__webpack_require__(27);

	__webpack_require__(28);

	__webpack_require__(29);

	__webpack_require__(30);

	__webpack_require__(31);

	__webpack_require__(32);

	__webpack_require__(33);

	__webpack_require__(34);

	__webpack_require__(35);

	__webpack_require__(36);

	__webpack_require__(37);

	__webpack_require__(38);

	__webpack_require__(39);

	__webpack_require__(40);

	__webpack_require__(41);

	__webpack_require__(42);

	__webpack_require__(43);


/***/ },
/* 10 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },
/* 11 */
10,
/* 12 */
10,
/* 13 */
10,
/* 14 */
10,
/* 15 */
10,
/* 16 */
10,
/* 17 */
10,
/* 18 */
10,
/* 19 */
10,
/* 20 */
10,
/* 21 */
10,
/* 22 */
10,
/* 23 */
10,
/* 24 */
10,
/* 25 */
10,
/* 26 */
10,
/* 27 */
10,
/* 28 */
10,
/* 29 */
10,
/* 30 */
10,
/* 31 */
10,
/* 32 */
10,
/* 33 */
10,
/* 34 */
10,
/* 35 */
10,
/* 36 */
10,
/* 37 */
10,
/* 38 */
10,
/* 39 */
10,
/* 40 */
10,
/* 41 */
10,
/* 42 */
10,
/* 43 */
10,
/* 44 */
/***/ function(module, exports) {

	;(function(window){
	/*!
	 * modernizr v3.3.1
	 * Build http://modernizr.com/download?-setclasses-dontmin
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
	    _version: '3.3.1',

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
	            /* jshint -W053 */
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
	      isSVG ? docElement.className.baseVal = className : docElement.className = className;
	    }

	  }

	  ;

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
	})(window);

/***/ },
/* 45 */
/***/ function(module, exports) {

	/*!
	Waypoints - 4.0.1
	Copyright © 2011-2016 Caleb Troughton
	Licensed under the MIT license.
	https://github.com/imakewebthings/waypoints/blob/master/licenses.txt
	*/
	(function() {
	  'use strict'

	  var keyCounter = 0
	  var allWaypoints = {}

	  /* http://imakewebthings.com/waypoints/api/waypoint */
	  function Waypoint(options) {
	    if (!options) {
	      throw new Error('No options passed to Waypoint constructor')
	    }
	    if (!options.element) {
	      throw new Error('No element option passed to Waypoint constructor')
	    }
	    if (!options.handler) {
	      throw new Error('No handler option passed to Waypoint constructor')
	    }

	    this.key = 'waypoint-' + keyCounter
	    this.options = Waypoint.Adapter.extend({}, Waypoint.defaults, options)
	    this.element = this.options.element
	    this.adapter = new Waypoint.Adapter(this.element)
	    this.callback = options.handler
	    this.axis = this.options.horizontal ? 'horizontal' : 'vertical'
	    this.enabled = this.options.enabled
	    this.triggerPoint = null
	    this.group = Waypoint.Group.findOrCreate({
	      name: this.options.group,
	      axis: this.axis
	    })
	    this.context = Waypoint.Context.findOrCreateByElement(this.options.context)

	    if (Waypoint.offsetAliases[this.options.offset]) {
	      this.options.offset = Waypoint.offsetAliases[this.options.offset]
	    }
	    this.group.add(this)
	    this.context.add(this)
	    allWaypoints[this.key] = this
	    keyCounter += 1
	  }

	  /* Private */
	  Waypoint.prototype.queueTrigger = function(direction) {
	    this.group.queueTrigger(this, direction)
	  }

	  /* Private */
	  Waypoint.prototype.trigger = function(args) {
	    if (!this.enabled) {
	      return
	    }
	    if (this.callback) {
	      this.callback.apply(this, args)
	    }
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/destroy */
	  Waypoint.prototype.destroy = function() {
	    this.context.remove(this)
	    this.group.remove(this)
	    delete allWaypoints[this.key]
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/disable */
	  Waypoint.prototype.disable = function() {
	    this.enabled = false
	    return this
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/enable */
	  Waypoint.prototype.enable = function() {
	    this.context.refresh()
	    this.enabled = true
	    return this
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/next */
	  Waypoint.prototype.next = function() {
	    return this.group.next(this)
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/previous */
	  Waypoint.prototype.previous = function() {
	    return this.group.previous(this)
	  }

	  /* Private */
	  Waypoint.invokeAll = function(method) {
	    var allWaypointsArray = []
	    for (var waypointKey in allWaypoints) {
	      allWaypointsArray.push(allWaypoints[waypointKey])
	    }
	    for (var i = 0, end = allWaypointsArray.length; i < end; i++) {
	      allWaypointsArray[i][method]()
	    }
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/destroy-all */
	  Waypoint.destroyAll = function() {
	    Waypoint.invokeAll('destroy')
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/disable-all */
	  Waypoint.disableAll = function() {
	    Waypoint.invokeAll('disable')
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/enable-all */
	  Waypoint.enableAll = function() {
	    Waypoint.Context.refreshAll()
	    for (var waypointKey in allWaypoints) {
	      allWaypoints[waypointKey].enabled = true
	    }
	    return this
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/refresh-all */
	  Waypoint.refreshAll = function() {
	    Waypoint.Context.refreshAll()
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/viewport-height */
	  Waypoint.viewportHeight = function() {
	    return window.innerHeight || document.documentElement.clientHeight
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/viewport-width */
	  Waypoint.viewportWidth = function() {
	    return document.documentElement.clientWidth
	  }

	  Waypoint.adapters = []

	  Waypoint.defaults = {
	    context: window,
	    continuous: true,
	    enabled: true,
	    group: 'default',
	    horizontal: false,
	    offset: 0
	  }

	  Waypoint.offsetAliases = {
	    'bottom-in-view': function() {
	      return this.context.innerHeight() - this.adapter.outerHeight()
	    },
	    'right-in-view': function() {
	      return this.context.innerWidth() - this.adapter.outerWidth()
	    }
	  }

	  window.Waypoint = Waypoint
	}())
	;(function() {
	  'use strict'

	  function requestAnimationFrameShim(callback) {
	    window.setTimeout(callback, 1000 / 60)
	  }

	  var keyCounter = 0
	  var contexts = {}
	  var Waypoint = window.Waypoint
	  var oldWindowLoad = window.onload

	  /* http://imakewebthings.com/waypoints/api/context */
	  function Context(element) {
	    this.element = element
	    this.Adapter = Waypoint.Adapter
	    this.adapter = new this.Adapter(element)
	    this.key = 'waypoint-context-' + keyCounter
	    this.didScroll = false
	    this.didResize = false
	    this.oldScroll = {
	      x: this.adapter.scrollLeft(),
	      y: this.adapter.scrollTop()
	    }
	    this.waypoints = {
	      vertical: {},
	      horizontal: {}
	    }

	    element.waypointContextKey = this.key
	    contexts[element.waypointContextKey] = this
	    keyCounter += 1
	    if (!Waypoint.windowContext) {
	      Waypoint.windowContext = true
	      Waypoint.windowContext = new Context(window)
	    }

	    this.createThrottledScrollHandler()
	    this.createThrottledResizeHandler()
	  }

	  /* Private */
	  Context.prototype.add = function(waypoint) {
	    var axis = waypoint.options.horizontal ? 'horizontal' : 'vertical'
	    this.waypoints[axis][waypoint.key] = waypoint
	    this.refresh()
	  }

	  /* Private */
	  Context.prototype.checkEmpty = function() {
	    var horizontalEmpty = this.Adapter.isEmptyObject(this.waypoints.horizontal)
	    var verticalEmpty = this.Adapter.isEmptyObject(this.waypoints.vertical)
	    var isWindow = this.element == this.element.window
	    if (horizontalEmpty && verticalEmpty && !isWindow) {
	      this.adapter.off('.waypoints')
	      delete contexts[this.key]
	    }
	  }

	  /* Private */
	  Context.prototype.createThrottledResizeHandler = function() {
	    var self = this

	    function resizeHandler() {
	      self.handleResize()
	      self.didResize = false
	    }

	    this.adapter.on('resize.waypoints', function() {
	      if (!self.didResize) {
	        self.didResize = true
	        Waypoint.requestAnimationFrame(resizeHandler)
	      }
	    })
	  }

	  /* Private */
	  Context.prototype.createThrottledScrollHandler = function() {
	    var self = this
	    function scrollHandler() {
	      self.handleScroll()
	      self.didScroll = false
	    }

	    this.adapter.on('scroll.waypoints', function() {
	      if (!self.didScroll || Waypoint.isTouch) {
	        self.didScroll = true
	        Waypoint.requestAnimationFrame(scrollHandler)
	      }
	    })
	  }

	  /* Private */
	  Context.prototype.handleResize = function() {
	    Waypoint.Context.refreshAll()
	  }

	  /* Private */
	  Context.prototype.handleScroll = function() {
	    var triggeredGroups = {}
	    var axes = {
	      horizontal: {
	        newScroll: this.adapter.scrollLeft(),
	        oldScroll: this.oldScroll.x,
	        forward: 'right',
	        backward: 'left'
	      },
	      vertical: {
	        newScroll: this.adapter.scrollTop(),
	        oldScroll: this.oldScroll.y,
	        forward: 'down',
	        backward: 'up'
	      }
	    }

	    for (var axisKey in axes) {
	      var axis = axes[axisKey]
	      var isForward = axis.newScroll > axis.oldScroll
	      var direction = isForward ? axis.forward : axis.backward

	      for (var waypointKey in this.waypoints[axisKey]) {
	        var waypoint = this.waypoints[axisKey][waypointKey]
	        if (waypoint.triggerPoint === null) {
	          continue
	        }
	        var wasBeforeTriggerPoint = axis.oldScroll < waypoint.triggerPoint
	        var nowAfterTriggerPoint = axis.newScroll >= waypoint.triggerPoint
	        var crossedForward = wasBeforeTriggerPoint && nowAfterTriggerPoint
	        var crossedBackward = !wasBeforeTriggerPoint && !nowAfterTriggerPoint
	        if (crossedForward || crossedBackward) {
	          waypoint.queueTrigger(direction)
	          triggeredGroups[waypoint.group.id] = waypoint.group
	        }
	      }
	    }

	    for (var groupKey in triggeredGroups) {
	      triggeredGroups[groupKey].flushTriggers()
	    }

	    this.oldScroll = {
	      x: axes.horizontal.newScroll,
	      y: axes.vertical.newScroll
	    }
	  }

	  /* Private */
	  Context.prototype.innerHeight = function() {
	    /*eslint-disable eqeqeq */
	    if (this.element == this.element.window) {
	      return Waypoint.viewportHeight()
	    }
	    /*eslint-enable eqeqeq */
	    return this.adapter.innerHeight()
	  }

	  /* Private */
	  Context.prototype.remove = function(waypoint) {
	    delete this.waypoints[waypoint.axis][waypoint.key]
	    this.checkEmpty()
	  }

	  /* Private */
	  Context.prototype.innerWidth = function() {
	    /*eslint-disable eqeqeq */
	    if (this.element == this.element.window) {
	      return Waypoint.viewportWidth()
	    }
	    /*eslint-enable eqeqeq */
	    return this.adapter.innerWidth()
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/context-destroy */
	  Context.prototype.destroy = function() {
	    var allWaypoints = []
	    for (var axis in this.waypoints) {
	      for (var waypointKey in this.waypoints[axis]) {
	        allWaypoints.push(this.waypoints[axis][waypointKey])
	      }
	    }
	    for (var i = 0, end = allWaypoints.length; i < end; i++) {
	      allWaypoints[i].destroy()
	    }
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/context-refresh */
	  Context.prototype.refresh = function() {
	    /*eslint-disable eqeqeq */
	    var isWindow = this.element == this.element.window
	    /*eslint-enable eqeqeq */
	    var contextOffset = isWindow ? undefined : this.adapter.offset()
	    var triggeredGroups = {}
	    var axes

	    this.handleScroll()
	    axes = {
	      horizontal: {
	        contextOffset: isWindow ? 0 : contextOffset.left,
	        contextScroll: isWindow ? 0 : this.oldScroll.x,
	        contextDimension: this.innerWidth(),
	        oldScroll: this.oldScroll.x,
	        forward: 'right',
	        backward: 'left',
	        offsetProp: 'left'
	      },
	      vertical: {
	        contextOffset: isWindow ? 0 : contextOffset.top,
	        contextScroll: isWindow ? 0 : this.oldScroll.y,
	        contextDimension: this.innerHeight(),
	        oldScroll: this.oldScroll.y,
	        forward: 'down',
	        backward: 'up',
	        offsetProp: 'top'
	      }
	    }

	    for (var axisKey in axes) {
	      var axis = axes[axisKey]
	      for (var waypointKey in this.waypoints[axisKey]) {
	        var waypoint = this.waypoints[axisKey][waypointKey]
	        var adjustment = waypoint.options.offset
	        var oldTriggerPoint = waypoint.triggerPoint
	        var elementOffset = 0
	        var freshWaypoint = oldTriggerPoint == null
	        var contextModifier, wasBeforeScroll, nowAfterScroll
	        var triggeredBackward, triggeredForward

	        if (waypoint.element !== waypoint.element.window) {
	          elementOffset = waypoint.adapter.offset()[axis.offsetProp]
	        }

	        if (typeof adjustment === 'function') {
	          adjustment = adjustment.apply(waypoint)
	        }
	        else if (typeof adjustment === 'string') {
	          adjustment = parseFloat(adjustment)
	          if (waypoint.options.offset.indexOf('%') > - 1) {
	            adjustment = Math.ceil(axis.contextDimension * adjustment / 100)
	          }
	        }

	        contextModifier = axis.contextScroll - axis.contextOffset
	        waypoint.triggerPoint = Math.floor(elementOffset + contextModifier - adjustment)
	        wasBeforeScroll = oldTriggerPoint < axis.oldScroll
	        nowAfterScroll = waypoint.triggerPoint >= axis.oldScroll
	        triggeredBackward = wasBeforeScroll && nowAfterScroll
	        triggeredForward = !wasBeforeScroll && !nowAfterScroll

	        if (!freshWaypoint && triggeredBackward) {
	          waypoint.queueTrigger(axis.backward)
	          triggeredGroups[waypoint.group.id] = waypoint.group
	        }
	        else if (!freshWaypoint && triggeredForward) {
	          waypoint.queueTrigger(axis.forward)
	          triggeredGroups[waypoint.group.id] = waypoint.group
	        }
	        else if (freshWaypoint && axis.oldScroll >= waypoint.triggerPoint) {
	          waypoint.queueTrigger(axis.forward)
	          triggeredGroups[waypoint.group.id] = waypoint.group
	        }
	      }
	    }

	    Waypoint.requestAnimationFrame(function() {
	      for (var groupKey in triggeredGroups) {
	        triggeredGroups[groupKey].flushTriggers()
	      }
	    })

	    return this
	  }

	  /* Private */
	  Context.findOrCreateByElement = function(element) {
	    return Context.findByElement(element) || new Context(element)
	  }

	  /* Private */
	  Context.refreshAll = function() {
	    for (var contextId in contexts) {
	      contexts[contextId].refresh()
	    }
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/context-find-by-element */
	  Context.findByElement = function(element) {
	    return contexts[element.waypointContextKey]
	  }

	  window.onload = function() {
	    if (oldWindowLoad) {
	      oldWindowLoad()
	    }
	    Context.refreshAll()
	  }


	  Waypoint.requestAnimationFrame = function(callback) {
	    var requestFn = window.requestAnimationFrame ||
	      window.mozRequestAnimationFrame ||
	      window.webkitRequestAnimationFrame ||
	      requestAnimationFrameShim
	    requestFn.call(window, callback)
	  }
	  Waypoint.Context = Context
	}())
	;(function() {
	  'use strict'

	  function byTriggerPoint(a, b) {
	    return a.triggerPoint - b.triggerPoint
	  }

	  function byReverseTriggerPoint(a, b) {
	    return b.triggerPoint - a.triggerPoint
	  }

	  var groups = {
	    vertical: {},
	    horizontal: {}
	  }
	  var Waypoint = window.Waypoint

	  /* http://imakewebthings.com/waypoints/api/group */
	  function Group(options) {
	    this.name = options.name
	    this.axis = options.axis
	    this.id = this.name + '-' + this.axis
	    this.waypoints = []
	    this.clearTriggerQueues()
	    groups[this.axis][this.name] = this
	  }

	  /* Private */
	  Group.prototype.add = function(waypoint) {
	    this.waypoints.push(waypoint)
	  }

	  /* Private */
	  Group.prototype.clearTriggerQueues = function() {
	    this.triggerQueues = {
	      up: [],
	      down: [],
	      left: [],
	      right: []
	    }
	  }

	  /* Private */
	  Group.prototype.flushTriggers = function() {
	    for (var direction in this.triggerQueues) {
	      var waypoints = this.triggerQueues[direction]
	      var reverse = direction === 'up' || direction === 'left'
	      waypoints.sort(reverse ? byReverseTriggerPoint : byTriggerPoint)
	      for (var i = 0, end = waypoints.length; i < end; i += 1) {
	        var waypoint = waypoints[i]
	        if (waypoint.options.continuous || i === waypoints.length - 1) {
	          waypoint.trigger([direction])
	        }
	      }
	    }
	    this.clearTriggerQueues()
	  }

	  /* Private */
	  Group.prototype.next = function(waypoint) {
	    this.waypoints.sort(byTriggerPoint)
	    var index = Waypoint.Adapter.inArray(waypoint, this.waypoints)
	    var isLast = index === this.waypoints.length - 1
	    return isLast ? null : this.waypoints[index + 1]
	  }

	  /* Private */
	  Group.prototype.previous = function(waypoint) {
	    this.waypoints.sort(byTriggerPoint)
	    var index = Waypoint.Adapter.inArray(waypoint, this.waypoints)
	    return index ? this.waypoints[index - 1] : null
	  }

	  /* Private */
	  Group.prototype.queueTrigger = function(waypoint, direction) {
	    this.triggerQueues[direction].push(waypoint)
	  }

	  /* Private */
	  Group.prototype.remove = function(waypoint) {
	    var index = Waypoint.Adapter.inArray(waypoint, this.waypoints)
	    if (index > -1) {
	      this.waypoints.splice(index, 1)
	    }
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/first */
	  Group.prototype.first = function() {
	    return this.waypoints[0]
	  }

	  /* Public */
	  /* http://imakewebthings.com/waypoints/api/last */
	  Group.prototype.last = function() {
	    return this.waypoints[this.waypoints.length - 1]
	  }

	  /* Private */
	  Group.findOrCreate = function(options) {
	    return groups[options.axis][options.name] || new Group(options)
	  }

	  Waypoint.Group = Group
	}())
	;(function() {
	  'use strict'

	  var $ = window.jQuery
	  var Waypoint = window.Waypoint

	  function JQueryAdapter(element) {
	    this.$element = $(element)
	  }

	  $.each([
	    'innerHeight',
	    'innerWidth',
	    'off',
	    'offset',
	    'on',
	    'outerHeight',
	    'outerWidth',
	    'scrollLeft',
	    'scrollTop'
	  ], function(i, method) {
	    JQueryAdapter.prototype[method] = function() {
	      var args = Array.prototype.slice.call(arguments)
	      return this.$element[method].apply(this.$element, args)
	    }
	  })

	  $.each([
	    'extend',
	    'inArray',
	    'isEmptyObject'
	  ], function(i, method) {
	    JQueryAdapter[method] = $[method]
	  })

	  Waypoint.adapters.push({
	    name: 'jquery',
	    Adapter: JQueryAdapter
	  })
	  Waypoint.Adapter = JQueryAdapter
	}())
	;(function() {
	  'use strict'

	  var Waypoint = window.Waypoint

	  function createExtension(framework) {
	    return function() {
	      var waypoints = []
	      var overrides = arguments[0]

	      if (framework.isFunction(arguments[0])) {
	        overrides = framework.extend({}, arguments[1])
	        overrides.handler = arguments[0]
	      }

	      this.each(function() {
	        var options = framework.extend({}, overrides, {
	          element: this
	        })
	        if (typeof options.context === 'string') {
	          options.context = framework(this).closest(options.context)[0]
	        }
	        waypoints.push(new Waypoint(options))
	      })

	      return waypoints
	    }
	  }

	  if (window.jQuery) {
	    window.jQuery.fn.waypoint = createExtension(window.jQuery)
	  }
	  if (window.Zepto) {
	    window.Zepto.fn.waypoint = createExtension(window.Zepto)
	  }
	}())
	;

/***/ },
/* 46 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/*
	 *  webui popover plugin  - v1.2.16
	 *  A lightWeight popover plugin with jquery ,enchance the  popover plugin of bootstrap with some awesome new features. It works well with bootstrap ,but bootstrap is not necessary!
	 *  https://github.com/sandywalker/webui-popover
	 *
	 *  Made by Sandy Duan
	 *  Under MIT License
	 */
	(function(window, document, undefined) {
	    'use strict';
	    (function(factory) {
	        if (true) {
	            // Register as an anonymous AMD module.
	            !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(47)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory), __WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ? (__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	        } else if (typeof exports === 'object') {
	            // Node/CommonJS
	            module.exports = factory(require('jquery'));
	        } else {
	            // Browser globals
	            factory(window.jQuery);
	        }
	    }(function($) {
	        // Create the defaults once
	        var pluginName = 'webuiPopover';
	        var pluginClass = 'webui-popover';
	        var pluginType = 'webui.popover';
	        var defaults = {
	            placement: 'auto',
	            container: null,
	            width: 'auto',
	            height: 'auto',
	            trigger: 'click', //hover,click,sticky,manual
	            style: '',
	            selector: false, // jQuery selector, if a selector is provided, popover objects will be delegated to the specified. 
	            delay: {
	                show: null,
	                hide: 300
	            },
	            async: {
	                type: 'GET',
	                before: null, //function(that, xhr){}
	                success: null, //function(that, xhr){}
	                error: null //function(that, xhr, data){}
	            },
	            cache: true,
	            multi: false,
	            arrow: true,
	            title: '',
	            content: '',
	            closeable: false,
	            padding: true,
	            url: '',
	            type: 'html',
	            direction: '', // ltr,rtl
	            animation: null,
	            template: '<div class="webui-popover">' +
	                '<div class="webui-arrow"></div>' +
	                '<div class="webui-popover-inner">' +
	                '<a href="#" class="close"></a>' +
	                '<h3 class="webui-popover-title"></h3>' +
	                '<div class="webui-popover-content"><i class="icon-refresh"></i> <p>&nbsp;</p></div>' +
	                '</div>' +
	                '</div>',
	            backdrop: false,
	            dismissible: true,
	            onShow: null,
	            onHide: null,
	            abortXHR: true,
	            autoHide: false,
	            offsetTop: 0,
	            offsetLeft: 0,
	            iframeOptions: {
	                frameborder: '0',
	                allowtransparency: 'true',
	                id: '',
	                name: '',
	                scrolling: '',
	                onload: '',
	                height: '',
	                width: ''
	            },
	            hideEmpty: false
	        };

	        var rtlClass = pluginClass + '-rtl';
	        var _srcElements = [];
	        var backdrop = $('<div class="webui-popover-backdrop"></div>');
	        var _globalIdSeed = 0;
	        var _isBodyEventHandled = false;
	        var _offsetOut = -2000; // the value offset  out of the screen
	        var $document = $(document);

	        var toNumber = function(numeric, fallback) {
	            return isNaN(numeric) ? (fallback || 0) : Number(numeric);
	        };

	        var getPopFromElement = function($element) {
	            return $element.data('plugin_' + pluginName);
	        };

	        var hideAllPop = function() {
	            var pop = null;
	            for (var i = 0; i < _srcElements.length; i++) {
	                pop = getPopFromElement(_srcElements[i]);
	                if (pop) {
	                    pop.hide(true);
	                }
	            }
	            $document.trigger('hiddenAll.' + pluginType);
	        };

	        var hideOtherPops = function(currentPop) {
	            var pop = null;
	            for (var i = 0; i < _srcElements.length; i++) {
	                pop = getPopFromElement(_srcElements[i]);
	                if (pop && pop.id !== currentPop.id) {
	                    pop.hide(true);
	                }
	            }
	            $document.trigger('hiddenAll.' + pluginType);
	        };

	        var isMobile = ('ontouchstart' in document.documentElement) && (/Mobi/.test(navigator.userAgent));

	        var pointerEventToXY = function(e) {
	            var out = {
	                x: 0,
	                y: 0
	            };
	            if (e.type === 'touchstart' || e.type === 'touchmove' || e.type === 'touchend' || e.type === 'touchcancel') {
	                var touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0];
	                out.x = touch.pageX;
	                out.y = touch.pageY;
	            } else if (e.type === 'mousedown' || e.type === 'mouseup' || e.type === 'click') {
	                out.x = e.pageX;
	                out.y = e.pageY;
	            }
	            return out;
	        };



	        // The actual plugin constructor
	        function WebuiPopover(element, options) {
	            this.$element = $(element);
	            if (options) {
	                if ($.type(options.delay) === 'string' || $.type(options.delay) === 'number') {
	                    options.delay = {
	                        show: options.delay,
	                        hide: options.delay
	                    }; // bc break fix
	                }
	            }
	            this.options = $.extend({}, defaults, options);
	            this._defaults = defaults;
	            this._name = pluginName;
	            this._targetclick = false;
	            this.init();
	            _srcElements.push(this.$element);
	            return this;

	        }

	        WebuiPopover.prototype = {
	            //init webui popover
	            init: function() {
	                if (this.$element[0] instanceof document.constructor && !this.options.selector) {
	                    throw new Error('`selector` option must be specified when initializing ' + this.type + ' on the window.document object!');
	                }

	                if (this.getTrigger() !== 'manual') {
	                    //init the event handlers
	                    if (this.getTrigger() === 'click' || isMobile) {
	                        this.$element.off('click touchend', this.options.selector).on('click touchend', this.options.selector, $.proxy(this.toggle, this));
	                    } else if (this.getTrigger() === 'hover') {
	                        this.$element
	                            .off('mouseenter mouseleave click', this.options.selector)
	                            .on('mouseenter', this.options.selector, $.proxy(this.mouseenterHandler, this))
	                            .on('mouseleave', this.options.selector, $.proxy(this.mouseleaveHandler, this));
	                    }
	                }
	                this._poped = false;
	                this._inited = true;
	                this._opened = false;
	                this._idSeed = _globalIdSeed;
	                this.id = pluginName + this._idSeed;
	                // normalize container
	                this.options.container = $(this.options.container || document.body).first();

	                if (this.options.backdrop) {
	                    backdrop.appendTo(this.options.container).hide();
	                }
	                _globalIdSeed++;
	                if (this.getTrigger() === 'sticky') {
	                    this.show();
	                }

	                if (this.options.selector) {
	                    this._options = $.extend({}, this.options, {
	                        selector: ''
	                    });
	                }

	            },
	            /* api methods and actions */
	            destroy: function() {
	                var index = -1;

	                for (var i = 0; i < _srcElements.length; i++) {
	                    if (_srcElements[i] === this.$element) {
	                        index = i;
	                        break;
	                    }
	                }

	                _srcElements.splice(index, 1);


	                this.hide();
	                this.$element.data('plugin_' + pluginName, null);
	                if (this.getTrigger() === 'click') {
	                    this.$element.off('click');
	                } else if (this.getTrigger() === 'hover') {
	                    this.$element.off('mouseenter mouseleave');
	                }
	                if (this.$target) {
	                    this.$target.remove();
	                }
	            },
	            getDelegateOptions: function() {
	                var options = {};

	                this._options && $.each(this._options, function(key, value) {
	                    if (defaults[key] !== value) {
	                        options[key] = value;
	                    }
	                });
	                return options;
	            },
	            /*
	                param: force    boolean value, if value is true then force hide the popover
	                param: event    dom event,
	            */
	            hide: function(force, event) {

	                if (!force && this.getTrigger() === 'sticky') {
	                    return;
	                }
	                if (!this._opened) {
	                    return;
	                }
	                if (event) {
	                    event.preventDefault();
	                    event.stopPropagation();
	                }

	                if (this.xhr && this.options.abortXHR === true) {
	                    this.xhr.abort();
	                    this.xhr = null;
	                }


	                var e = $.Event('hide.' + pluginType);
	                this.$element.trigger(e, [this.$target]);
	                if (this.$target) {
	                    this.$target.removeClass('in').addClass(this.getHideAnimation());
	                    var that = this;
	                    setTimeout(function() {
	                        that.$target.hide();
	                        if (!that.getCache()) {
	                            that.$target.remove();
	                        }
	                    }, that.getHideDelay());
	                }
	                if (this.options.backdrop) {
	                    backdrop.hide();
	                }
	                this._opened = false;
	                this.$element.trigger('hidden.' + pluginType, [this.$target]);

	                if (this.options.onHide) {
	                    this.options.onHide(this.$target);
	                }

	            },
	            resetAutoHide: function() {
	                var that = this;
	                var autoHide = that.getAutoHide();
	                if (autoHide) {
	                    if (that.autoHideHandler) {
	                        clearTimeout(that.autoHideHandler);
	                    }
	                    that.autoHideHandler = setTimeout(function() {
	                        that.hide();
	                    }, autoHide);
	                }
	            },
	            delegate: function(eventTarget) {
	                var self = $(eventTarget).data('plugin_' + pluginName);
	                if (!self) {
	                    self = new WebuiPopover(eventTarget, this.getDelegateOptions());
	                    $(eventTarget).data('plugin_' + pluginName, self);
	                }
	                return self;
	            },
	            toggle: function(e) {
	                var self = this;
	                if (e) {
	                    e.preventDefault();
	                    e.stopPropagation();
	                    if (this.options.selector) {
	                        self = this.delegate(e.currentTarget);
	                    }
	                }
	                self[self.getTarget().hasClass('in') ? 'hide' : 'show']();
	            },
	            hideAll: function() {
	                hideAllPop();
	            },
	            hideOthers: function() {
	                hideOtherPops(this);
	            },
	            /*core method ,show popover */
	            show: function() {
	                if (this._opened) {
	                    return;
	                }
	                //removeAllTargets();
	                var
	                    $target = this.getTarget().removeClass().addClass(pluginClass).addClass(this._customTargetClass);
	                if (!this.options.multi) {
	                    this.hideOthers();
	                }

	                // use cache by default, if not cache setted  , reInit the contents
	                if (!this.getCache() || !this._poped || this.content === '') {
	                    this.content = '';
	                    this.setTitle(this.getTitle());
	                    if (!this.options.closeable) {
	                        $target.find('.close').off('click').remove();
	                    }
	                    if (!this.isAsync()) {
	                        this.setContent(this.getContent());
	                    } else {
	                        this.setContentASync(this.options.content);
	                    }

	                    if (this.canEmptyHide() && this.content === '') {
	                        return;
	                    }
	                    $target.show();
	                }

	                this.displayContent();

	                if (this.options.onShow) {
	                    this.options.onShow($target);
	                }

	                this.bindBodyEvents();
	                if (this.options.backdrop) {
	                    backdrop.show();
	                }
	                this._opened = true;
	                this.resetAutoHide();
	            },
	            displayContent: function() {
	                var
	                //element postion
	                    elementPos = this.getElementPosition(),
	                    //target postion
	                    $target = this.getTarget().removeClass().addClass(pluginClass).addClass(this._customTargetClass),
	                    //target content
	                    $targetContent = this.getContentElement(),
	                    //target Width
	                    targetWidth = $target[0].offsetWidth,
	                    //target Height
	                    targetHeight = $target[0].offsetHeight,
	                    //placement
	                    placement = 'bottom',
	                    e = $.Event('show.' + pluginType);

	                if (this.canEmptyHide()) {

	                    var content = $targetContent.children().html();
	                    if (content !== null && content.trim().length === 0) {
	                        return;
	                    }
	                }

	                //if (this.hasContent()){
	                this.$element.trigger(e, [$target]);
	                //}
	                // support width as data attribute
	                var optWidth = this.$element.data('width') || this.options.width;
	                if (optWidth === '') {
	                    optWidth = this._defaults.width;
	                }

	                if (optWidth !== 'auto') {
	                    $target.width(optWidth);
	                }

	                // support height as data attribute
	                var optHeight = this.$element.data('height') || this.options.height;
	                if (optHeight === '') {
	                    optHeight = this._defaults.height;
	                }

	                if (optHeight !== 'auto') {
	                    $targetContent.height(optHeight);
	                }

	                if (this.options.style) {
	                    this.$target.addClass(pluginClass + '-' + this.options.style);
	                }

	                //check rtl
	                if (this.options.direction === 'rtl' && !$targetContent.hasClass(rtlClass)) {
	                    $targetContent.addClass(rtlClass);
	                }

	                //init the popover and insert into the document body
	                if (!this.options.arrow) {
	                    $target.find('.webui-arrow').remove();
	                }
	                $target.detach().css({
	                    top: _offsetOut,
	                    left: _offsetOut,
	                    display: 'block'
	                });

	                if (this.getAnimation()) {
	                    $target.addClass(this.getAnimation());
	                }
	                $target.appendTo(this.options.container);


	                placement = this.getPlacement(elementPos);

	                //This line is just for compatible with knockout custom binding
	                this.$element.trigger('added.' + pluginType);

	                this.initTargetEvents();

	                if (!this.options.padding) {
	                    if (this.options.height !== 'auto') {
	                        $targetContent.css('height', $targetContent.outerHeight());
	                    }
	                    this.$target.addClass('webui-no-padding');
	                }

	                // add maxHeight and maxWidth support by limodou@gmail.com 2016/10/1
	                if (this.options.maxHeight) {
	                    $targetContent.css('maxHeight', this.options.maxHeight);
	                }

	                if (this.options.maxWidth) {
	                    $targetContent.css('maxWidth', this.options.maxWidth);
	                }
	                // end

	                targetWidth = $target[0].offsetWidth;
	                targetHeight = $target[0].offsetHeight;

	                var postionInfo = this.getTargetPositin(elementPos, placement, targetWidth, targetHeight);

	                this.$target.css(postionInfo.position).addClass(placement).addClass('in');

	                if (this.options.type === 'iframe') {
	                    var $iframe = $target.find('iframe');
	                    var iframeWidth = $target.width();
	                    var iframeHeight = $iframe.parent().height();

	                    if (this.options.iframeOptions.width !== '' && this.options.iframeOptions.width !== 'auto') {
	                        iframeWidth = this.options.iframeOptions.width;
	                    }

	                    if (this.options.iframeOptions.height !== '' && this.options.iframeOptions.height !== 'auto') {
	                        iframeHeight = this.options.iframeOptions.height;
	                    }

	                    $iframe.width(iframeWidth).height(iframeHeight);
	                }

	                if (!this.options.arrow) {
	                    this.$target.css({
	                        'margin': 0
	                    });
	                }
	                if (this.options.arrow) {
	                    var $arrow = this.$target.find('.webui-arrow');
	                    $arrow.removeAttr('style');

	                    //prevent arrow change by content size
	                    if (placement === 'left' || placement === 'right') {
	                        $arrow.css({
	                            top: this.$target.height() / 2
	                        });
	                    } else if (placement === 'top' || placement === 'bottom') {
	                        $arrow.css({
	                            left: this.$target.width() / 2
	                        });
	                    }

	                    if (postionInfo.arrowOffset) {
	                        //hide the arrow if offset is negative
	                        if (postionInfo.arrowOffset.left === -1 || postionInfo.arrowOffset.top === -1) {
	                            $arrow.hide();
	                        } else {
	                            $arrow.css(postionInfo.arrowOffset);
	                        }
	                    }

	                }
	                this._poped = true;
	                this.$element.trigger('shown.' + pluginType, [this.$target]);
	            },

	            isTargetLoaded: function() {
	                return this.getTarget().find('i.glyphicon-refresh').length === 0;
	            },

	            /*getter setters */
	            getTriggerElement: function() {
	                return this.$element;
	            },
	            getTarget: function() {
	                if (!this.$target) {
	                    var id = pluginName + this._idSeed;
	                    this.$target = $(this.options.template)
	                        .attr('id', id);
	                    this._customTargetClass = this.$target.attr('class') !== pluginClass ? this.$target.attr('class') : null;
	                    this.getTriggerElement().attr('data-target', id);
	                }
	                if (!this.$target.data('trigger-element')) {
	                    this.$target.data('trigger-element', this.getTriggerElement());
	                }
	                return this.$target;
	            },
	            removeTarget: function() {
	                this.$target.remove();
	                this.$target = null;
	                this.$contentElement = null;
	            },
	            getTitleElement: function() {
	                return this.getTarget().find('.' + pluginClass + '-title');
	            },
	            getContentElement: function() {
	                if (!this.$contentElement) {
	                    this.$contentElement = this.getTarget().find('.' + pluginClass + '-content');
	                }
	                return this.$contentElement;
	            },
	            getTitle: function() {
	                return this.$element.attr('data-title') || this.options.title || this.$element.attr('title');
	            },
	            getUrl: function() {
	                return this.$element.attr('data-url') || this.options.url;
	            },
	            getAutoHide: function() {
	                return this.$element.attr('data-auto-hide') || this.options.autoHide;
	            },
	            getOffsetTop: function() {
	                return toNumber(this.$element.attr('data-offset-top')) || this.options.offsetTop;
	            },
	            getOffsetLeft: function() {
	                return toNumber(this.$element.attr('data-offset-left')) || this.options.offsetLeft;
	            },
	            getCache: function() {
	                var dataAttr = this.$element.attr('data-cache');
	                if (typeof(dataAttr) !== 'undefined') {
	                    switch (dataAttr.toLowerCase()) {
	                        case 'true':
	                        case 'yes':
	                        case '1':
	                            return true;
	                        case 'false':
	                        case 'no':
	                        case '0':
	                            return false;
	                    }
	                }
	                return this.options.cache;
	            },
	            getTrigger: function() {
	                return this.$element.attr('data-trigger') || this.options.trigger;
	            },
	            getDelayShow: function() {
	                var dataAttr = this.$element.attr('data-delay-show');
	                if (typeof(dataAttr) !== 'undefined') {
	                    return dataAttr;
	                }
	                return this.options.delay.show === 0 ? 0 : this.options.delay.show || 100;
	            },
	            getHideDelay: function() {
	                var dataAttr = this.$element.attr('data-delay-hide');
	                if (typeof(dataAttr) !== 'undefined') {
	                    return dataAttr;
	                }
	                return this.options.delay.hide === 0 ? 0 : this.options.delay.hide || 100;
	            },
	            getAnimation: function() {
	                var dataAttr = this.$element.attr('data-animation');
	                return dataAttr || this.options.animation;
	            },
	            getHideAnimation: function() {
	                var ani = this.getAnimation();
	                return ani ? ani + '-out' : 'out';
	            },
	            setTitle: function(title) {
	                var $titleEl = this.getTitleElement();
	                if (title) {
	                    //check rtl
	                    if (this.options.direction === 'rtl' && !$titleEl.hasClass(rtlClass)) {
	                        $titleEl.addClass(rtlClass);
	                    }
	                    $titleEl.html(title);
	                } else {
	                    $titleEl.remove();
	                }
	            },
	            hasContent: function() {
	                return this.getContent();
	            },
	            canEmptyHide: function() {
	                return this.options.hideEmpty && this.options.type === 'html';
	            },
	            getIframe: function() {
	                var $iframe = $('<iframe></iframe>').attr('src', this.getUrl());
	                var self = this;
	                $.each(this._defaults.iframeOptions, function(opt) {
	                    if (typeof self.options.iframeOptions[opt] !== 'undefined') {
	                        $iframe.attr(opt, self.options.iframeOptions[opt]);
	                    }
	                });

	                return $iframe;
	            },
	            getContent: function() {
	                if (this.getUrl()) {
	                    switch (this.options.type) {
	                        case 'iframe':
	                            this.content = this.getIframe();
	                            break;
	                        case 'html':
	                            try {
	                                this.content = $(this.getUrl());
	                                if (!this.content.is(':visible')) {
	                                    this.content.show();
	                                }
	                            } catch (error) {
	                                throw new Error('Unable to get popover content. Invalid selector specified.');
	                            }
	                            break;
	                    }
	                } else if (!this.content) {
	                    var content = '';
	                    if ($.isFunction(this.options.content)) {
	                        content = this.options.content.apply(this.$element[0], [this]);
	                    } else {
	                        content = this.options.content;
	                    }
	                    this.content = this.$element.attr('data-content') || content;
	                    if (!this.content) {
	                        var $next = this.$element.next();

	                        if ($next && $next.hasClass(pluginClass + '-content')) {
	                            this.content = $next;
	                        }
	                    }
	                }
	                return this.content;
	            },
	            setContent: function(content) {
	                var $target = this.getTarget();
	                var $ct = this.getContentElement();
	                if (typeof content === 'string') {
	                    $ct.html(content);
	                } else if (content instanceof $) {
	                    $ct.html('');
	                    //Don't want to clone too many times.
	                    if (!this.options.cache) {
	                        content.clone(true, true).removeClass(pluginClass + '-content').appendTo($ct);
	                    } else {
	                        content.removeClass(pluginClass + '-content').appendTo($ct);
	                    }
	                }
	                this.$target = $target;
	            },
	            isAsync: function() {
	                return this.options.type === 'async';
	            },
	            setContentASync: function(content) {
	                var that = this;
	                if (this.xhr) {
	                    return;
	                }
	                this.xhr = $.ajax({
	                    url: this.getUrl(),
	                    type: this.options.async.type,
	                    cache: this.getCache(),
	                    beforeSend: function(xhr) {
	                        if (that.options.async.before) {
	                            that.options.async.before(that, xhr);
	                        }
	                    },
	                    success: function(data) {
	                        that.bindBodyEvents();
	                        if (content && $.isFunction(content)) {
	                            that.content = content.apply(that.$element[0], [data]);
	                        } else {
	                            that.content = data;
	                        }
	                        that.setContent(that.content);
	                        var $targetContent = that.getContentElement();
	                        $targetContent.removeAttr('style');
	                        that.displayContent();
	                        if (that.options.async.success) {
	                            that.options.async.success(that, data);
	                        }
	                    },
	                    complete: function() {
	                        that.xhr = null;
	                    },
	                    error: function(xhr, data) {
	                        if (that.options.async.error) {
	                            that.options.async.error(that, xhr, data);
	                        }
	                    }
	                });
	            },

	            bindBodyEvents: function() {
	                if (_isBodyEventHandled) {
	                    return;
	                }
	                if (this.options.dismissible && this.getTrigger() === 'click') {
	                    $document.off('keyup.webui-popover').on('keyup.webui-popover', $.proxy(this.escapeHandler, this));
	                    $document.off('click.webui-popover touchend.webui-popover')
	                        .on('click.webui-popover touchend.webui-popover', $.proxy(this.bodyClickHandler, this));
	                } else if (this.getTrigger() === 'hover') {
	                    $document.off('touchend.webui-popover')
	                        .on('touchend.webui-popover', $.proxy(this.bodyClickHandler, this));
	                }
	            },

	            /* event handlers */
	            mouseenterHandler: function(e) {
	                var self = this;

	                if (e && this.options.selector) {
	                    self = this.delegate(e.currentTarget);
	                }

	                if (self._timeout) {
	                    clearTimeout(self._timeout);
	                }
	                self._enterTimeout = setTimeout(function() {
	                    if (!self.getTarget().is(':visible')) {
	                        self.show();
	                    }
	                }, this.getDelayShow());
	            },
	            mouseleaveHandler: function() {
	                var self = this;
	                clearTimeout(self._enterTimeout);
	                //key point, set the _timeout  then use clearTimeout when mouse leave
	                self._timeout = setTimeout(function() {
	                    self.hide();
	                }, this.getHideDelay());
	            },
	            escapeHandler: function(e) {
	                if (e.keyCode === 27) {
	                    this.hideAll();
	                }
	            },

	            bodyClickHandler: function(e) {
	                _isBodyEventHandled = true;
	                var canHide = true;
	                for (var i = 0; i < _srcElements.length; i++) {
	                    var pop = getPopFromElement(_srcElements[i]);
	                    if (pop && pop._opened) {
	                        var offset = pop.getTarget().offset();
	                        var popX1 = offset.left;
	                        var popY1 = offset.top;
	                        var popX2 = offset.left + pop.getTarget().width();
	                        var popY2 = offset.top + pop.getTarget().height();
	                        var pt = pointerEventToXY(e);
	                        var inPop = pt.x >= popX1 && pt.x <= popX2 && pt.y >= popY1 && pt.y <= popY2;
	                        if (inPop) {
	                            canHide = false;
	                            break;
	                        }
	                    }
	                }
	                if (canHide) {
	                    hideAllPop();
	                }
	            },

	            /*
	            targetClickHandler: function() {
	                this._targetclick = true;
	            },
	            */

	            //reset and init the target events;
	            initTargetEvents: function() {
	                if (this.getTrigger() === 'hover') {
	                    this.$target
	                        .off('mouseenter mouseleave')
	                        .on('mouseenter', $.proxy(this.mouseenterHandler, this))
	                        .on('mouseleave', $.proxy(this.mouseleaveHandler, this));
	                }
	                this.$target.find('.close').off('click').on('click', $.proxy(this.hide, this, true));
	                //this.$target.off('click.webui-popover').on('click.webui-popover', $.proxy(this.targetClickHandler, this));
	            },
	            /* utils methods */
	            //caculate placement of the popover
	            getPlacement: function(pos) {
	                var
	                    placement,
	                    container = this.options.container,
	                    clientWidth = container.innerWidth(),
	                    clientHeight = container.innerHeight(),
	                    scrollTop = container.scrollTop(),
	                    scrollLeft = container.scrollLeft(),
	                    pageX = Math.max(0, pos.left - scrollLeft),
	                    pageY = Math.max(0, pos.top - scrollTop);
	                //arrowSize = 20;

	                //if placement equals auto，caculate the placement by element information;
	                if (typeof(this.options.placement) === 'function') {
	                    placement = this.options.placement.call(this, this.getTarget()[0], this.$element[0]);
	                } else {
	                    placement = this.$element.data('placement') || this.options.placement;
	                }

	                var isH = placement === 'horizontal';
	                var isV = placement === 'vertical';
	                var detect = placement === 'auto' || isH || isV;

	                if (detect) {
	                    if (pageX < clientWidth / 3) {
	                        if (pageY < clientHeight / 3) {
	                            placement = isH ? 'right-bottom' : 'bottom-right';
	                        } else if (pageY < clientHeight * 2 / 3) {
	                            if (isV) {
	                                placement = pageY <= clientHeight / 2 ? 'bottom-right' : 'top-right';
	                            } else {
	                                placement = 'right';
	                            }
	                        } else {
	                            placement = isH ? 'right-top' : 'top-right';
	                        }
	                        //placement= pageY>targetHeight+arrowSize?'top-right':'bottom-right';
	                    } else if (pageX < clientWidth * 2 / 3) {
	                        if (pageY < clientHeight / 3) {
	                            if (isH) {
	                                placement = pageX <= clientWidth / 2 ? 'right-bottom' : 'left-bottom';
	                            } else {
	                                placement = 'bottom';
	                            }
	                        } else if (pageY < clientHeight * 2 / 3) {
	                            if (isH) {
	                                placement = pageX <= clientWidth / 2 ? 'right' : 'left';
	                            } else {
	                                placement = pageY <= clientHeight / 2 ? 'bottom' : 'top';
	                            }
	                        } else {
	                            if (isH) {
	                                placement = pageX <= clientWidth / 2 ? 'right-top' : 'left-top';
	                            } else {
	                                placement = 'top';
	                            }
	                        }
	                    } else {
	                        //placement = pageY>targetHeight+arrowSize?'top-left':'bottom-left';
	                        if (pageY < clientHeight / 3) {
	                            placement = isH ? 'left-bottom' : 'bottom-left';
	                        } else if (pageY < clientHeight * 2 / 3) {
	                            if (isV) {
	                                placement = pageY <= clientHeight / 2 ? 'bottom-left' : 'top-left';
	                            } else {
	                                placement = 'left';
	                            }
	                        } else {
	                            placement = isH ? 'left-top' : 'top-left';
	                        }
	                    }
	                } else if (placement === 'auto-top') {
	                    if (pageX < clientWidth / 3) {
	                        placement = 'top-right';
	                    } else if (pageX < clientWidth * 2 / 3) {
	                        placement = 'top';
	                    } else {
	                        placement = 'top-left';
	                    }
	                } else if (placement === 'auto-bottom') {
	                    if (pageX < clientWidth / 3) {
	                        placement = 'bottom-right';
	                    } else if (pageX < clientWidth * 2 / 3) {
	                        placement = 'bottom';
	                    } else {
	                        placement = 'bottom-left';
	                    }
	                } else if (placement === 'auto-left') {
	                    if (pageY < clientHeight / 3) {
	                        placement = 'left-top';
	                    } else if (pageY < clientHeight * 2 / 3) {
	                        placement = 'left';
	                    } else {
	                        placement = 'left-bottom';
	                    }
	                } else if (placement === 'auto-right') {
	                    if (pageY < clientHeight / 3) {
	                        placement = 'right-bottom';
	                    } else if (pageY < clientHeight * 2 / 3) {
	                        placement = 'right';
	                    } else {
	                        placement = 'right-top';
	                    }
	                }
	                return placement;
	            },
	            getElementPosition: function() {
	                // If the container is the body or normal conatiner, just use $element.offset()
	                var elRect = this.$element[0].getBoundingClientRect();
	                var container = this.options.container;
	                var cssPos = container.css('position');

	                if (container.is(document.body) || cssPos === 'static') {
	                    return $.extend({}, this.$element.offset(), {
	                        width: this.$element[0].offsetWidth || elRect.width,
	                        height: this.$element[0].offsetHeight || elRect.height
	                    });
	                    // Else fixed container need recalculate the  position
	                } else if (cssPos === 'fixed') {
	                    var containerRect = container[0].getBoundingClientRect();
	                    return {
	                        top: elRect.top - containerRect.top + container.scrollTop(),
	                        left: elRect.left - containerRect.left + container.scrollLeft(),
	                        width: elRect.width,
	                        height: elRect.height
	                    };
	                } else if (cssPos === 'relative') {
	                    return {
	                        top: this.$element.offset().top - container.offset().top,
	                        left: this.$element.offset().left - container.offset().left,
	                        width: this.$element[0].offsetWidth || elRect.width,
	                        height: this.$element[0].offsetHeight || elRect.height
	                    };
	                }
	            },

	            getTargetPositin: function(elementPos, placement, targetWidth, targetHeight) {
	                var pos = elementPos,
	                    container = this.options.container,
	                    //clientWidth = container.innerWidth(),
	                    //clientHeight = container.innerHeight(),
	                    elementW = this.$element.outerWidth(),
	                    elementH = this.$element.outerHeight(),
	                    scrollTop = document.documentElement.scrollTop + container.scrollTop(),
	                    scrollLeft = document.documentElement.scrollLeft + container.scrollLeft(),
	                    position = {},
	                    arrowOffset = null,
	                    arrowSize = this.options.arrow ? 20 : 0,
	                    padding = 10,
	                    fixedW = elementW < arrowSize + padding ? arrowSize : 0,
	                    fixedH = elementH < arrowSize + padding ? arrowSize : 0,
	                    refix = 0,
	                    pageH = document.documentElement.clientHeight + scrollTop,
	                    pageW = document.documentElement.clientWidth + scrollLeft;

	                var validLeft = pos.left + pos.width / 2 - fixedW > 0;
	                var validRight = pos.left + pos.width / 2 + fixedW < pageW;
	                var validTop = pos.top + pos.height / 2 - fixedH > 0;
	                var validBottom = pos.top + pos.height / 2 + fixedH < pageH;


	                switch (placement) {
	                    case 'bottom':
	                        position = {
	                            top: pos.top + pos.height,
	                            left: pos.left + pos.width / 2 - targetWidth / 2
	                        };
	                        break;
	                    case 'top':
	                        position = {
	                            top: pos.top - targetHeight,
	                            left: pos.left + pos.width / 2 - targetWidth / 2
	                        };
	                        break;
	                    case 'left':
	                        position = {
	                            top: pos.top + pos.height / 2 - targetHeight / 2,
	                            left: pos.left - targetWidth
	                        };
	                        break;
	                    case 'right':
	                        position = {
	                            top: pos.top + pos.height / 2 - targetHeight / 2,
	                            left: pos.left + pos.width
	                        };
	                        break;
	                    case 'top-right':
	                        position = {
	                            top: pos.top - targetHeight,
	                            left: validLeft ? pos.left - fixedW : padding
	                        };
	                        arrowOffset = {
	                            left: validLeft ? Math.min(elementW, targetWidth) / 2 + fixedW : _offsetOut
	                        };
	                        break;
	                    case 'top-left':
	                        refix = validRight ? fixedW : -padding;
	                        position = {
	                            top: pos.top - targetHeight,
	                            left: pos.left - targetWidth + pos.width + refix
	                        };
	                        arrowOffset = {
	                            left: validRight ? targetWidth - Math.min(elementW, targetWidth) / 2 - fixedW : _offsetOut
	                        };
	                        break;
	                    case 'bottom-right':
	                        position = {
	                            top: pos.top + pos.height,
	                            left: validLeft ? pos.left - fixedW : padding
	                        };
	                        arrowOffset = {
	                            left: validLeft ? Math.min(elementW, targetWidth) / 2 + fixedW : _offsetOut
	                        };
	                        break;
	                    case 'bottom-left':
	                        refix = validRight ? fixedW : -padding;
	                        position = {
	                            top: pos.top + pos.height,
	                            left: pos.left - targetWidth + pos.width + refix
	                        };
	                        arrowOffset = {
	                            left: validRight ? targetWidth - Math.min(elementW, targetWidth) / 2 - fixedW : _offsetOut
	                        };
	                        break;
	                    case 'right-top':
	                        refix = validBottom ? fixedH : -padding;
	                        position = {
	                            top: pos.top - targetHeight + pos.height + refix,
	                            left: pos.left + pos.width
	                        };
	                        arrowOffset = {
	                            top: validBottom ? targetHeight - Math.min(elementH, targetHeight) / 2 - fixedH : _offsetOut
	                        };
	                        break;
	                    case 'right-bottom':
	                        position = {
	                            top: validTop ? pos.top - fixedH : padding,
	                            left: pos.left + pos.width
	                        };
	                        arrowOffset = {
	                            top: validTop ? Math.min(elementH, targetHeight) / 2 + fixedH : _offsetOut
	                        };
	                        break;
	                    case 'left-top':
	                        refix = validBottom ? fixedH : -padding;
	                        position = {
	                            top: pos.top - targetHeight + pos.height + refix,
	                            left: pos.left - targetWidth
	                        };
	                        arrowOffset = {
	                            top: validBottom ? targetHeight - Math.min(elementH, targetHeight) / 2 - fixedH : _offsetOut
	                        };
	                        break;
	                    case 'left-bottom':
	                        position = {
	                            top: validTop ? pos.top - fixedH : padding,
	                            left: pos.left - targetWidth
	                        };
	                        arrowOffset = {
	                            top: validTop ? Math.min(elementH, targetHeight) / 2 + fixedH : _offsetOut
	                        };
	                        break;

	                }
	                position.top += this.getOffsetTop();
	                position.left += this.getOffsetLeft();

	                return {
	                    position: position,
	                    arrowOffset: arrowOffset
	                };
	            }
	        };
	        $.fn[pluginName] = function(options, noInit) {
	            var results = [];
	            var $result = this.each(function() {

	                var webuiPopover = $.data(this, 'plugin_' + pluginName);
	                if (!webuiPopover) {
	                    if (!options) {
	                        webuiPopover = new WebuiPopover(this, null);
	                    } else if (typeof options === 'string') {
	                        if (options !== 'destroy') {
	                            if (!noInit) {
	                                webuiPopover = new WebuiPopover(this, null);
	                                results.push(webuiPopover[options]());
	                            }
	                        }
	                    } else if (typeof options === 'object') {
	                        webuiPopover = new WebuiPopover(this, options);
	                    }
	                    $.data(this, 'plugin_' + pluginName, webuiPopover);
	                } else {
	                    if (options === 'destroy') {
	                        webuiPopover.destroy();
	                    } else if (typeof options === 'string') {
	                        results.push(webuiPopover[options]());
	                    }
	                }
	            });
	            return (results.length) ? results : $result;
	        };

	        //Global object exposes to window.
	        var webuiPopovers = (function() {
	            var _hideAll = function() {
	                hideAllPop();
	            };
	            var _create = function(selector, options) {
	                options = options || {};
	                $(selector).webuiPopover(options);
	            };
	            var _isCreated = function(selector) {
	                var created = true;
	                $(selector).each(function(i, item) {
	                    created = created && $(item).data('plugin_' + pluginName) !== undefined;
	                });
	                return created;
	            };
	            var _show = function(selector, options) {
	                if (options) {
	                    $(selector).webuiPopover(options).webuiPopover('show');
	                } else {
	                    $(selector).webuiPopover('show');
	                }
	            };
	            var _hide = function(selector) {
	                $(selector).webuiPopover('hide');
	            };

	            var _setDefaultOptions = function(options) {
	                defaults = $.extend({}, defaults, options);
	            };

	            var _updateContent = function(selector, content) {
	                var pop = $(selector).data('plugin_' + pluginName);
	                if (pop) {
	                    var cache = pop.getCache();
	                    pop.options.cache = false;
	                    pop.options.content = content;
	                    if (pop._opened) {
	                        pop._opened = false;
	                        pop.show();
	                    } else {
	                        if (pop.isAsync()) {
	                            pop.setContentASync(content);
	                        } else {
	                            pop.setContent(content);
	                        }
	                    }
	                    pop.options.cache = cache;
	                }
	            };

	            var _updateContentAsync = function(selector, url) {
	                var pop = $(selector).data('plugin_' + pluginName);
	                if (pop) {
	                    var cache = pop.getCache();
	                    var type = pop.options.type;
	                    pop.options.cache = false;
	                    pop.options.url = url;

	                    if (pop._opened) {
	                        pop._opened = false;
	                        pop.show();
	                    } else {
	                        pop.options.type = 'async';
	                        pop.setContentASync(pop.content);
	                    }
	                    pop.options.cache = cache;
	                    pop.options.type = type;
	                }
	            };

	            return {
	                show: _show,
	                hide: _hide,
	                create: _create,
	                isCreated: _isCreated,
	                hideAll: _hideAll,
	                updateContent: _updateContent,
	                updateContentAsync: _updateContentAsync,
	                setDefaultOptions: _setDefaultOptions
	            };
	        })();
	        window.WebuiPopovers = webuiPopovers;
	    }));
	})(window, document);


/***/ },
/* 47 */
/***/ function(module, exports) {

	module.exports = jQuery;

/***/ },
/* 48 */
/***/ function(module, exports) {

	(function() {
	  var $, AbstractChosen, Chosen, SelectParser, _ref,
	    __hasProp = {}.hasOwnProperty,
	    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

	  SelectParser = (function() {
	    function SelectParser() {
	      this.options_index = 0;
	      this.parsed = [];
	    }

	    SelectParser.prototype.add_node = function(child) {
	      if (child.nodeName.toUpperCase() === "OPTGROUP") {
	        return this.add_group(child);
	      } else {
	        return this.add_option(child);
	      }
	    };

	    SelectParser.prototype.add_group = function(group) {
	      var group_position, option, _i, _len, _ref, _results;
	      group_position = this.parsed.length;
	      this.parsed.push({
	        array_index: group_position,
	        group: true,
	        label: this.escapeExpression(group.label),
	        title: group.title ? group.title : void 0,
	        children: 0,
	        disabled: group.disabled,
	        classes: group.className
	      });
	      _ref = group.childNodes;
	      _results = [];
	      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	        option = _ref[_i];
	        _results.push(this.add_option(option, group_position, group.disabled));
	      }
	      return _results;
	    };

	    SelectParser.prototype.add_option = function(option, group_position, group_disabled) {
	      if (option.nodeName.toUpperCase() === "OPTION") {
	        if (option.text !== "") {
	          if (group_position != null) {
	            this.parsed[group_position].children += 1;
	          }
	          this.parsed.push({
	            array_index: this.parsed.length,
	            options_index: this.options_index,
	            value: option.value,
	            text: option.text,
	            html: option.innerHTML,
	            title: option.title ? option.title : void 0,
	            selected: option.selected,
	            disabled: group_disabled === true ? group_disabled : option.disabled,
	            group_array_index: group_position,
	            group_label: group_position != null ? this.parsed[group_position].label : null,
	            classes: option.className,
	            style: option.style.cssText
	          });
	        } else {
	          this.parsed.push({
	            array_index: this.parsed.length,
	            options_index: this.options_index,
	            empty: true
	          });
	        }
	        return this.options_index += 1;
	      }
	    };

	    SelectParser.prototype.escapeExpression = function(text) {
	      var map, unsafe_chars;
	      if ((text == null) || text === false) {
	        return "";
	      }
	      if (!/[\&\<\>\"\'\`]/.test(text)) {
	        return text;
	      }
	      map = {
	        "<": "&lt;",
	        ">": "&gt;",
	        '"': "&quot;",
	        "'": "&#x27;",
	        "`": "&#x60;"
	      };
	      unsafe_chars = /&(?!\w+;)|[\<\>\"\'\`]/g;
	      return text.replace(unsafe_chars, function(chr) {
	        return map[chr] || "&amp;";
	      });
	    };

	    return SelectParser;

	  })();

	  SelectParser.select_to_array = function(select) {
	    var child, parser, _i, _len, _ref;
	    parser = new SelectParser();
	    _ref = select.childNodes;
	    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	      child = _ref[_i];
	      parser.add_node(child);
	    }
	    return parser.parsed;
	  };

	  AbstractChosen = (function() {
	    function AbstractChosen(form_field, options) {
	      this.form_field = form_field;
	      this.options = options != null ? options : {};
	      if (!AbstractChosen.browser_is_supported()) {
	        return;
	      }
	      this.is_multiple = this.form_field.multiple;
	      this.set_default_text();
	      this.set_default_values();
	      this.setup();
	      this.set_up_html();
	      this.register_observers();
	      this.on_ready();
	    }

	    AbstractChosen.prototype.set_default_values = function() {
	      var _this = this;
	      this.click_test_action = function(evt) {
	        return _this.test_active_click(evt);
	      };
	      this.activate_action = function(evt) {
	        return _this.activate_field(evt);
	      };
	      this.active_field = false;
	      this.mouse_on_container = false;
	      this.results_showing = false;
	      this.result_highlighted = null;
	      this.allow_single_deselect = (this.options.allow_single_deselect != null) && (this.form_field.options[0] != null) && this.form_field.options[0].text === "" ? this.options.allow_single_deselect : false;
	      this.disable_search_threshold = this.options.disable_search_threshold || 0;
	      this.disable_search = this.options.disable_search || false;
	      this.enable_split_word_search = this.options.enable_split_word_search != null ? this.options.enable_split_word_search : true;
	      this.group_search = this.options.group_search != null ? this.options.group_search : true;
	      this.search_contains = this.options.search_contains || false;
	      this.single_backstroke_delete = this.options.single_backstroke_delete != null ? this.options.single_backstroke_delete : true;
	      this.max_selected_options = this.options.max_selected_options || Infinity;
	      this.inherit_select_classes = this.options.inherit_select_classes || false;
	      this.display_selected_options = this.options.display_selected_options != null ? this.options.display_selected_options : true;
	      this.display_disabled_options = this.options.display_disabled_options != null ? this.options.display_disabled_options : true;
	      this.include_group_label_in_selected = this.options.include_group_label_in_selected || false;
	      this.max_shown_results = this.options.max_shown_results || Number.POSITIVE_INFINITY;
	      return this.case_sensitive_search = this.options.case_sensitive_search || false;
	    };

	    AbstractChosen.prototype.set_default_text = function() {
	      if (this.form_field.getAttribute("data-placeholder")) {
	        this.default_text = this.form_field.getAttribute("data-placeholder");
	      } else if (this.is_multiple) {
	        this.default_text = this.options.placeholder_text_multiple || this.options.placeholder_text || AbstractChosen.default_multiple_text;
	      } else {
	        this.default_text = this.options.placeholder_text_single || this.options.placeholder_text || AbstractChosen.default_single_text;
	      }
	      return this.results_none_found = this.form_field.getAttribute("data-no_results_text") || this.options.no_results_text || AbstractChosen.default_no_result_text;
	    };

	    AbstractChosen.prototype.choice_label = function(item) {
	      if (this.include_group_label_in_selected && (item.group_label != null)) {
	        return "<b class='group-name'>" + item.group_label + "</b>" + item.html;
	      } else {
	        return item.html;
	      }
	    };

	    AbstractChosen.prototype.mouse_enter = function() {
	      return this.mouse_on_container = true;
	    };

	    AbstractChosen.prototype.mouse_leave = function() {
	      return this.mouse_on_container = false;
	    };

	    AbstractChosen.prototype.input_focus = function(evt) {
	      var _this = this;
	      if (this.is_multiple) {
	        if (!this.active_field) {
	          return setTimeout((function() {
	            return _this.container_mousedown();
	          }), 50);
	        }
	      } else {
	        if (!this.active_field) {
	          return this.activate_field();
	        }
	      }
	    };

	    AbstractChosen.prototype.input_blur = function(evt) {
	      var _this = this;
	      if (!this.mouse_on_container) {
	        this.active_field = false;
	        return setTimeout((function() {
	          return _this.blur_test();
	        }), 100);
	      }
	    };

	    AbstractChosen.prototype.results_option_build = function(options) {
	      var content, data, data_content, shown_results, _i, _len, _ref;
	      content = '';
	      shown_results = 0;
	      _ref = this.results_data;
	      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	        data = _ref[_i];
	        data_content = '';
	        if (data.group) {
	          data_content = this.result_add_group(data);
	        } else {
	          data_content = this.result_add_option(data);
	        }
	        if (data_content !== '') {
	          shown_results++;
	          content += data_content;
	        }
	        if (options != null ? options.first : void 0) {
	          if (data.selected && this.is_multiple) {
	            this.choice_build(data);
	          } else if (data.selected && !this.is_multiple) {
	            this.single_set_selected_text(this.choice_label(data));
	          }
	        }
	        if (shown_results >= this.max_shown_results) {
	          break;
	        }
	      }
	      return content;
	    };

	    AbstractChosen.prototype.result_add_option = function(option) {
	      var classes, option_el;
	      if (!option.search_match) {
	        return '';
	      }
	      if (!this.include_option_in_results(option)) {
	        return '';
	      }
	      classes = [];
	      if (!option.disabled && !(option.selected && this.is_multiple)) {
	        classes.push("active-result");
	      }
	      if (option.disabled && !(option.selected && this.is_multiple)) {
	        classes.push("disabled-result");
	      }
	      if (option.selected) {
	        classes.push("result-selected");
	      }
	      if (option.group_array_index != null) {
	        classes.push("group-option");
	      }
	      if (option.classes !== "") {
	        classes.push(option.classes);
	      }
	      option_el = document.createElement("li");
	      option_el.className = classes.join(" ");
	      option_el.style.cssText = option.style;
	      option_el.setAttribute("data-option-array-index", option.array_index);
	      option_el.innerHTML = option.search_text;
	      if (option.title) {
	        option_el.title = option.title;
	      }
	      return this.outerHTML(option_el);
	    };

	    AbstractChosen.prototype.result_add_group = function(group) {
	      var classes, group_el;
	      if (!(group.search_match || group.group_match)) {
	        return '';
	      }
	      if (!(group.active_options > 0)) {
	        return '';
	      }
	      classes = [];
	      classes.push("group-result");
	      if (group.classes) {
	        classes.push(group.classes);
	      }
	      group_el = document.createElement("li");
	      group_el.className = classes.join(" ");
	      group_el.innerHTML = group.search_text;
	      if (group.title) {
	        group_el.title = group.title;
	      }
	      return this.outerHTML(group_el);
	    };

	    AbstractChosen.prototype.results_update_field = function() {
	      this.set_default_text();
	      if (!this.is_multiple) {
	        this.results_reset_cleanup();
	      }
	      this.result_clear_highlight();
	      this.results_build();
	      if (this.results_showing) {
	        return this.winnow_results();
	      }
	    };

	    AbstractChosen.prototype.reset_single_select_options = function() {
	      var result, _i, _len, _ref, _results;
	      _ref = this.results_data;
	      _results = [];
	      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	        result = _ref[_i];
	        if (result.selected) {
	          _results.push(result.selected = false);
	        } else {
	          _results.push(void 0);
	        }
	      }
	      return _results;
	    };

	    AbstractChosen.prototype.results_toggle = function() {
	      if (this.results_showing) {
	        return this.results_hide();
	      } else {
	        return this.results_show();
	      }
	    };

	    AbstractChosen.prototype.results_search = function(evt) {
	      if (this.results_showing) {
	        return this.winnow_results();
	      } else {
	        return this.results_show();
	      }
	    };

	    AbstractChosen.prototype.winnow_results = function() {
	      var escapedSearchText, option, regex, results, results_group, searchText, startpos, text, zregex, _i, _len, _ref;
	      this.no_results_clear();
	      results = 0;
	      searchText = this.get_search_text();
	      escapedSearchText = searchText.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
	      zregex = new RegExp(escapedSearchText, 'i');
	      regex = this.get_search_regex(escapedSearchText);
	      _ref = this.results_data;
	      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	        option = _ref[_i];
	        option.search_match = false;
	        results_group = null;
	        if (this.include_option_in_results(option)) {
	          if (option.group) {
	            option.group_match = false;
	            option.active_options = 0;
	          }
	          if ((option.group_array_index != null) && this.results_data[option.group_array_index]) {
	            results_group = this.results_data[option.group_array_index];
	            if (results_group.active_options === 0 && results_group.search_match) {
	              results += 1;
	            }
	            results_group.active_options += 1;
	          }
	          option.search_text = option.group ? option.label : option.html;
	          if (!(option.group && !this.group_search)) {
	            option.search_match = this.search_string_match(option.search_text, regex);
	            if (option.search_match && !option.group) {
	              results += 1;
	            }
	            if (option.search_match) {
	              if (searchText.length) {
	                startpos = option.search_text.search(zregex);
	                text = option.search_text.substr(0, startpos + searchText.length) + '</em>' + option.search_text.substr(startpos + searchText.length);
	                option.search_text = text.substr(0, startpos) + '<em>' + text.substr(startpos);
	              }
	              if (results_group != null) {
	                results_group.group_match = true;
	              }
	            } else if ((option.group_array_index != null) && this.results_data[option.group_array_index].search_match) {
	              option.search_match = true;
	            }
	          }
	        }
	      }
	      this.result_clear_highlight();
	      if (results < 1 && searchText.length) {
	        this.update_results_content("");
	        return this.no_results(searchText);
	      } else {
	        this.update_results_content(this.results_option_build());
	        return this.winnow_results_set_highlight();
	      }
	    };

	    AbstractChosen.prototype.get_search_regex = function(escaped_search_string) {
	      var regex_anchor, regex_flag;
	      regex_anchor = this.search_contains ? "" : "^";
	      regex_flag = this.case_sensitive_search ? "" : "i";
	      return new RegExp(regex_anchor + escaped_search_string, regex_flag);
	    };

	    AbstractChosen.prototype.search_string_match = function(search_string, regex) {
	      var part, parts, _i, _len;
	      if (regex.test(search_string)) {
	        return true;
	      } else if (this.enable_split_word_search && (search_string.indexOf(" ") >= 0 || search_string.indexOf("[") === 0)) {
	        parts = search_string.replace(/\[|\]/g, "").split(" ");
	        if (parts.length) {
	          for (_i = 0, _len = parts.length; _i < _len; _i++) {
	            part = parts[_i];
	            if (regex.test(part)) {
	              return true;
	            }
	          }
	        }
	      }
	    };

	    AbstractChosen.prototype.choices_count = function() {
	      var option, _i, _len, _ref;
	      if (this.selected_option_count != null) {
	        return this.selected_option_count;
	      }
	      this.selected_option_count = 0;
	      _ref = this.form_field.options;
	      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
	        option = _ref[_i];
	        if (option.selected) {
	          this.selected_option_count += 1;
	        }
	      }
	      return this.selected_option_count;
	    };

	    AbstractChosen.prototype.choices_click = function(evt) {
	      evt.preventDefault();
	      if (!(this.results_showing || this.is_disabled)) {
	        return this.results_show();
	      }
	    };

	    AbstractChosen.prototype.keyup_checker = function(evt) {
	      var stroke, _ref;
	      stroke = (_ref = evt.which) != null ? _ref : evt.keyCode;
	      this.search_field_scale();
	      switch (stroke) {
	        case 8:
	          if (this.is_multiple && this.backstroke_length < 1 && this.choices_count() > 0) {
	            return this.keydown_backstroke();
	          } else if (!this.pending_backstroke) {
	            this.result_clear_highlight();
	            return this.results_search();
	          }
	          break;
	        case 13:
	          evt.preventDefault();
	          if (this.results_showing) {
	            return this.result_select(evt);
	          }
	          break;
	        case 27:
	          if (this.results_showing) {
	            this.results_hide();
	          }
	          return true;
	        case 9:
	        case 38:
	        case 40:
	        case 16:
	        case 91:
	        case 17:
	        case 18:
	          break;
	        default:
	          return this.results_search();
	      }
	    };

	    AbstractChosen.prototype.clipboard_event_checker = function(evt) {
	      var _this = this;
	      return setTimeout((function() {
	        return _this.results_search();
	      }), 50);
	    };

	    AbstractChosen.prototype.container_width = function() {
	      if (this.options.width != null) {
	        return this.options.width;
	      } else {
	        return "" + this.form_field.offsetWidth + "px";
	      }
	    };

	    AbstractChosen.prototype.include_option_in_results = function(option) {
	      if (this.is_multiple && (!this.display_selected_options && option.selected)) {
	        return false;
	      }
	      if (!this.display_disabled_options && option.disabled) {
	        return false;
	      }
	      if (option.empty) {
	        return false;
	      }
	      return true;
	    };

	    AbstractChosen.prototype.search_results_touchstart = function(evt) {
	      this.touch_started = true;
	      return this.search_results_mouseover(evt);
	    };

	    AbstractChosen.prototype.search_results_touchmove = function(evt) {
	      this.touch_started = false;
	      return this.search_results_mouseout(evt);
	    };

	    AbstractChosen.prototype.search_results_touchend = function(evt) {
	      if (this.touch_started) {
	        return this.search_results_mouseup(evt);
	      }
	    };

	    AbstractChosen.prototype.outerHTML = function(element) {
	      var tmp;
	      if (element.outerHTML) {
	        return element.outerHTML;
	      }
	      tmp = document.createElement("div");
	      tmp.appendChild(element);
	      return tmp.innerHTML;
	    };

	    AbstractChosen.browser_is_supported = function() {
	      if ("Microsoft Internet Explorer" === window.navigator.appName) {
	        return document.documentMode >= 8;
	      }
	      if (/iP(od|hone)/i.test(window.navigator.userAgent) || /IEMobile/i.test(window.navigator.userAgent) || /Windows Phone/i.test(window.navigator.userAgent) || /BlackBerry/i.test(window.navigator.userAgent) || /BB10/i.test(window.navigator.userAgent) || /Android.*Mobile/i.test(window.navigator.userAgent)) {
	        return false;
	      }
	      return true;
	    };

	    AbstractChosen.default_multiple_text = "Select Some Options";

	    AbstractChosen.default_single_text = "Select an Option";

	    AbstractChosen.default_no_result_text = "No results match";

	    return AbstractChosen;

	  })();

	  $ = jQuery;

	  $.fn.extend({
	    chosen: function(options) {
	      if (!AbstractChosen.browser_is_supported()) {
	        return this;
	      }
	      return this.each(function(input_field) {
	        var $this, chosen;
	        $this = $(this);
	        chosen = $this.data('chosen');
	        if (options === 'destroy') {
	          if (chosen instanceof Chosen) {
	            chosen.destroy();
	          }
	          return;
	        }
	        if (!(chosen instanceof Chosen)) {
	          $this.data('chosen', new Chosen(this, options));
	        }
	      });
	    }
	  });

	  Chosen = (function(_super) {
	    __extends(Chosen, _super);

	    function Chosen() {
	      _ref = Chosen.__super__.constructor.apply(this, arguments);
	      return _ref;
	    }

	    Chosen.prototype.setup = function() {
	      this.form_field_jq = $(this.form_field);
	      this.current_selectedIndex = this.form_field.selectedIndex;
	      return this.is_rtl = this.form_field_jq.hasClass("chosen-rtl");
	    };

	    Chosen.prototype.set_up_html = function() {
	      var container_classes, container_props;
	      container_classes = ["chosen-container"];
	      container_classes.push("chosen-container-" + (this.is_multiple ? "multi" : "single"));
	      if (this.inherit_select_classes && this.form_field.className) {
	        container_classes.push(this.form_field.className);
	      }
	      if (this.is_rtl) {
	        container_classes.push("chosen-rtl");
	      }
	      container_props = {
	        'class': container_classes.join(' '),
	        'style': "width: " + (this.container_width()) + ";",
	        'title': this.form_field.title
	      };
	      if (this.form_field.id.length) {
	        container_props.id = this.form_field.id.replace(/[^\w]/g, '_') + "_chosen";
	      }
	      this.container = $("<div />", container_props);
	      if (this.is_multiple) {
	        this.container.html('<ul class="chosen-choices"><li class="search-field"><input type="text" value="' + this.default_text + '" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chosen-drop"><ul class="chosen-results"></ul></div>');
	      } else {
	        this.container.html('<a class="chosen-single chosen-default"><span>' + this.default_text + '</span><div><b></b></div></a><div class="chosen-drop"><div class="chosen-search"><input type="text" autocomplete="off" /></div><ul class="chosen-results"></ul></div>');
	      }
	      this.form_field_jq.hide().after(this.container);
	      this.dropdown = this.container.find('div.chosen-drop').first();
	      this.search_field = this.container.find('input').first();
	      this.search_results = this.container.find('ul.chosen-results').first();
	      this.search_field_scale();
	      this.search_no_results = this.container.find('li.no-results').first();
	      if (this.is_multiple) {
	        this.search_choices = this.container.find('ul.chosen-choices').first();
	        this.search_container = this.container.find('li.search-field').first();
	      } else {
	        this.search_container = this.container.find('div.chosen-search').first();
	        this.selected_item = this.container.find('.chosen-single').first();
	      }
	      this.results_build();
	      this.set_tab_index();
	      return this.set_label_behavior();
	    };

	    Chosen.prototype.on_ready = function() {
	      return this.form_field_jq.trigger("chosen:ready", {
	        chosen: this
	      });
	    };

	    Chosen.prototype.register_observers = function() {
	      var _this = this;
	      this.container.bind('touchstart.chosen', function(evt) {
	        _this.container_mousedown(evt);
	        return evt.preventDefault();
	      });
	      this.container.bind('touchend.chosen', function(evt) {
	        _this.container_mouseup(evt);
	        return evt.preventDefault();
	      });
	      this.container.bind('mousedown.chosen', function(evt) {
	        _this.container_mousedown(evt);
	      });
	      this.container.bind('mouseup.chosen', function(evt) {
	        _this.container_mouseup(evt);
	      });
	      this.container.bind('mouseenter.chosen', function(evt) {
	        _this.mouse_enter(evt);
	      });
	      this.container.bind('mouseleave.chosen', function(evt) {
	        _this.mouse_leave(evt);
	      });
	      this.search_results.bind('mouseup.chosen', function(evt) {
	        _this.search_results_mouseup(evt);
	      });
	      this.search_results.bind('mouseover.chosen', function(evt) {
	        _this.search_results_mouseover(evt);
	      });
	      this.search_results.bind('mouseout.chosen', function(evt) {
	        _this.search_results_mouseout(evt);
	      });
	      this.search_results.bind('mousewheel.chosen DOMMouseScroll.chosen', function(evt) {
	        _this.search_results_mousewheel(evt);
	      });
	      this.search_results.bind('touchstart.chosen', function(evt) {
	        _this.search_results_touchstart(evt);
	      });
	      this.search_results.bind('touchmove.chosen', function(evt) {
	        _this.search_results_touchmove(evt);
	      });
	      this.search_results.bind('touchend.chosen', function(evt) {
	        _this.search_results_touchend(evt);
	      });
	      this.form_field_jq.bind("chosen:updated.chosen", function(evt) {
	        _this.results_update_field(evt);
	      });
	      this.form_field_jq.bind("chosen:activate.chosen", function(evt) {
	        _this.activate_field(evt);
	      });
	      this.form_field_jq.bind("chosen:open.chosen", function(evt) {
	        _this.container_mousedown(evt);
	      });
	      this.form_field_jq.bind("chosen:close.chosen", function(evt) {
	        _this.input_blur(evt);
	      });
	      this.search_field.bind('blur.chosen', function(evt) {
	        _this.input_blur(evt);
	      });
	      this.search_field.bind('keyup.chosen', function(evt) {
	        _this.keyup_checker(evt);
	      });
	      this.search_field.bind('keydown.chosen', function(evt) {
	        _this.keydown_checker(evt);
	      });
	      this.search_field.bind('focus.chosen', function(evt) {
	        _this.input_focus(evt);
	      });
	      this.search_field.bind('cut.chosen', function(evt) {
	        _this.clipboard_event_checker(evt);
	      });
	      this.search_field.bind('paste.chosen', function(evt) {
	        _this.clipboard_event_checker(evt);
	      });
	      if (this.is_multiple) {
	        return this.search_choices.bind('click.chosen', function(evt) {
	          _this.choices_click(evt);
	        });
	      } else {
	        return this.container.bind('click.chosen', function(evt) {
	          evt.preventDefault();
	        });
	      }
	    };

	    Chosen.prototype.destroy = function() {
	      $(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action);
	      if (this.search_field[0].tabIndex) {
	        this.form_field_jq[0].tabIndex = this.search_field[0].tabIndex;
	      }
	      this.container.remove();
	      this.form_field_jq.removeData('chosen');
	      return this.form_field_jq.show();
	    };

	    Chosen.prototype.search_field_disabled = function() {
	      this.is_disabled = this.form_field_jq[0].disabled;
	      if (this.is_disabled) {
	        this.container.addClass('chosen-disabled');
	        this.search_field[0].disabled = true;
	        if (!this.is_multiple) {
	          this.selected_item.unbind("focus.chosen", this.activate_action);
	        }
	        return this.close_field();
	      } else {
	        this.container.removeClass('chosen-disabled');
	        this.search_field[0].disabled = false;
	        if (!this.is_multiple) {
	          return this.selected_item.bind("focus.chosen", this.activate_action);
	        }
	      }
	    };

	    Chosen.prototype.container_mousedown = function(evt) {
	      if (!this.is_disabled) {
	        if (evt && evt.type === "mousedown" && !this.results_showing) {
	          evt.preventDefault();
	        }
	        if (!((evt != null) && ($(evt.target)).hasClass("search-choice-close"))) {
	          if (!this.active_field) {
	            if (this.is_multiple) {
	              this.search_field.val("");
	            }
	            $(this.container[0].ownerDocument).bind('click.chosen', this.click_test_action);
	            this.results_show();
	          } else if (!this.is_multiple && evt && (($(evt.target)[0] === this.selected_item[0]) || $(evt.target).parents("a.chosen-single").length)) {
	            evt.preventDefault();
	            this.results_toggle();
	          }
	          return this.activate_field();
	        }
	      }
	    };

	    Chosen.prototype.container_mouseup = function(evt) {
	      if (evt.target.nodeName === "ABBR" && !this.is_disabled) {
	        return this.results_reset(evt);
	      }
	    };

	    Chosen.prototype.search_results_mousewheel = function(evt) {
	      var delta;
	      if (evt.originalEvent) {
	        delta = evt.originalEvent.deltaY || -evt.originalEvent.wheelDelta || evt.originalEvent.detail;
	      }
	      if (delta != null) {
	        evt.preventDefault();
	        if (evt.type === 'DOMMouseScroll') {
	          delta = delta * 40;
	        }
	        return this.search_results.scrollTop(delta + this.search_results.scrollTop());
	      }
	    };

	    Chosen.prototype.blur_test = function(evt) {
	      if (!this.active_field && this.container.hasClass("chosen-container-active")) {
	        return this.close_field();
	      }
	    };

	    Chosen.prototype.close_field = function() {
	      $(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action);
	      this.active_field = false;
	      this.results_hide();
	      this.container.removeClass("chosen-container-active");
	      this.clear_backstroke();
	      this.show_search_field_default();
	      return this.search_field_scale();
	    };

	    Chosen.prototype.activate_field = function() {
	      this.container.addClass("chosen-container-active");
	      this.active_field = true;
	      this.search_field.val(this.search_field.val());
	      return this.search_field.focus();
	    };

	    Chosen.prototype.test_active_click = function(evt) {
	      var active_container;
	      active_container = $(evt.target).closest('.chosen-container');
	      if (active_container.length && this.container[0] === active_container[0]) {
	        return this.active_field = true;
	      } else {
	        return this.close_field();
	      }
	    };

	    Chosen.prototype.results_build = function() {
	      this.parsing = true;
	      this.selected_option_count = null;
	      this.results_data = SelectParser.select_to_array(this.form_field);
	      if (this.is_multiple) {
	        this.search_choices.find("li.search-choice").remove();
	      } else if (!this.is_multiple) {
	        this.single_set_selected_text();
	        if (this.disable_search || this.form_field.options.length <= this.disable_search_threshold) {
	          this.search_field[0].readOnly = true;
	          this.container.addClass("chosen-container-single-nosearch");
	        } else {
	          this.search_field[0].readOnly = false;
	          this.container.removeClass("chosen-container-single-nosearch");
	        }
	      }
	      this.update_results_content(this.results_option_build({
	        first: true
	      }));
	      this.search_field_disabled();
	      this.show_search_field_default();
	      this.search_field_scale();
	      return this.parsing = false;
	    };

	    Chosen.prototype.result_do_highlight = function(el) {
	      var high_bottom, high_top, maxHeight, visible_bottom, visible_top;
	      if (el.length) {
	        this.result_clear_highlight();
	        this.result_highlight = el;
	        this.result_highlight.addClass("highlighted");
	        maxHeight = parseInt(this.search_results.css("maxHeight"), 10);
	        visible_top = this.search_results.scrollTop();
	        visible_bottom = maxHeight + visible_top;
	        high_top = this.result_highlight.position().top + this.search_results.scrollTop();
	        high_bottom = high_top + this.result_highlight.outerHeight();
	        if (high_bottom >= visible_bottom) {
	          return this.search_results.scrollTop((high_bottom - maxHeight) > 0 ? high_bottom - maxHeight : 0);
	        } else if (high_top < visible_top) {
	          return this.search_results.scrollTop(high_top);
	        }
	      }
	    };

	    Chosen.prototype.result_clear_highlight = function() {
	      if (this.result_highlight) {
	        this.result_highlight.removeClass("highlighted");
	      }
	      return this.result_highlight = null;
	    };

	    Chosen.prototype.results_show = function() {
	      if (this.is_multiple && this.max_selected_options <= this.choices_count()) {
	        this.form_field_jq.trigger("chosen:maxselected", {
	          chosen: this
	        });
	        return false;
	      }
	      this.container.addClass("chosen-with-drop");
	      this.results_showing = true;
	      this.search_field.focus();
	      this.search_field.val(this.search_field.val());
	      this.winnow_results();
	      return this.form_field_jq.trigger("chosen:showing_dropdown", {
	        chosen: this
	      });
	    };

	    Chosen.prototype.update_results_content = function(content) {
	      return this.search_results.html(content);
	    };

	    Chosen.prototype.results_hide = function() {
	      if (this.results_showing) {
	        this.result_clear_highlight();
	        this.container.removeClass("chosen-with-drop");
	        this.form_field_jq.trigger("chosen:hiding_dropdown", {
	          chosen: this
	        });
	      }
	      return this.results_showing = false;
	    };

	    Chosen.prototype.set_tab_index = function(el) {
	      var ti;
	      if (this.form_field.tabIndex) {
	        ti = this.form_field.tabIndex;
	        this.form_field.tabIndex = -1;
	        return this.search_field[0].tabIndex = ti;
	      }
	    };

	    Chosen.prototype.set_label_behavior = function() {
	      var _this = this;
	      this.form_field_label = this.form_field_jq.parents("label");
	      if (!this.form_field_label.length && this.form_field.id.length) {
	        this.form_field_label = $("label[for='" + this.form_field.id + "']");
	      }
	      if (this.form_field_label.length > 0) {
	        return this.form_field_label.bind('click.chosen', function(evt) {
	          if (_this.is_multiple) {
	            return _this.container_mousedown(evt);
	          } else {
	            return _this.activate_field();
	          }
	        });
	      }
	    };

	    Chosen.prototype.show_search_field_default = function() {
	      if (this.is_multiple && this.choices_count() < 1 && !this.active_field) {
	        this.search_field.val(this.default_text);
	        return this.search_field.addClass("default");
	      } else {
	        this.search_field.val("");
	        return this.search_field.removeClass("default");
	      }
	    };

	    Chosen.prototype.search_results_mouseup = function(evt) {
	      var target;
	      target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
	      if (target.length) {
	        this.result_highlight = target;
	        this.result_select(evt);
	        return this.search_field.focus();
	      }
	    };

	    Chosen.prototype.search_results_mouseover = function(evt) {
	      var target;
	      target = $(evt.target).hasClass("active-result") ? $(evt.target) : $(evt.target).parents(".active-result").first();
	      if (target) {
	        return this.result_do_highlight(target);
	      }
	    };

	    Chosen.prototype.search_results_mouseout = function(evt) {
	      if ($(evt.target).hasClass("active-result" || $(evt.target).parents('.active-result').first())) {
	        return this.result_clear_highlight();
	      }
	    };

	    Chosen.prototype.choice_build = function(item) {
	      var choice, close_link,
	        _this = this;
	      choice = $('<li />', {
	        "class": "search-choice"
	      }).html("<span>" + (this.choice_label(item)) + "</span>");
	      if (item.disabled) {
	        choice.addClass('search-choice-disabled');
	      } else {
	        close_link = $('<a />', {
	          "class": 'search-choice-close',
	          'data-option-array-index': item.array_index
	        });
	        close_link.bind('click.chosen', function(evt) {
	          return _this.choice_destroy_link_click(evt);
	        });
	        choice.append(close_link);
	      }
	      return this.search_container.before(choice);
	    };

	    Chosen.prototype.choice_destroy_link_click = function(evt) {
	      evt.preventDefault();
	      evt.stopPropagation();
	      if (!this.is_disabled) {
	        return this.choice_destroy($(evt.target));
	      }
	    };

	    Chosen.prototype.choice_destroy = function(link) {
	      if (this.result_deselect(link[0].getAttribute("data-option-array-index"))) {
	        this.show_search_field_default();
	        if (this.is_multiple && this.choices_count() > 0 && this.search_field.val().length < 1) {
	          this.results_hide();
	        }
	        link.parents('li').first().remove();
	        return this.search_field_scale();
	      }
	    };

	    Chosen.prototype.results_reset = function() {
	      this.reset_single_select_options();
	      this.form_field.options[0].selected = true;
	      this.single_set_selected_text();
	      this.show_search_field_default();
	      this.results_reset_cleanup();
	      this.form_field_jq.trigger("change");
	      if (this.active_field) {
	        return this.results_hide();
	      }
	    };

	    Chosen.prototype.results_reset_cleanup = function() {
	      this.current_selectedIndex = this.form_field.selectedIndex;
	      return this.selected_item.find("abbr").remove();
	    };

	    Chosen.prototype.result_select = function(evt) {
	      var high, item;
	      if (this.result_highlight) {
	        high = this.result_highlight;
	        this.result_clear_highlight();
	        if (this.is_multiple && this.max_selected_options <= this.choices_count()) {
	          this.form_field_jq.trigger("chosen:maxselected", {
	            chosen: this
	          });
	          return false;
	        }
	        if (this.is_multiple) {
	          high.removeClass("active-result");
	        } else {
	          this.reset_single_select_options();
	        }
	        high.addClass("result-selected");
	        item = this.results_data[high[0].getAttribute("data-option-array-index")];
	        item.selected = true;
	        this.form_field.options[item.options_index].selected = true;
	        this.selected_option_count = null;
	        if (this.is_multiple) {
	          this.choice_build(item);
	        } else {
	          this.single_set_selected_text(this.choice_label(item));
	        }
	        if (!((evt.metaKey || evt.ctrlKey) && this.is_multiple)) {
	          this.results_hide();
	        }
	        this.show_search_field_default();
	        if (this.is_multiple || this.form_field.selectedIndex !== this.current_selectedIndex) {
	          this.form_field_jq.trigger("change", {
	            'selected': this.form_field.options[item.options_index].value
	          });
	        }
	        this.current_selectedIndex = this.form_field.selectedIndex;
	        evt.preventDefault();
	        return this.search_field_scale();
	      }
	    };

	    Chosen.prototype.single_set_selected_text = function(text) {
	      if (text == null) {
	        text = this.default_text;
	      }
	      if (text === this.default_text) {
	        this.selected_item.addClass("chosen-default");
	      } else {
	        this.single_deselect_control_build();
	        this.selected_item.removeClass("chosen-default");
	      }
	      return this.selected_item.find("span").html(text);
	    };

	    Chosen.prototype.result_deselect = function(pos) {
	      var result_data;
	      result_data = this.results_data[pos];
	      if (!this.form_field.options[result_data.options_index].disabled) {
	        result_data.selected = false;
	        this.form_field.options[result_data.options_index].selected = false;
	        this.selected_option_count = null;
	        this.result_clear_highlight();
	        if (this.results_showing) {
	          this.winnow_results();
	        }
	        this.form_field_jq.trigger("change", {
	          deselected: this.form_field.options[result_data.options_index].value
	        });
	        this.search_field_scale();
	        return true;
	      } else {
	        return false;
	      }
	    };

	    Chosen.prototype.single_deselect_control_build = function() {
	      if (!this.allow_single_deselect) {
	        return;
	      }
	      if (!this.selected_item.find("abbr").length) {
	        this.selected_item.find("span").first().after("<abbr class=\"search-choice-close\"></abbr>");
	      }
	      return this.selected_item.addClass("chosen-single-with-deselect");
	    };

	    Chosen.prototype.get_search_text = function() {
	      return $('<div/>').text($.trim(this.search_field.val())).html();
	    };

	    Chosen.prototype.winnow_results_set_highlight = function() {
	      var do_high, selected_results;
	      selected_results = !this.is_multiple ? this.search_results.find(".result-selected.active-result") : [];
	      do_high = selected_results.length ? selected_results.first() : this.search_results.find(".active-result").first();
	      if (do_high != null) {
	        return this.result_do_highlight(do_high);
	      }
	    };

	    Chosen.prototype.no_results = function(terms) {
	      var no_results_html;
	      no_results_html = $('<li class="no-results">' + this.results_none_found + ' "<span></span>"</li>');
	      no_results_html.find("span").first().html(terms);
	      this.search_results.append(no_results_html);
	      return this.form_field_jq.trigger("chosen:no_results", {
	        chosen: this
	      });
	    };

	    Chosen.prototype.no_results_clear = function() {
	      return this.search_results.find(".no-results").remove();
	    };

	    Chosen.prototype.keydown_arrow = function() {
	      var next_sib;
	      if (this.results_showing && this.result_highlight) {
	        next_sib = this.result_highlight.nextAll("li.active-result").first();
	        if (next_sib) {
	          return this.result_do_highlight(next_sib);
	        }
	      } else {
	        return this.results_show();
	      }
	    };

	    Chosen.prototype.keyup_arrow = function() {
	      var prev_sibs;
	      if (!this.results_showing && !this.is_multiple) {
	        return this.results_show();
	      } else if (this.result_highlight) {
	        prev_sibs = this.result_highlight.prevAll("li.active-result");
	        if (prev_sibs.length) {
	          return this.result_do_highlight(prev_sibs.first());
	        } else {
	          if (this.choices_count() > 0) {
	            this.results_hide();
	          }
	          return this.result_clear_highlight();
	        }
	      }
	    };

	    Chosen.prototype.keydown_backstroke = function() {
	      var next_available_destroy;
	      if (this.pending_backstroke) {
	        this.choice_destroy(this.pending_backstroke.find("a").first());
	        return this.clear_backstroke();
	      } else {
	        next_available_destroy = this.search_container.siblings("li.search-choice").last();
	        if (next_available_destroy.length && !next_available_destroy.hasClass("search-choice-disabled")) {
	          this.pending_backstroke = next_available_destroy;
	          if (this.single_backstroke_delete) {
	            return this.keydown_backstroke();
	          } else {
	            return this.pending_backstroke.addClass("search-choice-focus");
	          }
	        }
	      }
	    };

	    Chosen.prototype.clear_backstroke = function() {
	      if (this.pending_backstroke) {
	        this.pending_backstroke.removeClass("search-choice-focus");
	      }
	      return this.pending_backstroke = null;
	    };

	    Chosen.prototype.keydown_checker = function(evt) {
	      var stroke, _ref1;
	      stroke = (_ref1 = evt.which) != null ? _ref1 : evt.keyCode;
	      this.search_field_scale();
	      if (stroke !== 8 && this.pending_backstroke) {
	        this.clear_backstroke();
	      }
	      switch (stroke) {
	        case 8:
	          this.backstroke_length = this.search_field.val().length;
	          break;
	        case 9:
	          if (this.results_showing && !this.is_multiple) {
	            this.result_select(evt);
	          }
	          this.mouse_on_container = false;
	          break;
	        case 13:
	          if (this.results_showing) {
	            evt.preventDefault();
	          }
	          break;
	        case 32:
	          if (this.disable_search) {
	            evt.preventDefault();
	          }
	          break;
	        case 38:
	          evt.preventDefault();
	          this.keyup_arrow();
	          break;
	        case 40:
	          evt.preventDefault();
	          this.keydown_arrow();
	          break;
	      }
	    };

	    Chosen.prototype.search_field_scale = function() {
	      var div, f_width, h, style, style_block, styles, w, _i, _len;
	      if (this.is_multiple) {
	        h = 0;
	        w = 0;
	        style_block = "position:absolute; left: -1000px; top: -1000px; display:none;";
	        styles = ['font-size', 'font-style', 'font-weight', 'font-family', 'line-height', 'text-transform', 'letter-spacing'];
	        for (_i = 0, _len = styles.length; _i < _len; _i++) {
	          style = styles[_i];
	          style_block += style + ":" + this.search_field.css(style) + ";";
	        }
	        div = $('<div />', {
	          'style': style_block
	        });
	        div.text(this.search_field.val());
	        $('body').append(div);
	        w = div.width() + 25;
	        div.remove();
	        f_width = this.container.outerWidth();
	        if (w > f_width - 10) {
	          w = f_width - 10;
	        }
	        return this.search_field.css({
	          'width': w + 'px'
	        });
	      }
	    };

	    return Chosen;

	  })(AbstractChosen);

	}).call(this);


/***/ },
/* 49 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/*
	     _ _      _       _
	 ___| (_) ___| | __  (_)___
	/ __| | |/ __| |/ /  | / __|
	\__ \ | | (__|   < _ | \__ \
	|___/_|_|\___|_|\_(_)/ |___/
	                   |__/

	 Version: 1.6.0
	  Author: Ken Wheeler
	 Website: http://kenwheeler.github.io
	    Docs: http://kenwheeler.github.io/slick
	    Repo: http://github.com/kenwheeler/slick
	  Issues: http://github.com/kenwheeler/slick/issues

	 */
	/* global window, document, define, jQuery, setInterval, clearInterval */
	(function(factory) {
	    'use strict';
	    if (true) {
	        !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(47)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory), __WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ? (__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	    } else if (typeof exports !== 'undefined') {
	        module.exports = factory(require('jquery'));
	    } else {
	        factory(jQuery);
	    }

	}(function($) {
	    'use strict';
	    var Slick = window.Slick || {};

	    Slick = (function() {

	        var instanceUid = 0;

	        function Slick(element, settings) {

	            var _ = this, dataSettings;

	            _.defaults = {
	                accessibility: true,
	                adaptiveHeight: false,
	                appendArrows: $(element),
	                appendDots: $(element),
	                arrows: true,
	                asNavFor: null,
	                prevArrow: '<button type="button" data-role="none" class="slick-prev" aria-label="Previous" tabindex="0" role="button">Previous</button>',
	                nextArrow: '<button type="button" data-role="none" class="slick-next" aria-label="Next" tabindex="0" role="button">Next</button>',
	                autoplay: false,
	                autoplaySpeed: 3000,
	                centerMode: false,
	                centerPadding: '50px',
	                cssEase: 'ease',
	                customPaging: function(slider, i) {
	                    return $('<button type="button" data-role="none" role="button" tabindex="0" />').text(i + 1);
	                },
	                dots: false,
	                dotsClass: 'slick-dots',
	                draggable: true,
	                easing: 'linear',
	                edgeFriction: 0.35,
	                fade: false,
	                focusOnSelect: false,
	                infinite: true,
	                initialSlide: 0,
	                lazyLoad: 'ondemand',
	                mobileFirst: false,
	                pauseOnHover: true,
	                pauseOnFocus: true,
	                pauseOnDotsHover: false,
	                respondTo: 'window',
	                responsive: null,
	                rows: 1,
	                rtl: false,
	                slide: '',
	                slidesPerRow: 1,
	                slidesToShow: 1,
	                slidesToScroll: 1,
	                speed: 500,
	                swipe: true,
	                swipeToSlide: false,
	                touchMove: true,
	                touchThreshold: 5,
	                useCSS: true,
	                useTransform: true,
	                variableWidth: false,
	                vertical: false,
	                verticalSwiping: false,
	                waitForAnimate: true,
	                zIndex: 1000
	            };

	            _.initials = {
	                animating: false,
	                dragging: false,
	                autoPlayTimer: null,
	                currentDirection: 0,
	                currentLeft: null,
	                currentSlide: 0,
	                direction: 1,
	                $dots: null,
	                listWidth: null,
	                listHeight: null,
	                loadIndex: 0,
	                $nextArrow: null,
	                $prevArrow: null,
	                slideCount: null,
	                slideWidth: null,
	                $slideTrack: null,
	                $slides: null,
	                sliding: false,
	                slideOffset: 0,
	                swipeLeft: null,
	                $list: null,
	                touchObject: {},
	                transformsEnabled: false,
	                unslicked: false
	            };

	            $.extend(_, _.initials);

	            _.activeBreakpoint = null;
	            _.animType = null;
	            _.animProp = null;
	            _.breakpoints = [];
	            _.breakpointSettings = [];
	            _.cssTransitions = false;
	            _.focussed = false;
	            _.interrupted = false;
	            _.hidden = 'hidden';
	            _.paused = true;
	            _.positionProp = null;
	            _.respondTo = null;
	            _.rowCount = 1;
	            _.shouldClick = true;
	            _.$slider = $(element);
	            _.$slidesCache = null;
	            _.transformType = null;
	            _.transitionType = null;
	            _.visibilityChange = 'visibilitychange';
	            _.windowWidth = 0;
	            _.windowTimer = null;

	            dataSettings = $(element).data('slick') || {};

	            _.options = $.extend({}, _.defaults, settings, dataSettings);

	            _.currentSlide = _.options.initialSlide;

	            _.originalSettings = _.options;

	            if (typeof document.mozHidden !== 'undefined') {
	                _.hidden = 'mozHidden';
	                _.visibilityChange = 'mozvisibilitychange';
	            } else if (typeof document.webkitHidden !== 'undefined') {
	                _.hidden = 'webkitHidden';
	                _.visibilityChange = 'webkitvisibilitychange';
	            }

	            _.autoPlay = $.proxy(_.autoPlay, _);
	            _.autoPlayClear = $.proxy(_.autoPlayClear, _);
	            _.autoPlayIterator = $.proxy(_.autoPlayIterator, _);
	            _.changeSlide = $.proxy(_.changeSlide, _);
	            _.clickHandler = $.proxy(_.clickHandler, _);
	            _.selectHandler = $.proxy(_.selectHandler, _);
	            _.setPosition = $.proxy(_.setPosition, _);
	            _.swipeHandler = $.proxy(_.swipeHandler, _);
	            _.dragHandler = $.proxy(_.dragHandler, _);
	            _.keyHandler = $.proxy(_.keyHandler, _);

	            _.instanceUid = instanceUid++;

	            // A simple way to check for HTML strings
	            // Strict HTML recognition (must start with <)
	            // Extracted from jQuery v1.11 source
	            _.htmlExpr = /^(?:\s*(<[\w\W]+>)[^>]*)$/;


	            _.registerBreakpoints();
	            _.init(true);

	        }

	        return Slick;

	    }());

	    Slick.prototype.activateADA = function() {
	        var _ = this;

	        _.$slideTrack.find('.slick-active').attr({
	            'aria-hidden': 'false'
	        }).find('a, input, button, select').attr({
	            'tabindex': '0'
	        });

	    };

	    Slick.prototype.addSlide = Slick.prototype.slickAdd = function(markup, index, addBefore) {

	        var _ = this;

	        if (typeof(index) === 'boolean') {
	            addBefore = index;
	            index = null;
	        } else if (index < 0 || (index >= _.slideCount)) {
	            return false;
	        }

	        _.unload();

	        if (typeof(index) === 'number') {
	            if (index === 0 && _.$slides.length === 0) {
	                $(markup).appendTo(_.$slideTrack);
	            } else if (addBefore) {
	                $(markup).insertBefore(_.$slides.eq(index));
	            } else {
	                $(markup).insertAfter(_.$slides.eq(index));
	            }
	        } else {
	            if (addBefore === true) {
	                $(markup).prependTo(_.$slideTrack);
	            } else {
	                $(markup).appendTo(_.$slideTrack);
	            }
	        }

	        _.$slides = _.$slideTrack.children(this.options.slide);

	        _.$slideTrack.children(this.options.slide).detach();

	        _.$slideTrack.append(_.$slides);

	        _.$slides.each(function(index, element) {
	            $(element).attr('data-slick-index', index);
	        });

	        _.$slidesCache = _.$slides;

	        _.reinit();

	    };

	    Slick.prototype.animateHeight = function() {
	        var _ = this;
	        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
	            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
	            _.$list.animate({
	                height: targetHeight
	            }, _.options.speed);
	        }
	    };

	    Slick.prototype.animateSlide = function(targetLeft, callback) {

	        var animProps = {},
	            _ = this;

	        _.animateHeight();

	        if (_.options.rtl === true && _.options.vertical === false) {
	            targetLeft = -targetLeft;
	        }
	        if (_.transformsEnabled === false) {
	            if (_.options.vertical === false) {
	                _.$slideTrack.animate({
	                    left: targetLeft
	                }, _.options.speed, _.options.easing, callback);
	            } else {
	                _.$slideTrack.animate({
	                    top: targetLeft
	                }, _.options.speed, _.options.easing, callback);
	            }

	        } else {

	            if (_.cssTransitions === false) {
	                if (_.options.rtl === true) {
	                    _.currentLeft = -(_.currentLeft);
	                }
	                $({
	                    animStart: _.currentLeft
	                }).animate({
	                    animStart: targetLeft
	                }, {
	                    duration: _.options.speed,
	                    easing: _.options.easing,
	                    step: function(now) {
	                        now = Math.ceil(now);
	                        if (_.options.vertical === false) {
	                            animProps[_.animType] = 'translate(' +
	                                now + 'px, 0px)';
	                            _.$slideTrack.css(animProps);
	                        } else {
	                            animProps[_.animType] = 'translate(0px,' +
	                                now + 'px)';
	                            _.$slideTrack.css(animProps);
	                        }
	                    },
	                    complete: function() {
	                        if (callback) {
	                            callback.call();
	                        }
	                    }
	                });

	            } else {

	                _.applyTransition();
	                targetLeft = Math.ceil(targetLeft);

	                if (_.options.vertical === false) {
	                    animProps[_.animType] = 'translate3d(' + targetLeft + 'px, 0px, 0px)';
	                } else {
	                    animProps[_.animType] = 'translate3d(0px,' + targetLeft + 'px, 0px)';
	                }
	                _.$slideTrack.css(animProps);

	                if (callback) {
	                    setTimeout(function() {

	                        _.disableTransition();

	                        callback.call();
	                    }, _.options.speed);
	                }

	            }

	        }

	    };

	    Slick.prototype.getNavTarget = function() {

	        var _ = this,
	            asNavFor = _.options.asNavFor;

	        if ( asNavFor && asNavFor !== null ) {
	            asNavFor = $(asNavFor).not(_.$slider);
	        }

	        return asNavFor;

	    };

	    Slick.prototype.asNavFor = function(index) {

	        var _ = this,
	            asNavFor = _.getNavTarget();

	        if ( asNavFor !== null && typeof asNavFor === 'object' ) {
	            asNavFor.each(function() {
	                var target = $(this).slick('getSlick');
	                if(!target.unslicked) {
	                    target.slideHandler(index, true);
	                }
	            });
	        }

	    };

	    Slick.prototype.applyTransition = function(slide) {

	        var _ = this,
	            transition = {};

	        if (_.options.fade === false) {
	            transition[_.transitionType] = _.transformType + ' ' + _.options.speed + 'ms ' + _.options.cssEase;
	        } else {
	            transition[_.transitionType] = 'opacity ' + _.options.speed + 'ms ' + _.options.cssEase;
	        }

	        if (_.options.fade === false) {
	            _.$slideTrack.css(transition);
	        } else {
	            _.$slides.eq(slide).css(transition);
	        }

	    };

	    Slick.prototype.autoPlay = function() {

	        var _ = this;

	        _.autoPlayClear();

	        if ( _.slideCount > _.options.slidesToShow ) {
	            _.autoPlayTimer = setInterval( _.autoPlayIterator, _.options.autoplaySpeed );
	        }

	    };

	    Slick.prototype.autoPlayClear = function() {

	        var _ = this;

	        if (_.autoPlayTimer) {
	            clearInterval(_.autoPlayTimer);
	        }

	    };

	    Slick.prototype.autoPlayIterator = function() {

	        var _ = this,
	            slideTo = _.currentSlide + _.options.slidesToScroll;

	        if ( !_.paused && !_.interrupted && !_.focussed ) {

	            if ( _.options.infinite === false ) {

	                if ( _.direction === 1 && ( _.currentSlide + 1 ) === ( _.slideCount - 1 )) {
	                    _.direction = 0;
	                }

	                else if ( _.direction === 0 ) {

	                    slideTo = _.currentSlide - _.options.slidesToScroll;

	                    if ( _.currentSlide - 1 === 0 ) {
	                        _.direction = 1;
	                    }

	                }

	            }

	            _.slideHandler( slideTo );

	        }

	    };

	    Slick.prototype.buildArrows = function() {

	        var _ = this;

	        if (_.options.arrows === true ) {

	            _.$prevArrow = $(_.options.prevArrow).addClass('slick-arrow');
	            _.$nextArrow = $(_.options.nextArrow).addClass('slick-arrow');

	            if( _.slideCount > _.options.slidesToShow ) {

	                _.$prevArrow.removeClass('slick-hidden').removeAttr('aria-hidden tabindex');
	                _.$nextArrow.removeClass('slick-hidden').removeAttr('aria-hidden tabindex');

	                if (_.htmlExpr.test(_.options.prevArrow)) {
	                    _.$prevArrow.prependTo(_.options.appendArrows);
	                }

	                if (_.htmlExpr.test(_.options.nextArrow)) {
	                    _.$nextArrow.appendTo(_.options.appendArrows);
	                }

	                if (_.options.infinite !== true) {
	                    _.$prevArrow
	                        .addClass('slick-disabled')
	                        .attr('aria-disabled', 'true');
	                }

	            } else {

	                _.$prevArrow.add( _.$nextArrow )

	                    .addClass('slick-hidden')
	                    .attr({
	                        'aria-disabled': 'true',
	                        'tabindex': '-1'
	                    });

	            }

	        }

	    };

	    Slick.prototype.buildDots = function() {

	        var _ = this,
	            i, dot;

	        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

	            _.$slider.addClass('slick-dotted');

	            dot = $('<ul />').addClass(_.options.dotsClass);

	            for (i = 0; i <= _.getDotCount(); i += 1) {
	                dot.append($('<li />').append(_.options.customPaging.call(this, _, i)));
	            }

	            _.$dots = dot.appendTo(_.options.appendDots);

	            _.$dots.find('li').first().addClass('slick-active').attr('aria-hidden', 'false');

	        }

	    };

	    Slick.prototype.buildOut = function() {

	        var _ = this;

	        _.$slides =
	            _.$slider
	                .children( _.options.slide + ':not(.slick-cloned)')
	                .addClass('slick-slide');

	        _.slideCount = _.$slides.length;

	        _.$slides.each(function(index, element) {
	            $(element)
	                .attr('data-slick-index', index)
	                .data('originalStyling', $(element).attr('style') || '');
	        });

	        _.$slider.addClass('slick-slider');

	        _.$slideTrack = (_.slideCount === 0) ?
	            $('<div class="slick-track"/>').appendTo(_.$slider) :
	            _.$slides.wrapAll('<div class="slick-track"/>').parent();

	        _.$list = _.$slideTrack.wrap(
	            '<div aria-live="polite" class="slick-list"/>').parent();
	        _.$slideTrack.css('opacity', 0);

	        if (_.options.centerMode === true || _.options.swipeToSlide === true) {
	            _.options.slidesToScroll = 1;
	        }

	        $('img[data-lazy]', _.$slider).not('[src]').addClass('slick-loading');

	        _.setupInfinite();

	        _.buildArrows();

	        _.buildDots();

	        _.updateDots();


	        _.setSlideClasses(typeof _.currentSlide === 'number' ? _.currentSlide : 0);

	        if (_.options.draggable === true) {
	            _.$list.addClass('draggable');
	        }

	    };

	    Slick.prototype.buildRows = function() {

	        var _ = this, a, b, c, newSlides, numOfSlides, originalSlides,slidesPerSection;

	        newSlides = document.createDocumentFragment();
	        originalSlides = _.$slider.children();

	        if(_.options.rows > 1) {

	            slidesPerSection = _.options.slidesPerRow * _.options.rows;
	            numOfSlides = Math.ceil(
	                originalSlides.length / slidesPerSection
	            );

	            for(a = 0; a < numOfSlides; a++){
	                var slide = document.createElement('div');
	                for(b = 0; b < _.options.rows; b++) {
	                    var row = document.createElement('div');
	                    for(c = 0; c < _.options.slidesPerRow; c++) {
	                        var target = (a * slidesPerSection + ((b * _.options.slidesPerRow) + c));
	                        if (originalSlides.get(target)) {
	                            row.appendChild(originalSlides.get(target));
	                        }
	                    }
	                    slide.appendChild(row);
	                }
	                newSlides.appendChild(slide);
	            }

	            _.$slider.empty().append(newSlides);
	            _.$slider.children().children().children()
	                .css({
	                    'width':(100 / _.options.slidesPerRow) + '%',
	                    'display': 'inline-block'
	                });

	        }

	    };

	    Slick.prototype.checkResponsive = function(initial, forceUpdate) {

	        var _ = this,
	            breakpoint, targetBreakpoint, respondToWidth, triggerBreakpoint = false;
	        var sliderWidth = _.$slider.width();
	        var windowWidth = window.innerWidth || $(window).width();

	        if (_.respondTo === 'window') {
	            respondToWidth = windowWidth;
	        } else if (_.respondTo === 'slider') {
	            respondToWidth = sliderWidth;
	        } else if (_.respondTo === 'min') {
	            respondToWidth = Math.min(windowWidth, sliderWidth);
	        }

	        if ( _.options.responsive &&
	            _.options.responsive.length &&
	            _.options.responsive !== null) {

	            targetBreakpoint = null;

	            for (breakpoint in _.breakpoints) {
	                if (_.breakpoints.hasOwnProperty(breakpoint)) {
	                    if (_.originalSettings.mobileFirst === false) {
	                        if (respondToWidth < _.breakpoints[breakpoint]) {
	                            targetBreakpoint = _.breakpoints[breakpoint];
	                        }
	                    } else {
	                        if (respondToWidth > _.breakpoints[breakpoint]) {
	                            targetBreakpoint = _.breakpoints[breakpoint];
	                        }
	                    }
	                }
	            }

	            if (targetBreakpoint !== null) {
	                if (_.activeBreakpoint !== null) {
	                    if (targetBreakpoint !== _.activeBreakpoint || forceUpdate) {
	                        _.activeBreakpoint =
	                            targetBreakpoint;
	                        if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
	                            _.unslick(targetBreakpoint);
	                        } else {
	                            _.options = $.extend({}, _.originalSettings,
	                                _.breakpointSettings[
	                                    targetBreakpoint]);
	                            if (initial === true) {
	                                _.currentSlide = _.options.initialSlide;
	                            }
	                            _.refresh(initial);
	                        }
	                        triggerBreakpoint = targetBreakpoint;
	                    }
	                } else {
	                    _.activeBreakpoint = targetBreakpoint;
	                    if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
	                        _.unslick(targetBreakpoint);
	                    } else {
	                        _.options = $.extend({}, _.originalSettings,
	                            _.breakpointSettings[
	                                targetBreakpoint]);
	                        if (initial === true) {
	                            _.currentSlide = _.options.initialSlide;
	                        }
	                        _.refresh(initial);
	                    }
	                    triggerBreakpoint = targetBreakpoint;
	                }
	            } else {
	                if (_.activeBreakpoint !== null) {
	                    _.activeBreakpoint = null;
	                    _.options = _.originalSettings;
	                    if (initial === true) {
	                        _.currentSlide = _.options.initialSlide;
	                    }
	                    _.refresh(initial);
	                    triggerBreakpoint = targetBreakpoint;
	                }
	            }

	            // only trigger breakpoints during an actual break. not on initialize.
	            if( !initial && triggerBreakpoint !== false ) {
	                _.$slider.trigger('breakpoint', [_, triggerBreakpoint]);
	            }
	        }

	    };

	    Slick.prototype.changeSlide = function(event, dontAnimate) {

	        var _ = this,
	            $target = $(event.currentTarget),
	            indexOffset, slideOffset, unevenOffset;

	        // If target is a link, prevent default action.
	        if($target.is('a')) {
	            event.preventDefault();
	        }

	        // If target is not the <li> element (ie: a child), find the <li>.
	        if(!$target.is('li')) {
	            $target = $target.closest('li');
	        }

	        unevenOffset = (_.slideCount % _.options.slidesToScroll !== 0);
	        indexOffset = unevenOffset ? 0 : (_.slideCount - _.currentSlide) % _.options.slidesToScroll;

	        switch (event.data.message) {

	            case 'previous':
	                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : _.options.slidesToShow - indexOffset;
	                if (_.slideCount > _.options.slidesToShow) {
	                    _.slideHandler(_.currentSlide - slideOffset, false, dontAnimate);
	                }
	                break;

	            case 'next':
	                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : indexOffset;
	                if (_.slideCount > _.options.slidesToShow) {
	                    _.slideHandler(_.currentSlide + slideOffset, false, dontAnimate);
	                }
	                break;

	            case 'index':
	                var index = event.data.index === 0 ? 0 :
	                    event.data.index || $target.index() * _.options.slidesToScroll;

	                _.slideHandler(_.checkNavigable(index), false, dontAnimate);
	                $target.children().trigger('focus');
	                break;

	            default:
	                return;
	        }

	    };

	    Slick.prototype.checkNavigable = function(index) {

	        var _ = this,
	            navigables, prevNavigable;

	        navigables = _.getNavigableIndexes();
	        prevNavigable = 0;
	        if (index > navigables[navigables.length - 1]) {
	            index = navigables[navigables.length - 1];
	        } else {
	            for (var n in navigables) {
	                if (index < navigables[n]) {
	                    index = prevNavigable;
	                    break;
	                }
	                prevNavigable = navigables[n];
	            }
	        }

	        return index;
	    };

	    Slick.prototype.cleanUpEvents = function() {

	        var _ = this;

	        if (_.options.dots && _.$dots !== null) {

	            $('li', _.$dots)
	                .off('click.slick', _.changeSlide)
	                .off('mouseenter.slick', $.proxy(_.interrupt, _, true))
	                .off('mouseleave.slick', $.proxy(_.interrupt, _, false));

	        }

	        _.$slider.off('focus.slick blur.slick');

	        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
	            _.$prevArrow && _.$prevArrow.off('click.slick', _.changeSlide);
	            _.$nextArrow && _.$nextArrow.off('click.slick', _.changeSlide);
	        }

	        _.$list.off('touchstart.slick mousedown.slick', _.swipeHandler);
	        _.$list.off('touchmove.slick mousemove.slick', _.swipeHandler);
	        _.$list.off('touchend.slick mouseup.slick', _.swipeHandler);
	        _.$list.off('touchcancel.slick mouseleave.slick', _.swipeHandler);

	        _.$list.off('click.slick', _.clickHandler);

	        $(document).off(_.visibilityChange, _.visibility);

	        _.cleanUpSlideEvents();

	        if (_.options.accessibility === true) {
	            _.$list.off('keydown.slick', _.keyHandler);
	        }

	        if (_.options.focusOnSelect === true) {
	            $(_.$slideTrack).children().off('click.slick', _.selectHandler);
	        }

	        $(window).off('orientationchange.slick.slick-' + _.instanceUid, _.orientationChange);

	        $(window).off('resize.slick.slick-' + _.instanceUid, _.resize);

	        $('[draggable!=true]', _.$slideTrack).off('dragstart', _.preventDefault);

	        $(window).off('load.slick.slick-' + _.instanceUid, _.setPosition);
	        $(document).off('ready.slick.slick-' + _.instanceUid, _.setPosition);

	    };

	    Slick.prototype.cleanUpSlideEvents = function() {

	        var _ = this;

	        _.$list.off('mouseenter.slick', $.proxy(_.interrupt, _, true));
	        _.$list.off('mouseleave.slick', $.proxy(_.interrupt, _, false));

	    };

	    Slick.prototype.cleanUpRows = function() {

	        var _ = this, originalSlides;

	        if(_.options.rows > 1) {
	            originalSlides = _.$slides.children().children();
	            originalSlides.removeAttr('style');
	            _.$slider.empty().append(originalSlides);
	        }

	    };

	    Slick.prototype.clickHandler = function(event) {

	        var _ = this;

	        if (_.shouldClick === false) {
	            event.stopImmediatePropagation();
	            event.stopPropagation();
	            event.preventDefault();
	        }

	    };

	    Slick.prototype.destroy = function(refresh) {

	        var _ = this;

	        _.autoPlayClear();

	        _.touchObject = {};

	        _.cleanUpEvents();

	        $('.slick-cloned', _.$slider).detach();

	        if (_.$dots) {
	            _.$dots.remove();
	        }


	        if ( _.$prevArrow && _.$prevArrow.length ) {

	            _.$prevArrow
	                .removeClass('slick-disabled slick-arrow slick-hidden')
	                .removeAttr('aria-hidden aria-disabled tabindex')
	                .css('display','');

	            if ( _.htmlExpr.test( _.options.prevArrow )) {
	                _.$prevArrow.remove();
	            }
	        }

	        if ( _.$nextArrow && _.$nextArrow.length ) {

	            _.$nextArrow
	                .removeClass('slick-disabled slick-arrow slick-hidden')
	                .removeAttr('aria-hidden aria-disabled tabindex')
	                .css('display','');

	            if ( _.htmlExpr.test( _.options.nextArrow )) {
	                _.$nextArrow.remove();
	            }

	        }


	        if (_.$slides) {

	            _.$slides
	                .removeClass('slick-slide slick-active slick-center slick-visible slick-current')
	                .removeAttr('aria-hidden')
	                .removeAttr('data-slick-index')
	                .each(function(){
	                    $(this).attr('style', $(this).data('originalStyling'));
	                });

	            _.$slideTrack.children(this.options.slide).detach();

	            _.$slideTrack.detach();

	            _.$list.detach();

	            _.$slider.append(_.$slides);
	        }

	        _.cleanUpRows();

	        _.$slider.removeClass('slick-slider');
	        _.$slider.removeClass('slick-initialized');
	        _.$slider.removeClass('slick-dotted');

	        _.unslicked = true;

	        if(!refresh) {
	            _.$slider.trigger('destroy', [_]);
	        }

	    };

	    Slick.prototype.disableTransition = function(slide) {

	        var _ = this,
	            transition = {};

	        transition[_.transitionType] = '';

	        if (_.options.fade === false) {
	            _.$slideTrack.css(transition);
	        } else {
	            _.$slides.eq(slide).css(transition);
	        }

	    };

	    Slick.prototype.fadeSlide = function(slideIndex, callback) {

	        var _ = this;

	        if (_.cssTransitions === false) {

	            _.$slides.eq(slideIndex).css({
	                zIndex: _.options.zIndex
	            });

	            _.$slides.eq(slideIndex).animate({
	                opacity: 1
	            }, _.options.speed, _.options.easing, callback);

	        } else {

	            _.applyTransition(slideIndex);

	            _.$slides.eq(slideIndex).css({
	                opacity: 1,
	                zIndex: _.options.zIndex
	            });

	            if (callback) {
	                setTimeout(function() {

	                    _.disableTransition(slideIndex);

	                    callback.call();
	                }, _.options.speed);
	            }

	        }

	    };

	    Slick.prototype.fadeSlideOut = function(slideIndex) {

	        var _ = this;

	        if (_.cssTransitions === false) {

	            _.$slides.eq(slideIndex).animate({
	                opacity: 0,
	                zIndex: _.options.zIndex - 2
	            }, _.options.speed, _.options.easing);

	        } else {

	            _.applyTransition(slideIndex);

	            _.$slides.eq(slideIndex).css({
	                opacity: 0,
	                zIndex: _.options.zIndex - 2
	            });

	        }

	    };

	    Slick.prototype.filterSlides = Slick.prototype.slickFilter = function(filter) {

	        var _ = this;

	        if (filter !== null) {

	            _.$slidesCache = _.$slides;

	            _.unload();

	            _.$slideTrack.children(this.options.slide).detach();

	            _.$slidesCache.filter(filter).appendTo(_.$slideTrack);

	            _.reinit();

	        }

	    };

	    Slick.prototype.focusHandler = function() {

	        var _ = this;

	        _.$slider
	            .off('focus.slick blur.slick')
	            .on('focus.slick blur.slick',
	                '*:not(.slick-arrow)', function(event) {

	            event.stopImmediatePropagation();
	            var $sf = $(this);

	            setTimeout(function() {

	                if( _.options.pauseOnFocus ) {
	                    _.focussed = $sf.is(':focus');
	                    _.autoPlay();
	                }

	            }, 0);

	        });
	    };

	    Slick.prototype.getCurrent = Slick.prototype.slickCurrentSlide = function() {

	        var _ = this;
	        return _.currentSlide;

	    };

	    Slick.prototype.getDotCount = function() {

	        var _ = this;

	        var breakPoint = 0;
	        var counter = 0;
	        var pagerQty = 0;

	        if (_.options.infinite === true) {
	            while (breakPoint < _.slideCount) {
	                ++pagerQty;
	                breakPoint = counter + _.options.slidesToScroll;
	                counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
	            }
	        } else if (_.options.centerMode === true) {
	            pagerQty = _.slideCount;
	        } else if(!_.options.asNavFor) {
	            pagerQty = 1 + Math.ceil((_.slideCount - _.options.slidesToShow) / _.options.slidesToScroll);
	        }else {
	            while (breakPoint < _.slideCount) {
	                ++pagerQty;
	                breakPoint = counter + _.options.slidesToScroll;
	                counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
	            }
	        }

	        return pagerQty - 1;

	    };

	    Slick.prototype.getLeft = function(slideIndex) {

	        var _ = this,
	            targetLeft,
	            verticalHeight,
	            verticalOffset = 0,
	            targetSlide;

	        _.slideOffset = 0;
	        verticalHeight = _.$slides.first().outerHeight(true);

	        if (_.options.infinite === true) {
	            if (_.slideCount > _.options.slidesToShow) {
	                _.slideOffset = (_.slideWidth * _.options.slidesToShow) * -1;
	                verticalOffset = (verticalHeight * _.options.slidesToShow) * -1;
	            }
	            if (_.slideCount % _.options.slidesToScroll !== 0) {
	                if (slideIndex + _.options.slidesToScroll > _.slideCount && _.slideCount > _.options.slidesToShow) {
	                    if (slideIndex > _.slideCount) {
	                        _.slideOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * _.slideWidth) * -1;
	                        verticalOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * verticalHeight) * -1;
	                    } else {
	                        _.slideOffset = ((_.slideCount % _.options.slidesToScroll) * _.slideWidth) * -1;
	                        verticalOffset = ((_.slideCount % _.options.slidesToScroll) * verticalHeight) * -1;
	                    }
	                }
	            }
	        } else {
	            if (slideIndex + _.options.slidesToShow > _.slideCount) {
	                _.slideOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * _.slideWidth;
	                verticalOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * verticalHeight;
	            }
	        }

	        if (_.slideCount <= _.options.slidesToShow) {
	            _.slideOffset = 0;
	            verticalOffset = 0;
	        }

	        if (_.options.centerMode === true && _.options.infinite === true) {
	            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2) - _.slideWidth;
	        } else if (_.options.centerMode === true) {
	            _.slideOffset = 0;
	            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2);
	        }

	        if (_.options.vertical === false) {
	            targetLeft = ((slideIndex * _.slideWidth) * -1) + _.slideOffset;
	        } else {
	            targetLeft = ((slideIndex * verticalHeight) * -1) + verticalOffset;
	        }

	        if (_.options.variableWidth === true) {

	            if (_.slideCount <= _.options.slidesToShow || _.options.infinite === false) {
	                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
	            } else {
	                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow);
	            }

	            if (_.options.rtl === true) {
	                if (targetSlide[0]) {
	                    targetLeft = (_.$slideTrack.width() - targetSlide[0].offsetLeft - targetSlide.width()) * -1;
	                } else {
	                    targetLeft =  0;
	                }
	            } else {
	                targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;
	            }

	            if (_.options.centerMode === true) {
	                if (_.slideCount <= _.options.slidesToShow || _.options.infinite === false) {
	                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
	                } else {
	                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow + 1);
	                }

	                if (_.options.rtl === true) {
	                    if (targetSlide[0]) {
	                        targetLeft = (_.$slideTrack.width() - targetSlide[0].offsetLeft - targetSlide.width()) * -1;
	                    } else {
	                        targetLeft =  0;
	                    }
	                } else {
	                    targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;
	                }

	                targetLeft += (_.$list.width() - targetSlide.outerWidth()) / 2;
	            }
	        }

	        return targetLeft;

	    };

	    Slick.prototype.getOption = Slick.prototype.slickGetOption = function(option) {

	        var _ = this;

	        return _.options[option];

	    };

	    Slick.prototype.getNavigableIndexes = function() {

	        var _ = this,
	            breakPoint = 0,
	            counter = 0,
	            indexes = [],
	            max;

	        if (_.options.infinite === false) {
	            max = _.slideCount;
	        } else {
	            breakPoint = _.options.slidesToScroll * -1;
	            counter = _.options.slidesToScroll * -1;
	            max = _.slideCount * 2;
	        }

	        while (breakPoint < max) {
	            indexes.push(breakPoint);
	            breakPoint = counter + _.options.slidesToScroll;
	            counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
	        }

	        return indexes;

	    };

	    Slick.prototype.getSlick = function() {

	        return this;

	    };

	    Slick.prototype.getSlideCount = function() {

	        var _ = this,
	            slidesTraversed, swipedSlide, centerOffset;

	        centerOffset = _.options.centerMode === true ? _.slideWidth * Math.floor(_.options.slidesToShow / 2) : 0;

	        if (_.options.swipeToSlide === true) {
	            _.$slideTrack.find('.slick-slide').each(function(index, slide) {
	                if (slide.offsetLeft - centerOffset + ($(slide).outerWidth() / 2) > (_.swipeLeft * -1)) {
	                    swipedSlide = slide;
	                    return false;
	                }
	            });

	            slidesTraversed = Math.abs($(swipedSlide).attr('data-slick-index') - _.currentSlide) || 1;

	            return slidesTraversed;

	        } else {
	            return _.options.slidesToScroll;
	        }

	    };

	    Slick.prototype.goTo = Slick.prototype.slickGoTo = function(slide, dontAnimate) {

	        var _ = this;

	        _.changeSlide({
	            data: {
	                message: 'index',
	                index: parseInt(slide)
	            }
	        }, dontAnimate);

	    };

	    Slick.prototype.init = function(creation) {

	        var _ = this;

	        if (!$(_.$slider).hasClass('slick-initialized')) {

	            $(_.$slider).addClass('slick-initialized');

	            _.buildRows();
	            _.buildOut();
	            _.setProps();
	            _.startLoad();
	            _.loadSlider();
	            _.initializeEvents();
	            _.updateArrows();
	            _.updateDots();
	            _.checkResponsive(true);
	            _.focusHandler();

	        }

	        if (creation) {
	            _.$slider.trigger('init', [_]);
	        }

	        if (_.options.accessibility === true) {
	            _.initADA();
	        }

	        if ( _.options.autoplay ) {

	            _.paused = false;
	            _.autoPlay();

	        }

	    };

	    Slick.prototype.initADA = function() {
	        var _ = this;
	        _.$slides.add(_.$slideTrack.find('.slick-cloned')).attr({
	            'aria-hidden': 'true',
	            'tabindex': '-1'
	        }).find('a, input, button, select').attr({
	            'tabindex': '-1'
	        });

	        _.$slideTrack.attr('role', 'listbox');

	        _.$slides.not(_.$slideTrack.find('.slick-cloned')).each(function(i) {
	            $(this).attr({
	                'role': 'option',
	                'aria-describedby': 'slick-slide' + _.instanceUid + i + ''
	            });
	        });

	        if (_.$dots !== null) {
	            _.$dots.attr('role', 'tablist').find('li').each(function(i) {
	                $(this).attr({
	                    'role': 'presentation',
	                    'aria-selected': 'false',
	                    'aria-controls': 'navigation' + _.instanceUid + i + '',
	                    'id': 'slick-slide' + _.instanceUid + i + ''
	                });
	            })
	                .first().attr('aria-selected', 'true').end()
	                .find('button').attr('role', 'button').end()
	                .closest('div').attr('role', 'toolbar');
	        }
	        _.activateADA();

	    };

	    Slick.prototype.initArrowEvents = function() {

	        var _ = this;

	        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
	            _.$prevArrow
	               .off('click.slick')
	               .on('click.slick', {
	                    message: 'previous'
	               }, _.changeSlide);
	            _.$nextArrow
	               .off('click.slick')
	               .on('click.slick', {
	                    message: 'next'
	               }, _.changeSlide);
	        }

	    };

	    Slick.prototype.initDotEvents = function() {

	        var _ = this;

	        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {
	            $('li', _.$dots).on('click.slick', {
	                message: 'index'
	            }, _.changeSlide);
	        }

	        if ( _.options.dots === true && _.options.pauseOnDotsHover === true ) {

	            $('li', _.$dots)
	                .on('mouseenter.slick', $.proxy(_.interrupt, _, true))
	                .on('mouseleave.slick', $.proxy(_.interrupt, _, false));

	        }

	    };

	    Slick.prototype.initSlideEvents = function() {

	        var _ = this;

	        if ( _.options.pauseOnHover ) {

	            _.$list.on('mouseenter.slick', $.proxy(_.interrupt, _, true));
	            _.$list.on('mouseleave.slick', $.proxy(_.interrupt, _, false));

	        }

	    };

	    Slick.prototype.initializeEvents = function() {

	        var _ = this;

	        _.initArrowEvents();

	        _.initDotEvents();
	        _.initSlideEvents();

	        _.$list.on('touchstart.slick mousedown.slick', {
	            action: 'start'
	        }, _.swipeHandler);
	        _.$list.on('touchmove.slick mousemove.slick', {
	            action: 'move'
	        }, _.swipeHandler);
	        _.$list.on('touchend.slick mouseup.slick', {
	            action: 'end'
	        }, _.swipeHandler);
	        _.$list.on('touchcancel.slick mouseleave.slick', {
	            action: 'end'
	        }, _.swipeHandler);

	        _.$list.on('click.slick', _.clickHandler);

	        $(document).on(_.visibilityChange, $.proxy(_.visibility, _));

	        if (_.options.accessibility === true) {
	            _.$list.on('keydown.slick', _.keyHandler);
	        }

	        if (_.options.focusOnSelect === true) {
	            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
	        }

	        $(window).on('orientationchange.slick.slick-' + _.instanceUid, $.proxy(_.orientationChange, _));

	        $(window).on('resize.slick.slick-' + _.instanceUid, $.proxy(_.resize, _));

	        $('[draggable!=true]', _.$slideTrack).on('dragstart', _.preventDefault);

	        $(window).on('load.slick.slick-' + _.instanceUid, _.setPosition);
	        $(document).on('ready.slick.slick-' + _.instanceUid, _.setPosition);

	    };

	    Slick.prototype.initUI = function() {

	        var _ = this;

	        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

	            _.$prevArrow.show();
	            _.$nextArrow.show();

	        }

	        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

	            _.$dots.show();

	        }

	    };

	    Slick.prototype.keyHandler = function(event) {

	        var _ = this;
	         //Dont slide if the cursor is inside the form fields and arrow keys are pressed
	        if(!event.target.tagName.match('TEXTAREA|INPUT|SELECT')) {
	            if (event.keyCode === 37 && _.options.accessibility === true) {
	                _.changeSlide({
	                    data: {
	                        message: _.options.rtl === true ? 'next' :  'previous'
	                    }
	                });
	            } else if (event.keyCode === 39 && _.options.accessibility === true) {
	                _.changeSlide({
	                    data: {
	                        message: _.options.rtl === true ? 'previous' : 'next'
	                    }
	                });
	            }
	        }

	    };

	    Slick.prototype.lazyLoad = function() {

	        var _ = this,
	            loadRange, cloneRange, rangeStart, rangeEnd;

	        function loadImages(imagesScope) {

	            $('img[data-lazy]', imagesScope).each(function() {

	                var image = $(this),
	                    imageSource = $(this).attr('data-lazy'),
	                    imageToLoad = document.createElement('img');

	                imageToLoad.onload = function() {

	                    image
	                        .animate({ opacity: 0 }, 100, function() {
	                            image
	                                .attr('src', imageSource)
	                                .animate({ opacity: 1 }, 200, function() {
	                                    image
	                                        .removeAttr('data-lazy')
	                                        .removeClass('slick-loading');
	                                });
	                            _.$slider.trigger('lazyLoaded', [_, image, imageSource]);
	                        });

	                };

	                imageToLoad.onerror = function() {

	                    image
	                        .removeAttr( 'data-lazy' )
	                        .removeClass( 'slick-loading' )
	                        .addClass( 'slick-lazyload-error' );

	                    _.$slider.trigger('lazyLoadError', [ _, image, imageSource ]);

	                };

	                imageToLoad.src = imageSource;

	            });

	        }

	        if (_.options.centerMode === true) {
	            if (_.options.infinite === true) {
	                rangeStart = _.currentSlide + (_.options.slidesToShow / 2 + 1);
	                rangeEnd = rangeStart + _.options.slidesToShow + 2;
	            } else {
	                rangeStart = Math.max(0, _.currentSlide - (_.options.slidesToShow / 2 + 1));
	                rangeEnd = 2 + (_.options.slidesToShow / 2 + 1) + _.currentSlide;
	            }
	        } else {
	            rangeStart = _.options.infinite ? _.options.slidesToShow + _.currentSlide : _.currentSlide;
	            rangeEnd = Math.ceil(rangeStart + _.options.slidesToShow);
	            if (_.options.fade === true) {
	                if (rangeStart > 0) rangeStart--;
	                if (rangeEnd <= _.slideCount) rangeEnd++;
	            }
	        }

	        loadRange = _.$slider.find('.slick-slide').slice(rangeStart, rangeEnd);
	        loadImages(loadRange);

	        if (_.slideCount <= _.options.slidesToShow) {
	            cloneRange = _.$slider.find('.slick-slide');
	            loadImages(cloneRange);
	        } else
	        if (_.currentSlide >= _.slideCount - _.options.slidesToShow) {
	            cloneRange = _.$slider.find('.slick-cloned').slice(0, _.options.slidesToShow);
	            loadImages(cloneRange);
	        } else if (_.currentSlide === 0) {
	            cloneRange = _.$slider.find('.slick-cloned').slice(_.options.slidesToShow * -1);
	            loadImages(cloneRange);
	        }

	    };

	    Slick.prototype.loadSlider = function() {

	        var _ = this;

	        _.setPosition();

	        _.$slideTrack.css({
	            opacity: 1
	        });

	        _.$slider.removeClass('slick-loading');

	        _.initUI();

	        if (_.options.lazyLoad === 'progressive') {
	            _.progressiveLazyLoad();
	        }

	    };

	    Slick.prototype.next = Slick.prototype.slickNext = function() {

	        var _ = this;

	        _.changeSlide({
	            data: {
	                message: 'next'
	            }
	        });

	    };

	    Slick.prototype.orientationChange = function() {

	        var _ = this;

	        _.checkResponsive();
	        _.setPosition();

	    };

	    Slick.prototype.pause = Slick.prototype.slickPause = function() {

	        var _ = this;

	        _.autoPlayClear();
	        _.paused = true;

	    };

	    Slick.prototype.play = Slick.prototype.slickPlay = function() {

	        var _ = this;

	        _.autoPlay();
	        _.options.autoplay = true;
	        _.paused = false;
	        _.focussed = false;
	        _.interrupted = false;

	    };

	    Slick.prototype.postSlide = function(index) {

	        var _ = this;

	        if( !_.unslicked ) {

	            _.$slider.trigger('afterChange', [_, index]);

	            _.animating = false;

	            _.setPosition();

	            _.swipeLeft = null;

	            if ( _.options.autoplay ) {
	                _.autoPlay();
	            }

	            if (_.options.accessibility === true) {
	                _.initADA();
	            }

	        }

	    };

	    Slick.prototype.prev = Slick.prototype.slickPrev = function() {

	        var _ = this;

	        _.changeSlide({
	            data: {
	                message: 'previous'
	            }
	        });

	    };

	    Slick.prototype.preventDefault = function(event) {

	        event.preventDefault();

	    };

	    Slick.prototype.progressiveLazyLoad = function( tryCount ) {

	        tryCount = tryCount || 1;

	        var _ = this,
	            $imgsToLoad = $( 'img[data-lazy]', _.$slider ),
	            image,
	            imageSource,
	            imageToLoad;

	        if ( $imgsToLoad.length ) {

	            image = $imgsToLoad.first();
	            imageSource = image.attr('data-lazy');
	            imageToLoad = document.createElement('img');

	            imageToLoad.onload = function() {

	                image
	                    .attr( 'src', imageSource )
	                    .removeAttr('data-lazy')
	                    .removeClass('slick-loading');

	                if ( _.options.adaptiveHeight === true ) {
	                    _.setPosition();
	                }

	                _.$slider.trigger('lazyLoaded', [ _, image, imageSource ]);
	                _.progressiveLazyLoad();

	            };

	            imageToLoad.onerror = function() {

	                if ( tryCount < 3 ) {

	                    /**
	                     * try to load the image 3 times,
	                     * leave a slight delay so we don't get
	                     * servers blocking the request.
	                     */
	                    setTimeout( function() {
	                        _.progressiveLazyLoad( tryCount + 1 );
	                    }, 500 );

	                } else {

	                    image
	                        .removeAttr( 'data-lazy' )
	                        .removeClass( 'slick-loading' )
	                        .addClass( 'slick-lazyload-error' );

	                    _.$slider.trigger('lazyLoadError', [ _, image, imageSource ]);

	                    _.progressiveLazyLoad();

	                }

	            };

	            imageToLoad.src = imageSource;

	        } else {

	            _.$slider.trigger('allImagesLoaded', [ _ ]);

	        }

	    };

	    Slick.prototype.refresh = function( initializing ) {

	        var _ = this, currentSlide, lastVisibleIndex;

	        lastVisibleIndex = _.slideCount - _.options.slidesToShow;

	        // in non-infinite sliders, we don't want to go past the
	        // last visible index.
	        if( !_.options.infinite && ( _.currentSlide > lastVisibleIndex )) {
	            _.currentSlide = lastVisibleIndex;
	        }

	        // if less slides than to show, go to start.
	        if ( _.slideCount <= _.options.slidesToShow ) {
	            _.currentSlide = 0;

	        }

	        currentSlide = _.currentSlide;

	        _.destroy(true);

	        $.extend(_, _.initials, { currentSlide: currentSlide });

	        _.init();

	        if( !initializing ) {

	            _.changeSlide({
	                data: {
	                    message: 'index',
	                    index: currentSlide
	                }
	            }, false);

	        }

	    };

	    Slick.prototype.registerBreakpoints = function() {

	        var _ = this, breakpoint, currentBreakpoint, l,
	            responsiveSettings = _.options.responsive || null;

	        if ( $.type(responsiveSettings) === 'array' && responsiveSettings.length ) {

	            _.respondTo = _.options.respondTo || 'window';

	            for ( breakpoint in responsiveSettings ) {

	                l = _.breakpoints.length-1;
	                currentBreakpoint = responsiveSettings[breakpoint].breakpoint;

	                if (responsiveSettings.hasOwnProperty(breakpoint)) {

	                    // loop through the breakpoints and cut out any existing
	                    // ones with the same breakpoint number, we don't want dupes.
	                    while( l >= 0 ) {
	                        if( _.breakpoints[l] && _.breakpoints[l] === currentBreakpoint ) {
	                            _.breakpoints.splice(l,1);
	                        }
	                        l--;
	                    }

	                    _.breakpoints.push(currentBreakpoint);
	                    _.breakpointSettings[currentBreakpoint] = responsiveSettings[breakpoint].settings;

	                }

	            }

	            _.breakpoints.sort(function(a, b) {
	                return ( _.options.mobileFirst ) ? a-b : b-a;
	            });

	        }

	    };

	    Slick.prototype.reinit = function() {

	        var _ = this;

	        _.$slides =
	            _.$slideTrack
	                .children(_.options.slide)
	                .addClass('slick-slide');

	        _.slideCount = _.$slides.length;

	        if (_.currentSlide >= _.slideCount && _.currentSlide !== 0) {
	            _.currentSlide = _.currentSlide - _.options.slidesToScroll;
	        }

	        if (_.slideCount <= _.options.slidesToShow) {
	            _.currentSlide = 0;
	        }

	        _.registerBreakpoints();

	        _.setProps();
	        _.setupInfinite();
	        _.buildArrows();
	        _.updateArrows();
	        _.initArrowEvents();
	        _.buildDots();
	        _.updateDots();
	        _.initDotEvents();
	        _.cleanUpSlideEvents();
	        _.initSlideEvents();

	        _.checkResponsive(false, true);

	        if (_.options.focusOnSelect === true) {
	            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
	        }

	        _.setSlideClasses(typeof _.currentSlide === 'number' ? _.currentSlide : 0);

	        _.setPosition();
	        _.focusHandler();

	        _.paused = !_.options.autoplay;
	        _.autoPlay();

	        _.$slider.trigger('reInit', [_]);

	    };

	    Slick.prototype.resize = function() {

	        var _ = this;

	        if ($(window).width() !== _.windowWidth) {
	            clearTimeout(_.windowDelay);
	            _.windowDelay = window.setTimeout(function() {
	                _.windowWidth = $(window).width();
	                _.checkResponsive();
	                if( !_.unslicked ) { _.setPosition(); }
	            }, 50);
	        }
	    };

	    Slick.prototype.removeSlide = Slick.prototype.slickRemove = function(index, removeBefore, removeAll) {

	        var _ = this;

	        if (typeof(index) === 'boolean') {
	            removeBefore = index;
	            index = removeBefore === true ? 0 : _.slideCount - 1;
	        } else {
	            index = removeBefore === true ? --index : index;
	        }

	        if (_.slideCount < 1 || index < 0 || index > _.slideCount - 1) {
	            return false;
	        }

	        _.unload();

	        if (removeAll === true) {
	            _.$slideTrack.children().remove();
	        } else {
	            _.$slideTrack.children(this.options.slide).eq(index).remove();
	        }

	        _.$slides = _.$slideTrack.children(this.options.slide);

	        _.$slideTrack.children(this.options.slide).detach();

	        _.$slideTrack.append(_.$slides);

	        _.$slidesCache = _.$slides;

	        _.reinit();

	    };

	    Slick.prototype.setCSS = function(position) {

	        var _ = this,
	            positionProps = {},
	            x, y;

	        if (_.options.rtl === true) {
	            position = -position;
	        }
	        x = _.positionProp == 'left' ? Math.ceil(position) + 'px' : '0px';
	        y = _.positionProp == 'top' ? Math.ceil(position) + 'px' : '0px';

	        positionProps[_.positionProp] = position;

	        if (_.transformsEnabled === false) {
	            _.$slideTrack.css(positionProps);
	        } else {
	            positionProps = {};
	            if (_.cssTransitions === false) {
	                positionProps[_.animType] = 'translate(' + x + ', ' + y + ')';
	                _.$slideTrack.css(positionProps);
	            } else {
	                positionProps[_.animType] = 'translate3d(' + x + ', ' + y + ', 0px)';
	                _.$slideTrack.css(positionProps);
	            }
	        }

	    };

	    Slick.prototype.setDimensions = function() {

	        var _ = this;

	        if (_.options.vertical === false) {
	            if (_.options.centerMode === true) {
	                _.$list.css({
	                    padding: ('0px ' + _.options.centerPadding)
	                });
	            }
	        } else {
	            _.$list.height(_.$slides.first().outerHeight(true) * _.options.slidesToShow);
	            if (_.options.centerMode === true) {
	                _.$list.css({
	                    padding: (_.options.centerPadding + ' 0px')
	                });
	            }
	        }

	        _.listWidth = _.$list.width();
	        _.listHeight = _.$list.height();


	        if (_.options.vertical === false && _.options.variableWidth === false) {
	            _.slideWidth = Math.ceil(_.listWidth / _.options.slidesToShow);
	            _.$slideTrack.width(Math.ceil((_.slideWidth * _.$slideTrack.children('.slick-slide').length)));

	        } else if (_.options.variableWidth === true) {
	            _.$slideTrack.width(5000 * _.slideCount);
	        } else {
	            _.slideWidth = Math.ceil(_.listWidth);
	            _.$slideTrack.height(Math.ceil((_.$slides.first().outerHeight(true) * _.$slideTrack.children('.slick-slide').length)));
	        }

	        var offset = _.$slides.first().outerWidth(true) - _.$slides.first().width();
	        if (_.options.variableWidth === false) _.$slideTrack.children('.slick-slide').width(_.slideWidth - offset);

	    };

	    Slick.prototype.setFade = function() {

	        var _ = this,
	            targetLeft;

	        _.$slides.each(function(index, element) {
	            targetLeft = (_.slideWidth * index) * -1;
	            if (_.options.rtl === true) {
	                $(element).css({
	                    position: 'relative',
	                    right: targetLeft,
	                    top: 0,
	                    zIndex: _.options.zIndex - 2,
	                    opacity: 0
	                });
	            } else {
	                $(element).css({
	                    position: 'relative',
	                    left: targetLeft,
	                    top: 0,
	                    zIndex: _.options.zIndex - 2,
	                    opacity: 0
	                });
	            }
	        });

	        _.$slides.eq(_.currentSlide).css({
	            zIndex: _.options.zIndex - 1,
	            opacity: 1
	        });

	    };

	    Slick.prototype.setHeight = function() {

	        var _ = this;

	        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
	            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
	            _.$list.css('height', targetHeight);
	        }

	    };

	    Slick.prototype.setOption =
	    Slick.prototype.slickSetOption = function() {

	        /**
	         * accepts arguments in format of:
	         *
	         *  - for changing a single option's value:
	         *     .slick("setOption", option, value, refresh )
	         *
	         *  - for changing a set of responsive options:
	         *     .slick("setOption", 'responsive', [{}, ...], refresh )
	         *
	         *  - for updating multiple values at once (not responsive)
	         *     .slick("setOption", { 'option': value, ... }, refresh )
	         */

	        var _ = this, l, item, option, value, refresh = false, type;

	        if( $.type( arguments[0] ) === 'object' ) {

	            option =  arguments[0];
	            refresh = arguments[1];
	            type = 'multiple';

	        } else if ( $.type( arguments[0] ) === 'string' ) {

	            option =  arguments[0];
	            value = arguments[1];
	            refresh = arguments[2];

	            if ( arguments[0] === 'responsive' && $.type( arguments[1] ) === 'array' ) {

	                type = 'responsive';

	            } else if ( typeof arguments[1] !== 'undefined' ) {

	                type = 'single';

	            }

	        }

	        if ( type === 'single' ) {

	            _.options[option] = value;


	        } else if ( type === 'multiple' ) {

	            $.each( option , function( opt, val ) {

	                _.options[opt] = val;

	            });


	        } else if ( type === 'responsive' ) {

	            for ( item in value ) {

	                if( $.type( _.options.responsive ) !== 'array' ) {

	                    _.options.responsive = [ value[item] ];

	                } else {

	                    l = _.options.responsive.length-1;

	                    // loop through the responsive object and splice out duplicates.
	                    while( l >= 0 ) {

	                        if( _.options.responsive[l].breakpoint === value[item].breakpoint ) {

	                            _.options.responsive.splice(l,1);

	                        }

	                        l--;

	                    }

	                    _.options.responsive.push( value[item] );

	                }

	            }

	        }

	        if ( refresh ) {

	            _.unload();
	            _.reinit();

	        }

	    };

	    Slick.prototype.setPosition = function() {

	        var _ = this;

	        _.setDimensions();

	        _.setHeight();

	        if (_.options.fade === false) {
	            _.setCSS(_.getLeft(_.currentSlide));
	        } else {
	            _.setFade();
	        }

	        _.$slider.trigger('setPosition', [_]);

	    };

	    Slick.prototype.setProps = function() {

	        var _ = this,
	            bodyStyle = document.body.style;

	        _.positionProp = _.options.vertical === true ? 'top' : 'left';

	        if (_.positionProp === 'top') {
	            _.$slider.addClass('slick-vertical');
	        } else {
	            _.$slider.removeClass('slick-vertical');
	        }

	        if (bodyStyle.WebkitTransition !== undefined ||
	            bodyStyle.MozTransition !== undefined ||
	            bodyStyle.msTransition !== undefined) {
	            if (_.options.useCSS === true) {
	                _.cssTransitions = true;
	            }
	        }

	        if ( _.options.fade ) {
	            if ( typeof _.options.zIndex === 'number' ) {
	                if( _.options.zIndex < 3 ) {
	                    _.options.zIndex = 3;
	                }
	            } else {
	                _.options.zIndex = _.defaults.zIndex;
	            }
	        }

	        if (bodyStyle.OTransform !== undefined) {
	            _.animType = 'OTransform';
	            _.transformType = '-o-transform';
	            _.transitionType = 'OTransition';
	            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
	        }
	        if (bodyStyle.MozTransform !== undefined) {
	            _.animType = 'MozTransform';
	            _.transformType = '-moz-transform';
	            _.transitionType = 'MozTransition';
	            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.MozPerspective === undefined) _.animType = false;
	        }
	        if (bodyStyle.webkitTransform !== undefined) {
	            _.animType = 'webkitTransform';
	            _.transformType = '-webkit-transform';
	            _.transitionType = 'webkitTransition';
	            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
	        }
	        if (bodyStyle.msTransform !== undefined) {
	            _.animType = 'msTransform';
	            _.transformType = '-ms-transform';
	            _.transitionType = 'msTransition';
	            if (bodyStyle.msTransform === undefined) _.animType = false;
	        }
	        if (bodyStyle.transform !== undefined && _.animType !== false) {
	            _.animType = 'transform';
	            _.transformType = 'transform';
	            _.transitionType = 'transition';
	        }
	        _.transformsEnabled = _.options.useTransform && (_.animType !== null && _.animType !== false);
	    };


	    Slick.prototype.setSlideClasses = function(index) {

	        var _ = this,
	            centerOffset, allSlides, indexOffset, remainder;

	        allSlides = _.$slider
	            .find('.slick-slide')
	            .removeClass('slick-active slick-center slick-current')
	            .attr('aria-hidden', 'true');

	        _.$slides
	            .eq(index)
	            .addClass('slick-current');

	        if (_.options.centerMode === true) {

	            centerOffset = Math.floor(_.options.slidesToShow / 2);

	            if (_.options.infinite === true) {

	                if (index >= centerOffset && index <= (_.slideCount - 1) - centerOffset) {

	                    _.$slides
	                        .slice(index - centerOffset, index + centerOffset + 1)
	                        .addClass('slick-active')
	                        .attr('aria-hidden', 'false');

	                } else {

	                    indexOffset = _.options.slidesToShow + index;
	                    allSlides
	                        .slice(indexOffset - centerOffset + 1, indexOffset + centerOffset + 2)
	                        .addClass('slick-active')
	                        .attr('aria-hidden', 'false');

	                }

	                if (index === 0) {

	                    allSlides
	                        .eq(allSlides.length - 1 - _.options.slidesToShow)
	                        .addClass('slick-center');

	                } else if (index === _.slideCount - 1) {

	                    allSlides
	                        .eq(_.options.slidesToShow)
	                        .addClass('slick-center');

	                }

	            }

	            _.$slides
	                .eq(index)
	                .addClass('slick-center');

	        } else {

	            if (index >= 0 && index <= (_.slideCount - _.options.slidesToShow)) {

	                _.$slides
	                    .slice(index, index + _.options.slidesToShow)
	                    .addClass('slick-active')
	                    .attr('aria-hidden', 'false');

	            } else if (allSlides.length <= _.options.slidesToShow) {

	                allSlides
	                    .addClass('slick-active')
	                    .attr('aria-hidden', 'false');

	            } else {

	                remainder = _.slideCount % _.options.slidesToShow;
	                indexOffset = _.options.infinite === true ? _.options.slidesToShow + index : index;

	                if (_.options.slidesToShow == _.options.slidesToScroll && (_.slideCount - index) < _.options.slidesToShow) {

	                    allSlides
	                        .slice(indexOffset - (_.options.slidesToShow - remainder), indexOffset + remainder)
	                        .addClass('slick-active')
	                        .attr('aria-hidden', 'false');

	                } else {

	                    allSlides
	                        .slice(indexOffset, indexOffset + _.options.slidesToShow)
	                        .addClass('slick-active')
	                        .attr('aria-hidden', 'false');

	                }

	            }

	        }

	        if (_.options.lazyLoad === 'ondemand') {
	            _.lazyLoad();
	        }

	    };

	    Slick.prototype.setupInfinite = function() {

	        var _ = this,
	            i, slideIndex, infiniteCount;

	        if (_.options.fade === true) {
	            _.options.centerMode = false;
	        }

	        if (_.options.infinite === true && _.options.fade === false) {

	            slideIndex = null;

	            if (_.slideCount > _.options.slidesToShow) {

	                if (_.options.centerMode === true) {
	                    infiniteCount = _.options.slidesToShow + 1;
	                } else {
	                    infiniteCount = _.options.slidesToShow;
	                }

	                for (i = _.slideCount; i > (_.slideCount -
	                        infiniteCount); i -= 1) {
	                    slideIndex = i - 1;
	                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
	                        .attr('data-slick-index', slideIndex - _.slideCount)
	                        .prependTo(_.$slideTrack).addClass('slick-cloned');
	                }
	                for (i = 0; i < infiniteCount; i += 1) {
	                    slideIndex = i;
	                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
	                        .attr('data-slick-index', slideIndex + _.slideCount)
	                        .appendTo(_.$slideTrack).addClass('slick-cloned');
	                }
	                _.$slideTrack.find('.slick-cloned').find('[id]').each(function() {
	                    $(this).attr('id', '');
	                });

	            }

	        }

	    };

	    Slick.prototype.interrupt = function( toggle ) {

	        var _ = this;

	        if( !toggle ) {
	            _.autoPlay();
	        }
	        _.interrupted = toggle;

	    };

	    Slick.prototype.selectHandler = function(event) {

	        var _ = this;

	        var targetElement =
	            $(event.target).is('.slick-slide') ?
	                $(event.target) :
	                $(event.target).parents('.slick-slide');

	        var index = parseInt(targetElement.attr('data-slick-index'));

	        if (!index) index = 0;

	        if (_.slideCount <= _.options.slidesToShow) {

	            _.setSlideClasses(index);
	            _.asNavFor(index);
	            return;

	        }

	        _.slideHandler(index);

	    };

	    Slick.prototype.slideHandler = function(index, sync, dontAnimate) {

	        var targetSlide, animSlide, oldSlide, slideLeft, targetLeft = null,
	            _ = this, navTarget;

	        sync = sync || false;

	        if (_.animating === true && _.options.waitForAnimate === true) {
	            return;
	        }

	        if (_.options.fade === true && _.currentSlide === index) {
	            return;
	        }

	        if (_.slideCount <= _.options.slidesToShow) {
	            return;
	        }

	        if (sync === false) {
	            _.asNavFor(index);
	        }

	        targetSlide = index;
	        targetLeft = _.getLeft(targetSlide);
	        slideLeft = _.getLeft(_.currentSlide);

	        _.currentLeft = _.swipeLeft === null ? slideLeft : _.swipeLeft;

	        if (_.options.infinite === false && _.options.centerMode === false && (index < 0 || index > _.getDotCount() * _.options.slidesToScroll)) {
	            if (_.options.fade === false) {
	                targetSlide = _.currentSlide;
	                if (dontAnimate !== true) {
	                    _.animateSlide(slideLeft, function() {
	                        _.postSlide(targetSlide);
	                    });
	                } else {
	                    _.postSlide(targetSlide);
	                }
	            }
	            return;
	        } else if (_.options.infinite === false && _.options.centerMode === true && (index < 0 || index > (_.slideCount - _.options.slidesToScroll))) {
	            if (_.options.fade === false) {
	                targetSlide = _.currentSlide;
	                if (dontAnimate !== true) {
	                    _.animateSlide(slideLeft, function() {
	                        _.postSlide(targetSlide);
	                    });
	                } else {
	                    _.postSlide(targetSlide);
	                }
	            }
	            return;
	        }

	        if ( _.options.autoplay ) {
	            clearInterval(_.autoPlayTimer);
	        }

	        if (targetSlide < 0) {
	            if (_.slideCount % _.options.slidesToScroll !== 0) {
	                animSlide = _.slideCount - (_.slideCount % _.options.slidesToScroll);
	            } else {
	                animSlide = _.slideCount + targetSlide;
	            }
	        } else if (targetSlide >= _.slideCount) {
	            if (_.slideCount % _.options.slidesToScroll !== 0) {
	                animSlide = 0;
	            } else {
	                animSlide = targetSlide - _.slideCount;
	            }
	        } else {
	            animSlide = targetSlide;
	        }

	        _.animating = true;

	        _.$slider.trigger('beforeChange', [_, _.currentSlide, animSlide]);

	        oldSlide = _.currentSlide;
	        _.currentSlide = animSlide;

	        _.setSlideClasses(_.currentSlide);

	        if ( _.options.asNavFor ) {

	            navTarget = _.getNavTarget();
	            navTarget = navTarget.slick('getSlick');

	            if ( navTarget.slideCount <= navTarget.options.slidesToShow ) {
	                navTarget.setSlideClasses(_.currentSlide);
	            }

	        }

	        _.updateDots();
	        _.updateArrows();

	        if (_.options.fade === true) {
	            if (dontAnimate !== true) {

	                _.fadeSlideOut(oldSlide);

	                _.fadeSlide(animSlide, function() {
	                    _.postSlide(animSlide);
	                });

	            } else {
	                _.postSlide(animSlide);
	            }
	            _.animateHeight();
	            return;
	        }

	        if (dontAnimate !== true) {
	            _.animateSlide(targetLeft, function() {
	                _.postSlide(animSlide);
	            });
	        } else {
	            _.postSlide(animSlide);
	        }

	    };

	    Slick.prototype.startLoad = function() {

	        var _ = this;

	        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

	            _.$prevArrow.hide();
	            _.$nextArrow.hide();

	        }

	        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

	            _.$dots.hide();

	        }

	        _.$slider.addClass('slick-loading');

	    };

	    Slick.prototype.swipeDirection = function() {

	        var xDist, yDist, r, swipeAngle, _ = this;

	        xDist = _.touchObject.startX - _.touchObject.curX;
	        yDist = _.touchObject.startY - _.touchObject.curY;
	        r = Math.atan2(yDist, xDist);

	        swipeAngle = Math.round(r * 180 / Math.PI);
	        if (swipeAngle < 0) {
	            swipeAngle = 360 - Math.abs(swipeAngle);
	        }

	        if ((swipeAngle <= 45) && (swipeAngle >= 0)) {
	            return (_.options.rtl === false ? 'left' : 'right');
	        }
	        if ((swipeAngle <= 360) && (swipeAngle >= 315)) {
	            return (_.options.rtl === false ? 'left' : 'right');
	        }
	        if ((swipeAngle >= 135) && (swipeAngle <= 225)) {
	            return (_.options.rtl === false ? 'right' : 'left');
	        }
	        if (_.options.verticalSwiping === true) {
	            if ((swipeAngle >= 35) && (swipeAngle <= 135)) {
	                return 'down';
	            } else {
	                return 'up';
	            }
	        }

	        return 'vertical';

	    };

	    Slick.prototype.swipeEnd = function(event) {

	        var _ = this,
	            slideCount,
	            direction;

	        _.dragging = false;
	        _.interrupted = false;
	        _.shouldClick = ( _.touchObject.swipeLength > 10 ) ? false : true;

	        if ( _.touchObject.curX === undefined ) {
	            return false;
	        }

	        if ( _.touchObject.edgeHit === true ) {
	            _.$slider.trigger('edge', [_, _.swipeDirection() ]);
	        }

	        if ( _.touchObject.swipeLength >= _.touchObject.minSwipe ) {

	            direction = _.swipeDirection();

	            switch ( direction ) {

	                case 'left':
	                case 'down':

	                    slideCount =
	                        _.options.swipeToSlide ?
	                            _.checkNavigable( _.currentSlide + _.getSlideCount() ) :
	                            _.currentSlide + _.getSlideCount();

	                    _.currentDirection = 0;

	                    break;

	                case 'right':
	                case 'up':

	                    slideCount =
	                        _.options.swipeToSlide ?
	                            _.checkNavigable( _.currentSlide - _.getSlideCount() ) :
	                            _.currentSlide - _.getSlideCount();

	                    _.currentDirection = 1;

	                    break;

	                default:


	            }

	            if( direction != 'vertical' ) {

	                _.slideHandler( slideCount );
	                _.touchObject = {};
	                _.$slider.trigger('swipe', [_, direction ]);

	            }

	        } else {

	            if ( _.touchObject.startX !== _.touchObject.curX ) {

	                _.slideHandler( _.currentSlide );
	                _.touchObject = {};

	            }

	        }

	    };

	    Slick.prototype.swipeHandler = function(event) {

	        var _ = this;

	        if ((_.options.swipe === false) || ('ontouchend' in document && _.options.swipe === false)) {
	            return;
	        } else if (_.options.draggable === false && event.type.indexOf('mouse') !== -1) {
	            return;
	        }

	        _.touchObject.fingerCount = event.originalEvent && event.originalEvent.touches !== undefined ?
	            event.originalEvent.touches.length : 1;

	        _.touchObject.minSwipe = _.listWidth / _.options
	            .touchThreshold;

	        if (_.options.verticalSwiping === true) {
	            _.touchObject.minSwipe = _.listHeight / _.options
	                .touchThreshold;
	        }

	        switch (event.data.action) {

	            case 'start':
	                _.swipeStart(event);
	                break;

	            case 'move':
	                _.swipeMove(event);
	                break;

	            case 'end':
	                _.swipeEnd(event);
	                break;

	        }

	    };

	    Slick.prototype.swipeMove = function(event) {

	        var _ = this,
	            edgeWasHit = false,
	            curLeft, swipeDirection, swipeLength, positionOffset, touches;

	        touches = event.originalEvent !== undefined ? event.originalEvent.touches : null;

	        if (!_.dragging || touches && touches.length !== 1) {
	            return false;
	        }

	        curLeft = _.getLeft(_.currentSlide);

	        _.touchObject.curX = touches !== undefined ? touches[0].pageX : event.clientX;
	        _.touchObject.curY = touches !== undefined ? touches[0].pageY : event.clientY;

	        _.touchObject.swipeLength = Math.round(Math.sqrt(
	            Math.pow(_.touchObject.curX - _.touchObject.startX, 2)));

	        if (_.options.verticalSwiping === true) {
	            _.touchObject.swipeLength = Math.round(Math.sqrt(
	                Math.pow(_.touchObject.curY - _.touchObject.startY, 2)));
	        }

	        swipeDirection = _.swipeDirection();

	        if (swipeDirection === 'vertical') {
	            return;
	        }

	        if (event.originalEvent !== undefined && _.touchObject.swipeLength > 4) {
	            event.preventDefault();
	        }

	        positionOffset = (_.options.rtl === false ? 1 : -1) * (_.touchObject.curX > _.touchObject.startX ? 1 : -1);
	        if (_.options.verticalSwiping === true) {
	            positionOffset = _.touchObject.curY > _.touchObject.startY ? 1 : -1;
	        }


	        swipeLength = _.touchObject.swipeLength;

	        _.touchObject.edgeHit = false;

	        if (_.options.infinite === false) {
	            if ((_.currentSlide === 0 && swipeDirection === 'right') || (_.currentSlide >= _.getDotCount() && swipeDirection === 'left')) {
	                swipeLength = _.touchObject.swipeLength * _.options.edgeFriction;
	                _.touchObject.edgeHit = true;
	            }
	        }

	        if (_.options.vertical === false) {
	            _.swipeLeft = curLeft + swipeLength * positionOffset;
	        } else {
	            _.swipeLeft = curLeft + (swipeLength * (_.$list.height() / _.listWidth)) * positionOffset;
	        }
	        if (_.options.verticalSwiping === true) {
	            _.swipeLeft = curLeft + swipeLength * positionOffset;
	        }

	        if (_.options.fade === true || _.options.touchMove === false) {
	            return false;
	        }

	        if (_.animating === true) {
	            _.swipeLeft = null;
	            return false;
	        }

	        _.setCSS(_.swipeLeft);

	    };

	    Slick.prototype.swipeStart = function(event) {

	        var _ = this,
	            touches;

	        _.interrupted = true;

	        if (_.touchObject.fingerCount !== 1 || _.slideCount <= _.options.slidesToShow) {
	            _.touchObject = {};
	            return false;
	        }

	        if (event.originalEvent !== undefined && event.originalEvent.touches !== undefined) {
	            touches = event.originalEvent.touches[0];
	        }

	        _.touchObject.startX = _.touchObject.curX = touches !== undefined ? touches.pageX : event.clientX;
	        _.touchObject.startY = _.touchObject.curY = touches !== undefined ? touches.pageY : event.clientY;

	        _.dragging = true;

	    };

	    Slick.prototype.unfilterSlides = Slick.prototype.slickUnfilter = function() {

	        var _ = this;

	        if (_.$slidesCache !== null) {

	            _.unload();

	            _.$slideTrack.children(this.options.slide).detach();

	            _.$slidesCache.appendTo(_.$slideTrack);

	            _.reinit();

	        }

	    };

	    Slick.prototype.unload = function() {

	        var _ = this;

	        $('.slick-cloned', _.$slider).remove();

	        if (_.$dots) {
	            _.$dots.remove();
	        }

	        if (_.$prevArrow && _.htmlExpr.test(_.options.prevArrow)) {
	            _.$prevArrow.remove();
	        }

	        if (_.$nextArrow && _.htmlExpr.test(_.options.nextArrow)) {
	            _.$nextArrow.remove();
	        }

	        _.$slides
	            .removeClass('slick-slide slick-active slick-visible slick-current')
	            .attr('aria-hidden', 'true')
	            .css('width', '');

	    };

	    Slick.prototype.unslick = function(fromBreakpoint) {

	        var _ = this;
	        _.$slider.trigger('unslick', [_, fromBreakpoint]);
	        _.destroy();

	    };

	    Slick.prototype.updateArrows = function() {

	        var _ = this,
	            centerOffset;

	        centerOffset = Math.floor(_.options.slidesToShow / 2);

	        if ( _.options.arrows === true &&
	            _.slideCount > _.options.slidesToShow &&
	            !_.options.infinite ) {

	            _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');
	            _.$nextArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

	            if (_.currentSlide === 0) {

	                _.$prevArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
	                _.$nextArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

	            } else if (_.currentSlide >= _.slideCount - _.options.slidesToShow && _.options.centerMode === false) {

	                _.$nextArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
	                _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

	            } else if (_.currentSlide >= _.slideCount - 1 && _.options.centerMode === true) {

	                _.$nextArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
	                _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

	            }

	        }

	    };

	    Slick.prototype.updateDots = function() {

	        var _ = this;

	        if (_.$dots !== null) {

	            _.$dots
	                .find('li')
	                .removeClass('slick-active')
	                .attr('aria-hidden', 'true');

	            _.$dots
	                .find('li')
	                .eq(Math.floor(_.currentSlide / _.options.slidesToScroll))
	                .addClass('slick-active')
	                .attr('aria-hidden', 'false');

	        }

	    };

	    Slick.prototype.visibility = function() {

	        var _ = this;

	        if ( _.options.autoplay ) {

	            if ( document[_.hidden] ) {

	                _.interrupted = true;

	            } else {

	                _.interrupted = false;

	            }

	        }

	    };

	    $.fn.slick = function() {
	        var _ = this,
	            opt = arguments[0],
	            args = Array.prototype.slice.call(arguments, 1),
	            l = _.length,
	            i,
	            ret;
	        for (i = 0; i < l; i++) {
	            if (typeof opt == 'object' || typeof opt == 'undefined')
	                _[i].slick = new Slick(_[i], opt);
	            else
	                ret = _[i].slick[opt].apply(_[i].slick, args);
	            if (typeof ret != 'undefined') return ret;
	        }
	        return _;
	    };

	}));


/***/ },
/* 50 */
/***/ function(module, exports) {

	var Dismiss, Toggle;

	Toggle = (function() {
	  function Toggle(query) {
	    this.query = query;
	    $(document).on('click', this.query, (function(_this) {
	      return function(e) {
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
	    })(this));
	  }

	  Toggle.prototype.enable = function(targets) {
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

	  Toggle.prototype.disable = function(targets) {
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

	})();

	Dismiss = (function() {
	  function Dismiss(query) {
	    this.query = query;
	    $(document).on('click', this.query, function(e) {
	      var $this;
	      $this = $(this);
	      switch ($this.data('dismiss')) {
	        case 'alert':
	          return $this.parent().slideUp();
	      }
	    });
	  }

	  return Dismiss;

	})();

	module.exports = {
	  Toggle: Toggle,
	  Dismiss: Dismiss
	};


/***/ },
/* 51 */
/***/ function(module, exports) {

	var TextInput;

	TextInput = (function() {
	  function TextInput() {
	    $(document).on('focus', 'input.form-control, .text.form-control', (function(_this) {
	      return function(e) {
	        return _this.focus(e.currentTarget);
	      };
	    })(this)).on('blur', 'input.form-control, .text.form-control', (function(_this) {
	      return function(e) {
	        if ($(e.currentTarget).val().length > 0) {
	          return _this.focus(e.currentTarget);
	        } else {
	          return _this.blur(e.currentTarget);
	        }
	      };
	    })(this));
	  }

	  TextInput.prototype.focus = function(el) {
	    return $(el).parent().addClass('is-focused');
	  };

	  TextInput.prototype.blur = function(el) {
	    return $(el).parent().removeClass('is-focused');
	  };

	  return TextInput;

	})();

	module.exports = {
	  TextInput: TextInput
	};


/***/ },
/* 52 */
/***/ function(module, exports) {

	var Collapse;

	Collapse = (function() {
	  function Collapse(query) {
	    this.query = query;
	    $(document).on('page:change', (function(_this) {
	      return function() {
	        _this.toggle = $(_this.query);
	        _this.toggle_wrapper = _this.toggle.parent();
	        return _this.toggle_target = $(_this.toggle.data('collapse'));
	      };
	    })(this));
	    $(document).on('click', this.query, (function(_this) {
	      return function(e) {
	        _this.toggle.toggleClass('active');
	        _this.toggle_wrapper.toggleClass('extracted');
	        return _this.toggle_target.slideToggle(300);
	      };
	    })(this));
	  }

	  return Collapse;

	})();

	module.exports = Collapse;


/***/ },
/* 53 */
/***/ function(module, exports, __webpack_require__) {

	var Cookies, Rules;

	Cookies = __webpack_require__(54);

	Rules = (function() {
	  function Rules() {
	    $(document).on('click', '#appeal-to-schedule', (function(_this) {
	      return function(e) {
	        return _this.check_cookie(e, 'schedule');
	      };
	    })(this));
	    $(document).on('click', '#appeal-to-verdict', (function(_this) {
	      return function(e) {
	        return _this.check_cookie(e, 'verdict');
	      };
	    })(this));
	    $(document).on('click', '#confirmed-schedule-rules', (function(_this) {
	      return function(e) {
	        return _this.set_cookie_and_go(e, 'schedule');
	      };
	    })(this));
	    $(document).on('click', '#confirmed-verdict-rules', (function(_this) {
	      return function(e) {
	        return _this.set_cookie_and_go(e, 'verdict');
	      };
	    })(this));
	  }

	  Rules.prototype.check_cookie = function(e, type) {
	    var role;
	    e.preventDefault();
	    role = $(e.target).data('role');
	    if (Cookies.get(role + "_has_seen_" + type + "_rules")) {
	      return Turbolinks.visit(e.target.href);
	    } else {
	      return Turbolinks.visit("/" + role + "/score/" + type + "s/rule");
	    }
	  };

	  Rules.prototype.set_cookie_and_go = function(e, type) {
	    var role;
	    e.preventDefault();
	    role = $(e.target).data('role');
	    Cookies.set(role + "_has_seen_" + type + "_rules", true, {
	      expires: 7
	    });
	    return Turbolinks.visit(e.target.href);
	  };

	  return Rules;

	})();

	module.exports = Rules;


/***/ },
/* 54 */
/***/ function(module, exports, __webpack_require__) {

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
			!(__WEBPACK_AMD_DEFINE_FACTORY__ = (factory), __WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ? (__WEBPACK_AMD_DEFINE_FACTORY__.call(exports, __webpack_require__, exports, module)) : __WEBPACK_AMD_DEFINE_FACTORY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
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


/***/ },
/* 55 */
/***/ function(module, exports) {

	var ToTop;

	ToTop = (function() {
	  function ToTop(query) {
	    var $to_top;
	    this.query = query;
	    $to_top = $(this.query);
	    $to_top.on('click', function() {
	      $('html, body').animate({
	        scrollTop: 0
	      }, 500);
	      return false;
	    });
	    $(window).on('scroll', function() {
	      return requestAnimationFrame(function() {
	        if ($(window).scrollTop() > 100) {
	          return $to_top.addClass('active');
	        } else {
	          return $to_top.removeClass('active');
	        }
	      });
	    });
	  }

	  return ToTop;

	})();

	module.exports = ToTop;


/***/ },
/* 56 */
/***/ function(module, exports) {

	var Tab;

	Tab = (function() {
	  function Tab(query) {
	    this.query = query;
	    $(document).on("click", this.query, (function(_this) {
	      return function(e) {
	        var $this;
	        $this = $(e.currentTarget);
	        if (!$this.hasClass('active')) {
	          _this.update_active($this);
	          return _this.update_active($($this.data('tab-content')));
	        }
	      };
	    })(this));
	  }

	  Tab.prototype.update_active = function(el) {
	    return el.addClass('active').siblings().removeClass('active');
	  };

	  return Tab;

	})();

	module.exports = Tab;


/***/ },
/* 57 */
/***/ function(module, exports) {

	var next, prev;

	prev = function(class_name) {
	  return "<button type='button' class='" + class_name + "__prev appearance-none'>\n  <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>\n</button>";
	};

	next = function(class_name) {
	  return "<button type='button' class='" + class_name + "__next appearance-none'>\n  <svg class='icon'><use xlink:href='#icon-arrow-next' /></svg>\n</button>";
	};

	module.exports = {
	  prev: prev,
	  next: next
	};


/***/ },
/* 58 */
/***/ function(module, exports) {

	'use strict';

	$(document).on('ready page:load', function () {
	  $('.card--article img').each(function () {
	    $(this).wrap("<div class='image-wrapper'></div>");
	  });
	});

/***/ },
/* 59 */
/***/ function(module, exports, __webpack_require__) {

	var map = {
		"./arrow-last.svg": 60,
		"./arrow-next.svg": 64,
		"./avatar-lawyer.svg": 65,
		"./avatar-observer.svg": 66,
		"./avatar-party.svg": 67,
		"./chart.svg": 68,
		"./close.svg": 69,
		"./envelop.svg": 70,
		"./exit.svg": 71,
		"./file-search.svg": 72,
		"./forwards.svg": 73,
		"./info.svg": 74,
		"./key.svg": 75,
		"./medal.svg": 76,
		"./menu.svg": 77,
		"./pencil.svg": 78,
		"./phone.svg": 79,
		"./plus-circle-o.svg": 80,
		"./profile.svg": 81,
		"./star-full.svg": 82,
		"./star-half.svg": 83,
		"./star-o.svg": 84,
		"./star.svg": 85,
		"./user.svg": 86
	};
	function webpackContext(req) {
		return __webpack_require__(webpackContextResolve(req));
	};
	function webpackContextResolve(req) {
		return map[req] || (function() { throw new Error("Cannot find module '" + req + "'.") }());
	};
	webpackContext.keys = function webpackContextKeys() {
		return Object.keys(map);
	};
	webpackContext.resolve = webpackContextResolve;
	module.exports = webpackContext;
	webpackContext.id = 59;


/***/ },
/* 60 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-arrow-last\" ><path d=\"M20.034 11.407l-6.346-7.045c-.54-.483-1.07-.483-1.587 0-.517.483-.506.988.034 1.515l5.738 6.32-5.738 6.256c-.225.22-.338.472-.338.757 0 .285.113.538.338.757.495.527 1.013.527 1.553 0l6.346-7.045c.225-.22.337-.472.337-.757 0-.286-.112-.538-.337-.758zM4.37 19.967c.495.505 1.013.494 1.553-.033l6.414-7.045c.18-.22.27-.461.27-.724 0-.308-.09-.571-.27-.79L5.924 4.328a1.08 1.08 0 0 0-1.553 0c-.495.483-.495.988 0 1.515l5.739 6.32L4.37 18.42c-.495.527-.495 1.042 0 1.547z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-arrow-last");

/***/ },
/* 61 */
/***/ function(module, exports, __webpack_require__) {

	var Sprite, globalSprite, inject_sprite;

	Sprite = __webpack_require__(62);

	globalSprite = new Sprite();

	inject_sprite = function() {
	  return globalSprite.elem = globalSprite.render(document.body);
	};

	document.addEventListener('DOMContentLoaded', inject_sprite, false);

	document.addEventListener('page:load', inject_sprite, false);

	module.exports = globalSprite;


/***/ },
/* 62 */
/***/ function(module, exports, __webpack_require__) {

	var Sniffr = __webpack_require__(63);

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

	      if (this.browser.name === 'firefox' || this.browser.name === 'edge' || this.browser.name === 'chrome' && this.browser.version[0] >= 49) {
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

	Sprite.styles = ['position:absolute', 'width:0', 'height:0', 'visibility:hidden'];

	Sprite.spriteTemplate = svgOpening + ' style="'+ Sprite.styles.join(';') +'"><defs>' + contentPlaceHolder + '</defs>' + svgClosing;
	Sprite.symbolTemplate = svgOpening + '>' + contentPlaceHolder + svgClosing;

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

	  /**
	   * Fix for browser (IE, maybe other too) which are throwing 'WrongDocumentError'
	   * if you insert an element which is not part of the document
	   * @see http://stackoverflow.com/questions/7981100/how-do-i-dynamically-insert-an-svg-image-into-html#7986519
	   */
	  if (document.importNode) {
	    svg = document.importNode(svg, true);
	  }

	  if (this.browser.name !== 'ie' && this.urlPrefix) {
	    baseUrlWorkAround(svg, DEFAULT_URI_PREFIX, this.urlPrefix);
	  }

	  return svg;
	};

	Sprite.prototype.appendSymbol = function (content) {
	  var symbol = this.wrapSVG(content, Sprite.symbolTemplate).childNodes[0];

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

	  var svg = this.wrapSVG(this.content.join(''), Sprite.spriteTemplate);

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


/***/ },
/* 63 */
/***/ function(module, exports) {

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


/***/ },
/* 64 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-arrow-next\" ><path d=\"M16.312 11.407L9.966 4.362c-.54-.483-1.068-.483-1.586 0s-.506.988.034 1.515l5.738 6.32-5.738 6.256c-.225.22-.338.472-.338.757 0 .285.113.538.338.757.495.527 1.012.527 1.552 0l6.346-7.045c.225-.22.338-.472.338-.757 0-.286-.113-.538-.338-.758z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-arrow-next");

/***/ },
/* 65 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 183.08 70.95\" id=\"icon-avatar-lawyer\" ><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M29.88 15.19s24 26.25 24 29.25v24.5M153.88 15.19s-24 26.25-24 29.25v24.5\"/><path d=\"M.27 20.94l24.11-6.66V9.94s-.91-2.15 3.52-3.14S53.75 1 56.51 1c3.76 0 30.57 34.94 30.3 39.38-.16 2.61-.09 30.56-.09 30.56M182.81 20.94l-24.43-6.66V9.94s1.23-2.15-3.2-3.14S129.48 1 126.72 1C123 1 96.23 35.94 96.5 40.38c.16 2.61 0 30.56 0 30.56\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-avatar-lawyer");

/***/ },
/* 66 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 141.8 57.5\" id=\"icon-avatar-observer\" ><g fill=\"none\" data-name=\"Layer 4\"><circle cx=\"33.59\" cy=\"28.75\" r=\"27.75\"/><circle cx=\"109.48\" cy=\"28.75\" r=\"27.75\"/><path d=\"M56.84 20.75s14.5-7.25 29 0M133 20.68s7.37-1.82 7.87 0M8.84 20.68s-7.37-1.82-7.87 0\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-avatar-observer");

/***/ },
/* 67 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 72.21 94.12\" id=\"icon-avatar-party\" ><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M57.53 93.47s12.3-14.59 12.3-17.75 3.08-25.25 0-33.25c-1.26-3.27-12-2-12-2L52 56s-15.81 2.69-21.81 25.75M30.34 3.47v41M43.34 3.47v41\"/><path d=\"M57.71 41s.82-17.19-1-28.5c-.86-5.31-6.8-8.26-13.49-9.41-7.78-4.38-12.75-.51-13.37 0h-.07c-7.33 1.39-11 3.55-11.93 7.38-.66 2.79-.92 26.73-1 36.55V21.71c0-4.56-6.24-2.89-7.85-1-7.76 9.1-8 47-8 47l9.06 23.73\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-avatar-party");

/***/ },
/* 68 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 56 57\" id=\"icon-chart\" ><path d=\"M43.604 44.469V31.927h-6.27V44.47h6.27zm-12.541 0V13.26h-6.125V44.47h6.125zm-12.396 0V22.594h-6.271v21.875h6.27zM49.729.865c1.653 0 3.111.632 4.375 1.895C55.368 4.024 56 5.483 56 7.135v43.459c0 1.653-.632 3.11-1.896 4.375-1.264 1.264-2.722 1.896-4.375 1.896H6.271c-1.653 0-3.111-.632-4.375-1.896C.632 53.705 0 52.247 0 50.594V7.135c0-1.652.632-3.11 1.896-4.375C3.16 1.497 4.618.865 6.27.865h43.458z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-chart");

/***/ },
/* 69 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 8 8\" id=\"icon-close\" ><path d=\"M8 .805L4.805 4 8 7.195 7.195 8 4 4.805.805 8 0 7.195 3.195 4 0 .805.805 0 4 3.195 7.195 0z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-close");

/***/ },
/* 70 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-envelop\" ><path d=\"M18.737 8H5.263C4.567 8 4 8.56 4 9.25v7.5c0 .69.567 1.25 1.263 1.25h13.474c.696 0 1.263-.56 1.263-1.25v-7.5C20 8.56 19.433 8 18.737 8zm0 .833c.025 0 .049.003.073.007l-6.343 4.184c-.244.161-.69.161-.934 0L5.191 8.84a.42.42 0 0 1 .073-.007h13.474-.001zm0 8.334H5.263a.419.419 0 0 1-.42-.417V9.612l6.223 4.105c.262.173.598.26.934.26.336 0 .672-.087.934-.26l6.224-4.105v7.138c0 .23-.189.417-.421.417z\" fill=\"currentColor\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-envelop");

/***/ },
/* 71 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-exit\" ><path d=\"M14.208 0c.473 0 .89.18 1.25.542.361.36.542.777.542 1.25v12.416c0 .473-.18.89-.542 1.25-.36.361-.777.542-1.25.542H1.792c-.5 0-.924-.18-1.271-.542-.347-.36-.521-.777-.521-1.25v-3.541h1.792v3.541h12.416V1.792H1.792v3.541H0V1.792c0-.473.174-.89.52-1.25C.869.18 1.293 0 1.793 0h12.416zM6.292 11.738l2.291-2.355H0V7.617h8.583L6.292 5.262 7.542 4 12 8.5 7.542 13l-1.25-1.262z\" fill-rule=\"evenodd\" fill-opacity=\".87\"/></symbol>";
	module.exports = sprite.add(image, "icon-exit");

/***/ },
/* 72 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-file-search\" ><g fill=\"currentColor\" fill-rule=\"evenodd\"><path d=\"M18.881 7.912l-3.656-3.79A.399.399 0 0 0 14.937 4H7.22C6.547 4 6 4.567 6 5.263v13.474C6 19.433 6.547 20 7.219 20H17.78c.672 0 1.219-.567 1.219-1.263V8.21a.432.432 0 0 0-.119-.299zm-.862.299h-2.675a.414.414 0 0 1-.407-.422V5.016l3.082 3.195zm-.238 10.947H7.22a.414.414 0 0 1-.407-.421V5.263c0-.232.182-.42.407-.42h6.906v2.946c0 .697.547 1.264 1.219 1.264h2.844v9.684a.414.414 0 0 1-.407.42z\"/><path d=\"M16.467 17.623l-2.387-2.924c.532-.6.857-1.4.857-2.278 0-1.858-1.457-3.368-3.25-3.368-1.792 0-3.25 1.51-3.25 3.368 0 1.858 1.458 3.368 3.25 3.368.654 0 1.262-.2 1.773-.545l2.386 2.923a.4.4 0 0 0 .573.05.432.432 0 0 0 .048-.594zM9.25 12.42c0-1.393 1.094-2.526 2.438-2.526 1.343 0 2.437 1.133 2.437 2.526 0 1.393-1.094 2.526-2.438 2.526-1.343 0-2.437-1.133-2.437-2.526z\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-file-search");

/***/ },
/* 73 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 18 18\" id=\"icon-forwards\" ><g fill-rule=\"evenodd\"><path d=\"M17.429 8.929a8.5 8.5 0 1 0-17 0 8.5 8.5 0 0 0 17 0zm-15.867 0a7.367 7.367 0 1 1 14.733 0 7.367 7.367 0 0 1-14.733 0z\"/><path d=\"M9 5l4 4-4 4-.702-.702 2.784-2.807H5V8.51h6.082L8.298 5.702z\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-forwards");

/***/ },
/* 74 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 12 12\" id=\"icon-info\" ><path d=\"M5.408 4.183V2.972h1.184v1.211H5.408zM6 10.803c1.315 0 2.446-.474 3.394-1.423.949-.948 1.423-2.08 1.423-3.394 0-1.315-.474-2.446-1.423-3.394C8.446 1.643 7.314 1.169 6 1.169c-1.315 0-2.446.474-3.394 1.423-.949.948-1.423 2.08-1.423 3.394s.474 2.446 1.423 3.394c.948.949 2.08 1.423 3.394 1.423zM6-.014c1.653 0 3.066.587 4.24 1.76C11.412 2.92 12 4.333 12 5.986s-.587 3.066-1.76 4.24c-1.174 1.173-2.587 1.76-4.24 1.76s-3.066-.587-4.24-1.76C.588 9.051 0 7.638 0 5.985s.587-3.066 1.76-4.24C2.935.573 4.348-.014 6-.014zM5.408 9V5.394h1.184V9H5.408z\" fill-rule=\"evenodd\" fill-opacity=\".7\"/></symbol>";
	module.exports = sprite.add(image, "icon-info");

/***/ },
/* 75 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 17 16\" id=\"icon-key\" ><g fill-rule=\"evenodd\"><path d=\"M7.564 7.349c.06 0 .121-.02.17-.062l5.83-4.961-.34-.376-5.83 4.96a.245.245 0 0 0-.024.353.26.26 0 0 0 .194.086z\"/><path d=\"M5.248 16c3.164 0 5.055-2.415 5.055-4.75 0-.673-.166-1.415-.411-1.896l2.33-1.13A.25.25 0 0 0 12.363 8V6h1.545l.058-.003c.343-.022.446-.128.457-.497v-2h1.546c.066 0 .112.007.143.011.062.01.179.027.28-.06.104-.09.1-.204.095-.305-.001-.036-.003-.083-.003-.146V.735A.747.747 0 0 0 15.728 0h-1.996a.776.776 0 0 0-.5.182L6.44 5.962c-.334-.065-.84-.15-1.191-.15C2.354 5.813 0 8.098 0 10.907 0 13.714 2.354 16 5.248 16zm0-9.688c.258 0 .7.06 1.213.164a.26.26 0 0 0 .223-.056L13.572.559a.249.249 0 0 1 .16-.059h1.996c.134 0 .242.105.242.235V3h-1.803a.254.254 0 0 0-.258.25V5.5h-1.803a.254.254 0 0 0-.258.25v2.096l-2.433 1.18a.252.252 0 0 0-.135.165.244.244 0 0 0 .041.205c.227.304.467 1.057.467 1.854 0 2.089-1.698 4.25-4.54 4.25-2.61 0-4.733-2.061-4.733-4.594 0-2.533 2.124-4.594 4.733-4.594z\"/><path d=\"M4.379 13.5c.994 0 1.803-.785 1.803-1.75S5.373 10 4.379 10c-.994 0-1.803.785-1.803 1.75s.809 1.75 1.803 1.75zm0-3c.71 0 1.288.561 1.288 1.25S5.089 13 4.379 13c-.71 0-1.288-.561-1.288-1.25s.578-1.25 1.288-1.25z\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-key");

/***/ },
/* 76 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-medal\" ><path d=\"M15.618 5.628l-.528-1.625h-1.708L12 3l-1.382 1.003H8.91l-.528 1.625L7 6.632l.528 1.624L7 9.881l1.382 1.003.314.964v8.68a.474.474 0 0 0 .733.393L12 19.207l2.57 1.714a.47.47 0 0 0 .485.023.47.47 0 0 0 .25-.416v-8.68l.313-.964L17 9.881l-.528-1.625L17 6.632l-1.382-1.004zm-.803 4.673l-.408 1.26h-.046l-1.285.003-1.075.78-1.075-.78H9.597l-.41-1.264-1.076-.78.41-1.265-.41-1.264 1.076-.78.41-1.264h1.329L12 4.166l1.075.78h1.329l.41 1.265 1.076.78-.411 1.264.41 1.264-1.075.782z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-medal");

/***/ },
/* 77 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 18 12\" id=\"icon-menu\" ><path d=\"M0 12h18v-2H0v2zm0-5h18V5H0v2zm0-7v2h18V0H0z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-menu");

/***/ },
/* 78 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-pencil\" ><g fill-rule=\"evenodd\"><path d=\"M2.8 13.6a.4.4 0 0 1-.376-.537l1.6-4.4a.408.408 0 0 1 .093-.146l8.4-8.4a.4.4 0 0 1 .565 0l2.8 2.8a.4.4 0 0 1 0 .565l-8.4 8.4a.397.397 0 0 1-.146.093l-4.4 1.6a.404.404 0 0 1-.137.024l.001.001zm1.946-4.58l-1.277 3.511 3.511-1.277L15.034 3.2 12.8.966 4.746 9.02z\"/><path d=\"M14 16H1.2C.538 16 0 15.462 0 14.8V2C0 1.338.538.8 1.2.8h8a.4.4 0 0 1 0 .8h-8a.4.4 0 0 0-.4.4v12.8c0 .22.18.4.4.4H14a.4.4 0 0 0 .4-.4v-8a.4.4 0 0 1 .8 0v8c0 .662-.538 1.2-1.2 1.2z\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-pencil");

/***/ },
/* 79 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 24 24\" id=\"icon-phone\" ><g fill=\"currentColor\" fill-rule=\"evenodd\"><path d=\"M15.781 20H8.47a1.211 1.211 0 0 1-1.219-1.2V14c0-.22.182-.4.406-.4.225 0 .407.18.407.4v4.8c0 .22.181.4.406.4h7.312c.224 0 .406-.18.406-.4V5.2c0-.22-.182-.4-.406-.4h-3.25a.403.403 0 0 1-.406-.4c0-.22.182-.4.406-.4h3.25C16.453 4 17 4.538 17 5.2v13.6c0 .662-.547 1.2-1.219 1.2z\"/><path d=\"M14.969 16.8H9.28a.403.403 0 0 1-.406-.4V14c0-.22.182-.4.406-.4.224 0 .406.18.406.4v2h4.876V6.4h-.407a.403.403 0 0 1-.406-.4c0-.22.182-.4.406-.4h.813c.224 0 .406.18.406.4v10.4c0 .22-.182.4-.406.4zM12.531 18.4h-.812a.403.403 0 0 1-.406-.4c0-.22.181-.4.406-.4h.812c.224 0 .406.18.406.4 0 .22-.181.4-.406.4z\"/><path d=\"M8.469 12.8C6.004 12.8 4 10.826 4 8.4S6.004 4 8.469 4c2.464 0 4.469 1.974 4.469 4.4s-2.005 4.4-4.47 4.4zm0-8c-2.016 0-3.656 1.615-3.656 3.6S6.452 12 8.469 12s3.656-1.615 3.656-3.6-1.64-3.6-3.656-3.6z\"/><path d=\"M8.469 7.2a.403.403 0 0 1-.406-.4V6c0-.22.181-.4.406-.4.224 0 .406.18.406.4v.8c0 .22-.182.4-.406.4zM8.469 11.2a.403.403 0 0 1-.406-.4V8.4c0-.22.181-.4.406-.4.224 0 .406.18.406.4v2.4c0 .22-.182.4-.406.4z\"/></g></symbol>";
	module.exports = sprite.add(image, "icon-phone");

/***/ },
/* 80 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"icon-plus-circle-o\" ><path d=\"M8 14.404c1.753 0 3.261-.632 4.526-1.897 1.264-1.264 1.897-2.773 1.897-4.526 0-1.753-.633-3.261-1.897-4.526C11.26 2.191 9.753 1.56 8 1.56c-1.753 0-3.261.632-4.526 1.896C2.21 4.72 1.577 6.228 1.577 7.981c0 1.753.633 3.262 1.897 4.526C4.74 13.772 6.247 14.404 8 14.404zM8-.02c2.203 0 4.088.783 5.653 2.348C15.218 3.894 16 5.778 16 7.98c0 2.204-.782 4.088-2.347 5.653-1.565 1.565-3.45 2.347-5.653 2.347-2.203 0-4.088-.782-5.653-2.347C.782 12.069 0 10.184 0 7.98 0 5.778.782 3.894 2.347 2.33 3.912.764 5.797-.02 8-.02zm.789 3.981v3.23h3.23V8.77h-3.23V12H7.21V8.77h-3.23V7.192h3.23v-3.23H8.79z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-plus-circle-o");

/***/ },
/* 81 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 18 16\" id=\"icon-profile\" ><path d=\"M.187 15.992a.253.253 0 0 0 .308-.177c.519-1.922 2.627-2.42 3.887-2.718.316-.074.565-.133.727-.203 1.435-.618 1.903-1.614 2.043-2.34a.25.25 0 0 0-.083-.236c-.747-.64-1.378-1.602-1.776-2.709a.246.246 0 0 0-.051-.085c-.527-.568-.829-1.169-.829-1.647 0-.28.106-.467.346-.609a.25.25 0 0 0 .122-.204C4.992 2.517 6.819.512 9.061.5l.053.003c2.252.031 4.068 2.08 4.133 4.663a.248.248 0 0 0 .09.184c.157.133.23.3.23.529 0 .4-.214.893-.604 1.386a.26.26 0 0 0-.042.079c-.403 1.268-1.126 2.388-1.984 3.073a.25.25 0 0 0-.09.241c.14.726.609 1.72 2.044 2.34.17.073.433.13.767.202 1.247.268 3.335.717 3.847 2.616a.252.252 0 0 0 .486-.13c-.591-2.194-2.956-2.702-4.226-2.975-.295-.064-.55-.118-.673-.172-.937-.404-1.514-1.02-1.718-1.833.87-.742 1.597-1.886 2.013-3.17.442-.57.685-1.156.685-1.658 0-.334-.109-.613-.324-.831C13.628 2.243 11.614.036 9.114 0L9.04 0C6.585.013 4.563 2.162 4.386 4.916c-.315.23-.475.552-.475.962 0 .591.336 1.299.926 1.948.408 1.112 1.04 2.088 1.791 2.772-.203.816-.78 1.434-1.72 1.838-.12.053-.362.11-.642.176-1.28.302-3.661.865-4.257 3.074a.25.25 0 0 0 .178.306z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-profile");

/***/ },
/* 82 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-full\" ><path d=\"M17 25.679L6.465 32l2.793-11.852L0 12.168l12.211-1.027L17 0l4.789 11.14L34 12.169l-9.258 7.98L27.535 32z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-star-full");

/***/ },
/* 83 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-half\" ><defs><radialGradient cy=\"0%\" fx=\"50%\" fy=\"0%\" r=\"100%\" id=\"icon-star-half_a\"><stop stop-color=\"currentColor\" offset=\"0%\"/><stop stop-color=\"currentColor\" offset=\"100%\"/></radialGradient></defs><path d=\"M17 22.542l6.385 3.862-1.676-7.172 5.667-4.887-7.503-.63L17 6.935v15.606zm17-10.325l-9.258 7.96L27.535 32 17 25.695 6.465 32l2.793-11.823L0 12.217l12.211-1.025L17 0l4.789 11.192L34 12.217z\" fill=\"currentColor\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-star-half");

/***/ },
/* 84 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"icon-star-o\" ><path d=\"M17 22.598l6.385 3.792-1.676-7.19 5.667-4.899-7.503-.632L17 6.874l-2.873 6.795-7.503.632 5.667 4.899-1.676 7.19L17 22.598zm17-10.43l-9.258 7.98L27.535 32 17 25.679 6.465 32l2.793-11.852L0 12.168l12.211-1.027L17 0l4.789 11.14L34 12.169z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-star-o");

/***/ },
/* 85 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 60 56\" id=\"icon-star\" ><path d=\"M30 44.938L11.408 56l4.93-20.74L0 21.293l21.55-1.798L30 0l8.45 19.496L60 21.294 43.662 35.259 48.592 56z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-star");

/***/ },
/* 86 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(61);
	var image = "<symbol viewBox=\"0 0 56 57\" id=\"icon-user\" ><path d=\"M28 35.082c5.895 0 12.035 1.283 18.421 3.848C52.807 41.495 56 44.852 56 49v7.04H0V49c0-4.148 3.193-7.505 9.579-10.07 6.386-2.565 12.526-3.848 18.421-3.848zm0-7.041c-3.82 0-7.096-1.365-9.825-4.094-2.729-2.729-4.093-6.004-4.093-9.824 0-3.82 1.364-7.123 4.093-9.907C20.905 1.433 24.18.041 28 .041c3.82 0 7.096 1.392 9.825 4.175 2.729 2.784 4.093 6.086 4.093 9.907 0 3.82-1.364 7.095-4.093 9.824-2.73 2.73-6.004 4.094-9.825 4.094z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "icon-user");

/***/ }
/******/ ])));