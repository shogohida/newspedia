(window.webpackJsonp=window.webpackJsonp||[]).push([["o-date"],{"35e4b704":function(t,e,o){"use strict";o.r(e),o.d(e,"default",(function(){return r}));var a,i=o("fa4420dc"),n=o.n(i);function r(t){t?t instanceof HTMLElement||(t=document.querySelector(t)):t=document.body,"o-date"===t.getAttribute("data-o-component")?this.el=t:this.el=t.querySelector('[data-o-component~="o-date"]'),void 0!==this.el&&(document.body.addEventListener("oDate.update",this),this.update()),a||(a=setInterval((function(){document.body.dispatchEvent(new CustomEvent("oDate.update"))}),6e4))}r.prototype.handleEvent=function(t){"oDate.update"===t.type&&this.update()},r.prototype.update=function(){var t,e,o=this.el,a=o.getAttribute("datetime"),i=o.getAttribute("data-o-date-format"),r=o.querySelector(".o-date__printer")||o,d=r.firstChild&&3===r.firstChild.nodeType;(a?a=n.a.toDate(a):d&&(a=new Date),a)&&("today-or-yesterday-or-nothing"===i?t=n.a.asTodayOrYesterdayOrNothing(a):"date-only"===i?t=n.a.format(a,"date"):"time-ago-limit-4-hours"===i?t=n.a.timeAgo(a,{limit:4*n.a.inSeconds.hour}):"time-ago-abbreviated"===i?(t=n.a.timeAgo(a,{abbreviated:!0}),e=n.a.timeAgo(a)):"time-ago-abbreviated-limit-4-hours"===i?(t=n.a.timeAgo(a,{abbreviated:!0,limit:4*n.a.inSeconds.hour}),e=n.a.timeAgo(a,{limit:4*n.a.inSeconds.hour})):t="time-ago-no-seconds"===i?n.a.timeAgoNoSeconds(a):null!==i?n.a.format(a,i):n.a.ftTime(a),d?r.firstChild.nodeValue=t:r.innerHTML=t,o.setAttribute("data-o-date-js",""),t?(o.setAttribute("title",n.a.format(a,"datetime")),o.setAttribute("aria-label",e||t),o.removeAttribute("aria-hidden")):(o.removeAttribute("title"),o.removeAttribute("aria-label"),o.setAttribute("aria-hidden","")))},r.prototype.destroy=function(){document.body.removeEventListener("oDate.update",this),this.el=null},r.toDate=n.a.toDate,r.format=n.a.format,r.getSecondsBetween=n.a.getSecondsBetween,r.ftTime=n.a.ftTime,r.isNearFuture=n.a.isNearFuture,r.isFarFuture=n.a.isFarFuture,r.isToday=n.a.isToday,r.isYesterday=n.a.isYesterday,r.timeAgo=n.a.timeAgo,r.asTodayOrYesterdayOrNothing=n.a.asTodayOrYesterdayOrNothing,r.timeAgoNoSeconds=n.a.timeAgoNoSeconds,r.init=function(t){if(t||(t=document.body),t instanceof HTMLElement||(t=document.querySelector(t)),/\bo-date\b/.test(t.getAttribute("data-o-component")))return new r(t);var e=t.querySelectorAll('[data-o-component~="o-date"]');return[].map.call(e,(function(t){return new r(t)}))};"undefined"!=typeof window&&document.addEventListener("o.DOMContentLoaded",(function t(){r.init(),document.removeEventListener("o.DOMContentLoaded",t)}))}}]);
//# sourceMappingURL=o-date.6c2d8994db80.bundle.js.map