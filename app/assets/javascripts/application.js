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


var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substrRegex;
 
    // an array that will be populated with substring matches
    matches = [];
 
    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');
 
    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
      if (substrRegex.test(str)) {
        // the typeahead jQuery plugin expects suggestions to a
        // JavaScript object, refer to typeahead docs for more info
        matches.push({ value: str });
      }
    });
 
    cb(matches);
  };
};
 
var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
  'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
  'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
  'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
  'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
  'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
  'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
  'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
  'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
];
 
$('#the-basics .typeahead').typeahead({
  hint: true,
  highlight: true,
  minLength: 1
},
{
  name: 'states',
  displayKey: 'value',
  source: substringMatcher(states)
});

