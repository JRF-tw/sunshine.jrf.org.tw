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

	var Dismiss, TextInput, Toggle, ref, sprites;

	__webpack_require__(1);

	__webpack_require__(18);

	__webpack_require__(19);

	ref = __webpack_require__(20), Toggle = ref.Toggle, Dismiss = ref.Dismiss;

	TextInput = __webpack_require__(21).TextInput;

	sprites = __webpack_require__(22);

	sprites.keys().forEach(sprites);

	$(document).on("page:change", function() {
	  var $main_header;
	  new Toggle('.switch');
	  new Dismiss('[data-dismiss]').init();
	  new TextInput();
	  $main_header = $('#main-header');
	  return $('.card__heading').waypoint({
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
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(2);

	__webpack_require__(3);

	__webpack_require__(4);

	__webpack_require__(5);

	__webpack_require__(6);

	__webpack_require__(7);

	__webpack_require__(8);

	__webpack_require__(9);

	__webpack_require__(10);

	__webpack_require__(11);

	__webpack_require__(12);

	__webpack_require__(13);

	__webpack_require__(14);

	__webpack_require__(15);

	__webpack_require__(16);

	__webpack_require__(17);


/***/ },
/* 2 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },
/* 3 */
2,
/* 4 */
2,
/* 5 */
2,
/* 6 */
2,
/* 7 */
2,
/* 8 */
2,
/* 9 */
2,
/* 10 */
2,
/* 11 */
2,
/* 12 */
2,
/* 13 */
2,
/* 14 */
2,
/* 15 */
2,
/* 16 */
2,
/* 17 */
2,
/* 18 */
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
/* 19 */
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
/* 20 */
/***/ function(module, exports) {

	var Dismiss, Toggle;

	Toggle = (function() {
	  function Toggle(query) {
	    this.query = query;
	    $(this.query).on('click', (function(_this) {
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
	  }

	  Dismiss.prototype.init = function() {
	    return $(this.query).on('click', function(e) {
	      var $this;
	      $this = $(this);
	      switch ($this.data('dismiss')) {
	        case 'alert':
	          return $this.parent().slideUp();
	      }
	    });
	  };

	  return Dismiss;

	})();

	module.exports = {
	  Toggle: Toggle,
	  Dismiss: Dismiss
	};


/***/ },
/* 21 */
/***/ function(module, exports) {

	var TextInput;

	TextInput = (function() {
	  function TextInput() {
	    $('input').on('focus', (function(_this) {
	      return function(e) {
	        return _this.focus(e.currentTarget);
	      };
	    })(this)).on('blur', (function(_this) {
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
/* 22 */
/***/ function(module, exports, __webpack_require__) {

	var map = {
		"./avatar-lawyer.svg": 23,
		"./avatar-observer.svg": 27,
		"./avatar-party.svg": 28,
		"./close.svg": 29,
		"./exit.svg": 30,
		"./key.svg": 31,
		"./menu.svg": 32,
		"./pencil.svg": 33,
		"./profile.svg": 34
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
	webpackContext.id = 22;


/***/ },
/* 23 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 183.08 70.95\" id=\"avatar-lawyer\" ><title>&#x8CC7;&#x7522; 4</title><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M29.88 15.19s24 26.25 24 29.25v24.5M153.88 15.19s-24 26.25-24 29.25v24.5\"/><path d=\"M.27 20.94l24.11-6.66V9.94s-.91-2.15 3.52-3.14S53.75 1 56.51 1c3.76 0 30.57 34.94 30.3 39.38-.16 2.61-.09 30.56-.09 30.56M182.81 20.94l-24.43-6.66V9.94s1.23-2.15-3.2-3.14S129.48 1 126.72 1C123 1 96.23 35.94 96.5 40.38c.16 2.61 0 30.56 0 30.56\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-lawyer");

/***/ },
/* 24 */
/***/ function(module, exports, __webpack_require__) {

	var Sprite, globalSprite, inject_sprite;

	Sprite = __webpack_require__(25);

	globalSprite = new Sprite();

	inject_sprite = function() {
	  return globalSprite.elem = globalSprite.render(document.body);
	};

	document.addEventListener('DOMContentLoaded', inject_sprite, false);

	document.addEventListener('page:load', inject_sprite, false);

	module.exports = globalSprite;


/***/ },
/* 25 */
/***/ function(module, exports, __webpack_require__) {

	var Sniffr = __webpack_require__(26);

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
/* 26 */
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
/* 27 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 141.8 57.5\" id=\"avatar-observer\" ><title>&#x8CC7;&#x7522; 5</title><g fill=\"none\" data-name=\"Layer 4\"><circle cx=\"33.59\" cy=\"28.75\" r=\"27.75\"/><circle cx=\"109.48\" cy=\"28.75\" r=\"27.75\"/><path d=\"M56.84 20.75s14.5-7.25 29 0M133 20.68s7.37-1.82 7.87 0M8.84 20.68s-7.37-1.82-7.87 0\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-observer");

/***/ },
/* 28 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 72.21 94.12\" id=\"avatar-party\" ><title>&#x8CC7;&#x7522; 3</title><g fill=\"none\" data-name=\"Layer 4\"><path d=\"M57.53 93.47s12.3-14.59 12.3-17.75 3.08-25.25 0-33.25c-1.26-3.27-12-2-12-2L52 56s-15.81 2.69-21.81 25.75M30.34 3.47v41M43.34 3.47v41\"/><path d=\"M57.71 41s.82-17.19-1-28.5c-.86-5.31-6.8-8.26-13.49-9.41-7.78-4.38-12.75-.51-13.37 0h-.07c-7.33 1.39-11 3.55-11.93 7.38-.66 2.79-.92 26.73-1 36.55V21.71c0-4.56-6.24-2.89-7.85-1-7.76 9.1-8 47-8 47l9.06 23.73\"/></g></symbol>";
	module.exports = sprite.add(image, "avatar-party");

/***/ },
/* 29 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 8 8\" id=\"close\" ><title>icons/close</title><path d=\"M8 .805L4.805 4 8 7.195 7.195 8 4 4.805.805 8 0 7.195 3.195 4 0 .805.805 0 4 3.195 7.195 0z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "close");

/***/ },
/* 30 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"exit\" ><title>icon exit</title><path d=\"M14.208 0c.473 0 .89.18 1.25.542.361.36.542.777.542 1.25v12.416c0 .473-.18.89-.542 1.25-.36.361-.777.542-1.25.542H1.792c-.5 0-.924-.18-1.271-.542-.347-.36-.521-.777-.521-1.25v-3.541h1.792v3.541h12.416V1.792H1.792v3.541H0V1.792c0-.473.174-.89.52-1.25C.869.18 1.293 0 1.793 0h12.416zM6.292 11.738l2.291-2.355H0V7.617h8.583L6.292 5.262 7.542 4 12 8.5 7.542 13l-1.25-1.262z\" fill-rule=\"evenodd\" fill-opacity=\".87\"/></symbol>";
	module.exports = sprite.add(image, "exit");

/***/ },
/* 31 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 17 16\" id=\"key\" ><title>icon/key</title><g fill-rule=\"evenodd\"><path d=\"M7.564 7.349c.06 0 .121-.02.17-.062l5.83-4.961-.34-.376-5.83 4.96a.245.245 0 0 0-.024.353.26.26 0 0 0 .194.086z\"/><path d=\"M5.248 16c3.164 0 5.055-2.415 5.055-4.75 0-.673-.166-1.415-.411-1.896l2.33-1.13A.25.25 0 0 0 12.363 8V6h1.545l.058-.003c.343-.022.446-.128.457-.497v-2h1.546c.066 0 .112.007.143.011.062.01.179.027.28-.06.104-.09.1-.204.095-.305-.001-.036-.003-.083-.003-.146V.735A.747.747 0 0 0 15.728 0h-1.996a.776.776 0 0 0-.5.182L6.44 5.962c-.334-.065-.84-.15-1.191-.15C2.354 5.813 0 8.098 0 10.907 0 13.714 2.354 16 5.248 16zm0-9.688c.258 0 .7.06 1.213.164a.26.26 0 0 0 .223-.056L13.572.559a.249.249 0 0 1 .16-.059h1.996c.134 0 .242.105.242.235V3h-1.803a.254.254 0 0 0-.258.25V5.5h-1.803a.254.254 0 0 0-.258.25v2.096l-2.433 1.18a.252.252 0 0 0-.135.165.244.244 0 0 0 .041.205c.227.304.467 1.057.467 1.854 0 2.089-1.698 4.25-4.54 4.25-2.61 0-4.733-2.061-4.733-4.594 0-2.533 2.124-4.594 4.733-4.594z\"/><path d=\"M4.379 13.5c.994 0 1.803-.785 1.803-1.75S5.373 10 4.379 10c-.994 0-1.803.785-1.803 1.75s.809 1.75 1.803 1.75zm0-3c.71 0 1.288.561 1.288 1.25S5.089 13 4.379 13c-.71 0-1.288-.561-1.288-1.25s.578-1.25 1.288-1.25z\"/></g></symbol>";
	module.exports = sprite.add(image, "key");

/***/ },
/* 32 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 18 12\" id=\"menu\" ><title>menu</title><path d=\"M0 12h18v-2H0v2zm0-5h18V5H0v2zm0-7v2h18V0H0z\" fill=\"#FFF\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "menu");

/***/ },
/* 33 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 16 16\" id=\"pencil\" ><title>icon/pencil</title><g fill-rule=\"evenodd\"><path d=\"M2.8 13.6a.4.4 0 0 1-.376-.537l1.6-4.4a.408.408 0 0 1 .093-.146l8.4-8.4a.4.4 0 0 1 .565 0l2.8 2.8a.4.4 0 0 1 0 .565l-8.4 8.4a.397.397 0 0 1-.146.093l-4.4 1.6a.404.404 0 0 1-.137.024l.001.001zm1.946-4.58l-1.277 3.511 3.511-1.277L15.034 3.2 12.8.966 4.746 9.02z\"/><path d=\"M14 16H1.2C.538 16 0 15.462 0 14.8V2C0 1.338.538.8 1.2.8h8a.4.4 0 0 1 0 .8h-8a.4.4 0 0 0-.4.4v12.8c0 .22.18.4.4.4H14a.4.4 0 0 0 .4-.4v-8a.4.4 0 0 1 .8 0v8c0 .662-.538 1.2-1.2 1.2z\"/></g></symbol>";
	module.exports = sprite.add(image, "pencil");

/***/ },
/* 34 */
/***/ function(module, exports, __webpack_require__) {

	
	var sprite = __webpack_require__(24);
	var image = "<symbol viewBox=\"0 0 18 16\" id=\"profile\" ><title>icon/profile</title><path d=\"M.187 15.992a.253.253 0 0 0 .308-.177c.519-1.922 2.627-2.42 3.887-2.718.316-.074.565-.133.727-.203 1.435-.618 1.903-1.614 2.043-2.34a.25.25 0 0 0-.083-.236c-.747-.64-1.378-1.602-1.776-2.709a.246.246 0 0 0-.051-.085c-.527-.568-.829-1.169-.829-1.647 0-.28.106-.467.346-.609a.25.25 0 0 0 .122-.204C4.992 2.517 6.819.512 9.061.5l.053.003c2.252.031 4.068 2.08 4.133 4.663a.248.248 0 0 0 .09.184c.157.133.23.3.23.529 0 .4-.214.893-.604 1.386a.26.26 0 0 0-.042.079c-.403 1.268-1.126 2.388-1.984 3.073a.25.25 0 0 0-.09.241c.14.726.609 1.72 2.044 2.34.17.073.433.13.767.202 1.247.268 3.335.717 3.847 2.616a.252.252 0 0 0 .486-.13c-.591-2.194-2.956-2.702-4.226-2.975-.295-.064-.55-.118-.673-.172-.937-.404-1.514-1.02-1.718-1.833.87-.742 1.597-1.886 2.013-3.17.442-.57.685-1.156.685-1.658 0-.334-.109-.613-.324-.831C13.628 2.243 11.614.036 9.114 0L9.04 0C6.585.013 4.563 2.162 4.386 4.916c-.315.23-.475.552-.475.962 0 .591.336 1.299.926 1.948.408 1.112 1.04 2.088 1.791 2.772-.203.816-.78 1.434-1.72 1.838-.12.053-.362.11-.642.176-1.28.302-3.661.865-4.257 3.074a.25.25 0 0 0 .178.306z\" fill-rule=\"evenodd\"/></symbol>";
	module.exports = sprite.add(image, "profile");

/***/ }
/******/ ])));