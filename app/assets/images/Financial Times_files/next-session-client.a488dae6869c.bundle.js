(window.webpackJsonp=window.webpackJsonp||[]).push([["next-session-client"],{"8b8c7872":function(t,n,r){"use strict";r.r(n),r.d(n,"uuid",(function(){return l})),r.d(n,"products",(function(){return v})),r.d(n,"validate",(function(){return p})),r.d(n,"cache",(function(){return i})),r.d(n,"cookie",(function(){return a})),r.d(n,"sessionId",(function(){return f}));var e=function(t){var n=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},r=n.credentials,e=void 0===r?"omit":r;return fetch("https://session-next.ft.com".concat(t),{credentials:e,useCorsProxy:!0}).then((function(t){return t.ok?t.json():t.text().then((function(n){throw new Error('Next session responded with "'.concat(n,'" (').concat(t.status,")"))}))})).catch((function(t){document.body.dispatchEvent(new CustomEvent("oErrors.log",{bubbles:!0,detail:{error:t,info:{component:"next-session-client"}}}))}))},o={},u=function(t,n){if("object"!=typeof t){if("string"!=typeof t||"string"!=typeof n){if("string"==typeof t&&void 0===n)return o[t]||null;if(void 0===t&&void 0===n)return o;throw new Error("Invalid arguments")}o[t]=n}else o=t};u.clear=function(){o={}};var i=u;function c(t,n){return function(t){if(Array.isArray(t))return t}(t)||function(t,n){if("undefined"==typeof Symbol||!(Symbol.iterator in Object(t)))return;var r=[],e=!0,o=!1,u=void 0;try{for(var i,c=t[Symbol.iterator]();!(e=(i=c.next()).done)&&(r.push(i.value),!n||r.length!==n);e=!0);}catch(t){o=!0,u=t}finally{try{e||null==c.return||c.return()}finally{if(o)throw u}}return r}(t,n)||function(t,n){if(!t)return;if("string"==typeof t)return s(t,n);var r=Object.prototype.toString.call(t).slice(8,-1);"Object"===r&&t.constructor&&(r=t.constructor.name);if("Map"===r||"Set"===r)return Array.from(t);if("Arguments"===r||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(r))return s(t,n)}(t,n)||function(){throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function s(t,n){(null==n||n>t.length)&&(n=t.length);for(var r=0,e=new Array(n);r<n;r++)e[r]=t[r];return e}var d={},a=function(){return(/FTSession=([^;]+)/.exec(document.cookie)||[null,""])[1]},f=function(){return c(/FTSession_s=([^;]+)/.exec(document.cookie)||[],2)[1]},l=function(){var t=i("uuid");if(t)return Promise.resolve({uuid:t});var n=f();return n?(d.uuid||(d.uuid=e("/sessions/s/".concat(n)).then((function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},n=t.uuid;return delete d.uuid,n&&i("uuid",n),{uuid:n}}))),d.uuid):Promise.resolve({uuid:void 0})},v=function(){var t=i("products"),n=i("uuid");return t&&n?Promise.resolve({products:t,uuid:n}):f()?(d.products||(d.products=e("/products",{credentials:"include"}).then((function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},n=t.products,r=t.uuid;return d.products=void 0,n&&i("products",n),r&&i("uuid",r),{products:n,uuid:r}}))),d.products):Promise.resolve({})},p=function(){return l().then((function(t){return!!t.uuid}))};n.default={uuid:l,products:v,validate:p,cache:i,cookie:a,sessionId:f}}}]);
//# sourceMappingURL=next-session-client.a488dae6869c.bundle.js.map