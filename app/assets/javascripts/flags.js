FlagToggler = {
  init: function() {
    $(document).on('click', '.fa-flag', function() {
      FlagToggler.toggle($(this))
    })
  },

  toggle: function(clickedObject) {
    var socrates_id = $('#student_name').data("student-id")
    var data = {user_id: socrates_id, flag: clickedObject.attr('id')}

    $.post('/users/toggle_flag', data, function(response){
      clickedObject.removeClass('red')
      clickedObject.removeClass('green')
      clickedObject.addClass(response.color)
    }, 'json')
  }
}

$(document).ready(function(){

  FlagToggler.init()

})
