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

	var Dismiss, Rules, StoryCollapse, TextInput, Toggle, ref, sprites;

	__webpack_require__(9);

	__webpack_require__(31);

	__webpack_require__(32);

	__webpack_require__(33);

	ref = __webpack_require__(35), Toggle = ref.Toggle, Dismiss = ref.Dismiss;

	TextInput = __webpack_require__(36).TextInput;

	StoryCollapse = __webpack_require__(37);

	Rules = __webpack_require__(38);

	sprites = __webpack_require__(40);

	sprites.keys().forEach(sprites);

	new TextInput();

	new StoryCollapse('#story-collapse-toggle');

	new Toggle('.switch');

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
	  return $('.popover-trigger').webuiPopover();
	});

	$(document).on("page:change", function() {
	  var $main_header;
	  $('input.form-control:not([autofocus], :hidden)').trigger('blur');
	  Waypoint.destroyAll();
	  $main_header = $('#main-header');
	  return $('.card__heading, .character-selector__heading').waypoint({
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
/* 32 */
/***/ function(module, exports) {

	/*!
	Waypoints - 4.0.0
	Copyright © 2011-2015 Caleb Troughton
	Licensed under the MIT license.
	https://github.com/imakewebthings/waypoints/blog/master/licenses.txt
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
	    Waypoint.invokeAll('enable')
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
	    if (horizontalEmpty && verticalEmpty) {
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
	        waypoint.triggerPoint = elementOffset + contextModifier - adjustment
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
/* 33 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/*
	 *  webui popover plugin  - v1.2.12
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
	            !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(34)], __WEBPACK_AMD_DEFINE_FACTORY__ = (factory), __WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ? (__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
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

	        var isMobile = ('ontouchstart' in document.documentElement) && (/Mobi/.test(navigator.userAgent));

	        //var removeAllTargets = function() {
	        // for (var i = 0; i < _srcElements.length; i++) {
	        //     var pop = getPopFromElement(_srcElements[i]);
	        //     console.log(pop.$target);
	        // }
	        //};

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

	        }

	        WebuiPopover.prototype = {
	            //init webui popover
	            init: function() {
	                if (this.getTrigger() !== 'manual') {
	                    //init the event handlers
	                    if (this.getTrigger() === 'click' || isMobile) {
	                        this.$element.off('click touchend').on('click touchend', $.proxy(this.toggle, this));
	                    } else if (this.getTrigger() === 'hover') {
	                        this.$element
	                            .off('mouseenter mouseleave click')
	                            .on('mouseenter', $.proxy(this.mouseenterHandler, this))
	                            .on('mouseleave', $.proxy(this.mouseleaveHandler, this));
	                    }
	                }
	                this._poped = false;
	                this._inited = true;
	                this._opened = false;
	                this._idSeed = _globalIdSeed;
	                // normalize container
	                this.options.container = $(this.options.container || document.body).first();

	                if (this.options.backdrop) {
	                    backdrop.appendTo(this.options.container).hide();
	                }
	                _globalIdSeed++;
	                if (this.getTrigger() === 'sticky') {
	                    this.show();
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
	            toggle: function(e) {
	                if (e) {
	                    e.preventDefault();
	                    e.stopPropagation();
	                }
	                this[this.getTarget().hasClass('in') ? 'hide' : 'show']();
	            },
	            hideAll: function() {
	                hideAllPop();
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
	                    this.hideAll();
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
	                        .attr('id', id)
	                        .data('trigger-element', this.getTriggerElement());
	                    this._customTargetClass = this.$target.attr('class') !== pluginClass ? this.$target.attr('class') : null;
	                    this.getTriggerElement().attr('data-target', id);
	                }
	                return this.$target;
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
	            mouseenterHandler: function() {
	                var self = this;
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
	                        placement = 'right-top';
	                    } else if (pageY < clientHeight * 2 / 3) {
	                        placement = 'right';
	                    } else {
	                        placement = 'right-bottom';
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
	                $(selector).each(function(item) {
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
	            return {
	                show: _show,
	                hide: _hide,
	                create: _create,
	                isCreated: _isCreated,
	                hideAll: _hideAll
	            };
	        })();
	        window.WebuiPopovers = webuiPopovers;
	    }));
	})(window, document);


/***/ },
/* 34 */
/***/ function(module, exports) {

	module.exports = jQuery;

/***/ },
/* 35 */
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
/* 36 */
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
/* 37 */
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
/* 38 */
/***/ function(module, exports, __webpack_require__) {

	var Cookies, Rules;

	Cookies = __webpack_require__(39);

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
/* 39 */
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
/* 40 */
/***/ function(module, exports, __webpack_require__) {

	var map = {
		"./avatar-lawyer.svg": 41,
		"./avatar-observer.svg": 45,
		"./avatar-party.svg": 46,
		"./chart.svg": 47,
		"./close.svg": 48,
		"./exit.svg": 49,
		"./forwards.svg": 50,
		"./info.svg": 51,
		"./key.svg": 52,
		"./menu.svg": 53,
		"./pencil.svg": 54,
		"./plus-circle-o.svg": 55,
		"./profile.svg": 56,
		"./star-full.svg": 57,
		"./star-half.svg": 58,
		"./star-o.svg": 59,
		"./star.svg": 60,
		"./user.svg": 61
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
	webpackContext.id = 40;


/***/ },
/* 41 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 183.08 70.95\" id=\"avatar-lawyer\" ><title>&#x8CC7;&#x7522; 4</title><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M29.88 15.19s24 26.25 24 29.25v24.5M153.88 15.19s-24 26.25-24 29.25v24.5\"/><path d=\"M.27 20.94l24.11-6.66V9.94s-.91-2.15 3.52-3.14S53.75 1 56.51 1c3.76 0 30.57 34.94 30.3 39.38-.16 2.61-.09 30.56-.09 30.56M182.81 20.94l-24.43-6.66V9.94s1.23-2.15-3.2-3.14S129.48 1 126.72 1C123 1 96.23 35.94 96.5 40.38c.16 2.61 0 30.56 0 30.56\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-lawyer");

/***/ },
/* 42 */
/***/ function(module, exports, __webpack_require__) {

	var Sprite, globalSprite, inject_sprite;

	Sprite = __webpack_require__(43);

	globalSprite = new Sprite();

	inject_sprite = function() {
	  return globalSprite.elem = globalSprite.render(document.body);
	};

	document.addEventListener('DOMContentLoaded', inject_sprite, false);

	document.addEventListener('page:load', inject_sprite, false);

	module.exports = globalSprite;


/***/ },
/* 43 */
/***/ function(module, exports, __webpack_require__) {

	var Sniffr = __webpack_require__(44);

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
/* 44 */
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
/* 45 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 141.8 57.5\" id=\"avatar-observer\" ><title>&#x8CC7;&#x7522; 5</title><g fill=\"none\" data-name=\"Layer 4\"><circle cx=\"33.59\" cy=\"28.75\" r=\"27.75\"/><circle cx=\"109.48\" cy=\"28.75\" r=\"27.75\"/><path d=\"M56.84 20.75s14.5-7.25 29 0M133 20.68s7.37-1.82 7.87 0M8.84 20.68s-7.37-1.82-7.87 0\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-observer");

/***/ },
/* 46 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 72.21 94.12\" id=\"avatar-party\" ><title>&#x8CC7;&#x7522; 3</title><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M57.53 93.47s12.3-14.59 12.3-17.75 3.08-25.25 0-33.25c-1.26-3.27-12-2-12-2L52 56s-15.81 2.69-21.81 25.75M30.34 3.47v41M43.34 3.47v41\"/><path d=\"M57.71 41s.82-17.19-1-28.5c-.86-5.31-6.8-8.26-13.49-9.41-7.78-4.38-12.75-.51-13.37 0h-.07c-7.33 1.39-11 3.55-11.93 7.38-.66 2.79-.92 26.73-1 36.55V21.71c0-4.56-6.24-2.89-7.85-1-7.76 9.1-8 47-8 47l9.06 23.73\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-party");

/***/ },
/* 47 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 56 57\" id=\"chart\" ><title>icon/chart</title><path d=\"M43.604 44.469V31.927h-6.27V44.47h6.27zm-12.541 0V13.26h-6.125V44.47h6.125zm-12.396 0V22.594h-6.271v21.875h6.27zM49.729.865c1.653 0 3.111.632 4.375 1.895C55.368 4.024 56 5.483 56 7.135v43.459c0 1.653-.632 3.11-1.896 4.375-1.264 1.264-2.722 1.896-4.375 1.896H6.271c-1.653 0-3.111-.632-4.375-1.896C.632 53.705 0 52.247 0 50.594V7.135c0-1.652.632-3.11 1.896-4.375C3.16 1.497 4.618.865 6.27.865h43.458z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "chart");

/***/ },
/* 48 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 8 8\" id=\"close\" ><title>icons/close</title><path d=\"M8 .805L4.805 4 8 7.195 7.195 8 4 4.805.805 8 0 7.195 3.195 4 0 .805.805 0 4 3.195 7.195 0z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "close");

/***/ },
/* 49 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"exit\" ><title>icon exit</title><path d=\"M14.208 0c.473 0 .89.18 1.25.542.361.36.542.777.542 1.25v12.416c0 .473-.18.89-.542 1.25-.36.361-.777.542-1.25.542H1.792c-.5 0-.924-.18-1.271-.542-.347-.36-.521-.777-.521-1.25v-3.541h1.792v3.541h12.416V1.792H1.792v3.541H0V1.792c0-.473.174-.89.52-1.25C.869.18 1.293 0 1.793 0h12.416zM6.292 11.738l2.291-2.355H0V7.617h8.583L6.292 5.262 7.542 4 12 8.5 7.542 13l-1.25-1.262z\" fill-rule=\"evenodd\" fill-opacity=\".87\"/></symbol>";
	module.exports = sprite.add(image, "exit");

/***/ },
/* 50 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 18 18\" id=\"forwards\" ><title>button/forwards</title><g fill-rule=\"evenodd\"><path d=\"M17.429 8.929a8.5 8.5 0 1 0-17 0 8.5 8.5 0 0 0 17 0zm-15.867 0a7.367 7.367 0 1 1 14.733 0 7.367 7.367 0 0 1-14.733 0z\"/><path d=\"M9 5l4 4-4 4-.702-.702 2.784-2.807H5V8.51h6.082L8.298 5.702z\"/></g></symbol>";
	module.exports = sprite.add(image, "forwards");

/***/ },
/* 51 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 12 12\" id=\"info\" ><title>Page 1</title><path d=\"M5.408 4.183V2.972h1.184v1.211H5.408zM6 10.803c1.315 0 2.446-.474 3.394-1.423.949-.948 1.423-2.08 1.423-3.394 0-1.315-.474-2.446-1.423-3.394C8.446 1.643 7.314 1.169 6 1.169c-1.315 0-2.446.474-3.394 1.423-.949.948-1.423 2.08-1.423 3.394s.474 2.446 1.423 3.394c.948.949 2.08 1.423 3.394 1.423zM6-.014c1.653 0 3.066.587 4.24 1.76C11.412 2.92 12 4.333 12 5.986s-.587 3.066-1.76 4.24c-1.174 1.173-2.587 1.76-4.24 1.76s-3.066-.587-4.24-1.76C.588 9.051 0 7.638 0 5.985s.587-3.066 1.76-4.24C2.935.573 4.348-.014 6-.014zM5.408 9V5.394h1.184V9H5.408z\" fill-rule=\"evenodd\" fill-opacity=\".7\"/></symbol>";
	module.exports = sprite.add(image, "info");

/***/ },
/* 52 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 17 16\" id=\"key\" ><title>icon/key</title><g fill-rule=\"evenodd\"><path d=\"M7.564 7.349c.06 0 .121-.02.17-.062l5.83-4.961-.34-.376-5.83 4.96a.245.245 0 0 0-.024.353.26.26 0 0 0 .194.086z\"/><path d=\"M5.248 16c3.164 0 5.055-2.415 5.055-4.75 0-.673-.166-1.415-.411-1.896l2.33-1.13A.25.25 0 0 0 12.363 8V6h1.545l.058-.003c.343-.022.446-.128.457-.497v-2h1.546c.066 0 .112.007.143.011.062.01.179.027.28-.06.104-.09.1-.204.095-.305-.001-.036-.003-.083-.003-.146V.735A.747.747 0 0 0 15.728 0h-1.996a.776.776 0 0 0-.5.182L6.44 5.962c-.334-.065-.84-.15-1.191-.15C2.354 5.813 0 8.098 0 10.907 0 13.714 2.354 16 5.248 16zm0-9.688c.258 0 .7.06 1.213.164a.26.26 0 0 0 .223-.056L13.572.559a.249.249 0 0 1 .16-.059h1.996c.134 0 .242.105.242.235V3h-1.803a.254.254 0 0 0-.258.25V5.5h-1.803a.254.254 0 0 0-.258.25v2.096l-2.433 1.18a.252.252 0 0 0-.135.165.244.244 0 0 0 .041.205c.227.304.467 1.057.467 1.854 0 2.089-1.698 4.25-4.54 4.25-2.61 0-4.733-2.061-4.733-4.594 0-2.533 2.124-4.594 4.733-4.594z\"/><path d=\"M4.379 13.5c.994 0 1.803-.785 1.803-1.75S5.373 10 4.379 10c-.994 0-1.803.785-1.803 1.75s.809 1.75 1.803 1.75zm0-3c.71 0 1.288.561 1.288 1.25S5.089 13 4.379 13c-.71 0-1.288-.561-1.288-1.25s.578-1.25 1.288-1.25z\"/></g></symbol>";
	module.exports = sprite.add(image, "key");

/***/ },
/* 53 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 18 12\" id=\"menu\" ><title>menu</title><path d=\"M0 12h18v-2H0v2zm0-5h18V5H0v2zm0-7v2h18V0H0z\" fill=\"#FFF\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "menu");

/***/ },
/* 54 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"pencil\" ><title>icon/pencil</title><g fill-rule=\"evenodd\"><path d=\"M2.8 13.6a.4.4 0 0 1-.376-.537l1.6-4.4a.408.408 0 0 1 .093-.146l8.4-8.4a.4.4 0 0 1 .565 0l2.8 2.8a.4.4 0 0 1 0 .565l-8.4 8.4a.397.397 0 0 1-.146.093l-4.4 1.6a.404.404 0 0 1-.137.024l.001.001zm1.946-4.58l-1.277 3.511 3.511-1.277L15.034 3.2 12.8.966 4.746 9.02z\"/><path d=\"M14 16H1.2C.538 16 0 15.462 0 14.8V2C0 1.338.538.8 1.2.8h8a.4.4 0 0 1 0 .8h-8a.4.4 0 0 0-.4.4v12.8c0 .22.18.4.4.4H14a.4.4 0 0 0 .4-.4v-8a.4.4 0 0 1 .8 0v8c0 .662-.538 1.2-1.2 1.2z\"/></g></symbol>";
	module.exports = sprite.add(image, "pencil");

/***/ },
/* 55 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"plus-circle-o\" ><title>icons/plus-circle-o</title><path d=\"M8 14.404c1.753 0 3.261-.632 4.526-1.897 1.264-1.264 1.897-2.773 1.897-4.526 0-1.753-.633-3.261-1.897-4.526C11.26 2.191 9.753 1.56 8 1.56c-1.753 0-3.261.632-4.526 1.896C2.21 4.72 1.577 6.228 1.577 7.981c0 1.753.633 3.262 1.897 4.526C4.74 13.772 6.247 14.404 8 14.404zM8-.02c2.203 0 4.088.783 5.653 2.348C15.218 3.894 16 5.778 16 7.98c0 2.204-.782 4.088-2.347 5.653-1.565 1.565-3.45 2.347-5.653 2.347-2.203 0-4.088-.782-5.653-2.347C.782 12.069 0 10.184 0 7.98 0 5.778.782 3.894 2.347 2.33 3.912.764 5.797-.02 8-.02zm.789 3.981v3.23h3.23V8.77h-3.23V12H7.21V8.77h-3.23V7.192h3.23v-3.23H8.79z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "plus-circle-o");

/***/ },
/* 56 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 18 16\" id=\"profile\" ><title>icon/profile</title><path d=\"M.187 15.992a.253.253 0 0 0 .308-.177c.519-1.922 2.627-2.42 3.887-2.718.316-.074.565-.133.727-.203 1.435-.618 1.903-1.614 2.043-2.34a.25.25 0 0 0-.083-.236c-.747-.64-1.378-1.602-1.776-2.709a.246.246 0 0 0-.051-.085c-.527-.568-.829-1.169-.829-1.647 0-.28.106-.467.346-.609a.25.25 0 0 0 .122-.204C4.992 2.517 6.819.512 9.061.5l.053.003c2.252.031 4.068 2.08 4.133 4.663a.248.248 0 0 0 .09.184c.157.133.23.3.23.529 0 .4-.214.893-.604 1.386a.26.26 0 0 0-.042.079c-.403 1.268-1.126 2.388-1.984 3.073a.25.25 0 0 0-.09.241c.14.726.609 1.72 2.044 2.34.17.073.433.13.767.202 1.247.268 3.335.717 3.847 2.616a.252.252 0 0 0 .486-.13c-.591-2.194-2.956-2.702-4.226-2.975-.295-.064-.55-.118-.673-.172-.937-.404-1.514-1.02-1.718-1.833.87-.742 1.597-1.886 2.013-3.17.442-.57.685-1.156.685-1.658 0-.334-.109-.613-.324-.831C13.628 2.243 11.614.036 9.114 0L9.04 0C6.585.013 4.563 2.162 4.386 4.916c-.315.23-.475.552-.475.962 0 .591.336 1.299.926 1.948.408 1.112 1.04 2.088 1.791 2.772-.203.816-.78 1.434-1.72 1.838-.12.053-.362.11-.642.176-1.28.302-3.661.865-4.257 3.074a.25.25 0 0 0 .178.306z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "profile");

/***/ },
/* 57 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"star-full\" ><title>icon star copy</title><defs><radialGradient cy=\"0%\" fx=\"50%\" fy=\"0%\" r=\"100%\" id=\"star-full_a\"><stop stop-color=\"#FFC109\" offset=\"0%\"/><stop stop-color=\"#FFA000\" offset=\"100%\"/></radialGradient></defs><path d=\"M59 25.679L48.465 32l2.793-11.852L42 12.168l12.211-1.027L59 0l4.789 11.14L76 12.169l-9.258 7.98L69.535 32z\" transform=\"translate(-42)\" fill=\"url(#star-full_a)\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "star-full");

/***/ },
/* 58 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"star-half\" ><title>icon star half</title><defs><radialGradient cy=\"0%\" fx=\"50%\" fy=\"0%\" r=\"100%\" id=\"star-half_a\"><stop stop-color=\"#FFC109\" offset=\"0%\"/><stop stop-color=\"#FFA000\" offset=\"100%\"/></radialGradient></defs><path d=\"M101 22.542l6.385 3.862-1.676-7.172 5.667-4.887-7.503-.63L101 6.935v15.606zm17-10.325l-9.258 7.96L111.535 32 101 25.695 90.465 32l2.793-11.823L84 12.217l12.211-1.025L101 0l4.789 11.192L118 12.217z\" transform=\"translate(-84)\" fill=\"url(#star-half_a)\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "star-half");

/***/ },
/* 59 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 34 32\" id=\"star-o\" ><title>icon star-o</title><path d=\"M17 22.598l6.385 3.792-1.676-7.19 5.667-4.899-7.503-.632L17 6.874l-2.873 6.795-7.503.632 5.667 4.899-1.676 7.19L17 22.598zm17-10.43l-9.258 7.98L27.535 32 17 25.679 6.465 32l2.793-11.852L0 12.168l12.211-1.027L17 0l4.789 11.14L34 12.169z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "star-o");

/***/ },
/* 60 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 60 56\" id=\"star\" ><title>icon/star</title><path d=\"M30 44.938L11.408 56l4.93-20.74L0 21.293l21.55-1.798L30 0l8.45 19.496L60 21.294 43.662 35.259 48.592 56z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "star");

/***/ },
/* 61 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(42);
	var image = "<symbol viewBox=\"0 0 56 57\" id=\"user\" ><title>icon/user</title><path d=\"M28 35.082c5.895 0 12.035 1.283 18.421 3.848C52.807 41.495 56 44.852 56 49v7.04H0V49c0-4.148 3.193-7.505 9.579-10.07 6.386-2.565 12.526-3.848 18.421-3.848zm0-7.041c-3.82 0-7.096-1.365-9.825-4.094-2.729-2.729-4.093-6.004-4.093-9.824 0-3.82 1.364-7.123 4.093-9.907C20.905 1.433 24.18.041 28 .041c3.82 0 7.096 1.392 9.825 4.175 2.729 2.784 4.093 6.086 4.093 9.907 0 3.82-1.364 7.095-4.093 9.824-2.73 2.73-6.004 4.094-9.825 4.094z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "user");

/***/ }
/******/ ])));