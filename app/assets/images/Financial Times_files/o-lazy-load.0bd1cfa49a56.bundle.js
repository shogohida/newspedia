(window.webpackJsonp=window.webpackJsonp||[]).push([["o-lazy-load"],{b3de092d:function(t,e,o){"use strict";function n(t,e){for(var o=0;o<e.length;o++){var n=e[o];n.enumerable=n.enumerable||!1,n.configurable=!0,"value"in n&&(n.writable=!0),Object.defineProperty(t,n.key,n)}}o.r(e);var r={selector:".o-lazy-load"},a="data-o-lazy-load";function s(t){"picture"===t.nodeName.toLowerCase()&&Array.from(t.children).forEach(s),t.hasAttribute("data-src")&&(t.src=t.getAttribute("data-src"),t.removeAttribute("data-src")),t.hasAttribute("data-srcset")&&(t.srcset=t.getAttribute("data-srcset"),t.removeAttribute("data-srcset")),t.hasAttribute("data-toggle-class")&&(t.classList.toggle(t.getAttribute("data-toggle-class")),t.removeAttribute("data-toggle-class")),t.setAttribute(a,!0)}function i(t){return t.hasAttribute(a)}function c(t,e){var o=this,n=e.thresholds[0];t.forEach((function(t){if(t.isIntersecting&&t.intersectionRatio>=n){var r=t.target;e.unobserve(r),i(r)||(s(r),"function"==typeof o.options.callback&&o.options.callback(r))}}))}var u=function(){function t(e,o){!function(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}(this,t),this.rootEl=e,this.options=Object.assign({},r,o,t.getDataAttributes(e)),e===document.documentElement||e===document.body?this.options.root=null:this.options.root=e,this.observer=new IntersectionObserver(c.bind(this),this.options),this.observe()}var e,o,a;return e=t,a=[{key:"getDataAttributes",value:function(t){return t instanceof HTMLElement?Object.keys(t.dataset).reduce((function(e,o){if("oComponent"===o)return e;var n=o.replace(/^oLazyLoad(\w)(\w+)$/,(function(t,e,o){return e.toLowerCase()+o})),r=t.dataset[o];try{e[n]=JSON.parse(r.replace(/\'/g,'"'))}catch(t){e[n]=r}return e}),{}):{}}},{key:"init",value:function(e,o){return e||(e=document.body),e instanceof HTMLElement||(e=document.querySelector(e)),e instanceof HTMLElement&&e.matches('[data-o-component="o-lazy-load"]')?new t(e,o):Array.from(e.querySelectorAll('[data-o-component="o-lazy-load"]'),(function(e){return new t(e,o)}))}}],(o=[{key:"observe",value:function(){var t=this;this.rootEl.querySelectorAll(this.options.selector).forEach((function(e){i(e)||t.observer.observe(e)}))}}])&&n(e.prototype,o),a&&n(e,a),t}();document.addEventListener("o.DOMContentLoaded",(function t(){u.init(),document.removeEventListener("o.DOMContentLoaded",t)}));e.default=u}}]);
//# sourceMappingURL=o-lazy-load.0bd1cfa49a56.bundle.js.map