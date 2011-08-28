$(document).ready(function(){
  $("a.close").click(function(event){
    $(this).parent("div").hide('blind');
  });
});