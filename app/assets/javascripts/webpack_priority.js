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
/******/ ({

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(86);

	__webpack_require__(87);

	__webpack_require__(88);

	__webpack_require__(89);


/***/ },

/***/ 86:
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_RESULT__;/*! picturefill - v3.0.2 - 2016-02-12
	 * https://scottjehl.github.io/picturefill/
	 * Copyright (c) 2016 https://github.com/scottjehl/picturefill/blob/master/Authors.txt; Licensed MIT
	 */
	/*! Gecko-Picture - v1.0
	 * https://github.com/scottjehl/picturefill/tree/3.0/src/plugins/gecko-picture
	 * Firefox's early picture implementation (prior to FF41) is static and does
	 * not react to viewport changes. This tiny module fixes this.
	 */
	(function(window) {
		/*jshint eqnull:true */
		var ua = navigator.userAgent;

		if ( window.HTMLPictureElement && ((/ecko/).test(ua) && ua.match(/rv\:(\d+)/) && RegExp.$1 < 45) ) {
			addEventListener("resize", (function() {
				var timer;

				var dummySrc = document.createElement("source");

				var fixRespimg = function(img) {
					var source, sizes;
					var picture = img.parentNode;

					if (picture.nodeName.toUpperCase() === "PICTURE") {
						source = dummySrc.cloneNode();

						picture.insertBefore(source, picture.firstElementChild);
						setTimeout(function() {
							picture.removeChild(source);
						});
					} else if (!img._pfLastSize || img.offsetWidth > img._pfLastSize) {
						img._pfLastSize = img.offsetWidth;
						sizes = img.sizes;
						img.sizes += ",100vw";
						setTimeout(function() {
							img.sizes = sizes;
						});
					}
				};

				var findPictureImgs = function() {
					var i;
					var imgs = document.querySelectorAll("picture > img, img[srcset][sizes]");
					for (i = 0; i < imgs.length; i++) {
						fixRespimg(imgs[i]);
					}
				};
				var onResize = function() {
					clearTimeout(timer);
					timer = setTimeout(findPictureImgs, 99);
				};
				var mq = window.matchMedia && matchMedia("(orientation: landscape)");
				var init = function() {
					onResize();

					if (mq && mq.addListener) {
						mq.addListener(onResize);
					}
				};

				dummySrc.srcset = "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==";

				if (/^[c|i]|d$/.test(document.readyState || "")) {
					init();
				} else {
					document.addEventListener("DOMContentLoaded", init);
				}

				return onResize;
			})());
		}
	})(window);

	/*! Picturefill - v3.0.2
	 * http://scottjehl.github.io/picturefill
	 * Copyright (c) 2015 https://github.com/scottjehl/picturefill/blob/master/Authors.txt;
	 *  License: MIT
	 */

	(function( window, document, undefined ) {
		// Enable strict mode
		"use strict";

		// HTML shim|v it for old IE (IE9 will still need the HTML video tag workaround)
		document.createElement( "picture" );

		var warn, eminpx, alwaysCheckWDescriptor, evalId;
		// local object for method references and testing exposure
		var pf = {};
		var isSupportTestReady = false;
		var noop = function() {};
		var image = document.createElement( "img" );
		var getImgAttr = image.getAttribute;
		var setImgAttr = image.setAttribute;
		var removeImgAttr = image.removeAttribute;
		var docElem = document.documentElement;
		var types = {};
		var cfg = {
			//resource selection:
			algorithm: ""
		};
		var srcAttr = "data-pfsrc";
		var srcsetAttr = srcAttr + "set";
		// ua sniffing is done for undetectable img loading features,
		// to do some non crucial perf optimizations
		var ua = navigator.userAgent;
		var supportAbort = (/rident/).test(ua) || ((/ecko/).test(ua) && ua.match(/rv\:(\d+)/) && RegExp.$1 > 35 );
		var curSrcProp = "currentSrc";
		var regWDesc = /\s+\+?\d+(e\d+)?w/;
		var regSize = /(\([^)]+\))?\s*(.+)/;
		var setOptions = window.picturefillCFG;
		/**
		 * Shortcut property for https://w3c.github.io/webappsec/specs/mixedcontent/#restricts-mixed-content ( for easy overriding in tests )
		 */
		// baseStyle also used by getEmValue (i.e.: width: 1em is important)
		var baseStyle = "position:absolute;left:0;visibility:hidden;display:block;padding:0;border:none;font-size:1em;width:1em;overflow:hidden;clip:rect(0px, 0px, 0px, 0px)";
		var fsCss = "font-size:100%!important;";
		var isVwDirty = true;

		var cssCache = {};
		var sizeLengthCache = {};
		var DPR = window.devicePixelRatio;
		var units = {
			px: 1,
			"in": 96
		};
		var anchor = document.createElement( "a" );
		/**
		 * alreadyRun flag used for setOptions. is it true setOptions will reevaluate
		 * @type {boolean}
		 */
		var alreadyRun = false;

		// Reusable, non-"g" Regexes

		// (Don't use \s, to avoid matching non-breaking space.)
		var regexLeadingSpaces = /^[ \t\n\r\u000c]+/,
		    regexLeadingCommasOrSpaces = /^[, \t\n\r\u000c]+/,
		    regexLeadingNotSpaces = /^[^ \t\n\r\u000c]+/,
		    regexTrailingCommas = /[,]+$/,
		    regexNonNegativeInteger = /^\d+$/,

		    // ( Positive or negative or unsigned integers or decimals, without or without exponents.
		    // Must include at least one digit.
		    // According to spec tests any decimal point must be followed by a digit.
		    // No leading plus sign is allowed.)
		    // https://html.spec.whatwg.org/multipage/infrastructure.html#valid-floating-point-number
		    regexFloatingPoint = /^-?(?:[0-9]+|[0-9]*\.[0-9]+)(?:[eE][+-]?[0-9]+)?$/;

		var on = function(obj, evt, fn, capture) {
			if ( obj.addEventListener ) {
				obj.addEventListener(evt, fn, capture || false);
			} else if ( obj.attachEvent ) {
				obj.attachEvent( "on" + evt, fn);
			}
		};

		/**
		 * simple memoize function:
		 */

		var memoize = function(fn) {
			var cache = {};
			return function(input) {
				if ( !(input in cache) ) {
					cache[ input ] = fn(input);
				}
				return cache[ input ];
			};
		};

		// UTILITY FUNCTIONS

		// Manual is faster than RegEx
		// http://jsperf.com/whitespace-character/5
		function isSpace(c) {
			return (c === "\u0020" || // space
			        c === "\u0009" || // horizontal tab
			        c === "\u000A" || // new line
			        c === "\u000C" || // form feed
			        c === "\u000D");  // carriage return
		}

		/**
		 * gets a mediaquery and returns a boolean or gets a css length and returns a number
		 * @param css mediaqueries or css length
		 * @returns {boolean|number}
		 *
		 * based on: https://gist.github.com/jonathantneal/db4f77009b155f083738
		 */
		var evalCSS = (function() {

			var regLength = /^([\d\.]+)(em|vw|px)$/;
			var replace = function() {
				var args = arguments, index = 0, string = args[0];
				while (++index in args) {
					string = string.replace(args[index], args[++index]);
				}
				return string;
			};

			var buildStr = memoize(function(css) {

				return "return " + replace((css || "").toLowerCase(),
					// interpret `and`
					/\band\b/g, "&&",

					// interpret `,`
					/,/g, "||",

					// interpret `min-` as >=
					/min-([a-z-\s]+):/g, "e.$1>=",

					// interpret `max-` as <=
					/max-([a-z-\s]+):/g, "e.$1<=",

					//calc value
					/calc([^)]+)/g, "($1)",

					// interpret css values
					/(\d+[\.]*[\d]*)([a-z]+)/g, "($1 * e.$2)",
					//make eval less evil
					/^(?!(e.[a-z]|[0-9\.&=|><\+\-\*\(\)\/])).*/ig, ""
				) + ";";
			});

			return function(css, length) {
				var parsedLength;
				if (!(css in cssCache)) {
					cssCache[css] = false;
					if (length && (parsedLength = css.match( regLength ))) {
						cssCache[css] = parsedLength[ 1 ] * units[parsedLength[ 2 ]];
					} else {
						/*jshint evil:true */
						try{
							cssCache[css] = new Function("e", buildStr(css))(units);
						} catch(e) {}
						/*jshint evil:false */
					}
				}
				return cssCache[css];
			};
		})();

		var setResolution = function( candidate, sizesattr ) {
			if ( candidate.w ) { // h = means height: || descriptor.type === 'h' do not handle yet...
				candidate.cWidth = pf.calcListLength( sizesattr || "100vw" );
				candidate.res = candidate.w / candidate.cWidth ;
			} else {
				candidate.res = candidate.d;
			}
			return candidate;
		};

		/**
		 *
		 * @param opt
		 */
		var picturefill = function( opt ) {

			if (!isSupportTestReady) {return;}

			var elements, i, plen;

			var options = opt || {};

			if ( options.elements && options.elements.nodeType === 1 ) {
				if ( options.elements.nodeName.toUpperCase() === "IMG" ) {
					options.elements =  [ options.elements ];
				} else {
					options.context = options.elements;
					options.elements =  null;
				}
			}

			elements = options.elements || pf.qsa( (options.context || document), ( options.reevaluate || options.reselect ) ? pf.sel : pf.selShort );

			if ( (plen = elements.length) ) {

				pf.setupRun( options );
				alreadyRun = true;

				// Loop through all elements
				for ( i = 0; i < plen; i++ ) {
					pf.fillImg(elements[ i ], options);
				}

				pf.teardownRun( options );
			}
		};

		/**
		 * outputs a warning for the developer
		 * @param {message}
		 * @type {Function}
		 */
		warn = ( window.console && console.warn ) ?
			function( message ) {
				console.warn( message );
			} :
			noop
		;

		if ( !(curSrcProp in image) ) {
			curSrcProp = "src";
		}

		// Add support for standard mime types.
		types[ "image/jpeg" ] = true;
		types[ "image/gif" ] = true;
		types[ "image/png" ] = true;

		function detectTypeSupport( type, typeUri ) {
			// based on Modernizr's lossless img-webp test
			// note: asynchronous
			var image = new window.Image();
			image.onerror = function() {
				types[ type ] = false;
				picturefill();
			};
			image.onload = function() {
				types[ type ] = image.width === 1;
				picturefill();
			};
			image.src = typeUri;
			return "pending";
		}

		// test svg support
		types[ "image/svg+xml" ] = document.implementation.hasFeature( "http://www.w3.org/TR/SVG11/feature#Image", "1.1" );

		/**
		 * updates the internal vW property with the current viewport width in px
		 */
		function updateMetrics() {

			isVwDirty = false;
			DPR = window.devicePixelRatio;
			cssCache = {};
			sizeLengthCache = {};

			pf.DPR = DPR || 1;

			units.width = Math.max(window.innerWidth || 0, docElem.clientWidth);
			units.height = Math.max(window.innerHeight || 0, docElem.clientHeight);

			units.vw = units.width / 100;
			units.vh = units.height / 100;

			evalId = [ units.height, units.width, DPR ].join("-");

			units.em = pf.getEmValue();
			units.rem = units.em;
		}

		function chooseLowRes( lowerValue, higherValue, dprValue, isCached ) {
			var bonusFactor, tooMuch, bonus, meanDensity;

			//experimental
			if (cfg.algorithm === "saveData" ){
				if ( lowerValue > 2.7 ) {
					meanDensity = dprValue + 1;
				} else {
					tooMuch = higherValue - dprValue;
					bonusFactor = Math.pow(lowerValue - 0.6, 1.5);

					bonus = tooMuch * bonusFactor;

					if (isCached) {
						bonus += 0.1 * bonusFactor;
					}

					meanDensity = lowerValue + bonus;
				}
			} else {
				meanDensity = (dprValue > 1) ?
					Math.sqrt(lowerValue * higherValue) :
					lowerValue;
			}

			return meanDensity > dprValue;
		}

		function applyBestCandidate( img ) {
			var srcSetCandidates;
			var matchingSet = pf.getSet( img );
			var evaluated = false;
			if ( matchingSet !== "pending" ) {
				evaluated = evalId;
				if ( matchingSet ) {
					srcSetCandidates = pf.setRes( matchingSet );
					pf.applySetCandidate( srcSetCandidates, img );
				}
			}
			img[ pf.ns ].evaled = evaluated;
		}

		function ascendingSort( a, b ) {
			return a.res - b.res;
		}

		function setSrcToCur( img, src, set ) {
			var candidate;
			if ( !set && src ) {
				set = img[ pf.ns ].sets;
				set = set && set[set.length - 1];
			}

			candidate = getCandidateForSrc(src, set);

			if ( candidate ) {
				src = pf.makeUrl(src);
				img[ pf.ns ].curSrc = src;
				img[ pf.ns ].curCan = candidate;

				if ( !candidate.res ) {
					setResolution( candidate, candidate.set.sizes );
				}
			}
			return candidate;
		}

		function getCandidateForSrc( src, set ) {
			var i, candidate, candidates;
			if ( src && set ) {
				candidates = pf.parseSet( set );
				src = pf.makeUrl(src);
				for ( i = 0; i < candidates.length; i++ ) {
					if ( src === pf.makeUrl(candidates[ i ].url) ) {
						candidate = candidates[ i ];
						break;
					}
				}
			}
			return candidate;
		}

		function getAllSourceElements( picture, candidates ) {
			var i, len, source, srcset;

			// SPEC mismatch intended for size and perf:
			// actually only source elements preceding the img should be used
			// also note: don't use qsa here, because IE8 sometimes doesn't like source as the key part in a selector
			var sources = picture.getElementsByTagName( "source" );

			for ( i = 0, len = sources.length; i < len; i++ ) {
				source = sources[ i ];
				source[ pf.ns ] = true;
				srcset = source.getAttribute( "srcset" );

				// if source does not have a srcset attribute, skip
				if ( srcset ) {
					candidates.push( {
						srcset: srcset,
						media: source.getAttribute( "media" ),
						type: source.getAttribute( "type" ),
						sizes: source.getAttribute( "sizes" )
					} );
				}
			}
		}

		/**
		 * Srcset Parser
		 * By Alex Bell |  MIT License
		 *
		 * @returns Array [{url: _, d: _, w: _, h:_, set:_(????)}, ...]
		 *
		 * Based super duper closely on the reference algorithm at:
		 * https://html.spec.whatwg.org/multipage/embedded-content.html#parse-a-srcset-attribute
		 */

		// 1. Let input be the value passed to this algorithm.
		// (TO-DO : Explain what "set" argument is here. Maybe choose a more
		// descriptive & more searchable name.  Since passing the "set" in really has
		// nothing to do with parsing proper, I would prefer this assignment eventually
		// go in an external fn.)
		function parseSrcset(input, set) {

			function collectCharacters(regEx) {
				var chars,
				    match = regEx.exec(input.substring(pos));
				if (match) {
					chars = match[ 0 ];
					pos += chars.length;
					return chars;
				}
			}

			var inputLength = input.length,
			    url,
			    descriptors,
			    currentDescriptor,
			    state,
			    c,

			    // 2. Let position be a pointer into input, initially pointing at the start
			    //    of the string.
			    pos = 0,

			    // 3. Let candidates be an initially empty source set.
			    candidates = [];

			/**
			* Adds descriptor properties to a candidate, pushes to the candidates array
			* @return undefined
			*/
			// (Declared outside of the while loop so that it's only created once.
			// (This fn is defined before it is used, in order to pass JSHINT.
			// Unfortunately this breaks the sequencing of the spec comments. :/ )
			function parseDescriptors() {

				// 9. Descriptor parser: Let error be no.
				var pError = false,

				// 10. Let width be absent.
				// 11. Let density be absent.
				// 12. Let future-compat-h be absent. (We're implementing it now as h)
				    w, d, h, i,
				    candidate = {},
				    desc, lastChar, value, intVal, floatVal;

				// 13. For each descriptor in descriptors, run the appropriate set of steps
				// from the following list:
				for (i = 0 ; i < descriptors.length; i++) {
					desc = descriptors[ i ];

					lastChar = desc[ desc.length - 1 ];
					value = desc.substring(0, desc.length - 1);
					intVal = parseInt(value, 10);
					floatVal = parseFloat(value);

					// If the descriptor consists of a valid non-negative integer followed by
					// a U+0077 LATIN SMALL LETTER W character
					if (regexNonNegativeInteger.test(value) && (lastChar === "w")) {

						// If width and density are not both absent, then let error be yes.
						if (w || d) {pError = true;}

						// Apply the rules for parsing non-negative integers to the descriptor.
						// If the result is zero, let error be yes.
						// Otherwise, let width be the result.
						if (intVal === 0) {pError = true;} else {w = intVal;}

					// If the descriptor consists of a valid floating-point number followed by
					// a U+0078 LATIN SMALL LETTER X character
					} else if (regexFloatingPoint.test(value) && (lastChar === "x")) {

						// If width, density and future-compat-h are not all absent, then let error
						// be yes.
						if (w || d || h) {pError = true;}

						// Apply the rules for parsing floating-point number values to the descriptor.
						// If the result is less than zero, let error be yes. Otherwise, let density
						// be the result.
						if (floatVal < 0) {pError = true;} else {d = floatVal;}

					// If the descriptor consists of a valid non-negative integer followed by
					// a U+0068 LATIN SMALL LETTER H character
					} else if (regexNonNegativeInteger.test(value) && (lastChar === "h")) {

						// If height and density are not both absent, then let error be yes.
						if (h || d) {pError = true;}

						// Apply the rules for parsing non-negative integers to the descriptor.
						// If the result is zero, let error be yes. Otherwise, let future-compat-h
						// be the result.
						if (intVal === 0) {pError = true;} else {h = intVal;}

					// Anything else, Let error be yes.
					} else {pError = true;}
				} // (close step 13 for loop)

				// 15. If error is still no, then append a new image source to candidates whose
				// URL is url, associated with a width width if not absent and a pixel
				// density density if not absent. Otherwise, there is a parse error.
				if (!pError) {
					candidate.url = url;

					if (w) { candidate.w = w;}
					if (d) { candidate.d = d;}
					if (h) { candidate.h = h;}
					if (!h && !d && !w) {candidate.d = 1;}
					if (candidate.d === 1) {set.has1x = true;}
					candidate.set = set;

					candidates.push(candidate);
				}
			} // (close parseDescriptors fn)

			/**
			* Tokenizes descriptor properties prior to parsing
			* Returns undefined.
			* (Again, this fn is defined before it is used, in order to pass JSHINT.
			* Unfortunately this breaks the logical sequencing of the spec comments. :/ )
			*/
			function tokenize() {

				// 8.1. Descriptor tokeniser: Skip whitespace
				collectCharacters(regexLeadingSpaces);

				// 8.2. Let current descriptor be the empty string.
				currentDescriptor = "";

				// 8.3. Let state be in descriptor.
				state = "in descriptor";

				while (true) {

					// 8.4. Let c be the character at position.
					c = input.charAt(pos);

					//  Do the following depending on the value of state.
					//  For the purpose of this step, "EOF" is a special character representing
					//  that position is past the end of input.

					// In descriptor
					if (state === "in descriptor") {
						// Do the following, depending on the value of c:

					  // Space character
					  // If current descriptor is not empty, append current descriptor to
					  // descriptors and let current descriptor be the empty string.
					  // Set state to after descriptor.
						if (isSpace(c)) {
							if (currentDescriptor) {
								descriptors.push(currentDescriptor);
								currentDescriptor = "";
								state = "after descriptor";
							}

						// U+002C COMMA (,)
						// Advance position to the next character in input. If current descriptor
						// is not empty, append current descriptor to descriptors. Jump to the step
						// labeled descriptor parser.
						} else if (c === ",") {
							pos += 1;
							if (currentDescriptor) {
								descriptors.push(currentDescriptor);
							}
							parseDescriptors();
							return;

						// U+0028 LEFT PARENTHESIS (()
						// Append c to current descriptor. Set state to in parens.
						} else if (c === "\u0028") {
							currentDescriptor = currentDescriptor + c;
							state = "in parens";

						// EOF
						// If current descriptor is not empty, append current descriptor to
						// descriptors. Jump to the step labeled descriptor parser.
						} else if (c === "") {
							if (currentDescriptor) {
								descriptors.push(currentDescriptor);
							}
							parseDescriptors();
							return;

						// Anything else
						// Append c to current descriptor.
						} else {
							currentDescriptor = currentDescriptor + c;
						}
					// (end "in descriptor"

					// In parens
					} else if (state === "in parens") {

						// U+0029 RIGHT PARENTHESIS ())
						// Append c to current descriptor. Set state to in descriptor.
						if (c === ")") {
							currentDescriptor = currentDescriptor + c;
							state = "in descriptor";

						// EOF
						// Append current descriptor to descriptors. Jump to the step labeled
						// descriptor parser.
						} else if (c === "") {
							descriptors.push(currentDescriptor);
							parseDescriptors();
							return;

						// Anything else
						// Append c to current descriptor.
						} else {
							currentDescriptor = currentDescriptor + c;
						}

					// After descriptor
					} else if (state === "after descriptor") {

						// Do the following, depending on the value of c:
						// Space character: Stay in this state.
						if (isSpace(c)) {

						// EOF: Jump to the step labeled descriptor parser.
						} else if (c === "") {
							parseDescriptors();
							return;

						// Anything else
						// Set state to in descriptor. Set position to the previous character in input.
						} else {
							state = "in descriptor";
							pos -= 1;

						}
					}

					// Advance position to the next character in input.
					pos += 1;

				// Repeat this step.
				} // (close while true loop)
			}

			// 4. Splitting loop: Collect a sequence of characters that are space
			//    characters or U+002C COMMA characters. If any U+002C COMMA characters
			//    were collected, that is a parse error.
			while (true) {
				collectCharacters(regexLeadingCommasOrSpaces);

				// 5. If position is past the end of input, return candidates and abort these steps.
				if (pos >= inputLength) {
					return candidates; // (we're done, this is the sole return path)
				}

				// 6. Collect a sequence of characters that are not space characters,
				//    and let that be url.
				url = collectCharacters(regexLeadingNotSpaces);

				// 7. Let descriptors be a new empty list.
				descriptors = [];

				// 8. If url ends with a U+002C COMMA character (,), follow these substeps:
				//		(1). Remove all trailing U+002C COMMA characters from url. If this removed
				//         more than one character, that is a parse error.
				if (url.slice(-1) === ",") {
					url = url.replace(regexTrailingCommas, "");
					// (Jump ahead to step 9 to skip tokenization and just push the candidate).
					parseDescriptors();

				//	Otherwise, follow these substeps:
				} else {
					tokenize();
				} // (close else of step 8)

			// 16. Return to the step labeled splitting loop.
			} // (Close of big while loop.)
		}

		/*
		 * Sizes Parser
		 *
		 * By Alex Bell |  MIT License
		 *
		 * Non-strict but accurate and lightweight JS Parser for the string value <img sizes="here">
		 *
		 * Reference algorithm at:
		 * https://html.spec.whatwg.org/multipage/embedded-content.html#parse-a-sizes-attribute
		 *
		 * Most comments are copied in directly from the spec
		 * (except for comments in parens).
		 *
		 * Grammar is:
		 * <source-size-list> = <source-size># [ , <source-size-value> ]? | <source-size-value>
		 * <source-size> = <media-condition> <source-size-value>
		 * <source-size-value> = <length>
		 * http://www.w3.org/html/wg/drafts/html/master/embedded-content.html#attr-img-sizes
		 *
		 * E.g. "(max-width: 30em) 100vw, (max-width: 50em) 70vw, 100vw"
		 * or "(min-width: 30em), calc(30vw - 15px)" or just "30vw"
		 *
		 * Returns the first valid <css-length> with a media condition that evaluates to true,
		 * or "100vw" if all valid media conditions evaluate to false.
		 *
		 */

		function parseSizes(strValue) {

			// (Percentage CSS lengths are not allowed in this case, to avoid confusion:
			// https://html.spec.whatwg.org/multipage/embedded-content.html#valid-source-size-list
			// CSS allows a single optional plus or minus sign:
			// http://www.w3.org/TR/CSS2/syndata.html#numbers
			// CSS is ASCII case-insensitive:
			// http://www.w3.org/TR/CSS2/syndata.html#characters )
			// Spec allows exponential notation for <number> type:
			// http://dev.w3.org/csswg/css-values/#numbers
			var regexCssLengthWithUnits = /^(?:[+-]?[0-9]+|[0-9]*\.[0-9]+)(?:[eE][+-]?[0-9]+)?(?:ch|cm|em|ex|in|mm|pc|pt|px|rem|vh|vmin|vmax|vw)$/i;

			// (This is a quick and lenient test. Because of optional unlimited-depth internal
			// grouping parens and strict spacing rules, this could get very complicated.)
			var regexCssCalc = /^calc\((?:[0-9a-z \.\+\-\*\/\(\)]+)\)$/i;

			var i;
			var unparsedSizesList;
			var unparsedSizesListLength;
			var unparsedSize;
			var lastComponentValue;
			var size;

			// UTILITY FUNCTIONS

			//  (Toy CSS parser. The goals here are:
			//  1) expansive test coverage without the weight of a full CSS parser.
			//  2) Avoiding regex wherever convenient.
			//  Quick tests: http://jsfiddle.net/gtntL4gr/3/
			//  Returns an array of arrays.)
			function parseComponentValues(str) {
				var chrctr;
				var component = "";
				var componentArray = [];
				var listArray = [];
				var parenDepth = 0;
				var pos = 0;
				var inComment = false;

				function pushComponent() {
					if (component) {
						componentArray.push(component);
						component = "";
					}
				}

				function pushComponentArray() {
					if (componentArray[0]) {
						listArray.push(componentArray);
						componentArray = [];
					}
				}

				// (Loop forwards from the beginning of the string.)
				while (true) {
					chrctr = str.charAt(pos);

					if (chrctr === "") { // ( End of string reached.)
						pushComponent();
						pushComponentArray();
						return listArray;
					} else if (inComment) {
						if ((chrctr === "*") && (str[pos + 1] === "/")) { // (At end of a comment.)
							inComment = false;
							pos += 2;
							pushComponent();
							continue;
						} else {
							pos += 1; // (Skip all characters inside comments.)
							continue;
						}
					} else if (isSpace(chrctr)) {
						// (If previous character in loop was also a space, or if
						// at the beginning of the string, do not add space char to
						// component.)
						if ( (str.charAt(pos - 1) && isSpace( str.charAt(pos - 1) ) ) || !component ) {
							pos += 1;
							continue;
						} else if (parenDepth === 0) {
							pushComponent();
							pos +=1;
							continue;
						} else {
							// (Replace any space character with a plain space for legibility.)
							chrctr = " ";
						}
					} else if (chrctr === "(") {
						parenDepth += 1;
					} else if (chrctr === ")") {
						parenDepth -= 1;
					} else if (chrctr === ",") {
						pushComponent();
						pushComponentArray();
						pos += 1;
						continue;
					} else if ( (chrctr === "/") && (str.charAt(pos + 1) === "*") ) {
						inComment = true;
						pos += 2;
						continue;
					}

					component = component + chrctr;
					pos += 1;
				}
			}

			function isValidNonNegativeSourceSizeValue(s) {
				if (regexCssLengthWithUnits.test(s) && (parseFloat(s) >= 0)) {return true;}
				if (regexCssCalc.test(s)) {return true;}
				// ( http://www.w3.org/TR/CSS2/syndata.html#numbers says:
				// "-0 is equivalent to 0 and is not a negative number." which means that
				// unitless zero and unitless negative zero must be accepted as special cases.)
				if ((s === "0") || (s === "-0") || (s === "+0")) {return true;}
				return false;
			}

			// When asked to parse a sizes attribute from an element, parse a
			// comma-separated list of component values from the value of the element's
			// sizes attribute (or the empty string, if the attribute is absent), and let
			// unparsed sizes list be the result.
			// http://dev.w3.org/csswg/css-syntax/#parse-comma-separated-list-of-component-values

			unparsedSizesList = parseComponentValues(strValue);
			unparsedSizesListLength = unparsedSizesList.length;

			// For each unparsed size in unparsed sizes list:
			for (i = 0; i < unparsedSizesListLength; i++) {
				unparsedSize = unparsedSizesList[i];

				// 1. Remove all consecutive <whitespace-token>s from the end of unparsed size.
				// ( parseComponentValues() already omits spaces outside of parens. )

				// If unparsed size is now empty, that is a parse error; continue to the next
				// iteration of this algorithm.
				// ( parseComponentValues() won't push an empty array. )

				// 2. If the last component value in unparsed size is a valid non-negative
				// <source-size-value>, let size be its value and remove the component value
				// from unparsed size. Any CSS function other than the calc() function is
				// invalid. Otherwise, there is a parse error; continue to the next iteration
				// of this algorithm.
				// http://dev.w3.org/csswg/css-syntax/#parse-component-value
				lastComponentValue = unparsedSize[unparsedSize.length - 1];

				if (isValidNonNegativeSourceSizeValue(lastComponentValue)) {
					size = lastComponentValue;
					unparsedSize.pop();
				} else {
					continue;
				}

				// 3. Remove all consecutive <whitespace-token>s from the end of unparsed
				// size. If unparsed size is now empty, return size and exit this algorithm.
				// If this was not the last item in unparsed sizes list, that is a parse error.
				if (unparsedSize.length === 0) {
					return size;
				}

				// 4. Parse the remaining component values in unparsed size as a
				// <media-condition>. If it does not parse correctly, or it does parse
				// correctly but the <media-condition> evaluates to false, continue to the
				// next iteration of this algorithm.
				// (Parsing all possible compound media conditions in JS is heavy, complicated,
				// and the payoff is unclear. Is there ever an situation where the
				// media condition parses incorrectly but still somehow evaluates to true?
				// Can we just rely on the browser/polyfill to do it?)
				unparsedSize = unparsedSize.join(" ");
				if (!(pf.matchesMedia( unparsedSize ) ) ) {
					continue;
				}

				// 5. Return size and exit this algorithm.
				return size;
			}

			// If the above algorithm exhausts unparsed sizes list without returning a
			// size value, return 100vw.
			return "100vw";
		}

		// namespace
		pf.ns = ("pf" + new Date().getTime()).substr(0, 9);

		// srcset support test
		pf.supSrcset = "srcset" in image;
		pf.supSizes = "sizes" in image;
		pf.supPicture = !!window.HTMLPictureElement;

		// UC browser does claim to support srcset and picture, but not sizes,
		// this extended test reveals the browser does support nothing
		if (pf.supSrcset && pf.supPicture && !pf.supSizes) {
			(function(image2) {
				image.srcset = "data:,a";
				image2.src = "data:,a";
				pf.supSrcset = image.complete === image2.complete;
				pf.supPicture = pf.supSrcset && pf.supPicture;
			})(document.createElement("img"));
		}

		// Safari9 has basic support for sizes, but does't expose the `sizes` idl attribute
		if (pf.supSrcset && !pf.supSizes) {

			(function() {
				var width2 = "data:image/gif;base64,R0lGODlhAgABAPAAAP///wAAACH5BAAAAAAALAAAAAACAAEAAAICBAoAOw==";
				var width1 = "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==";
				var img = document.createElement("img");
				var test = function() {
					var width = img.width;

					if (width === 2) {
						pf.supSizes = true;
					}

					alwaysCheckWDescriptor = pf.supSrcset && !pf.supSizes;

					isSupportTestReady = true;
					// force async
					setTimeout(picturefill);
				};

				img.onload = test;
				img.onerror = test;
				img.setAttribute("sizes", "9px");

				img.srcset = width1 + " 1w," + width2 + " 9w";
				img.src = width1;
			})();

		} else {
			isSupportTestReady = true;
		}

		// using pf.qsa instead of dom traversing does scale much better,
		// especially on sites mixing responsive and non-responsive images
		pf.selShort = "picture>img,img[srcset]";
		pf.sel = pf.selShort;
		pf.cfg = cfg;

		/**
		 * Shortcut property for `devicePixelRatio` ( for easy overriding in tests )
		 */
		pf.DPR = (DPR  || 1 );
		pf.u = units;

		// container of supported mime types that one might need to qualify before using
		pf.types =  types;

		pf.setSize = noop;

		/**
		 * Gets a string and returns the absolute URL
		 * @param src
		 * @returns {String} absolute URL
		 */

		pf.makeUrl = memoize(function(src) {
			anchor.href = src;
			return anchor.href;
		});

		/**
		 * Gets a DOM element or document and a selctor and returns the found matches
		 * Can be extended with jQuery/Sizzle for IE7 support
		 * @param context
		 * @param sel
		 * @returns {NodeList|Array}
		 */
		pf.qsa = function(context, sel) {
			return ( "querySelector" in context ) ? context.querySelectorAll(sel) : [];
		};

		/**
		 * Shortcut method for matchMedia ( for easy overriding in tests )
		 * wether native or pf.mMQ is used will be decided lazy on first call
		 * @returns {boolean}
		 */
		pf.matchesMedia = function() {
			if ( window.matchMedia && (matchMedia( "(min-width: 0.1em)" ) || {}).matches ) {
				pf.matchesMedia = function( media ) {
					return !media || ( matchMedia( media ).matches );
				};
			} else {
				pf.matchesMedia = pf.mMQ;
			}

			return pf.matchesMedia.apply( this, arguments );
		};

		/**
		 * A simplified matchMedia implementation for IE8 and IE9
		 * handles only min-width/max-width with px or em values
		 * @param media
		 * @returns {boolean}
		 */
		pf.mMQ = function( media ) {
			return media ? evalCSS(media) : true;
		};

		/**
		 * Returns the calculated length in css pixel from the given sourceSizeValue
		 * http://dev.w3.org/csswg/css-values-3/#length-value
		 * intended Spec mismatches:
		 * * Does not check for invalid use of CSS functions
		 * * Does handle a computed length of 0 the same as a negative and therefore invalid value
		 * @param sourceSizeValue
		 * @returns {Number}
		 */
		pf.calcLength = function( sourceSizeValue ) {

			var value = evalCSS(sourceSizeValue, true) || false;
			if (value < 0) {
				value = false;
			}

			return value;
		};

		/**
		 * Takes a type string and checks if its supported
		 */

		pf.supportsType = function( type ) {
			return ( type ) ? types[ type ] : true;
		};

		/**
		 * Parses a sourceSize into mediaCondition (media) and sourceSizeValue (length)
		 * @param sourceSizeStr
		 * @returns {*}
		 */
		pf.parseSize = memoize(function( sourceSizeStr ) {
			var match = ( sourceSizeStr || "" ).match(regSize);
			return {
				media: match && match[1],
				length: match && match[2]
			};
		});

		pf.parseSet = function( set ) {
			if ( !set.cands ) {
				set.cands = parseSrcset(set.srcset, set);
			}
			return set.cands;
		};

		/**
		 * returns 1em in css px for html/body default size
		 * function taken from respondjs
		 * @returns {*|number}
		 */
		pf.getEmValue = function() {
			var body;
			if ( !eminpx && (body = document.body) ) {
				var div = document.createElement( "div" ),
					originalHTMLCSS = docElem.style.cssText,
					originalBodyCSS = body.style.cssText;

				div.style.cssText = baseStyle;

				// 1em in a media query is the value of the default font size of the browser
				// reset docElem and body to ensure the correct value is returned
				docElem.style.cssText = fsCss;
				body.style.cssText = fsCss;

				body.appendChild( div );
				eminpx = div.offsetWidth;
				body.removeChild( div );

				//also update eminpx before returning
				eminpx = parseFloat( eminpx, 10 );

				// restore the original values
				docElem.style.cssText = originalHTMLCSS;
				body.style.cssText = originalBodyCSS;

			}
			return eminpx || 16;
		};

		/**
		 * Takes a string of sizes and returns the width in pixels as a number
		 */
		pf.calcListLength = function( sourceSizeListStr ) {
			// Split up source size list, ie ( max-width: 30em ) 100%, ( max-width: 50em ) 50%, 33%
			//
			//                           or (min-width:30em) calc(30% - 15px)
			if ( !(sourceSizeListStr in sizeLengthCache) || cfg.uT ) {
				var winningLength = pf.calcLength( parseSizes( sourceSizeListStr ) );

				sizeLengthCache[ sourceSizeListStr ] = !winningLength ? units.width : winningLength;
			}

			return sizeLengthCache[ sourceSizeListStr ];
		};

		/**
		 * Takes a candidate object with a srcset property in the form of url/
		 * ex. "images/pic-medium.png 1x, images/pic-medium-2x.png 2x" or
		 *     "images/pic-medium.png 400w, images/pic-medium-2x.png 800w" or
		 *     "images/pic-small.png"
		 * Get an array of image candidates in the form of
		 *      {url: "/foo/bar.png", resolution: 1}
		 * where resolution is http://dev.w3.org/csswg/css-values-3/#resolution-value
		 * If sizes is specified, res is calculated
		 */
		pf.setRes = function( set ) {
			var candidates;
			if ( set ) {

				candidates = pf.parseSet( set );

				for ( var i = 0, len = candidates.length; i < len; i++ ) {
					setResolution( candidates[ i ], set.sizes );
				}
			}
			return candidates;
		};

		pf.setRes.res = setResolution;

		pf.applySetCandidate = function( candidates, img ) {
			if ( !candidates.length ) {return;}
			var candidate,
				i,
				j,
				length,
				bestCandidate,
				curSrc,
				curCan,
				candidateSrc,
				abortCurSrc;

			var imageData = img[ pf.ns ];
			var dpr = pf.DPR;

			curSrc = imageData.curSrc || img[curSrcProp];

			curCan = imageData.curCan || setSrcToCur(img, curSrc, candidates[0].set);

			// if we have a current source, we might either become lazy or give this source some advantage
			if ( curCan && curCan.set === candidates[ 0 ].set ) {

				// if browser can abort image request and the image has a higher pixel density than needed
				// and this image isn't downloaded yet, we skip next part and try to save bandwidth
				abortCurSrc = (supportAbort && !img.complete && curCan.res - 0.1 > dpr);

				if ( !abortCurSrc ) {
					curCan.cached = true;

					// if current candidate is "best", "better" or "okay",
					// set it to bestCandidate
					if ( curCan.res >= dpr ) {
						bestCandidate = curCan;
					}
				}
			}

			if ( !bestCandidate ) {

				candidates.sort( ascendingSort );

				length = candidates.length;
				bestCandidate = candidates[ length - 1 ];

				for ( i = 0; i < length; i++ ) {
					candidate = candidates[ i ];
					if ( candidate.res >= dpr ) {
						j = i - 1;

						// we have found the perfect candidate,
						// but let's improve this a little bit with some assumptions ;-)
						if (candidates[ j ] &&
							(abortCurSrc || curSrc !== pf.makeUrl( candidate.url )) &&
							chooseLowRes(candidates[ j ].res, candidate.res, dpr, candidates[ j ].cached)) {

							bestCandidate = candidates[ j ];

						} else {
							bestCandidate = candidate;
						}
						break;
					}
				}
			}

			if ( bestCandidate ) {

				candidateSrc = pf.makeUrl( bestCandidate.url );

				imageData.curSrc = candidateSrc;
				imageData.curCan = bestCandidate;

				if ( candidateSrc !== curSrc ) {
					pf.setSrc( img, bestCandidate );
				}
				pf.setSize( img );
			}
		};

		pf.setSrc = function( img, bestCandidate ) {
			var origWidth;
			img.src = bestCandidate.url;

			// although this is a specific Safari issue, we don't want to take too much different code paths
			if ( bestCandidate.set.type === "image/svg+xml" ) {
				origWidth = img.style.width;
				img.style.width = (img.offsetWidth + 1) + "px";

				// next line only should trigger a repaint
				// if... is only done to trick dead code removal
				if ( img.offsetWidth + 1 ) {
					img.style.width = origWidth;
				}
			}
		};

		pf.getSet = function( img ) {
			var i, set, supportsType;
			var match = false;
			var sets = img [ pf.ns ].sets;

			for ( i = 0; i < sets.length && !match; i++ ) {
				set = sets[i];

				if ( !set.srcset || !pf.matchesMedia( set.media ) || !(supportsType = pf.supportsType( set.type )) ) {
					continue;
				}

				if ( supportsType === "pending" ) {
					set = supportsType;
				}

				match = set;
				break;
			}

			return match;
		};

		pf.parseSets = function( element, parent, options ) {
			var srcsetAttribute, imageSet, isWDescripor, srcsetParsed;

			var hasPicture = parent && parent.nodeName.toUpperCase() === "PICTURE";
			var imageData = element[ pf.ns ];

			if ( imageData.src === undefined || options.src ) {
				imageData.src = getImgAttr.call( element, "src" );
				if ( imageData.src ) {
					setImgAttr.call( element, srcAttr, imageData.src );
				} else {
					removeImgAttr.call( element, srcAttr );
				}
			}

			if ( imageData.srcset === undefined || options.srcset || !pf.supSrcset || element.srcset ) {
				srcsetAttribute = getImgAttr.call( element, "srcset" );
				imageData.srcset = srcsetAttribute;
				srcsetParsed = true;
			}

			imageData.sets = [];

			if ( hasPicture ) {
				imageData.pic = true;
				getAllSourceElements( parent, imageData.sets );
			}

			if ( imageData.srcset ) {
				imageSet = {
					srcset: imageData.srcset,
					sizes: getImgAttr.call( element, "sizes" )
				};

				imageData.sets.push( imageSet );

				isWDescripor = (alwaysCheckWDescriptor || imageData.src) && regWDesc.test(imageData.srcset || "");

				// add normal src as candidate, if source has no w descriptor
				if ( !isWDescripor && imageData.src && !getCandidateForSrc(imageData.src, imageSet) && !imageSet.has1x ) {
					imageSet.srcset += ", " + imageData.src;
					imageSet.cands.push({
						url: imageData.src,
						d: 1,
						set: imageSet
					});
				}

			} else if ( imageData.src ) {
				imageData.sets.push( {
					srcset: imageData.src,
					sizes: null
				} );
			}

			imageData.curCan = null;
			imageData.curSrc = undefined;

			// if img has picture or the srcset was removed or has a srcset and does not support srcset at all
			// or has a w descriptor (and does not support sizes) set support to false to evaluate
			imageData.supported = !( hasPicture || ( imageSet && !pf.supSrcset ) || (isWDescripor && !pf.supSizes) );

			if ( srcsetParsed && pf.supSrcset && !imageData.supported ) {
				if ( srcsetAttribute ) {
					setImgAttr.call( element, srcsetAttr, srcsetAttribute );
					element.srcset = "";
				} else {
					removeImgAttr.call( element, srcsetAttr );
				}
			}

			if (imageData.supported && !imageData.srcset && ((!imageData.src && element.src) ||  element.src !== pf.makeUrl(imageData.src))) {
				if (imageData.src === null) {
					element.removeAttribute("src");
				} else {
					element.src = imageData.src;
				}
			}

			imageData.parsed = true;
		};

		pf.fillImg = function(element, options) {
			var imageData;
			var extreme = options.reselect || options.reevaluate;

			// expando for caching data on the img
			if ( !element[ pf.ns ] ) {
				element[ pf.ns ] = {};
			}

			imageData = element[ pf.ns ];

			// if the element has already been evaluated, skip it
			// unless `options.reevaluate` is set to true ( this, for example,
			// is set to true when running `picturefill` on `resize` ).
			if ( !extreme && imageData.evaled === evalId ) {
				return;
			}

			if ( !imageData.parsed || options.reevaluate ) {
				pf.parseSets( element, element.parentNode, options );
			}

			if ( !imageData.supported ) {
				applyBestCandidate( element );
			} else {
				imageData.evaled = evalId;
			}
		};

		pf.setupRun = function() {
			if ( !alreadyRun || isVwDirty || (DPR !== window.devicePixelRatio) ) {
				updateMetrics();
			}
		};

		// If picture is supported, well, that's awesome.
		if ( pf.supPicture ) {
			picturefill = noop;
			pf.fillImg = noop;
		} else {

			 // Set up picture polyfill by polling the document
			(function() {
				var isDomReady;
				var regReady = window.attachEvent ? /d$|^c/ : /d$|^c|^i/;

				var run = function() {
					var readyState = document.readyState || "";

					timerId = setTimeout(run, readyState === "loading" ? 200 :  999);
					if ( document.body ) {
						pf.fillImgs();
						isDomReady = isDomReady || regReady.test(readyState);
						if ( isDomReady ) {
							clearTimeout( timerId );
						}

					}
				};

				var timerId = setTimeout(run, document.body ? 9 : 99);

				// Also attach picturefill on resize and readystatechange
				// http://modernjavascript.blogspot.com/2013/08/building-better-debounce.html
				var debounce = function(func, wait) {
					var timeout, timestamp;
					var later = function() {
						var last = (new Date()) - timestamp;

						if (last < wait) {
							timeout = setTimeout(later, wait - last);
						} else {
							timeout = null;
							func();
						}
					};

					return function() {
						timestamp = new Date();

						if (!timeout) {
							timeout = setTimeout(later, wait);
						}
					};
				};
				var lastClientWidth = docElem.clientHeight;
				var onResize = function() {
					isVwDirty = Math.max(window.innerWidth || 0, docElem.clientWidth) !== units.width || docElem.clientHeight !== lastClientWidth;
					lastClientWidth = docElem.clientHeight;
					if ( isVwDirty ) {
						pf.fillImgs();
					}
				};

				on( window, "resize", debounce(onResize, 99 ) );
				on( document, "readystatechange", run );
			})();
		}

		pf.picturefill = picturefill;
		//use this internally for easy monkey patching/performance testing
		pf.fillImgs = picturefill;
		pf.teardownRun = noop;

		/* expose methods for testing */
		picturefill._ = pf;

		window.picturefillCFG = {
			pf: pf,
			push: function(args) {
				var name = args.shift();
				if (typeof pf[name] === "function") {
					pf[name].apply(pf, args);
				} else {
					cfg[name] = args[0];
					if (alreadyRun) {
						pf.fillImgs( { reselect: true } );
					}
				}
			}
		};

		while (setOptions && setOptions.length) {
			window.picturefillCFG.push(setOptions.shift());
		}

		/* expose picturefill */
		window.picturefill = picturefill;

		/* expose picturefill */
		if ( typeof module === "object" && typeof module.exports === "object" ) {
			// CommonJS, just export
			module.exports = picturefill;
		} else if ( true ) {
			// AMD support
			!(__WEBPACK_AMD_DEFINE_RESULT__ = function() { return picturefill; }.call(exports, __webpack_require__, exports, module), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
		}

		// IE8 evals this sync, so it must be the last thing we do
		if ( !pf.supPicture ) {
			types[ "image/webp" ] = detectTypeSupport("image/webp", "data:image/webp;base64,UklGRkoAAABXRUJQVlA4WAoAAAAQAAAAAAAAAAAAQUxQSAwAAAABBxAR/Q9ERP8DAABWUDggGAAAADABAJ0BKgEAAQADADQlpAADcAD++/1QAA==" );
		}

	} )( window, document );


