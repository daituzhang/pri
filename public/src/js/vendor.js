/******/ (function(modules) { // webpackBootstrap
/******/ 	// install a JSONP callback for chunk loading
/******/ 	var parentJsonpFunction = window["webpackJsonp"];
/******/ 	window["webpackJsonp"] = function webpackJsonpCallback(chunkIds, moreModules) {
/******/ 		// add "moreModules" to the modules object,
/******/ 		// then flag all "chunkIds" as loaded and fire callback
/******/ 		var moduleId, chunkId, i = 0, callbacks = [];
/******/ 		for(;i < chunkIds.length; i++) {
/******/ 			chunkId = chunkIds[i];
/******/ 			if(installedChunks[chunkId])
/******/ 				callbacks.push.apply(callbacks, installedChunks[chunkId]);
/******/ 			installedChunks[chunkId] = 0;
/******/ 		}
/******/ 		for(moduleId in moreModules) {
/******/ 			if(Object.prototype.hasOwnProperty.call(moreModules, moduleId)) {
/******/ 				modules[moduleId] = moreModules[moduleId];
/******/ 			}
/******/ 		}
/******/ 		if(parentJsonpFunction) parentJsonpFunction(chunkIds, moreModules);
/******/ 		while(callbacks.length)
/******/ 			callbacks.shift().call(null, __webpack_require__);
/******/ 		if(moreModules[0]) {
/******/ 			installedModules[0] = 0;
/******/ 			return __webpack_require__(0);
/******/ 		}
/******/ 	};
/******/
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// object to store loaded and loading chunks
/******/ 	// "0" means "already loaded"
/******/ 	// Array means "loading", array contains callbacks
/******/ 	var installedChunks = {
/******/ 		1:0
/******/ 	};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/ 	// This file contains only the entry chunk.
/******/ 	// The chunk loading function for additional chunks
/******/ 	__webpack_require__.e = function requireEnsure(chunkId, callback) {
/******/ 		// "0" is the signal for "already loaded"
/******/ 		if(installedChunks[chunkId] === 0)
/******/ 			return callback.call(null, __webpack_require__);
/******/
/******/ 		// an array means "currently loading".
/******/ 		if(installedChunks[chunkId] !== undefined) {
/******/ 			installedChunks[chunkId].push(callback);
/******/ 		} else {
/******/ 			// start chunk loading
/******/ 			installedChunks[chunkId] = [callback];
/******/ 			var head = document.getElementsByTagName('head')[0];
/******/ 			var script = document.createElement('script');
/******/ 			script.type = 'text/javascript';
/******/ 			script.charset = 'utf-8';
/******/ 			script.async = true;
/******/
/******/ 			script.src = __webpack_require__.p + "" + ({"0":"app"}[chunkId]||chunkId) + "-" + {"0":"4163704da08a4f236161"}[chunkId] + ".js";
/******/ 			head.appendChild(script);
/******/ 		}
/******/ 	};
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(2);


/***/ }),
/* 1 */,
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;(function(exports) {
	
	  'use strict';
	
	  var device = function(userAgent, classContainer) {
	
	    var device = {};
	
	    var docElement = classContainer || window.document.documentElement;
	    userAgent = (userAgent || window.navigator.userAgent).toLowerCase();
	
	    function find(needle) {
	      return userAgent.indexOf(needle) !== -1;
	    }
	
	    function hasClass(className) {
	      var regex;
	      regex = new RegExp(className, 'i');
	      return docElement.className.match(regex);
	    }
	
	    function addClass(className) {
	      if (!hasClass(className)) {
	        docElement.className += ' ' + className;
	      }
	    }
	
	    function removeClass(className) {
	      if (hasClass(className)) {
	        docElement.className = docElement.className.replace(className, '');
	      }
	    }
	
	    function getFirstMatch(regex) {
	      var match = userAgent.match(regex);
	      return (match && match.length > 1 && match[1]) || '';
	    }
	
	    device.ios = function() {
	      return device.iphone() || device.ipod() || device.ipad();
	    };
	
	    device.iphone = function() {
	      return find('iphone');
	    };
	
	    device.ipod = function() {
	      return find('ipod');
	    };
	
	    device.ipad = function() {
	      return find('ipad');
	    };
	
	    device.android = function() {
	      return find('android');
	    };
	
	    device.androidPhone = function() {
	      return device.android() && find('mobile');
	    };
	
	    device.androidTablet = function() {
	      return device.android() && !find('mobile');
	    };
	
	    device.blackberry = function() {
	      return find('blackberry') || find('bb10') || find('rim');
	    };
	
	    device.blackberryPhone = function() {
	      return device.blackberry() && !find('tablet');
	    };
	
	    device.blackberryTablet = function() {
	      return device.blackberry() && find('tablet');
	    };
	
	    device.windows = function() {
	      return find('windows');
	    };
	
	    device.windowsPhone = function() {
	      return device.windows() && find('phone');
	    };
	
	    device.windowsTablet = function() {
	      return device.windows() && (find('touch') && !device.windowsPhone());
	    };
	
	    device.fxos = function() {
	      return (find('(mobile;') || find('(tablet;')) && find('; rv:');
	    };
	
	    device.fxosPhone = function() {
	      return device.fxos() && find('mobile');
	    };
	
	    device.fxosTablet = function() {
	      return device.fxos() && find('tablet');
	    };
	
	    device.meego = function() {
	      return find('meego');
	    };
	
	    device.cordova = function() {
	      return window.cordova && location.protocol === 'file:';
	    };
	
	    device.nodeWebkit = function() {
	      return typeof window.process === 'object';
	    };
	
	    device.bada = function() {
	      return find('bada');
	    };
	
	    device.mobile = function() {
	      return device.androidPhone() || device.iphone() || device.ipod() || device.windowsPhone() || device.blackberryPhone() || device.fxosPhone() || device.meego();
	    };
	
	    device.tablet = function() {
	      return device.ipad() || device.androidTablet() || device.blackberryTablet() || device.windowsTablet() || device.fxosTablet();
	    };
	
	    device.desktop = function() {
	      return !device.tablet() && !device.mobile();
	    };
	
	    device.portrait = function() {
	      return (window.innerHeight / window.innerWidth) > 1;
	    };
	
	    device.landscape = function() {
	      return (window.innerHeight / window.innerWidth) < 1;
	    };
	
	    device.standAlone = function() {
	      return window.navigator.standalone === true;
	    };
	
	
	    device.addClasses = function() {
	
	      if (device._hasAddClasses) {
	        return;
	      }
	      device._hasAddClasses = true;
	
	      if (device.ios()) {
	        if (device.ipad()) {
	          addClass('ios ipad tablet');
	        } else if (device.iphone()) {
	          addClass('ios iphone mobile');
	        } else if (device.ipod()) {
	          addClass('ios ipod mobile');
	        }
	      } else if (device.android()) {
	        if (device.androidTablet()) {
	          addClass('android tablet');
	        } else {
	          addClass('android mobile');
	        }
	      } else if (device.blackberry()) {
	        if (device.blackberryTablet()) {
	          addClass('blackberry tablet');
	        } else {
	          addClass('blackberry mobile');
	        }
	      } else if (device.windows()) {
	        if (device.windowsTablet()) {
	          addClass('windows tablet');
	        } else if (device.windowsPhone()) {
	          addClass('windows mobile');
	        } else {
	          addClass('desktop');
	        }
	      } else if (device.fxos()) {
	        if (device.fxosTablet()) {
	          addClass('fxos tablet');
	        } else {
	          addClass('fxos mobile');
	        }
	      } else if (device.meego()) {
	        addClass('meego mobile');
	      } else if (device.nodeWebkit()) {
	        addClass('node-webkit');
	      } else {
	        addClass('desktop');
	      }
	
	      if (device.cordova()) {
	        addClass('cordova');
	      }
	
	      if (device.standAlone()) {
	        addClass('standalone');
	      }
	    };
	
	
	    // OS version extraction
	    var osVersion = '';
	    if (device.ios()) {
	      osVersion = getFirstMatch(/os (\d+([_\s]\d+)*) like mac os x/i);
	      osVersion = osVersion.replace(/[_\s]/g, '.');
	    } else if (device.android()) {
	      osVersion = getFirstMatch(/android[ \/-](\d+(\.\d+)*)/i);
	    } else if (device.windowsPhone()) {
	      osVersion = getFirstMatch(/windows phone (?:os)?\s?(\d+(\.\d+)*)/i);
	    }
	    /*else if (device.webos()) {
	          osVersion = getFirstMatch(/(?:web|hpw)os\/(\d+(\.\d+)*)/i); }*/
	    else if (device.blackberry()) {
	      osVersion = getFirstMatch(/rim\stablet\sos\s(\d+(\.\d+)*)/i);
	    } else if (device.bada()) {
	      osVersion = getFirstMatch(/bada\/(\d+(\.\d+)*)/i);
	    }
	    /*else if (result.tizen) {
	          osVersion = getFirstMatch(/tizen[\/\s](\d+(\.\d+)*)/i);
	        }*/
	
	    if (osVersion) {
	      device.osversion = osVersion;
	    }
	
	
	
	
	    device.addOrientationClasses = function() {
	
	      if (device.hasOrientationListener) {
	        return;
	      }
	
	      device.hasOrientationListener = true;
	
	      var onOrientationChange = function() {
	        if (device.landscape()) {
	          removeClass('portrait');
	          return addClass('landscape');
	        } else {
	          removeClass('landscape');
	          return addClass('portrait');
	        }
	      };
	
	      var orientationEvent = 'onorientationchange' in window ? 'orientationchange' : 'resize';
	
	      if (window.addEventListener) {
	        window.addEventListener(orientationEvent, onOrientationChange, false);
	      } else if (window.attachEvent) {
	        window.attachEvent(orientationEvent, onOrientationChange);
	      } else {
	        window[orientationEvent] = onOrientationChange;
	      }
	
	      onOrientationChange();
	
	    };
	
	    return device;
	  };
	
	  (typeof module !== 'undefined' && module.exports) ? (module.exports = device) : ( true ? (!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = function() {
	    return device;
	  }.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__))) : (exports.device = device));
	
	}(this));


