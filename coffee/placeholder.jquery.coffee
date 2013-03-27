###
Author: bmsantiago

Placeholder plugin for IE <= 9
###

$ = jQuery

ua = navigator.userAgent.toLowerCase();

match = /(msie) ([\w.]+)/.exec( ua ) || [];

browser =
  name: match[ 1 ] || ""
  version: match[ 2 ] || "0"

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
           
            #if have a placeholder atributte and if is text or password
            if(placeholder?) and ($(@).is('input:text') or $(@).is('input:password')) 
             
              $cur_input.attr("data-jqph-at", index)
              $cur_input.addClass("jqph-input")

              if $cur_input.css("margin") is "auto"
                $cur_input.css("margin","0")

              extraTop = 0 #for IE 9 fix top aligment
              if browser.name = 'msie' and browser.version == '9.0' then extraTop = 4
              spanCSS =
                "top": $cur_input.position().top + extraTop
                "left":$cur_input.position().left + parseInt($cur_input.css("margin-left").replace("px",""))
                "width" : $cur_input.width()
                "height": $cur_input.height()
                "padding": $cur_input.css('padding');
                "padding-left": parseInt($cur_input.css('padding-left').replace("px","")) + 2
                "font-family" : $cur_input.css('font-family')
                "font-size": $cur_input.css('font-size')
                "color": options.fontColor
                "position": "absolute"

              $span = $('<span></span>').hide();
              $span.attr("data-jqph-at", index)
              $span.addClass("jqph_span")
              $span.css spanCSS
              $span.css options.styles
              $span.html placeholder
              $span.addClass options.class
              $span.appendTo $('body')

              $span.show() if $cur_input.val() == "" #Some times the form load with data
           
              $span.on("click", (e)->
                e.stopPropagation();
                $input = $(".jqph-input:eq(#{$(@).data('jqph-at')})")
                $input.focus()

              )

              $cur_input.on('focusout', (e)->
                  e.stopPropagation()
                  if $(@).val() is ""
                    $(".jqph_span:eq(#{$(@).data('jqph-at')})").show()
              )


              $cur_input.on('keydown', (e)->
                e.stopPropagation()
                $(".jqph_span:eq(#{$(@).data('jqph-at')})").hide()
              )

              $cur_input.on('keyup', (e)->
                e.stopPropagation()
                if($(@).val() == "")
                  $(".jqph_span:eq(#{$(@).data('jqph-at')})").show()
                else
                  $(".jqph_span:eq(#{$(@).data('jqph-at')})").hide() 
              )
})