/***/ },

/***/ 87:
/***/ function(module, exports) {

	(function(window, document, undefined){
		/*jshint eqnull:true */
		'use strict';

		if(!document.addEventListener){return;}

		var config, riasCfg;
		var replaceTypes = {string: 1, number: 1};
		var regNumber = /^\-*\+*\d+\.*\d*$/;
		var regPicture = /^picture$/i;
		var regWidth = /\s*\{\s*width\s*\}\s*/i;
		var regHeight = /\s*\{\s*height\s*\}\s*/i;
		var regPlaceholder = /\s*\{\s*([a-z0-9]+)\s*\}\s*/ig;
		var regObj = /^\[.*\]|\{.*\}$/;
		var regAllowedSizes = /^(?:auto|\d+(px)?)$/;
		var anchor = document.createElement('a');
		var img = document.createElement('img');
		var buggySizes = ('srcset' in img) && !('sizes' in img);
		var supportPicture = !!window.HTMLPictureElement && !buggySizes;

		(function(){
			var prop;
			var noop = function(){};
			var riasDefaults = {
				prefix: '',
				postfix: '',
				srcAttr: 'data-src',
				absUrl: false,
				modifyOptions: noop,
				widthmap: {},
				ratio: false
			};

			config = (window.lazySizes && lazySizes.cfg) || window.lazySizesConfig;

			if(!config){
				config = {};
				window.lazySizesConfig = config;
			}

			if(!config.supportsType){
				config.supportsType = function(type/*, elem*/){
					return !type;
				};
			}

			if(!config.rias){
				config.rias = {};
			}
			riasCfg = config.rias;

			if(!('widths' in riasCfg)){
				riasCfg.widths = [];
				(function (widths){
					var width;
					var i = 0;
					while(!width || width < 3000){
						i += 5;
						if(i > 30){
							i += 1;
						}
						width = (36 * i);
						widths.push(width);
					}
				})(riasCfg.widths);
			}

			for(prop in riasDefaults){
				if(!(prop in riasCfg)){
					riasCfg[prop] = riasDefaults[prop];
				}
			}
		})();

		function getElementOptions(elem, src){
			var attr, parent, setOption, options;
			var elemStyles = window.getComputedStyle(elem);


			parent = elem.parentNode;
			options = {
				isPicture: !!(parent && regPicture.test(parent.nodeName || ''))
			};

			setOption = function(attr, run){
				var attrVal = elem.getAttribute('data-'+ attr);

				if (!attrVal) {
					// no data- attr, get value from the CSS
					var styles = elemStyles.getPropertyValue('--ls-' + attr);
					// at least Safari 9 returns null rather than
					// an empty string for getPropertyValue causing
					// .trim() to fail
					if (styles) {
						attrVal = styles.trim();
					}
				}

				if (attrVal) {
					if(attrVal == 'true'){
						attrVal = true;
					} else if(attrVal == 'false'){
						attrVal = false;
					} else if(regNumber.test(attrVal)){
						attrVal = parseFloat(attrVal);
					} else if(typeof riasCfg[attr] == 'function'){
						attrVal = riasCfg[attr](elem, attrVal);
					} else if(regObj.test(attrVal)){
						try {
							attrVal = JSON.parse(attrVal);
						} catch(e){}
					}
					options[attr] = attrVal;
				} else if((attr in riasCfg) && typeof riasCfg[attr] != 'function'){
					options[attr] = riasCfg[attr];
				} else if(run && typeof riasCfg[attr] == 'function'){
					options[attr] = riasCfg[attr](elem, attrVal);
				}
			};

			for(attr in riasCfg){
				setOption(attr);
			}
			src.replace(regPlaceholder, function(full, match){
				if(!(match in options)){
					setOption(match, true);
				}
			});

			return options;
		}

		function replaceUrlProps(url, options){
			var candidates = [];
			var replaceFn = function(full, match){
				return (replaceTypes[typeof options[match]]) ? options[match] : full;
			};
			candidates.srcset = [];

			if(options.absUrl){
				anchor.setAttribute('href', url);
				url = anchor.href;
			}

			url = ((options.prefix || '') + url + (options.postfix || '')).replace(regPlaceholder, replaceFn);

			options.widths.forEach(function(width){
				var widthAlias = options.widthmap[width] || width;
				var candidate = {
					u: url.replace(regWidth, widthAlias)
							.replace(regHeight, options.ratio ? Math.round(width * options.ratio) : ''),
					w: width
				};

				candidates.push(candidate);
				candidates.srcset.push( (candidate.c = candidate.u + ' ' + width + 'w') );
			});
			return candidates;
		}

		function setSrc(src, opts, elem){
			var elemW = 0;
			var elemH = 0;
			var sizeElement = elem;

			if(!src){return;}

			if (opts.ratio === 'container') {
				// calculate image or parent ratio
				elemW = sizeElement.scrollWidth;
				elemH = sizeElement.scrollHeight;

				while ((!elemW || !elemH) && sizeElement !== document) {
					sizeElement = sizeElement.parentNode;
					elemW = sizeElement.scrollWidth;
					elemH = sizeElement.scrollHeight;
				}
				if (elemW && elemH) {
					opts.ratio = elemH / elemW;
				}
			}

			src = replaceUrlProps(src, opts);

			src.isPicture = opts.isPicture;

			if(buggySizes && elem.nodeName.toUpperCase() == 'IMG'){
				elem.removeAttribute(config.srcsetAttr);
			} else {
				elem.setAttribute(config.srcsetAttr, src.srcset.join(', '));
			}

			Object.defineProperty(elem, '_lazyrias', {
				value: src,
				writable: true
			});
		}

		function createAttrObject(elem, src){
			var opts = getElementOptions(elem, src);

			riasCfg.modifyOptions.call(elem, {target: elem, details: opts, detail: opts});

			lazySizes.fire(elem, 'lazyriasmodifyoptions', opts);
			return opts;
		}

		function getSrc(elem){
			return elem.getAttribute( elem.getAttribute('data-srcattr') || riasCfg.srcAttr ) || elem.getAttribute(config.srcsetAttr) || elem.getAttribute(config.srcAttr) || elem.getAttribute('data-pfsrcset') || '';
		}

		addEventListener('lazybeforesizes', function(e){
			var elem, src, elemOpts, parent, sources, i, len, sourceSrc, sizes, detail, hasPlaceholder, modified, emptyList;
			elem = e.target;

			if(!e.detail.dataAttr || e.defaultPrevented || riasCfg.disabled || !((sizes = elem.getAttribute(config.sizesAttr) || elem.getAttribute('sizes')) && regAllowedSizes.test(sizes))){return;}

			src = getSrc(elem);

			elemOpts = createAttrObject(elem, src);

			hasPlaceholder = regWidth.test(elemOpts.prefix) || regWidth.test(elemOpts.postfix);

			if(elemOpts.isPicture && (parent = elem.parentNode)){
				sources = parent.getElementsByTagName('source');
				for(i = 0, len = sources.length; i < len; i++){
					if ( hasPlaceholder || regWidth.test(sourceSrc = getSrc(sources[i])) ){
						setSrc(sourceSrc, elemOpts, sources[i]);
						modified = true;
					}
				}
			}

			if ( hasPlaceholder || regWidth.test(src) ){
				setSrc(src, elemOpts, elem);
				modified = true;
			} else if (modified) {
				emptyList = [];
				emptyList.srcset = [];
				emptyList.isPicture = true;
				Object.defineProperty(elem, '_lazyrias', {
					value: emptyList,
					writable: true
				});
			}

			if(modified){
				if(supportPicture){
					elem.removeAttribute(config.srcAttr);
				} else if(sizes != 'auto') {
					detail = {
						width: parseInt(sizes, 10)
					};
					polyfill({
						target: elem,
						detail: detail
					});
				}
			}
		}, true);
		// partial polyfill
		var polyfill = (function(){
			var ascendingSort = function( a, b ) {
				return a.w - b.w;
			};

			var reduceCandidate = function (srces) {
				var lowerCandidate, bonusFactor;
				var len = srces.length;
				var candidate = srces[len -1];
				var i = 0;

				for(i; i < len;i++){
					candidate = srces[i];
					candidate.d = candidate.w / srces.w;
					if(candidate.d >= srces.d){
						if(!candidate.cached && (lowerCandidate = srces[i - 1]) &&
							lowerCandidate.d > srces.d - (0.13 * Math.pow(srces.d, 2.2))){

							bonusFactor = Math.pow(lowerCandidate.d - 0.6, 1.6);

							if(lowerCandidate.cached) {
								lowerCandidate.d += 0.15 * bonusFactor;
							}

							if(lowerCandidate.d + ((candidate.d - srces.d) * bonusFactor) > srces.d){
								candidate = lowerCandidate;
							}
						}
						break;
					}
				}
				return candidate;
			};

			var getWSet = function(elem, testPicture){
				var src;
				if(!elem._lazyrias && lazySizes.pWS && (src = lazySizes.pWS(elem.getAttribute(config.srcsetAttr || ''))).length){
					Object.defineProperty(elem, '_lazyrias', {
						value: src,
						writable: true
					});
					if(testPicture && elem.parentNode){
						src.isPicture = elem.parentNode.nodeName.toUpperCase() == 'PICTURE';
					}
				}
				return elem._lazyrias;
			};

			var getX = function(elem){
				var dpr = window.devicePixelRatio || 1;
				var optimum = lazySizes.getX && lazySizes.getX(elem);
				return Math.min(optimum || dpr, 2.4, dpr);
			};

			var getCandidate = function(elem, width){
				var sources, i, len, media, srces, src;

				srces = elem._lazyrias;

				if(srces.isPicture && window.matchMedia){
					for(i = 0, sources = elem.parentNode.getElementsByTagName('source'), len = sources.length; i < len; i++){
						if(getWSet(sources[i]) && !sources[i].getAttribute('type') && ( !(media = sources[i].getAttribute('media')) || ((matchMedia(media) || {}).matches))){
							srces = sources[i]._lazyrias;
							break;
						}
					}
				}

				if(!srces.w || srces.w < width){
					srces.w = width;
					srces.d = getX(elem);
					src = reduceCandidate(srces.sort(ascendingSort));
				}

				return src;
			};

			var polyfill = function(e){
				var candidate;
				var elem = e.target;

				if(!buggySizes && (window.respimage || window.picturefill || lazySizesConfig.pf)){
					document.removeEventListener('lazybeforesizes', polyfill);
					return;
				}

				if(!('_lazyrias' in elem) && (!e.detail.dataAttr || !getWSet(elem, true))){
					return;
				}

				candidate = getCandidate(elem, e.detail.width);

				if(candidate && candidate.u && elem._lazyrias.cur != candidate.u){
					elem._lazyrias.cur = candidate.u;
					candidate.cached = true;
					lazySizes.rAF(function(){
						elem.setAttribute(config.srcAttr, candidate.u);
						elem.setAttribute('src', candidate.u);
					});
				}
			};

			if(!supportPicture){
				addEventListener('lazybeforesizes', polyfill);
			} else {
				polyfill = function(){};
			}

			return polyfill;

		})();

	})(window, document);


/***/ },

