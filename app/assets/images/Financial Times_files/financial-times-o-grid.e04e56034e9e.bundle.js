(window.webpackJsonp=window.webpackJsonp||[]).push([["financial-times-o-grid"],{a4a69ef7:function(t,e,n){"use strict";function r(t){return function(t){if(Array.isArray(t))return o(t)}(t)||function(t){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(t))return Array.from(t)}(t)||function(t,e){if(!t)return;if("string"==typeof t)return o(t,e);var n=Object.prototype.toString.call(t).slice(8,-1);"Object"===n&&t.constructor&&(n=t.constructor.name);if("Map"===n||"Set"===n)return Array.from(t);if("Arguments"===n||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return o(t,e)}(t)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function o(t,e){(null==e||e>t.length)&&(e=t.length);for(var n=0,r=new Array(e);n<e;n++)r[n]=t[n];return r}Object.defineProperty(e,"__esModule",{value:!0}),e.getCurrentLayout=d,e.getCurrentGutter=s,e.getGridBreakpoints=c,e.enableLayoutChangeEvents=l,e.default=void 0;var a="Could not find layout information. You may need to include o-grid css. See the README (https://registry.origami.ft.com/components/o-grid/readme) for more information.";function i(){var t=u("after");return 0===Object.keys(t).length&&console.warn(a),t}function c(){var t=u("before");return 0===Object.keys(t).length&&console.warn(a),t}function u(t){try{var e=window.getComputedStyle(document.documentElement,":"+t).getPropertyValue("content");return e=e.replace(/'/g,"").replace(/\\/g,"").replace(/^"/,"").replace(/"$/,""),JSON.parse(e)}catch(t){return{}}}function d(){return i().layout}function s(){return i().gutter}function l(){var t=c();if(t.hasOwnProperty("layouts")){var e=t.layouts,n=new Map([].concat(r(Object.keys(e).map((function(t){return[t,e[t]]}))),[["default","240px"]])),o=function(t){return"".concat(Number(t.replace("px","")-1),"px")},a=function(t,e){var n=function(t){t.matches&&window.dispatchEvent(new CustomEvent("o-grid.layoutChange",{detail:{layout:e}}))},r=window.matchMedia(t);r.addListener(n),n(r)};n.forEach((function(t,e){switch(e){case"S":a("(min-width: ".concat(t,") and (max-width: ").concat(o(n.get("M")),")"),e);break;case"M":a("(min-width: ".concat(t,") and (max-width: ").concat(o(n.get("L")),")"),e);break;case"L":a("(min-width: ".concat(t,") and (max-width: ").concat(o(n.get("XL")),")"),e);break;case"XL":a("(min-width: ".concat(t,")"),e);break;case"default":default:a("(max-width: ".concat(o(n.get("S")),")"),e)}}))}else console.error("Could not enable grid layout change events. Include o-grid css. See the README (https://registry.origami.ft.com/components/o-grid/readme) for more details.")}var f={getCurrentLayout:d,getCurrentGutter:s,getGridBreakpoints:c,enableLayoutChangeEvents:l};e.default=f}}]);
//# sourceMappingURL=financial-times-o-grid.e04e56034e9e.bundle.js.map