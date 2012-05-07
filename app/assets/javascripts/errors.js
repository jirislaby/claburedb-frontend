
$(document).ready(function(){

    $("#search_input").focus(function(){
        if ($(this).val() == "Search filename...") {
            $(this).val('');
        }
    });
    
    $("#search_input").blur(function(){
        if ($(this).val() == "") {
            $(this).val('Search filename...');
        }
    });
    
	$(".open_details_stopped").live('click',function(e){
        e.preventDefault();
	});
	$(".show_source_code_stopped").live('click',function(e){
        e.preventDefault();
	});
		
    $(".open_details").live('click',function(e){
        e.preventDefault();
       	if (!$(this).hasClass("opened")) {
			$(this).addClass("opened");
			$(this).html("");
			
			anchor = $(this);
			this_id = $(this).attr("id");
			this_row = $("tr#e" + this_id);
			anchor.html('<img src="/assets/loader.gif"/>');

			/** PREVENT OPENING OTHERS **/
			$(".open_details").each(function(){
				 $(this).removeClass("open_details").addClass("open_details_stopped");
			});
			$(".show_source_code").each(function(){
				 $(this).removeClass("show_source_code").addClass("show_source_code_stopped");
			});
			
			$.ajax({
				url: "/errors/get_details/" + this_id,
				cache: true,
				success: function(html){
					this_row.after('<tr class="o' + this_id + '"><td colspan="6">' + html + '</td></tr>');
					//window.location.hash = "h"+ this_id;
					if (window.location.hash.length > 2) {
						window.location.hash = window.location.hash + "|h" + this_id;
					}else{
						window.location.hash = "h"+this_id;
					}
					anchor.html("&#9650; Close");
					anchor.removeClass("open_details").addClass("close_details");
				},
				complete: function(){
					anchor.show();
					$(".open_details_stopped").each(function(){
						 $(this).removeClass("open_details_stopped").addClass("open_details");
					});
					$(".show_source_code_stopped").each(function(){
						 $(this).addClass("show_source_code").removeClass("show_source_code_stopped");
					});
				}
			});			
		}
    });
	$(".open_details_file").live('click',function(e){
        e.preventDefault();
       	anchor = $(this).closest("tr").find("a.open_details");
		if(!anchor.hasClass("opened")){
			anchor.click();
		}
    });
	
	$(".show_source_code").live('click',function(e){
        e.preventDefault();
       	if (!$(this).hasClass("opened")) {
			$(this).addClass("opened");
			$(this).html("");
			
			anchor = $(this);
			this_id = $(this).attr("id");
			this_row = $("tr.o" + this_id);
			anchor.html('<img src="/assets/loader.gif"/>');
			
			/** PREVENT OPENING OTHERS **/
			$(".open_details").each(function(){
				 $(this).removeClass("open_details").addClass("open_details_stopped");
			});
			$(".show_source_code").each(function(){
				 $(this).removeClass("show_source_code").addClass("show_source_code_stopped");
			});
			
			$.ajax({
				url: "/errors/get_details_source/" + this_id,
				cache: true,
				success: function(html){
					this_row.after('<tr class="s' + this_id + '"><td colspan="6">' + html + '</td></tr>');
					anchor.html("&#9650; Hide source code");
					anchor.removeClass("open_details").addClass("close_details_source_code");
					line_number = $("#line"+this_id).text();
					
					source_code_el = $('tr.s'+this_id+' div.error_details_source');
					
					//scroll_to = 
					source_code_el.scrollTop($('tr.s'+this_id+' a[name=n'+line_number+']').position().top - source_code_el.position().top - 150);
					
					error_line = $("a#line"+this_id).text();
					
					$(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").css("background-color", "#DD7700");
					$(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").css("color", "#000000");
				    $(".s"+this_id+" div.CodeRay a[name=n"+error_line+"]").parent().css("background-color", "#DD7700");

				},
				complete: function(){
					anchor.show();
					$(".open_details_stopped").each(function(){
						 $(this).removeClass("open_details_stopped").addClass("open_details");
					});
					$(".show_source_code_stopped").each(function(){
						 $(this).addClass("show_source_code").removeClass("show_source_code_stopped");
					});
				}
			});				
		}
    });
    
    $(".close_details").live('click',function(e){
        e.preventDefault();
        
        if ($(this).hasClass("opened")) {
            this_id = $(this).attr("id");
            $("tr.o" + this_id).each(function(i){$(this).remove();});
			$("tr.s" + this_id).each(function(i){$(this).remove();});
            $(this).html("&#9660; Details");
            $(this).removeClass("opened").removeClass("close_details").addClass("open_details");
			
	        
			return_hash_string = "";	
			if (window.location.hash.length > 2) {
						var hashes_string = window.location.hash;
						hashes_string = hashes_string.substr(1, hashes_string.length);
						var hashes_array = hashes_string.split('|');
						var this_index=-1;
						for (var i = 0; i < hashes_array.length; i++) {
							hash = hashes_array[i];
							current_id = hash.substr(1, hash.length);
							if(current_id==this_id){
								this_index = i;
								break;
							}
						}
						if (this_index != -1) {
							hashes_array.splice(this_index, 1);
						}
						
			}
			window.location.hash = hashes_array.join("|");
		}
        
    });
	
	$(".close_details_source_code").live('click',function(e){
        e.preventDefault();
        
        if ($(this).hasClass("opened")) {
            this_id = $(this).attr("id");
            $("tr.s" + this_id).each(function(i){$(this).remove();});
            $(this).html("&#9660; Show source code");
            $(this).removeClass("opened").removeClass("close_details_source_code").addClass("show_source_code");
		}
        
    });
	
	$("#select_db").change(function(){
		$("#select_db_form").submit();
	});
	$(".line-numbers a").live('click',function(e){
		e.preventDefault();
	});
    
});

$(window).load(function () {
	
	if(window.location.hash.length > 2){
		hashes_string = window.location.hash;
		hashes_string = hashes_string.substr(1,hashes_string.length);
    hashes_array = hashes_string.split('|');
    
    for (var i = 0; i < hashes_array.length; i++){
		
  		hash = hashes_array[i];
  		
  		this_id = hash.substr(1,hash.length);
  		
         	
  		
  		anchor = $("a#"+this_id);
  		anchor_offset = anchor.offset();
  		$(window).scrollTop(anchor_offset.top-50);
  		if(!anchor.hasClass("opened")){
	  		anchor.addClass("opened");
	  		anchor.html('<img src="/assets/loader.gif"/>');
	  		
	  		this_row = $("tr#e" + this_id);
	  			
	  		$.ajax({
	  			url: "/errors/get_details/" + this_id,
	  			cache: true,
	  			async: false,
	  			success: function(html){
	  				this_row.after('<tr class="o' + this_id + '"><td colspan="6">' + html + '</td></tr>');
	  				
	  			},
	  			complete: function(){
	  				anchor.html("&#9650; Close");
	  				anchor.show();
	  				anchor.removeClass("open_details").addClass("close_details");
	  			}
	  		});
		}
	}
  } 
});