/***/ 88:
/***/ function(module, exports) {

	(function(){
		'use strict';
		if(!window.addEventListener){return;}

		var regWhite = /\s+/g;
		var regSplitSet = /\s*\|\s+|\s+\|\s*/g;
		var regSource = /^(.+?)(?:\s+\[\s*(.+?)\s*\])?$/;
		var regBgUrlEscape = /\(|\)|'/;
		var allowedBackgroundSize = {contain: 1, cover: 1};
		var proxyWidth = function(elem){
			var width = lazySizes.gW(elem, elem.parentNode);

			if(!elem._lazysizesWidth || width > elem._lazysizesWidth){
				elem._lazysizesWidth = width;
			}
			return elem._lazysizesWidth;
		};
		var getBgSize = function(elem){
			var bgSize;

			bgSize = (getComputedStyle(elem) || {getPropertyValue: function(){}}).getPropertyValue('background-size');

			if(!allowedBackgroundSize[bgSize] && allowedBackgroundSize[elem.style.backgroundSize]){
				bgSize = elem.style.backgroundSize;
			}

			return bgSize;
		};
		var createPicture = function(sets, elem, img){
			var picture = document.createElement('picture');
			var sizes = elem.getAttribute(lazySizesConfig.sizesAttr);
			var ratio = elem.getAttribute('data-ratio');
			var optimumx = elem.getAttribute('data-optimumx');

			if(elem._lazybgset && elem._lazybgset.parentNode == elem){
				elem.removeChild(elem._lazybgset);
			}

			Object.defineProperty(img, '_lazybgset', {
				value: elem,
				writable: true
			});
			Object.defineProperty(elem, '_lazybgset', {
				value: picture,
				writable: true
			});

			sets = sets.replace(regWhite, ' ').split(regSplitSet);

			picture.style.display = 'none';
			img.className = lazySizesConfig.lazyClass;

			if(sets.length == 1 && !sizes){
				sizes = 'auto';
			}

			sets.forEach(function(set){
				var source = document.createElement('source');

				if(sizes && sizes != 'auto'){
					source.setAttribute('sizes', sizes);
				}

				if(set.match(regSource)){
					source.setAttribute(lazySizesConfig.srcsetAttr, RegExp.$1);
					if(RegExp.$2){
						source.setAttribute('media', lazySizesConfig.customMedia[RegExp.$2] || RegExp.$2);
					}
				}
				picture.appendChild(source);
			});

			if(sizes){
				img.setAttribute(lazySizesConfig.sizesAttr, sizes);
				elem.removeAttribute(lazySizesConfig.sizesAttr);
				elem.removeAttribute('sizes');
			}
			if(optimumx){
				img.setAttribute('data-optimumx', optimumx);
			}
			if(ratio) {
				img.setAttribute('data-ratio', ratio);
			}

			picture.appendChild(img);

			elem.appendChild(picture);
		};

		var proxyLoad = function(e){
			if(!e.target._lazybgset){return;}

			var image = e.target;
			var elem = image._lazybgset;
			var bg = image.currentSrc || image.src;

			if(bg){
				elem.style.backgroundImage = 'url(' + (regBgUrlEscape.test(bg) ? JSON.stringify(bg) : bg ) + ')';
			}

			if(image._lazybgsetLoading){
				lazySizes.fire(elem, '_lazyloaded', {}, false, true);
				delete image._lazybgsetLoading;
			}
		};

		addEventListener('lazybeforeunveil', function(e){
			var set, image, elem;

			if(e.defaultPrevented || !(set = e.target.getAttribute('data-bgset'))){return;}

			elem = e.target;
			image = document.createElement('img');

			image.alt = '';

			image._lazybgsetLoading = true;
			e.detail.firesLoad = true;

			createPicture(set, elem, image);

			setTimeout(function(){
				lazySizes.loader.unveil(image);

				lazySizes.rAF(function(){
					lazySizes.fire(image, '_lazyloaded', {}, true, true);
					if(image.complete) {
						proxyLoad({target: image});
					}
				});
			});

		});

		document.addEventListener('load', proxyLoad, true);

		window.addEventListener('lazybeforesizes', function(e){
			if(e.target._lazybgset && e.detail.dataAttr){
				var elem = e.target._lazybgset;
				var bgSize = getBgSize(elem);

				if(allowedBackgroundSize[bgSize]){
					e.target._lazysizesParentFit = bgSize;

					lazySizes.rAF(function(){
						e.target.setAttribute('data-parent-fit', bgSize);
						if(e.target._lazysizesParentFit){
							delete e.target._lazysizesParentFit;
						}
					});
				}
			}
		}, true);

		document.documentElement.addEventListener('lazybeforesizes', function(e){
			if(e.defaultPrevented || !e.target._lazybgset){return;}
			e.detail.width = proxyWidth(e.target._lazybgset);
		});
	})();


/***/ },

