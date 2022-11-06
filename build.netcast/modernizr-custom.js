/*! modernizr 3.6.0 (Custom Build) | MIT *
 * https://modernizr.com/download/?-backgroundcliptext-borderradius-canvas-canvastext-cssfilters-cssgradients-cssscrollbar-csstransforms-csstransforms3d-csstransformslevel2-csstransitions-ellipsis-fullscreen-gamepads-passiveeventlisteners-requestanimationframe-textshadow-webworkers-domprefixes-prefixed-prefixedcss-prefixedcssvalue-setclasses-testallprops-testprop !*/
!function(e,t,n){function r(e,t){return typeof e===t}function s(){var e,t,n,s,i,o,a;for(var l in C)if(C.hasOwnProperty(l)){if(e=[],t=C[l],t.name&&(e.push(t.name.toLowerCase()),t.options&&t.options.aliases&&t.options.aliases.length))for(n=0;n<t.options.aliases.length;n++)e.push(t.options.aliases[n].toLowerCase());for(s=r(t.fn,"function")?t.fn():t.fn,i=0;i<e.length;i++)o=e[i],a=o.split("."),1===a.length?Modernizr[a[0]]=s:(!Modernizr[a[0]]||Modernizr[a[0]]instanceof Boolean||(Modernizr[a[0]]=new Boolean(Modernizr[a[0]])),Modernizr[a[0]][a[1]]=s),y.push((s?"":"no-")+a.join("-"))}}function i(e){var t=w.className,n=Modernizr._config.classPrefix||"";if(b&&(t=t.baseVal),Modernizr._config.enableJSClass){var r=new RegExp("(^|\\s)"+n+"no-js(\\s|$)");t=t.replace(r,"$1"+n+"js$2")}Modernizr._config.enableClasses&&(t+=" "+n+e.join(" "+n),b?w.className.baseVal=t:w.className=t)}function o(e){return e.replace(/([A-Z])/g,function(e,t){return"-"+t.toLowerCase()}).replace(/^ms-/,"-ms-")}function a(e){return e.replace(/([a-z])-([a-z])/g,function(e,t,n){return t+n.toUpperCase()}).replace(/^-/,"")}function l(){return"function"!=typeof t.createElement?t.createElement(arguments[0]):b?t.createElementNS.call(t,"http://www.w3.org/2000/svg",arguments[0]):t.createElement.apply(t,arguments)}function u(e,t){return!!~(""+e).indexOf(t)}function f(e,t){return function(){return e.apply(t,arguments)}}function d(e,t,n){var s;for(var i in e)if(e[i]in t)return n===!1?e[i]:(s=t[e[i]],r(s,"function")?f(s,n||t):s);return!1}function c(t,n,r){var s;if("getComputedStyle"in e){s=getComputedStyle.call(e,t,n);var i=e.console;if(null!==s)r&&(s=s.getPropertyValue(r));else if(i){var o=i.error?"error":"log";i[o].call(i,"getComputedStyle returning null, its possible modernizr test results are inaccurate")}}else s=!n&&t.currentStyle&&t.currentStyle[r];return s}function p(){var e=t.body;return e||(e=l(b?"svg":"body"),e.fake=!0),e}function v(e,n,r,s){var i,o,a,u,f="modernizr",d=l("div"),c=p();if(parseInt(r,10))for(;r--;)a=l("div"),a.id=s?s[r]:f+(r+1),d.appendChild(a);return i=l("style"),i.type="text/css",i.id="s"+f,(c.fake?c:d).appendChild(i),c.appendChild(d),i.styleSheet?i.styleSheet.cssText=e:i.appendChild(t.createTextNode(e)),d.id=f,c.fake&&(c.style.background="",c.style.overflow="hidden",u=w.style.overflow,w.style.overflow="hidden",w.appendChild(c)),o=n(d,e),c.fake?(c.parentNode.removeChild(c),w.style.overflow=u,w.offsetHeight):d.parentNode.removeChild(d),!!o}function m(t,r){var s=t.length;if("CSS"in e&&"supports"in e.CSS){for(;s--;)if(e.CSS.supports(o(t[s]),r))return!0;return!1}if("CSSSupportsRule"in e){for(var i=[];s--;)i.push("("+o(t[s])+":"+r+")");return i=i.join(" or "),v("@supports ("+i+") { #modernizr { position: absolute; } }",function(e){return"absolute"==c(e,null,"position")})}return n}function g(e,t,s,i){function o(){d&&(delete N.style,delete N.modElem)}if(i=r(i,"undefined")?!1:i,!r(s,"undefined")){var f=m(e,s);if(!r(f,"undefined"))return f}for(var d,c,p,v,g,h=["modernizr","tspan","samp"];!N.style&&h.length;)d=!0,N.modElem=l(h.shift()),N.style=N.modElem.style;for(p=e.length,c=0;p>c;c++)if(v=e[c],g=N.style[v],u(v,"-")&&(v=a(v)),N.style[v]!==n){if(i||r(s,"undefined"))return o(),"pfx"==t?v:!0;try{N.style[v]=s}catch(x){}if(N.style[v]!=g)return o(),"pfx"==t?v:!0}return o(),!1}function h(e,t,n,s,i){var o=e.charAt(0).toUpperCase()+e.slice(1),a=(e+" "+j.join(o+" ")+o).split(" ");return r(t,"string")||r(t,"undefined")?g(a,t,s,i):(a=(e+" "+_.join(o+" ")+o).split(" "),d(a,t,n))}function x(e,t,r){return h(e,n,n,t,r)}var y=[],C=[],S={_version:"3.6.0",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(e,t){var n=this;setTimeout(function(){t(n[e])},0)},addTest:function(e,t,n){C.push({name:e,fn:t,options:n})},addAsyncTest:function(e){C.push({name:null,fn:e})}},Modernizr=function(){};Modernizr.prototype=S,Modernizr=new Modernizr,Modernizr.addTest("passiveeventlisteners",function(){var t=!1;try{var n=Object.defineProperty({},"passive",{get:function(){t=!0}});e.addEventListener("test",null,n)}catch(r){}return t}),Modernizr.addTest("webworkers","Worker"in e);var w=t.documentElement,b="svg"===w.nodeName.toLowerCase(),T="Moz O ms Webkit",_=S._config.usePrefixes?T.toLowerCase().split(" "):[];S._domPrefixes=_;var P=function(e,t){var n=!1,r=l("div"),s=r.style;if(e in s){var i=_.length;for(s[e]=t,n=s[e];i--&&!n;)s[e]="-"+_[i]+"-"+t,n=s[e]}return""===n&&(n=!1),n};S.prefixedCSSValue=P,Modernizr.addTest("canvas",function(){var e=l("canvas");return!(!e.getContext||!e.getContext("2d"))}),Modernizr.addTest("canvastext",function(){return Modernizr.canvas===!1?!1:"function"==typeof l("canvas").getContext("2d").fillText});var k=S._config.usePrefixes?" -webkit- -moz- -o- -ms- ".split(" "):["",""];S._prefixes=k,Modernizr.addTest("cssgradients",function(){for(var e,t="background-image:",n="gradient(linear,left top,right bottom,from(#9f9),to(white));",r="",s=0,i=k.length-1;i>s;s++)e=0===s?"to ":"",r+=t+k[s]+"linear-gradient("+e+"left top, #9f9, white);";Modernizr._config.usePrefixes&&(r+=t+"-webkit-"+n);var o=l("a"),a=o.style;return a.cssText=r,(""+a.backgroundImage).indexOf("gradient")>-1});var z="CSS"in e&&"supports"in e.CSS,E="supportsCSS"in e;Modernizr.addTest("supports",z||E);var j=S._config.usePrefixes?T.split(" "):[];S._cssomPrefixes=j;var O=function(t){var r,s=k.length,i=e.CSSRule;if("undefined"==typeof i)return n;if(!t)return!1;if(t=t.replace(/^@/,""),r=t.replace(/-/g,"_").toUpperCase()+"_RULE",r in i)return"@"+t;for(var o=0;s>o;o++){var a=k[o],l=a.toUpperCase()+"_"+r;if(l in i)return"@-"+a.toLowerCase()+"-"+t}return!1};S.atRule=O;var A={elem:l("modernizr")};Modernizr._q.push(function(){delete A.elem});var N={style:A.elem.style};Modernizr._q.unshift(function(){delete N.style});var L=S.testStyles=v;L("#modernizr{overflow: scroll; width: 40px; height: 40px; }#"+k.join("scrollbar{width:10px} #modernizr::").split("#").slice(1).join("#")+"scrollbar{width:10px}",function(e){Modernizr.addTest("cssscrollbar","scrollWidth"in e&&30==e.scrollWidth)});var q=S.testProp=function(e,t,r){return g([e],n,t,r)};Modernizr.addTest("textshadow",q("textShadow","1px 1px")),S.testAllProps=h;var R=S.prefixed=function(e,t,n){return 0===e.indexOf("@")?O(e):(-1!=e.indexOf("-")&&(e=a(e)),t?h(e,t,n):h(e,"pfx"))};S.prefixedCSS=function(e){var t=R(e);return t&&o(t)};Modernizr.addTest("fullscreen",!(!R("exitFullscreen",t,!1)&&!R("cancelFullScreen",t,!1))),Modernizr.addTest("gamepads",!!R("getGamepads",navigator)),Modernizr.addTest("requestanimationframe",!!R("requestAnimationFrame",e),{aliases:["raf"]}),S.testAllProps=x,Modernizr.addTest("borderradius",x("borderRadius","0px",!0)),Modernizr.addTest("backgroundcliptext",function(){return x("backgroundClip","text")}),Modernizr.addTest("ellipsis",x("textOverflow","ellipsis")),Modernizr.addTest("cssfilters",function(){if(Modernizr.supports)return x("filter","blur(2px)");var e=l("a");return e.style.cssText=k.join("filter:blur(2px); "),!!e.style.length&&(t.documentMode===n||t.documentMode>9)}),Modernizr.addTest("csstransforms",function(){return-1===navigator.userAgent.indexOf("Android 2.")&&x("transform","scale(1)",!0)}),Modernizr.addTest("csstransforms3d",function(){return!!x("perspective","1px",!0)}),Modernizr.addTest("csstransformslevel2",function(){return x("translate","45px",!0)}),Modernizr.addTest("csstransitions",x("transition","all",!0)),s(),i(y),delete S.addTest,delete S.addAsyncTest;for(var U=0;U<Modernizr._q.length;U++)Modernizr._q[U]();e.Modernizr=Modernizr}(window,document);