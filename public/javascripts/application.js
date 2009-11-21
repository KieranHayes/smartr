// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function update_tag_list(tag){
  
  
}

$(document).ready(function(){
  $("div.tag-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/tags/" + tag,
            success: function(data){
              $("div.tag-list").html(data);
            }});
    
  });
  
  $(".question-edit form").submit(function(){
    $("textarea.markdown").parent().find("input.plain").val($("textarea.markdown").val());
  });
  $("textarea.markdown").change(function(){
    var plain = $("input.plain").val();
    var output = plain.replace(/&#95;/,"_");
    $("input.plain").val(output);
    
  });
  wmd_options = {
			// format sent to the server.  Use "Markdown" to return the markdown source.
			output: "Markdown",

			// line wrapping length for lists, blockquotes, etc.
			lineLength: 40,

			// toolbar buttons.  Undo and redo get appended automatically.
			buttons: "bold italic | link blockquote code image | ol ul heading hr",

			// option to automatically add WMD to the first textarea found.  See apiExample.html for usage.
			autostart: true
		};
     hljs.tabReplace = '    ';
     hljs.initHighlightingOnLoad();
});