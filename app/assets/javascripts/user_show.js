UserExerciseAttemptDetailToggler = {
  init: function() {
    $(document).on('click', ".attempts_toggle", this.toggle)
  },

  toggle: function() {
    $(this).next().toggle()
    UserExerciseAttemptDetailToggler.updateText($(this))
  },

  updateText: function(jQueryObj) {
    str = jQueryObj.text()
    new_str = str.indexOf("show") != -1 ? str.replace("show", "hide") : str.replace("hide", "show")
    jQueryObj.text(new_str)
  }
}


$(document).ready(function() {

  UserExerciseAttemptDetailToggler.init()

})
