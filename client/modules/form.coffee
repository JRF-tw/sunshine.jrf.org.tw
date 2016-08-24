class TextInput
  constructor: () ->
    $('input').on 'focus', (e) =>
      @focus e.currentTarget
    .on 'blur', (e) =>
      if $(e.currentTarget).val().length > 0 then return
      else @blur e.currentTarget

  focus: (el) ->
    $(el).parent().addClass 'is-focused'
  
  blur: (el) ->
    $(el).parent().removeClass 'is-focused'
  
module.exports =
  TextInput: TextInput