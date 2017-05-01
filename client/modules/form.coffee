export class TextInput
  constructor: () ->
    $(document).on 'focus', 'input.form-control, .text.form-control', (e) =>
      @focus e.currentTarget
    .on 'blur', 'input.form-control, .text.form-control', (e) =>
      if $(e.currentTarget).val().length > 0
        @focus e.currentTarget
      else
        @blur e.currentTarget

  focus: (el) ->
    $(el).parent().addClass 'is-focused'

  blur: (el) ->
    $(el).parent().removeClass 'is-focused'
  
