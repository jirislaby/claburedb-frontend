function ajax_load(id, anchor, async_load, add_to_hash) {
	if (anchor.hasClass("opened"))
		throw "ajax_load called from invalid context";

	anchor.addClass("opened");

	$("span#arrow" + this_id).html('<img src="/assets/loader.gif"/>');

	/** PREVENT OPENING OTHERS **/
	$(".open_details").each(function() {
		 $(this).addClass("open_details_stopped").removeClass("open_details");
	});
	$(".show_source_code").each(function(){
		 $(this).addClass("show_source_code_stopped").removeClass("show_source_code");
	});

	this_proj = project_id;
	this_id = id;
	this_row = $("tr#et" + this_id);
	$.ajax({
		url: "/projects/" + this_proj + "/errors/" + this_id + "/get_details",
		cache: true,
		async: async_load,
		success: function(html) {
			this_row.after('<tr class="o' + this_id + '"><td colspan="6">' + html + '</td></tr>');

			if (add_to_hash)
				window.location.hash += "h" + this_id + "|";

			$("span#arrow"+this_id).html("&#9650;");

			anchor.removeClass("open_details_stopped").addClass("close_details");

			$.ajax({
				url: "/projects/" + this_proj + "/errors/" + this_id + "/get_source",
				cache: true,
				async: async_load,
				success: function(html) {
					if (html.length > 10) {
						$("tr.o" + this_id).after('<tr class="s' + this_id + '"><td colspan="6">' + html + '</td></tr>');

						line_number = $("#line"+this_id).text();

						source_code_el = $('tr.s'+this_id+' div.error_details_source');

						//scroll to =
						source_code_el.scrollTop($('tr.s'+this_id+' a[name=n'+line_number+']').position().top - source_code_el.position().top - 150);

						error_line = $("#line"+this_id).text();

						$(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").css("background-color", "#DD7700");
						$(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").css("color", "#000000");
						$(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").parent().css("background-color", "#DD7700");
					}
				},
				complete: function() {
					$("#source_loader" + this_id).remove();
					$(".open_details_stopped").each(function() {
						 $(this).removeClass("open_details_stopped").addClass("open_details");
					});
					$(".show_source_code_stopped").each(function() {
						 $(this).addClass("show_source_code").removeClass("show_source_code_stopped");
					});
				}
			});
		},

		complete: function(){
		}
    	});
}

$(document).ready(function(){

	$("#search_input").focus(function() {
		if ($(this).val() == "Search filename...")
			$(this).val('');
	});
	$("#search_input").blur(function() {
		if ($(this).val() == "")
			$(this).val('Search filename...');
	});

	$(".open_details_stopped").live('click',function(e){
		e.preventDefault();
	});
	$(".show_source_code_stopped").live('click',function(e){
		e.preventDefault();
	});

	$(".open_details").live('click', function(e) {
		/* do not open the link */
		e.preventDefault();

		anchor = $(this);
		this_id = anchor.attr("id");
		this_id = this_id.substr(1, this_id.length);
		ajax_load(this_id, anchor, true, true);
	});

	$(".close_details").live('click', function(e) {
		e.preventDefault();

		if (!$(this).hasClass("opened"))
			throw "close called from invalid context"

		this_id = $(this).attr("id");
		this_id = this_id.substr(1, this_id.length);
		$("tr.o" + this_id).each(function(i) {
			$(this).remove();
		});
		$("tr.s" + this_id).each(function(i) {
			$(this).remove();
		});
		$("span#arrow" + this_id).html("&#9660;");
		$(this).removeClass("opened").removeClass("close_details").addClass("open_details");

		if (window.location.hash.length > 2) {
			var re = new RegExp("\\bh" + this_id + "\\|");
			window.location.hash = window.location.hash.replace(re, "");
		}
	});

	$(".line-numbers a").live('click',function(e) {
		e.preventDefault();
	});

});

$(window).load(function () {

	/* reopen reports passed in url */
	hashes_string = window.location.hash;
	if (hashes_string.charAt(1) == 'h' && hashes_string.length > 2) {
		/* skip hash mark */
		hashes_string = hashes_string.substr(1, hashes_string.length - 2);
		hashes_array = hashes_string.split('|');

		for (var i = 0; i < hashes_array.length; i++) {

			hash = hashes_array[i];

			this_id = hash.substr(1, hash.length);

			anchor = $("a#e" + this_id);

			ajax_load(this_id, anchor, false, false);
		}
	}
});
