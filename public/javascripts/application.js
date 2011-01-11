// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$("document").ready(function(){
  $('.know_submission').change(function() {
  console.log()
  var id = $(this).attr('id');
  var course_id = id.substring(5);
  var know = $(this).val();
  var user_id = $('#user').val();
  $.ajax({ 
    url: "save_user/" + course_id + "/" + user_id + "/" + know, 
    success: function(data){
      console.log(id + '_answered');
      $('#' + id + '_answered').hide();
    }});
  });
  console.log('awesome');
  $('#course_level_id').change(function() {
    console.log($('#course_level_id').val());
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
});
