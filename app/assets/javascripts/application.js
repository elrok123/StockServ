// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


document.title = ("Wealth Management System - " + ($(".header h3").text()));
String.prototype.lines = function() { return this.split(/\n*\./); }
String.prototype.lineCount = function() { return (this.lines().length); }
if($(".header h3").text() == "Meeting Details")
	$("#textarea1").attr("rows", $("#textarea1").val().lineCount());

$("a[href^='#']").attr("href", "/login");

window.onscroll = function(){

	$("body").height($(window).height());
}
var $oldPix = 0;
document.addEventListener('mousemove', function (event) {
    if (window.event) { // IE fix
        event = window.event;
    }
    // Grab the mouse's X-position.
    var mousex = event.clientX;
    var mousey = event.clientY;
    var hcenter = $(window).height() / 2;
    var wcenter = $(window).width() / 2;
    var bgpos = $(".shadow-container").css('backgroundPosition').split(" ");
    if(mousex < wcenter && mousey < hcenter)
    {
    	$(".shadow-container").css("backgroundPosition", Math.ceil((mousex - wcenter) / 2) + "px " + Math.ceil((mousey - hcenter) / 2) + "px");
   	}
   	if(mousex < wcenter && mousey > hcenter)
    {
    	$(".shadow-container").css("backgroundPosition", Math.ceil((mousex - wcenter) / 2) + "px -" + Math.ceil((mousey - hcenter) / 2) + "px");
   	}
   	if(mousex > wcenter && mousey > hcenter)
    {
    	$(".shadow-container").css("backgroundPosition", "-" + Math.ceil((mousex - wcenter) / 2) + "px -" + Math.ceil((mousey - hcenter) / 2) + "px");
   	}
   	if(mousex > wcenter && mousey < hcenter)
    {
    	$(".shadow-container").css("backgroundPosition", "-" + Math.ceil((mousex - wcenter) / 2) + "px " + Math.ceil((mousey - hcenter) / 2) + "px");
   	}
}, false);