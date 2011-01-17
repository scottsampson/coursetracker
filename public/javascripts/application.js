// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$("document").ready(function(){
  $('.know_submission').change(function() {
    var id = $(this).attr('id');
    var course_id = id.substring(5);
    var know = $(this).val();
    var user_id = $('#user').val();
    $.ajax({ 
      url: "save_user/" + course_id + "/" + user_id + "/" + know, 
      success: function(data){
        $('#' + id + '_answered').hide();
      }});
  });
  $('#course_level_id').change(function() {
    $.ajax({
      url: '/admin/courses/level_count/' + $('#course_level_id').val(),
      success: function(data) {
        $('#course_order_num').html(data);
      }
    });
  });
  
  $('.exercise_details').click(function() {
    var id = $(this).attr('id').substring(17);
    $('#tr_exercise_' + id).slideToggle('slow');
    return false;
  });
  
  $('.exercise_submission').change(function() {
    var id = $(this).attr('id');
    var exercise_id = id.substring(9);
    var finished = $(this).val();
    var user_id = $('#user').val();
    $.ajax({ 
      url: "save_finished/" + exercise_id + "/" + user_id + "/" + finished, 
      success: function(data){
        if(finished == 1) {
          $('#answered_' + exercise_id).show();
        } else {
          $('#answered_' + exercise_id).hide();
        }
      }
    });  
  });
});
