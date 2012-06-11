# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(()->
  $bodyTextareaBox = ($ '#body_textarea_box')
  $titleTextfieldBox = ($ '#title_textfield_box')
  $titleTextfield= ($ '#title_textfield')
  $imageUploadBox = ($ '#image_upload_box')

  $bodyTextareaBox.hide()
  $imageUploadBox.hide()

  $titleTextfield.on('focus', (evt)->
    $bodyTextareaBox.show()
    $imageUploadBox.show()
  )
)