/***/ 89:
/***/ function(module, exports) {

	(function(window, factory) {
		var lazySizes = factory(window, window.document);
		window.lazySizes = lazySizes;
		if(typeof module == 'object' && module.exports){
			module.exports = lazySizes;
		}
	}(window, function l(window, document) {
		'use strict';
		/*jshint eqnull:true */
		if(!document.getElementsByClassName){return;}

		var lazySizesConfig;

		var docElem = document.documentElement;

		var Date = window.Date;

		var supportPicture = window.HTMLPictureElement;

		var _addEventListener = 'addEventListener';

		var _getAttribute = 'getAttribute';

		var addEventListener = window[_addEventListener];

		var setTimeout = window.setTimeout;

		var requestAnimationFrame = window.requestAnimationFrame || setTimeout;

		var requestIdleCallback = window.requestIdleCallback;

		var regPicture = /^picture$/i;

		var loadEvents = ['load', 'error', 'lazyincluded', '_lazyloaded'];

		var regClassCache = {};

		var forEach = Array.prototype.forEach;

		var hasClass = function(ele, cls) {
			if(!regClassCache[cls]){
				regClassCache[cls] = new RegExp('(\\s|^)'+cls+'(\\s|$)');
			}
			return regClassCache[cls].test(ele[_getAttribute]('class') || '') && regClassCache[cls];
		};

		var addClass = function(ele, cls) {
			if (!hasClass(ele, cls)){
				ele.setAttribute('class', (ele[_getAttribute]('class') || '').trim() + ' ' + cls);
			}
		};

		var removeClass = function(ele, cls) {
			var reg;
			if ((reg = hasClass(ele,cls))) {
				ele.setAttribute('class', (ele[_getAttribute]('class') || '').replace(reg, ' '));
			}
		};

		var addRemoveLoadEvents = function(dom, fn, add){
			var action = add ? _addEventListener : 'removeEventListener';
			if(add){
				addRemoveLoadEvents(dom, fn);
			}
			loadEvents.forEach(function(evt){
				dom[action](evt, fn);
			});
		};

		var triggerEvent = function(elem, name, detail, noBubbles, noCancelable){
			var event = document.createEvent('CustomEvent');

			event.initCustomEvent(name, !noBubbles, !noCancelable, detail || {});

			elem.dispatchEvent(event);
			return event;
		};

		var updatePolyfill = function (el, full){
			var polyfill;
			if( !supportPicture && ( polyfill = (window.picturefill || lazySizesConfig.pf) ) ){
				polyfill({reevaluate: true, elements: [el]});
			} else if(full && full.src){
				el.src = full.src;
			}
		};

		var getCSS = function (elem, style){
			return (getComputedStyle(elem, null) || {})[style];
		};

		var getWidth = function(elem, parent, width){
			width = width || elem.offsetWidth;

			while(width < lazySizesConfig.minSize && parent && !elem._lazysizesWidth){
				width =  parent.offsetWidth;
				parent = parent.parentNode;
			}

			return width;
		};

		var rAF = (function(){
			var running, waiting;
			var fns = [];

			var run = function(){
				var fn;
				running = true;
				waiting = false;
				while(fns.length){
					fn = fns.shift();
					fn[0].apply(fn[1], fn[2]);
				}
				running = false;
			};

			var rafBatch = function(fn){
				if(running){
					fn.apply(this, arguments);
				} else {
					fns.push([fn, this, arguments]);

					if(!waiting){
						waiting = true;
						(document.hidden ? setTimeout : requestAnimationFrame)(run);
					}
				}
			};

			rafBatch._lsFlush = run;

			return rafBatch;
		})();

		var rAFIt = function(fn, simple){
			return simple ?
				function() {
					rAF(fn);
				} :
				function(){
					var that = this;
					var args = arguments;
					rAF(function(){
						fn.apply(that, args);
					});
				}
			;
		};

		var throttle = function(fn){
			var running;
			var lastTime = 0;
			var gDelay = 125;
			var RIC_DEFAULT_TIMEOUT = 666;
			var rICTimeout = RIC_DEFAULT_TIMEOUT;
			var run = function(){
				running = false;
				lastTime = Date.now();
				fn();
			};
			var idleCallback = requestIdleCallback ?
				function(){
					requestIdleCallback(run, {timeout: rICTimeout});
					if(rICTimeout !== RIC_DEFAULT_TIMEOUT){
						rICTimeout = RIC_DEFAULT_TIMEOUT;
					}
				}:
				rAFIt(function(){
					setTimeout(run);
				}, true)
			;

			return function(isPriority){
				var delay;
				if((isPriority = isPriority === true)){
					rICTimeout = 44;
				}

				if(running){
					return;
				}

				running =  true;

				delay = gDelay - (Date.now() - lastTime);

				if(delay < 0){
					delay = 0;
				}

				if(isPriority || (delay < 9 && requestIdleCallback)){
					idleCallback();
				} else {
					setTimeout(idleCallback, delay);
				}
			};
		};

		//based on http://modernjavascript.blogspot.de/2013/08/building-better-debounce.html
		var debounce = function(func) {
			var timeout, timestamp;
			var wait = 99;
			var run = function(){
				timeout = null;
				func();
			};
			var later = function() {
				var last = Date.now() - timestamp;

				if (last < wait) {
					setTimeout(later, wait - last);
				} else {
					(requestIdleCallback || run)(run);
				}
			};

			return function() {
				timestamp = Date.now();

				if (!timeout) {
					timeout = setTimeout(later, wait);
				}
			};
		};


		var loader = (function(){
			var lazyloadElems, preloadElems, isCompleted, resetPreloadingTimer, loadMode, started;

			var eLvW, elvH, eLtop, eLleft, eLright, eLbottom;

			var defaultExpand, preloadExpand, hFac;

			var regImg = /^img$/i;
			var regIframe = /^iframe$/i;

			var supportScroll = ('onscroll' in window) && !(/glebot/.test(navigator.userAgent));

			var shrinkExpand = 0;
			var currentExpand = 0;

			var isLoading = 0;
			var lowRuns = -1;

			var resetPreloading = function(e){
				isLoading--;
				if(e && e.target){
					addRemoveLoadEvents(e.target, resetPreloading);
				}

				if(!e || isLoading < 0 || !e.target){
					isLoading = 0;
				}
			};

			var isNestedVisible = function(elem, elemExpand){
				var outerRect;
				var parent = elem;
				var visible = getCSS(document.body, 'visibility') == 'hidden' || getCSS(elem, 'visibility') != 'hidden';

				eLtop -= elemExpand;
				eLbottom += elemExpand;
				eLleft -= elemExpand;
				eLright += elemExpand;

				while(visible && (parent = parent.offsetParent) && parent != document.body && parent != docElem){
					visible = ((getCSS(parent, 'opacity') || 1) > 0);

					if(visible && getCSS(parent, 'overflow') != 'visible'){
						outerRect = parent.getBoundingClientRect();
						visible = eLright > outerRect.left &&
							eLleft < outerRect.right &&
							eLbottom > outerRect.top - 1 &&
							eLtop < outerRect.bottom + 1
						;
					}
				}

				return visible;
			};

			var checkElements = function() {
				var eLlen, i, rect, autoLoadElem, loadedSomething, elemExpand, elemNegativeExpand, elemExpandVal, beforeExpandVal;

				if((loadMode = lazySizesConfig.loadMode) && isLoading < 8 && (eLlen = lazyloadElems.length)){

					i = 0;

					lowRuns++;

					if(preloadExpand == null){
						if(!('expand' in lazySizesConfig)){
							lazySizesConfig.expand = docElem.clientHeight > 500 && docElem.clientWidth > 500 ? 500 : 370;
						}

						defaultExpand = lazySizesConfig.expand;
						preloadExpand = defaultExpand * lazySizesConfig.expFactor;
					}

					if(currentExpand < preloadExpand && isLoading < 1 && lowRuns > 2 && loadMode > 2 && !document.hidden){
						currentExpand = preloadExpand;
						lowRuns = 0;
					} else if(loadMode > 1 && lowRuns > 1 && isLoading < 6){
						currentExpand = defaultExpand;
					} else {
						currentExpand = shrinkExpand;
					}

					for(; i < eLlen; i++){

						if(!lazyloadElems[i] || lazyloadElems[i]._lazyRace){continue;}

						if(!supportScroll){unveilElement(lazyloadElems[i]);continue;}

						if(!(elemExpandVal = lazyloadElems[i][_getAttribute]('data-expand')) || !(elemExpand = elemExpandVal * 1)){
							elemExpand = currentExpand;
						}

						if(beforeExpandVal !== elemExpand){
							eLvW = innerWidth + (elemExpand * hFac);
							elvH = innerHeight + elemExpand;
							elemNegativeExpand = elemExpand * -1;
							beforeExpandVal = elemExpand;
						}

						rect = lazyloadElems[i].getBoundingClientRect();

						if ((eLbottom = rect.bottom) >= elemNegativeExpand &&
							(eLtop = rect.top) <= elvH &&
							(eLright = rect.right) >= elemNegativeExpand * hFac &&
							(eLleft = rect.left) <= eLvW &&
							(eLbottom || eLright || eLleft || eLtop) &&
							((isCompleted && isLoading < 3 && !elemExpandVal && (loadMode < 3 || lowRuns < 4)) || isNestedVisible(lazyloadElems[i], elemExpand))){
							unveilElement(lazyloadElems[i]);
							loadedSomething = true;
							if(isLoading > 9){break;}
						} else if(!loadedSomething && isCompleted && !autoLoadElem &&
							isLoading < 4 && lowRuns < 4 && loadMode > 2 &&
							(preloadElems[0] || lazySizesConfig.preloadAfterLoad) &&
							(preloadElems[0] || (!elemExpandVal && ((eLbottom || eLright || eLleft || eLtop) || lazyloadElems[i][_getAttribute](lazySizesConfig.sizesAttr) != 'auto')))){
							autoLoadElem = preloadElems[0] || lazyloadElems[i];
						}
					}

					if(autoLoadElem && !loadedSomething){
						unveilElement(autoLoadElem);
					}
				}
			};

			var throttledCheckElements = throttle(checkElements);

			var switchLoadingClass = function(e){
				addClass(e.target, lazySizesConfig.loadedClass);
				removeClass(e.target, lazySizesConfig.loadingClass);
				addRemoveLoadEvents(e.target, rafSwitchLoadingClass);
			};
			var rafedSwitchLoadingClass = rAFIt(switchLoadingClass);
			var rafSwitchLoadingClass = function(e){
				rafedSwitchLoadingClass({target: e.target});
			};

			var changeIframeSrc = function(elem, src){
				try {
					elem.contentWindow.location.replace(src);
				} catch(e){
					elem.src = src;
				}
			};

			var handleSources = function(source){
				var customMedia, parent;

				var sourceSrcset = source[_getAttribute](lazySizesConfig.srcsetAttr);

				if( (customMedia = lazySizesConfig.customMedia[source[_getAttribute]('data-media') || source[_getAttribute]('media')]) ){
					source.setAttribute('media', customMedia);
				}

				if(sourceSrcset){
					source.setAttribute('srcset', sourceSrcset);
				}

				//https://bugzilla.mozilla.org/show_bug.cgi?id=1170572
				if(customMedia){
					parent = source.parentNode;
					parent.insertBefore(source.cloneNode(), source);
					parent.removeChild(source);
				}
			};

			var lazyUnveil = rAFIt(function (elem, detail, isAuto, sizes, isImg){
				var src, srcset, parent, isPicture, event, firesLoad;

				if(!(event = triggerEvent(elem, 'lazybeforeunveil', detail)).defaultPrevented){

					if(sizes){
						if(isAuto){
							addClass(elem, lazySizesConfig.autosizesClass);
						} else {
							elem.setAttribute('sizes', sizes);
						}
					}

					srcset = elem[_getAttribute](lazySizesConfig.srcsetAttr);
					src = elem[_getAttribute](lazySizesConfig.srcAttr);

					if(isImg) {
						parent = elem.parentNode;
						isPicture = parent && regPicture.test(parent.nodeName || '');
					}

					firesLoad = detail.firesLoad || (('src' in elem) && (srcset || src || isPicture));

					event = {target: elem};

					if(firesLoad){
						addRemoveLoadEvents(elem, resetPreloading, true);
						clearTimeout(resetPreloadingTimer);
						resetPreloadingTimer = setTimeout(resetPreloading, 2500);

						addClass(elem, lazySizesConfig.loadingClass);
						addRemoveLoadEvents(elem, rafSwitchLoadingClass, true);
					}

					if(isPicture){
						forEach.call(parent.getElementsByTagName('source'), handleSources);
					}

					if(srcset){
						elem.setAttribute('srcset', srcset);
					} else if(src && !isPicture){
						if(regIframe.test(elem.nodeName)){
							changeIframeSrc(elem, src);
						} else {
							elem.src = src;
						}
					}

					if(srcset || isPicture){
						updatePolyfill(elem, {src: src});
					}
				}

				rAF(function(){
					if(elem._lazyRace){
						delete elem._lazyRace;
					}
					removeClass(elem, lazySizesConfig.lazyClass);

					if( !firesLoad || elem.complete ){
						if(firesLoad){
							resetPreloading(event);
						} else {
							isLoading--;
						}
						switchLoadingClass(event);
					}
				});
			});

			var unveilElement = function (elem){
				var detail;

				var isImg = regImg.test(elem.nodeName);

				//allow using sizes="auto", but don't use. it's invalid. Use data-sizes="auto" or a valid value for sizes instead (i.e.: sizes="80vw")
				var sizes = isImg && (elem[_getAttribute](lazySizesConfig.sizesAttr) || elem[_getAttribute]('sizes'));
				var isAuto = sizes == 'auto';

				if( (isAuto || !isCompleted) && isImg && (elem.src || elem.srcset) && !elem.complete && !hasClass(elem, lazySizesConfig.errorClass)){return;}

				detail = triggerEvent(elem, 'lazyunveilread').detail;

				if(isAuto){
					 autoSizer.updateElem(elem, true, elem.offsetWidth);
				}

				elem._lazyRace = true;
				isLoading++;

				lazyUnveil(elem, detail, isAuto, sizes, isImg);
			};

			var onload = function(){
				if(isCompleted){return;}
				if(Date.now() - started < 999){
					setTimeout(onload, 999);
					return;
				}
				var afterScroll = debounce(function(){
					lazySizesConfig.loadMode = 3;
					throttledCheckElements();
				});

				isCompleted = true;

				lazySizesConfig.loadMode = 3;

				throttledCheckElements();

				addEventListener('scroll', function(){
					if(lazySizesConfig.loadMode == 3){
						lazySizesConfig.loadMode = 2;
					}
					afterScroll();
				}, true);
			};

			return {
				_: function(){
					started = Date.now();

					lazyloadElems = document.getElementsByClassName(lazySizesConfig.lazyClass);
					preloadElems = document.getElementsByClassName(lazySizesConfig.lazyClass + ' ' + lazySizesConfig.preloadClass);
					hFac = lazySizesConfig.hFac;

					addEventListener('scroll', throttledCheckElements, true);

					addEventListener('resize', throttledCheckElements, true);

					if(window.MutationObserver){
						new MutationObserver( throttledCheckElements ).observe( docElem, {childList: true, subtree: true, attributes: true} );
					} else {
						docElem[_addEventListener]('DOMNodeInserted', throttledCheckElements, true);
						docElem[_addEventListener]('DOMAttrModified', throttledCheckElements, true);
						setInterval(throttledCheckElements, 999);
					}

					addEventListener('hashchange', throttledCheckElements, true);

					//, 'fullscreenchange'
					['focus', 'mouseover', 'click', 'load', 'transitionend', 'animationend', 'webkitAnimationEnd'].forEach(function(name){
						document[_addEventListener](name, throttledCheckElements, true);
					});

					if((/d$|^c/.test(document.readyState))){
						onload();
					} else {
						addEventListener('load', onload);
						document[_addEventListener]('DOMContentLoaded', throttledCheckElements);
						setTimeout(onload, 20000);
					}

					if(lazyloadElems.length){
						checkElements();
					} else {
						throttledCheckElements();
					}
				},
				checkElems: throttledCheckElements,
				unveil: unveilElement
			};
		})();


		var autoSizer = (function(){
			var autosizesElems;

			var sizeElement = rAFIt(function(elem, parent, event, width){
				var sources, i, len;
				elem._lazysizesWidth = width;
				width += 'px';

				elem.setAttribute('sizes', width);

				if(regPicture.test(parent.nodeName || '')){
					sources = parent.getElementsByTagName('source');
					for(i = 0, len = sources.length; i < len; i++){
						sources[i].setAttribute('sizes', width);
					}
				}

				if(!event.detail.dataAttr){
					updatePolyfill(elem, event.detail);
				}
			});
			var getSizeElement = function (elem, dataAttr, width){
				var event;
				var parent = elem.parentNode;

				if(parent){
					width = getWidth(elem, parent, width);
					event = triggerEvent(elem, 'lazybeforesizes', {width: width, dataAttr: !!dataAttr});

					if(!event.defaultPrevented){
						width = event.detail.width;

						if(width && width !== elem._lazysizesWidth){
							sizeElement(elem, parent, event, width);
						}
					}
				}
			};

			var updateElementsSizes = function(){
				var i;
				var len = autosizesElems.length;
				if(len){
					i = 0;

					for(; i < len; i++){
						getSizeElement(autosizesElems[i]);
					}
				}
			};

			var debouncedUpdateElementsSizes = debounce(updateElementsSizes);

			return {
				_: function(){
					autosizesElems = document.getElementsByClassName(lazySizesConfig.autosizesClass);
					addEventListener('resize', debouncedUpdateElementsSizes);
				},
				checkElems: debouncedUpdateElementsSizes,
				updateElem: getSizeElement
			};
		})();

		var init = function(){
			if(!init.i){
				init.i = true;
				autoSizer._();
				loader._();
			}
		};

		(function(){
			var prop;

			var lazySizesDefaults = {
				lazyClass: 'lazyload',
				loadedClass: 'lazyloaded',
				loadingClass: 'lazyloading',
				preloadClass: 'lazypreload',
				errorClass: 'lazyerror',
				//strictClass: 'lazystrict',
				autosizesClass: 'lazyautosizes',
				srcAttr: 'data-src',
				srcsetAttr: 'data-srcset',
				sizesAttr: 'data-sizes',
				//preloadAfterLoad: false,
				minSize: 40,
				customMedia: {},
				init: true,
				expFactor: 1.5,
				hFac: 0.8,
				loadMode: 2
			};

			lazySizesConfig = window.lazySizesConfig || window.lazysizesConfig || {};

			for(prop in lazySizesDefaults){
				if(!(prop in lazySizesConfig)){
					lazySizesConfig[prop] = lazySizesDefaults[prop];
				}
			}

			window.lazySizesConfig = lazySizesConfig;

			setTimeout(function(){
				if(lazySizesConfig.init){
					init();
				}
			});
		})();

		return {
			cfg: lazySizesConfig,
			autoSizer: autoSizer,
			loader: loader,
			init: init,
			uP: updatePolyfill,
			aC: addClass,
			rC: removeClass,
			hC: hasClass,
			fire: triggerEvent,
			gW: getWidth,
			rAF: rAF,
		};
	}
	));


/***/ }

/******/ });