jQuery ->

  # Create a comment
  $(".comment-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      # if $(this) == $(".comment-form")[0]
        # $(xhr.responseText).hide().insertAfter($(this)).show('slow')
      # else
      $('<ul class="comment-list">\n'+xhr.responseText+'\n</ul>').hide().insertAfter($(this)).show('slow')
      $(".comment-form:not(:first)").hide()

  # Toggle reply to comment form
  $(document)
    .on "ajax:success", ".reply-link", ->
      $(".comment-form:not(:first)").hide()
      $(this).closest(".reply").children(".comment-form").show()
      false

  # Delete a comment
  $(document)
    .on "ajax:beforeSend", ".close", ->
      $(this).closest(".comment").fadeTo('fast', 0.5)
    .on "ajax:success", ".close", ->
      $(this).closest(".comment").hide('fast')
    .on "ajax:error", ".close", ->
      $(this).closest(".comment").fadeTo('fast', 1)