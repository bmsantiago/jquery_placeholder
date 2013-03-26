###
Author: bmsantiago
###

$ = jQuery

$.fn.extend({
    placeholder: (options) ->

        _defaults = 
          "fontColor": "#999"
          "class": ""
          "styles":""

        options = $.extend(_defaults, options)

        if (!('placeholder' of document.createElement 'input'))
          $(@).each (index) ->

            $cur_input = $(@)

            placeholder = $cur_input.attr('placeholder')
            
            if(placeholder?) #If have a placeholder atributte
              if $cur_input.css("margin") is "auto"
                $cur_input.css("margin","0")

              spanCSS = 
                "font-size": $cur_input.css('font-size')
                "bottom": $cur_input.height() + (parseInt($cur_input.css('padding-bottom').replace("px","")) * 2) + 2 #Bordes
                "margin": $cur_input.css('margin')
                "margin-bottom": (($cur_input.height() * 2) + 7) * -1
                "font-family" : $cur_input.css('font-family')
                "padding": $cur_input.css('padding');
                "padding-left": parseInt($cur_input.css('padding-left').replace("px","")) + 2
                "width" : $cur_input.width()
                "height": $cur_input.height()
                "color": options.fontColor
                "position": "relative"

              $span = $('<span></span>').hide() 
              $span.css spanCSS
              $span.css options.styles
              $span.html placeholder
              $span.addClass options.class
              $span.insertAfter $cur_input

              $span.css('display','block') if $cur_input.val() == ""



              $span.on("click", ()->
                $(@).hide()
                $input = $(@).prev()
                $input.focus()

              )

              $cur_input.on("focus", ()->
                $(@).next().hide();
              )

              $cur_input.on('focusout', ()->
                  if $(@).val() is ""
                    $(@).next().show()
              )

})
