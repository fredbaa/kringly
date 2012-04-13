// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

jQuery(document).ready(function(){
  jQuery(".menu_item").live("click", function(){
    var active  = jQuery(".active").parent().attr("content");
    var content = jQuery(this).parent().attr("content");
    content = content.replace("#","");
    active  = active.replace("#","");

    if(active != content){
      jQuery(".menu_item").removeClass("active");
      jQuery(this).addClass("active");

      var opts = {
        type  : "GET",
        url   : "/dashboard/replace_content",
        data  : "content=" + content,
        success : function(html){
          jQuery("#content_loader").hide();
          jQuery("#content_box_container").html(html);
          jQuery("#content_box_container").show();
        }
      };

      jQuery("#content_loader").show();
      jQuery("#content_box_container").hide();
      jQuery.ajax(opts);
    }

  });

  jQuery("#random_button").live("click", function(){
    jQuery(this).remove();
    jQuery("#choosing_button").show();

    var opts = {
      type  : "GET",
      url   : "/dashboard/randomize",
      success : function(html){
        jQuery("#random_info").hide();
        jQuery("#choosing_button").hide();
        jQuery("#lucky_person").html(html);
      }
    };

    jQuery.ajax(opts);
  });

  jQuery("#submit_wish").live("submit", function(){
    jQuery("#wish_field").attr("disabled", "");
  });
});
