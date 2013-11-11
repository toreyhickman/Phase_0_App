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

UserExerciseAttemptsToggler = {
  init: function() {
    $(document).on('click', '.exercise_sub_selector', this.toggle)
  },

  toggle: function() {
    str = $(this).text()

    if (str === "All") {
      $(".exercise_attempt_wrapper").show()
    }
    else if (str.indexOf("Complete (") != -1) {
      $(".exercise_attempt_wrapper.complete").show()
      $(".exercise_attempt_wrapper.incomplete").hide()
    }
    else {
      $(".exercise_attempt_wrapper.incomplete").show()
      $(".exercise_attempt_wrapper.complete").hide()
    }
  }
}

UserWeeklyChallengesToggler = {
  init: function() {
    $(document).on('click', '.challenges_toggle', function() {
      UserWeeklyChallengesToggler.toggle($(this))
    })
  },

  toggle: function(clickedObject) {
    str = clickedObject.text()
    new_str = str.indexOf("show") != -1 ? str.replace("show", "hide") : str.replace("hide", "show")
    clickedObject.text(new_str)

    clickedObject.parent().siblings('div').toggle()
  }
}

UserTabbedInterfaceController = {
  init: function() {
    $(document).on("click", ".user_data_tab span:last-child", function() {
      UserTabbedInterfaceController.toggle($(this))
    })
  },

  toggle: function(clickedObject) {
    $('.active_tab').removeClass("active_tab")
    clickedObject.closest('div').addClass("active_tab")
    $('.attempts_wrapper').toggle()
  }
}


$(document).ready(function() {

  UserExerciseAttemptDetailToggler.init()

  UserExerciseAttemptsToggler.init()

  UserTabbedInterfaceController.init()

  UserWeeklyChallengesToggler.init()

})
