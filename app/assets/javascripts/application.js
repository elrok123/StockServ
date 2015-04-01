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

function getClients(search_term) {
	if(search_term != "")
		$.ajax({
			method: "POST",
			url: "/clients/get_clients",
			dataType: "json",
			data: { client_name: search_term }
		})
		.done(function( data ) {
			$("no-search").empty();
			$("#client-container").empty();
			$("#client-container").append("<tr><th class=\"padding-10\">First name</th><th class=\"padding-10\">Last name</th><th class=\"padding-10\">Email</th><th class=\"padding-10\"></th><th class=\"padding-10\"></th></tr>");
			for(i = 0; i < data.length; i++)
				$("#client-container").append("<tr><td class=\"padding-10\">" + data[i].first_name + "</td><td class=\"padding-10\">" + data[i].last_name + "</td><td class=\"padding-10\">" + data[i].email + "</td><td class=\"padding-10\"><a href=\"/portfolio/" + data[i].id + "\" class=\"btn btn-success btn-xs\" >Portfolio</a></td><td class=\"padding-10\"><a href=\"/clients/" + data[i].id + "\" class=\"btn btn-info btn-xs\">Additional Info</a></td></tr>");
			
		});
	else
	{
		$("no-search").empty();
		$("#client-container").empty();
		$("#client-container").append("Search for a client...");
	}
}

$(document).ready(function() {
  $('[data-toggle=offcanvas]').click(function() {
    $('.row-offcanvas').toggleClass('active');
  });
});