/***/ })
/******/ ]);
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vd2VicGFjay9ib290c3RyYXAgNGJmZTM0NTExODJiOTAxN2ZhZWUiLCJ3ZWJwYWNrOi8vLy4vfi9kZXZpY2UuanMvZGV2aWNlLmpzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxnQkFBUSxvQkFBb0I7QUFDNUI7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQSx1QkFBZTtBQUNmO0FBQ0E7QUFDQTs7QUFFQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQSxZQUFJO0FBQ0o7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUEsd0RBQWdELFVBQVUsNkJBQTZCLDJCQUEyQjtBQUNsSDtBQUNBO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTs7Ozs7Ozs7Ozs7Ozs7O0FDOUZBOztBQUVBOztBQUVBOztBQUVBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBLDZCQUE0QixvQkFBb0IsY0FBYztBQUM5RDs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7O0FBR0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0EsVUFBUztBQUNUO0FBQ0EsVUFBUztBQUNUO0FBQ0E7QUFDQSxRQUFPO0FBQ1A7QUFDQTtBQUNBLFVBQVM7QUFDVDtBQUNBO0FBQ0EsUUFBTztBQUNQO0FBQ0E7QUFDQSxVQUFTO0FBQ1Q7QUFDQTtBQUNBLFFBQU87QUFDUDtBQUNBO0FBQ0EsVUFBUztBQUNUO0FBQ0EsVUFBUztBQUNUO0FBQ0E7QUFDQSxRQUFPO0FBQ1A7QUFDQTtBQUNBLFVBQVM7QUFDVDtBQUNBO0FBQ0EsUUFBTztBQUNQO0FBQ0EsUUFBTztBQUNQO0FBQ0EsUUFBTztBQUNQO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBOzs7QUFHQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsTUFBSztBQUNMO0FBQ0EsTUFBSztBQUNMO0FBQ0E7QUFDQTtBQUNBLHNFQUFxRSxFQUFFO0FBQ3ZFO0FBQ0E7QUFDQSxNQUFLO0FBQ0w7QUFDQTtBQUNBO0FBQ0E7QUFDQSxVQUFTOztBQUVUO0FBQ0E7QUFDQTs7Ozs7QUFLQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQSxVQUFTO0FBQ1Q7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7O0FBRUE7QUFDQTtBQUNBLFFBQU87QUFDUDtBQUNBLFFBQU87QUFDUDtBQUNBOztBQUVBOztBQUVBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLElBQUc7O0FBRUgsRUFBQyIsImZpbGUiOiJ2ZW5kb3IuanMiLCJzb3VyY2VzQ29udGVudCI6WyIgXHQvLyBpbnN0YWxsIGEgSlNPTlAgY2FsbGJhY2sgZm9yIGNodW5rIGxvYWRpbmdcbiBcdHZhciBwYXJlbnRKc29ucEZ1bmN0aW9uID0gd2luZG93W1wid2VicGFja0pzb25wXCJdO1xuIFx0d2luZG93W1wid2VicGFja0pzb25wXCJdID0gZnVuY3Rpb24gd2VicGFja0pzb25wQ2FsbGJhY2soY2h1bmtJZHMsIG1vcmVNb2R1bGVzKSB7XG4gXHRcdC8vIGFkZCBcIm1vcmVNb2R1bGVzXCIgdG8gdGhlIG1vZHVsZXMgb2JqZWN0LFxuIFx0XHQvLyB0aGVuIGZsYWcgYWxsIFwiY2h1bmtJZHNcIiBhcyBsb2FkZWQgYW5kIGZpcmUgY2FsbGJhY2tcbiBcdFx0dmFyIG1vZHVsZUlkLCBjaHVua0lkLCBpID0gMCwgY2FsbGJhY2tzID0gW107XG4gXHRcdGZvcig7aSA8IGNodW5rSWRzLmxlbmd0aDsgaSsrKSB7XG4gXHRcdFx0Y2h1bmtJZCA9IGNodW5rSWRzW2ldO1xuIFx0XHRcdGlmKGluc3RhbGxlZENodW5rc1tjaHVua0lkXSlcbiBcdFx0XHRcdGNhbGxiYWNrcy5wdXNoLmFwcGx5KGNhbGxiYWNrcywgaW5zdGFsbGVkQ2h1bmtzW2NodW5rSWRdKTtcbiBcdFx0XHRpbnN0YWxsZWRDaHVua3NbY2h1bmtJZF0gPSAwO1xuIFx0XHR9XG4gXHRcdGZvcihtb2R1bGVJZCBpbiBtb3JlTW9kdWxlcykge1xuIFx0XHRcdGlmKE9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChtb3JlTW9kdWxlcywgbW9kdWxlSWQpKSB7XG4gXHRcdFx0XHRtb2R1bGVzW21vZHVsZUlkXSA9IG1vcmVNb2R1bGVzW21vZHVsZUlkXTtcbiBcdFx0XHR9XG4gXHRcdH1cbiBcdFx0aWYocGFyZW50SnNvbnBGdW5jdGlvbikgcGFyZW50SnNvbnBGdW5jdGlvbihjaHVua0lkcywgbW9yZU1vZHVsZXMpO1xuIFx0XHR3aGlsZShjYWxsYmFja3MubGVuZ3RoKVxuIFx0XHRcdGNhbGxiYWNrcy5zaGlmdCgpLmNhbGwobnVsbCwgX193ZWJwYWNrX3JlcXVpcmVfXyk7XG4gXHRcdGlmKG1vcmVNb2R1bGVzWzBdKSB7XG4gXHRcdFx0aW5zdGFsbGVkTW9kdWxlc1swXSA9IDA7XG4gXHRcdFx0cmV0dXJuIF9fd2VicGFja19yZXF1aXJlX18oMCk7XG4gXHRcdH1cbiBcdH07XG5cbiBcdC8vIFRoZSBtb2R1bGUgY2FjaGVcbiBcdHZhciBpbnN0YWxsZWRNb2R1bGVzID0ge307XG5cbiBcdC8vIG9iamVjdCB0byBzdG9yZSBsb2FkZWQgYW5kIGxvYWRpbmcgY2h1bmtzXG4gXHQvLyBcIjBcIiBtZWFucyBcImFscmVhZHkgbG9hZGVkXCJcbiBcdC8vIEFycmF5IG1lYW5zIFwibG9hZGluZ1wiLCBhcnJheSBjb250YWlucyBjYWxsYmFja3NcbiBcdHZhciBpbnN0YWxsZWRDaHVua3MgPSB7XG4gXHRcdDE6MFxuIFx0fTtcblxuIFx0Ly8gVGhlIHJlcXVpcmUgZnVuY3Rpb25cbiBcdGZ1bmN0aW9uIF9fd2VicGFja19yZXF1aXJlX18obW9kdWxlSWQpIHtcblxuIFx0XHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcbiBcdFx0aWYoaW5zdGFsbGVkTW9kdWxlc1ttb2R1bGVJZF0pXG4gXHRcdFx0cmV0dXJuIGluc3RhbGxlZE1vZHVsZXNbbW9kdWxlSWRdLmV4cG9ydHM7XG5cbiBcdFx0Ly8gQ3JlYXRlIGEgbmV3IG1vZHVsZSAoYW5kIHB1dCBpdCBpbnRvIHRoZSBjYWNoZSlcbiBcdFx0dmFyIG1vZHVsZSA9IGluc3RhbGxlZE1vZHVsZXNbbW9kdWxlSWRdID0ge1xuIFx0XHRcdGV4cG9ydHM6IHt9LFxuIFx0XHRcdGlkOiBtb2R1bGVJZCxcbiBcdFx0XHRsb2FkZWQ6IGZhbHNlXG4gXHRcdH07XG5cbiBcdFx0Ly8gRXhlY3V0ZSB0aGUgbW9kdWxlIGZ1bmN0aW9uXG4gXHRcdG1vZHVsZXNbbW9kdWxlSWRdLmNhbGwobW9kdWxlLmV4cG9ydHMsIG1vZHVsZSwgbW9kdWxlLmV4cG9ydHMsIF9fd2VicGFja19yZXF1aXJlX18pO1xuXG4gXHRcdC8vIEZsYWcgdGhlIG1vZHVsZSBhcyBsb2FkZWRcbiBcdFx0bW9kdWxlLmxvYWRlZCA9IHRydWU7XG5cbiBcdFx0Ly8gUmV0dXJuIHRoZSBleHBvcnRzIG9mIHRoZSBtb2R1bGVcbiBcdFx0cmV0dXJuIG1vZHVsZS5leHBvcnRzO1xuIFx0fVxuXG4gXHQvLyBUaGlzIGZpbGUgY29udGFpbnMgb25seSB0aGUgZW50cnkgY2h1bmsuXG4gXHQvLyBUaGUgY2h1bmsgbG9hZGluZyBmdW5jdGlvbiBmb3IgYWRkaXRpb25hbCBjaHVua3NcbiBcdF9fd2VicGFja19yZXF1aXJlX18uZSA9IGZ1bmN0aW9uIHJlcXVpcmVFbnN1cmUoY2h1bmtJZCwgY2FsbGJhY2spIHtcbiBcdFx0Ly8gXCIwXCIgaXMgdGhlIHNpZ25hbCBmb3IgXCJhbHJlYWR5IGxvYWRlZFwiXG4gXHRcdGlmKGluc3RhbGxlZENodW5rc1tjaHVua0lkXSA9PT0gMClcbiBcdFx0XHRyZXR1cm4gY2FsbGJhY2suY2FsbChudWxsLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuIFx0XHQvLyBhbiBhcnJheSBtZWFucyBcImN1cnJlbnRseSBsb2FkaW5nXCIuXG4gXHRcdGlmKGluc3RhbGxlZENodW5rc1tjaHVua0lkXSAhPT0gdW5kZWZpbmVkKSB7XG4gXHRcdFx0aW5zdGFsbGVkQ2h1bmtzW2NodW5rSWRdLnB1c2goY2FsbGJhY2spO1xuIFx0XHR9IGVsc2Uge1xuIFx0XHRcdC8vIHN0YXJ0IGNodW5rIGxvYWRpbmdcbiBcdFx0XHRpbnN0YWxsZWRDaHVua3NbY2h1bmtJZF0gPSBbY2FsbGJhY2tdO1xuIFx0XHRcdHZhciBoZWFkID0gZG9jdW1lbnQuZ2V0RWxlbWVudHNCeVRhZ05hbWUoJ2hlYWQnKVswXTtcbiBcdFx0XHR2YXIgc2NyaXB0ID0gZG9jdW1lbnQuY3JlYXRlRWxlbWVudCgnc2NyaXB0Jyk7XG4gXHRcdFx0c2NyaXB0LnR5cGUgPSAndGV4dC9qYXZhc2NyaXB0JztcbiBcdFx0XHRzY3JpcHQuY2hhcnNldCA9ICd1dGYtOCc7XG4gXHRcdFx0c2NyaXB0LmFzeW5jID0gdHJ1ZTtcblxuIFx0XHRcdHNjcmlwdC5zcmMgPSBfX3dlYnBhY2tfcmVxdWlyZV9fLnAgKyBcIlwiICsgKHtcIjBcIjpcImFwcFwifVtjaHVua0lkXXx8Y2h1bmtJZCkgKyBcIi1cIiArIHtcIjBcIjpcIjQxNjM3MDRkYTA4YTRmMjM2MTYxXCJ9W2NodW5rSWRdICsgXCIuanNcIjtcbiBcdFx0XHRoZWFkLmFwcGVuZENoaWxkKHNjcmlwdCk7XG4gXHRcdH1cbiBcdH07XG5cbiBcdC8vIGV4cG9zZSB0aGUgbW9kdWxlcyBvYmplY3QgKF9fd2VicGFja19tb2R1bGVzX18pXG4gXHRfX3dlYnBhY2tfcmVxdWlyZV9fLm0gPSBtb2R1bGVzO1xuXG4gXHQvLyBleHBvc2UgdGhlIG1vZHVsZSBjYWNoZVxuIFx0X193ZWJwYWNrX3JlcXVpcmVfXy5jID0gaW5zdGFsbGVkTW9kdWxlcztcblxuIFx0Ly8gX193ZWJwYWNrX3B1YmxpY19wYXRoX19cbiBcdF9fd2VicGFja19yZXF1aXJlX18ucCA9IFwiXCI7XG5cbiBcdC8vIExvYWQgZW50cnkgbW9kdWxlIGFuZCByZXR1cm4gZXhwb3J0c1xuIFx0cmV0dXJuIF9fd2VicGFja19yZXF1aXJlX18oMCk7XG5cblxuXG4vLyBXRUJQQUNLIEZPT1RFUiAvL1xuLy8gd2VicGFjay9ib290c3RyYXAgNGJmZTM0NTExODJiOTAxN2ZhZWUiLCIoZnVuY3Rpb24oZXhwb3J0cykge1xuXG4gICd1c2Ugc3RyaWN0JztcblxuICB2YXIgZGV2aWNlID0gZnVuY3Rpb24odXNlckFnZW50LCBjbGFzc0NvbnRhaW5lcikge1xuXG4gICAgdmFyIGRldmljZSA9IHt9O1xuXG4gICAgdmFyIGRvY0VsZW1lbnQgPSBjbGFzc0NvbnRhaW5lciB8fCB3aW5kb3cuZG9jdW1lbnQuZG9jdW1lbnRFbGVtZW50O1xuICAgIHVzZXJBZ2VudCA9ICh1c2VyQWdlbnQgfHwgd2luZG93Lm5hdmlnYXRvci51c2VyQWdlbnQpLnRvTG93ZXJDYXNlKCk7XG5cbiAgICBmdW5jdGlvbiBmaW5kKG5lZWRsZSkge1xuICAgICAgcmV0dXJuIHVzZXJBZ2VudC5pbmRleE9mKG5lZWRsZSkgIT09IC0xO1xuICAgIH1cblxuICAgIGZ1bmN0aW9uIGhhc0NsYXNzKGNsYXNzTmFtZSkge1xuICAgICAgdmFyIHJlZ2V4O1xuICAgICAgcmVnZXggPSBuZXcgUmVnRXhwKGNsYXNzTmFtZSwgJ2knKTtcbiAgICAgIHJldHVybiBkb2NFbGVtZW50LmNsYXNzTmFtZS5tYXRjaChyZWdleCk7XG4gICAgfVxuXG4gICAgZnVuY3Rpb24gYWRkQ2xhc3MoY2xhc3NOYW1lKSB7XG4gICAgICBpZiAoIWhhc0NsYXNzKGNsYXNzTmFtZSkpIHtcbiAgICAgICAgZG9jRWxlbWVudC5jbGFzc05hbWUgKz0gJyAnICsgY2xhc3NOYW1lO1xuICAgICAgfVxuICAgIH1cblxuICAgIGZ1bmN0aW9uIHJlbW92ZUNsYXNzKGNsYXNzTmFtZSkge1xuICAgICAgaWYgKGhhc0NsYXNzKGNsYXNzTmFtZSkpIHtcbiAgICAgICAgZG9jRWxlbWVudC5jbGFzc05hbWUgPSBkb2NFbGVtZW50LmNsYXNzTmFtZS5yZXBsYWNlKGNsYXNzTmFtZSwgJycpO1xuICAgICAgfVxuICAgIH1cblxuICAgIGZ1bmN0aW9uIGdldEZpcnN0TWF0Y2gocmVnZXgpIHtcbiAgICAgIHZhciBtYXRjaCA9IHVzZXJBZ2VudC5tYXRjaChyZWdleCk7XG4gICAgICByZXR1cm4gKG1hdGNoICYmIG1hdGNoLmxlbmd0aCA+IDEgJiYgbWF0Y2hbMV0pIHx8ICcnO1xuICAgIH1cblxuICAgIGRldmljZS5pb3MgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuaXBob25lKCkgfHwgZGV2aWNlLmlwb2QoKSB8fCBkZXZpY2UuaXBhZCgpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuaXBob25lID0gZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gZmluZCgnaXBob25lJyk7XG4gICAgfTtcblxuICAgIGRldmljZS5pcG9kID0gZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gZmluZCgnaXBvZCcpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuaXBhZCA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGZpbmQoJ2lwYWQnKTtcbiAgICB9O1xuXG4gICAgZGV2aWNlLmFuZHJvaWQgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBmaW5kKCdhbmRyb2lkJyk7XG4gICAgfTtcblxuICAgIGRldmljZS5hbmRyb2lkUGhvbmUgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuYW5kcm9pZCgpICYmIGZpbmQoJ21vYmlsZScpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuYW5kcm9pZFRhYmxldCA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGRldmljZS5hbmRyb2lkKCkgJiYgIWZpbmQoJ21vYmlsZScpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuYmxhY2tiZXJyeSA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGZpbmQoJ2JsYWNrYmVycnknKSB8fCBmaW5kKCdiYjEwJykgfHwgZmluZCgncmltJyk7XG4gICAgfTtcblxuICAgIGRldmljZS5ibGFja2JlcnJ5UGhvbmUgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuYmxhY2tiZXJyeSgpICYmICFmaW5kKCd0YWJsZXQnKTtcbiAgICB9O1xuXG4gICAgZGV2aWNlLmJsYWNrYmVycnlUYWJsZXQgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuYmxhY2tiZXJyeSgpICYmIGZpbmQoJ3RhYmxldCcpO1xuICAgIH07XG5cbiAgICBkZXZpY2Uud2luZG93cyA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGZpbmQoJ3dpbmRvd3MnKTtcbiAgICB9O1xuXG4gICAgZGV2aWNlLndpbmRvd3NQaG9uZSA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGRldmljZS53aW5kb3dzKCkgJiYgZmluZCgncGhvbmUnKTtcbiAgICB9O1xuXG4gICAgZGV2aWNlLndpbmRvd3NUYWJsZXQgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2Uud2luZG93cygpICYmIChmaW5kKCd0b3VjaCcpICYmICFkZXZpY2Uud2luZG93c1Bob25lKCkpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuZnhvcyA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIChmaW5kKCcobW9iaWxlOycpIHx8IGZpbmQoJyh0YWJsZXQ7JykpICYmIGZpbmQoJzsgcnY6Jyk7XG4gICAgfTtcblxuICAgIGRldmljZS5meG9zUGhvbmUgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuZnhvcygpICYmIGZpbmQoJ21vYmlsZScpO1xuICAgIH07XG5cbiAgICBkZXZpY2UuZnhvc1RhYmxldCA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGRldmljZS5meG9zKCkgJiYgZmluZCgndGFibGV0Jyk7XG4gICAgfTtcblxuICAgIGRldmljZS5tZWVnbyA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIGZpbmQoJ21lZWdvJyk7XG4gICAgfTtcblxuICAgIGRldmljZS5jb3Jkb3ZhID0gZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gd2luZG93LmNvcmRvdmEgJiYgbG9jYXRpb24ucHJvdG9jb2wgPT09ICdmaWxlOic7XG4gICAgfTtcblxuICAgIGRldmljZS5ub2RlV2Via2l0ID0gZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gdHlwZW9mIHdpbmRvdy5wcm9jZXNzID09PSAnb2JqZWN0JztcbiAgICB9O1xuXG4gICAgZGV2aWNlLmJhZGEgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBmaW5kKCdiYWRhJyk7XG4gICAgfTtcblxuICAgIGRldmljZS5tb2JpbGUgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuYW5kcm9pZFBob25lKCkgfHwgZGV2aWNlLmlwaG9uZSgpIHx8IGRldmljZS5pcG9kKCkgfHwgZGV2aWNlLndpbmRvd3NQaG9uZSgpIHx8IGRldmljZS5ibGFja2JlcnJ5UGhvbmUoKSB8fCBkZXZpY2UuZnhvc1Bob25lKCkgfHwgZGV2aWNlLm1lZWdvKCk7XG4gICAgfTtcblxuICAgIGRldmljZS50YWJsZXQgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiBkZXZpY2UuaXBhZCgpIHx8IGRldmljZS5hbmRyb2lkVGFibGV0KCkgfHwgZGV2aWNlLmJsYWNrYmVycnlUYWJsZXQoKSB8fCBkZXZpY2Uud2luZG93c1RhYmxldCgpIHx8IGRldmljZS5meG9zVGFibGV0KCk7XG4gICAgfTtcblxuICAgIGRldmljZS5kZXNrdG9wID0gZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gIWRldmljZS50YWJsZXQoKSAmJiAhZGV2aWNlLm1vYmlsZSgpO1xuICAgIH07XG5cbiAgICBkZXZpY2UucG9ydHJhaXQgPSBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiAod2luZG93LmlubmVySGVpZ2h0IC8gd2luZG93LmlubmVyV2lkdGgpID4gMTtcbiAgICB9O1xuXG4gICAgZGV2aWNlLmxhbmRzY2FwZSA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuICh3aW5kb3cuaW5uZXJIZWlnaHQgLyB3aW5kb3cuaW5uZXJXaWR0aCkgPCAxO1xuICAgIH07XG5cbiAgICBkZXZpY2Uuc3RhbmRBbG9uZSA9IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIHdpbmRvdy5uYXZpZ2F0b3Iuc3RhbmRhbG9uZSA9PT0gdHJ1ZTtcbiAgICB9O1xuXG5cbiAgICBkZXZpY2UuYWRkQ2xhc3NlcyA9IGZ1bmN0aW9uKCkge1xuXG4gICAgICBpZiAoZGV2aWNlLl9oYXNBZGRDbGFzc2VzKSB7XG4gICAgICAgIHJldHVybjtcbiAgICAgIH1cbiAgICAgIGRldmljZS5faGFzQWRkQ2xhc3NlcyA9IHRydWU7XG5cbiAgICAgIGlmIChkZXZpY2UuaW9zKCkpIHtcbiAgICAgICAgaWYgKGRldmljZS5pcGFkKCkpIHtcbiAgICAgICAgICBhZGRDbGFzcygnaW9zIGlwYWQgdGFibGV0Jyk7XG4gICAgICAgIH0gZWxzZSBpZiAoZGV2aWNlLmlwaG9uZSgpKSB7XG4gICAgICAgICAgYWRkQ2xhc3MoJ2lvcyBpcGhvbmUgbW9iaWxlJyk7XG4gICAgICAgIH0gZWxzZSBpZiAoZGV2aWNlLmlwb2QoKSkge1xuICAgICAgICAgIGFkZENsYXNzKCdpb3MgaXBvZCBtb2JpbGUnKTtcbiAgICAgICAgfVxuICAgICAgfSBlbHNlIGlmIChkZXZpY2UuYW5kcm9pZCgpKSB7XG4gICAgICAgIGlmIChkZXZpY2UuYW5kcm9pZFRhYmxldCgpKSB7XG4gICAgICAgICAgYWRkQ2xhc3MoJ2FuZHJvaWQgdGFibGV0Jyk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgYWRkQ2xhc3MoJ2FuZHJvaWQgbW9iaWxlJyk7XG4gICAgICAgIH1cbiAgICAgIH0gZWxzZSBpZiAoZGV2aWNlLmJsYWNrYmVycnkoKSkge1xuICAgICAgICBpZiAoZGV2aWNlLmJsYWNrYmVycnlUYWJsZXQoKSkge1xuICAgICAgICAgIGFkZENsYXNzKCdibGFja2JlcnJ5IHRhYmxldCcpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIGFkZENsYXNzKCdibGFja2JlcnJ5IG1vYmlsZScpO1xuICAgICAgICB9XG4gICAgICB9IGVsc2UgaWYgKGRldmljZS53aW5kb3dzKCkpIHtcbiAgICAgICAgaWYgKGRldmljZS53aW5kb3dzVGFibGV0KCkpIHtcbiAgICAgICAgICBhZGRDbGFzcygnd2luZG93cyB0YWJsZXQnKTtcbiAgICAgICAgfSBlbHNlIGlmIChkZXZpY2Uud2luZG93c1Bob25lKCkpIHtcbiAgICAgICAgICBhZGRDbGFzcygnd2luZG93cyBtb2JpbGUnKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICBhZGRDbGFzcygnZGVza3RvcCcpO1xuICAgICAgICB9XG4gICAgICB9IGVsc2UgaWYgKGRldmljZS5meG9zKCkpIHtcbiAgICAgICAgaWYgKGRldmljZS5meG9zVGFibGV0KCkpIHtcbiAgICAgICAgICBhZGRDbGFzcygnZnhvcyB0YWJsZXQnKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICBhZGRDbGFzcygnZnhvcyBtb2JpbGUnKTtcbiAgICAgICAgfVxuICAgICAgfSBlbHNlIGlmIChkZXZpY2UubWVlZ28oKSkge1xuICAgICAgICBhZGRDbGFzcygnbWVlZ28gbW9iaWxlJyk7XG4gICAgICB9IGVsc2UgaWYgKGRldmljZS5ub2RlV2Via2l0KCkpIHtcbiAgICAgICAgYWRkQ2xhc3MoJ25vZGUtd2Via2l0Jyk7XG4gICAgICB9IGVsc2Uge1xuICAgICAgICBhZGRDbGFzcygnZGVza3RvcCcpO1xuICAgICAgfVxuXG4gICAgICBpZiAoZGV2aWNlLmNvcmRvdmEoKSkge1xuICAgICAgICBhZGRDbGFzcygnY29yZG92YScpO1xuICAgICAgfVxuXG4gICAgICBpZiAoZGV2aWNlLnN0YW5kQWxvbmUoKSkge1xuICAgICAgICBhZGRDbGFzcygnc3RhbmRhbG9uZScpO1xuICAgICAgfVxuICAgIH07XG5cblxuICAgIC8vIE9TIHZlcnNpb24gZXh0cmFjdGlvblxuICAgIHZhciBvc1ZlcnNpb24gPSAnJztcbiAgICBpZiAoZGV2aWNlLmlvcygpKSB7XG4gICAgICBvc1ZlcnNpb24gPSBnZXRGaXJzdE1hdGNoKC9vcyAoXFxkKyhbX1xcc11cXGQrKSopIGxpa2UgbWFjIG9zIHgvaSk7XG4gICAgICBvc1ZlcnNpb24gPSBvc1ZlcnNpb24ucmVwbGFjZSgvW19cXHNdL2csICcuJyk7XG4gICAgfSBlbHNlIGlmIChkZXZpY2UuYW5kcm9pZCgpKSB7XG4gICAgICBvc1ZlcnNpb24gPSBnZXRGaXJzdE1hdGNoKC9hbmRyb2lkWyBcXC8tXShcXGQrKFxcLlxcZCspKikvaSk7XG4gICAgfSBlbHNlIGlmIChkZXZpY2Uud2luZG93c1Bob25lKCkpIHtcbiAgICAgIG9zVmVyc2lvbiA9IGdldEZpcnN0TWF0Y2goL3dpbmRvd3MgcGhvbmUgKD86b3MpP1xccz8oXFxkKyhcXC5cXGQrKSopL2kpO1xuICAgIH1cbiAgICAvKmVsc2UgaWYgKGRldmljZS53ZWJvcygpKSB7XG4gICAgICAgICAgb3NWZXJzaW9uID0gZ2V0Rmlyc3RNYXRjaCgvKD86d2VifGhwdylvc1xcLyhcXGQrKFxcLlxcZCspKikvaSk7IH0qL1xuICAgIGVsc2UgaWYgKGRldmljZS5ibGFja2JlcnJ5KCkpIHtcbiAgICAgIG9zVmVyc2lvbiA9IGdldEZpcnN0TWF0Y2goL3JpbVxcc3RhYmxldFxcc29zXFxzKFxcZCsoXFwuXFxkKykqKS9pKTtcbiAgICB9IGVsc2UgaWYgKGRldmljZS5iYWRhKCkpIHtcbiAgICAgIG9zVmVyc2lvbiA9IGdldEZpcnN0TWF0Y2goL2JhZGFcXC8oXFxkKyhcXC5cXGQrKSopL2kpO1xuICAgIH1cbiAgICAvKmVsc2UgaWYgKHJlc3VsdC50aXplbikge1xuICAgICAgICAgIG9zVmVyc2lvbiA9IGdldEZpcnN0TWF0Y2goL3RpemVuW1xcL1xcc10oXFxkKyhcXC5cXGQrKSopL2kpO1xuICAgICAgICB9Ki9cblxuICAgIGlmIChvc1ZlcnNpb24pIHtcbiAgICAgIGRldmljZS5vc3ZlcnNpb24gPSBvc1ZlcnNpb247XG4gICAgfVxuXG5cblxuXG4gICAgZGV2aWNlLmFkZE9yaWVudGF0aW9uQ2xhc3NlcyA9IGZ1bmN0aW9uKCkge1xuXG4gICAgICBpZiAoZGV2aWNlLmhhc09yaWVudGF0aW9uTGlzdGVuZXIpIHtcbiAgICAgICAgcmV0dXJuO1xuICAgICAgfVxuXG4gICAgICBkZXZpY2UuaGFzT3JpZW50YXRpb25MaXN0ZW5lciA9IHRydWU7XG5cbiAgICAgIHZhciBvbk9yaWVudGF0aW9uQ2hhbmdlID0gZnVuY3Rpb24oKSB7XG4gICAgICAgIGlmIChkZXZpY2UubGFuZHNjYXBlKCkpIHtcbiAgICAgICAgICByZW1vdmVDbGFzcygncG9ydHJhaXQnKTtcbiAgICAgICAgICByZXR1cm4gYWRkQ2xhc3MoJ2xhbmRzY2FwZScpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIHJlbW92ZUNsYXNzKCdsYW5kc2NhcGUnKTtcbiAgICAgICAgICByZXR1cm4gYWRkQ2xhc3MoJ3BvcnRyYWl0Jyk7XG4gICAgICAgIH1cbiAgICAgIH07XG5cbiAgICAgIHZhciBvcmllbnRhdGlvbkV2ZW50ID0gJ29ub3JpZW50YXRpb25jaGFuZ2UnIGluIHdpbmRvdyA/ICdvcmllbnRhdGlvbmNoYW5nZScgOiAncmVzaXplJztcblxuICAgICAgaWYgKHdpbmRvdy5hZGRFdmVudExpc3RlbmVyKSB7XG4gICAgICAgIHdpbmRvdy5hZGRFdmVudExpc3RlbmVyKG9yaWVudGF0aW9uRXZlbnQsIG9uT3JpZW50YXRpb25DaGFuZ2UsIGZhbHNlKTtcbiAgICAgIH0gZWxzZSBpZiAod2luZG93LmF0dGFjaEV2ZW50KSB7XG4gICAgICAgIHdpbmRvdy5hdHRhY2hFdmVudChvcmllbnRhdGlvbkV2ZW50LCBvbk9yaWVudGF0aW9uQ2hhbmdlKTtcbiAgICAgIH0gZWxzZSB7XG4gICAgICAgIHdpbmRvd1tvcmllbnRhdGlvbkV2ZW50XSA9IG9uT3JpZW50YXRpb25DaGFuZ2U7XG4gICAgICB9XG5cbiAgICAgIG9uT3JpZW50YXRpb25DaGFuZ2UoKTtcblxuICAgIH07XG5cbiAgICByZXR1cm4gZGV2aWNlO1xuICB9O1xuXG4gICh0eXBlb2YgbW9kdWxlICE9PSAndW5kZWZpbmVkJyAmJiBtb2R1bGUuZXhwb3J0cykgPyAobW9kdWxlLmV4cG9ydHMgPSBkZXZpY2UpIDogKHR5cGVvZiBkZWZpbmUgPT09ICdmdW5jdGlvbicgJiYgZGVmaW5lLmFtZCA/IChkZWZpbmUoW10sIGZ1bmN0aW9uKCkge1xuICAgIHJldHVybiBkZXZpY2U7XG4gIH0pKSA6IChleHBvcnRzLmRldmljZSA9IGRldmljZSkpO1xuXG59KHRoaXMpKTtcblxuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vfi9kZXZpY2UuanMvZGV2aWNlLmpzXG4vLyBtb2R1bGUgaWQgPSAyXG4vLyBtb2R1bGUgY2h1bmtzID0gMSJdLCJzb3VyY2VSb290IjoiIn0=