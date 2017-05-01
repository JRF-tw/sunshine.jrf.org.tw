import "magnific-popup"

export default class Modal
  constructor: (@query) ->
    MFC = $.magnificPopup.instance

    $(@query).magnificPopup
      showCloseBtn: off
      removalDelay: 300
      mainClass: 'modal-fade'

      retina:
        ratio: 2
        replaceSrc: -> MFC.st.mainEl[MFC.index].dataset.retina

      gallery:
        enabled: on
        navigateByImgClick: on
        preload: [0, 2]
        # markup of an Custom arrow button
        # arrowMarkup: """
        #   <button title='%title%' type='button' class='modal-arrow--%dir% mfp-arrow mfp-arrow-%dir%'>
        #     <svg class='modal-arrow__icon'><use xlink:href=#{arrow}></svg>
        #   </button>
        # """
