system  = require("system")
webpage = require("webpage")

stampPdf = (phantom, webpage, options) ->

  # set up the web call to the main document
  mainPage = webpage.create()

  mainPage.viewportSize =
    width: 600
    height: 600

  mainPage.paperSize =
    format: 'A4'
    orientation: 'portrait'
    margin: '0.5cm'
    footer:
      height: '0.3cm'
      contents: 'test'

  # get the document
  mainPage.open options.documentAddress, (status) ->
    if status isnt "success"
      console.log "Unable to load the address!"
      console.log status
      phantom.exit()
    else

      # give the page 5 seconds to load, then
      # alter it for printing
      window.setTimeout (->
        mainPage.evaluate ->

          # these operations will alter the document
          # to make it look like a printed document.
          # many of these alterations are specific
          # to the way that phantomjs produces the PDF,
          # which may change.
          jQuery(".form-submit-button").css "background", "#fbfbfb"
          jQuery("select").each (index, item) ->
            oldValue = ''
            value = jQuery(item).find("option").filter((index) ->
              jQuery(jQuery(item).find("option")[index]).val() == jQuery(item).val()
            )[0]
            oldValue = jQuery(value).text() if value
            newItem = jQuery("<input type=\"text\" class=\"form-control ng-pristine ng-valid\">").val(oldValue)
            jQuery(item).replaceWith newItem

          jQuery("input").css "border", "1px solid gray"
          jQuery("input").css "border", "1px solid gray"
          jQuery("input,label,span").each (index, item) ->
            fontSize = parseInt(jQuery(item).css("font-size"))
            fontSize = (fontSize - 1) + "px"
            jQuery(item).css "font-size", fontSize
      ), 5000

      # give our code 10 seconds to do what
      # it must, then render the PDF
      window.setTimeout (->
        mainPage.render options.filename
        phantom.exit()
      ), 10000

options =
  documentAddress: system.args[1]
  filename:        system.args[2]

stampPdf phantom, webpage, options
