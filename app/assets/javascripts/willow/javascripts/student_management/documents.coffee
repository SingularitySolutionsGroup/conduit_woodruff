StudentDocumentsController = ($q, $scope, $http, $modal, selected_application_id_retriever, user_id, external_id, external_type, user_permissions, filepicker) ->
  $scope.loading = true
  $scope.impersonate_user_id = user_id
  $scope.fileUploads = []
  $scope.fileDownloads = []
  $scope.missing_signatures = []
  $scope.can_rename = false
  $scope.should_display_file_transfer_ui = user_permissions.see_files == true

  $scope.can_delete_files = user_permissions.delete_file == true

  $scope.loading = false if selected_application_id_retriever.get_user_application_id() == 0

  $scope.fileUploadRenamed = (text, model)->
    $http.post('/my_documents/rename_upload',
      id: model.id,
      name: text,
    ).success (data) ->
      $scope.loading = true
      $scope.loadData()

  $scope.fileDownloadRenamed = (text, model)->
    $http.post('/my_documents/rename_download',
      id: model.id,
      name: text,
    ).success (data) ->
      $scope.load_file_downloads()

  $scope.load_file_downloads = () ->
    deferred = $q.defer()
    $http.post('/my_documents/get_downloads',
        user_id: user_id,
        user_application_id: selected_application_id_retriever.get_user_application_id()).
    success((data) ->
      $scope.fileDownloads = data.files
      $scope.tags = data.tags
      $scope.can_rename = data.can_rename
      $scope.loading = false

      # set the name of the associated step for each file download
      for file in $scope.fileDownloads
        file.associated_step_name = ''
        continue unless file.step_association_data
        for step in $scope.available_download_steps
          if (step.id+'') == (file.step_association_data.step_id+'')
            file.associated_step_name = step.name
      deferred.resolve()
    ).error(() ->
      deferred.reject()
    )
    deferred.promise

  $scope.loadData = ->
    $scope.application = null
    $scope.loading = true
    $http.post('/students/get_application_with_state',
      user_id: user_id,
      user_application_id: selected_application_id_retriever.get_user_application_id()
    ).success (data) ->
      $scope.application = data.application
      $scope.available_download_steps = $scope.get_available_download_steps($scope.application)
      $http.post('/my_documents/get_uploads',
        user_id: user_id,
        user_application_id: selected_application_id_retriever.get_user_application_id()).success((data) ->
          $scope.fileUploads = data.files
          $scope.can_rename = data.can_rename
          $scope.loading = false
        )
      $scope.load_file_downloads()
      $http.post('/my_documents/get_missing_signatures',
        user_application_id: selected_application_id_retriever.get_user_application_id()).success((data) ->
          $scope.missing_signatures = data.missing_signatures
          $scope.loading = false
        )
    .error () ->
      alert('There was a problem with your request.  Please try again.');

  if selected_application_id_retriever.get_user_application_id() != 0 && selected_application_id_retriever.get_user_application_id() != null && selected_application_id_retriever.get_user_application_id() != undefined
    $scope.loading = true
    $scope.loadData()

  $scope.removeDownload = (document) ->
    if confirm("Are you sure you want to remove this file (#{document.name})? This action cannot be undone.") == true
      $http.post('/my_documents/remove_download',
        id: document.id,
      ).success (data) ->
        $scope.loading = true
        $scope.loadData()
        $scope.close_modal()

  $scope.removeUpload = (document) ->
    if confirm("Are you sure you want to remove this file (#{document.name})? This action cannot be undone.") == true
      $http.post('/my_documents/remove_upload',
        id: document.id,
      ).success (data) ->
        setTimeout(->
          $scope.loading = true
          $scope.loadData()
        , 1000)

  $scope.get_steps_with_ready_documents_from_step_group = (step_group) ->
    steps = []
    for step in step_group.steps
      steps.push step if step.status=='Complete' && step.pdf_filename !='' && step.pdf_filename != null && step.pdf_filename != undefined
    steps

  $scope.uploadTheFile = ->
    filepicker.pickAndStore({mimetypes: ['image/*,application/pdf,text/*,application/msword,video/mp4,video/x-m4v,video/*'], multiple: false},{}, (filepicker_data) ->
      $http.post("/students/create_download/#{user_id}", {
                                                           file_download: {
                                                                            user_application_id: selected_application_id_retriever.get_user_application_id(),
                                                                            filepicker_data: JSON.stringify(filepicker_data),
                                                                            upload_target: $scope.file_download_tag
                                                                          },
                                                         }).
      success((data) ->
        $scope.load_file_downloads().then(() ->
          for download in $scope.fileDownloads
            if download.id == data.file_download.id
              $scope.open_document_management_modal download
              return
        )
      )
    )

  $scope.send_notifications = (missing_secondary_signature_id) ->
    return unless confirm 'Are you sure you want to send notifications to all signers for this form?'
    $http.post('/secondary_form/send_notifications', { missing_secondary_signature_id: missing_secondary_signature_id }).success(() ->
      alert('The notifications have been sent.')
    ).error(() ->
      alert('There was a problem with your request.  Please try again later.')
    )

  $scope.add_recipient_to = (missing_signature) ->
    recipient_email = prompt "Enter the email address to add as a signer to #{missing_signature.primary_form_name} - #{missing_signature.secondary_form_name}"
    return unless recipient_email
    $http.post('/secondary_form/add_recipient', {
                                                  recipient_email: recipient_email,
                                                  missing_secondary_signature_id: missing_signature.missing_secondary_signature_id
                                                }).
    success((response) ->
      if response.status == 'success'
        missing_signature.recipients.push({ email: recipient_email })
        alert "A notification has been sent to #{recipient_email}"
      else
        alert "There was a problem with your request: #{response.message}"
    ).error(() ->
      alert 'There was a problem with your request.  Please try again.'
    )

  $scope.remove_recipient = (missing_signature, recipient_to_remove) ->
    return unless confirm "Are you sure you want to remove #{recipient_to_remove.email}?"
    $http.post('/secondary_form/remove_recipient', {
                                                      missing_secondary_signature_id: missing_signature.missing_secondary_signature_id,
                                                      recipient_email: recipient_to_remove.email
                                                   }).success((response) ->
      if response.status == 'success'
        new_recipients = []
        for recipient in missing_signature.recipients
          new_recipients.push recipient unless recipient.email == recipient_to_remove.email
        missing_signature.recipients = new_recipients
      else
        alert "There was a problem with your request: #{response.message}"
    ).error(() ->
      alert 'There was a problem with your request.  Please try again later.'
    )

  $scope.send_notification = (missing_signature, recipient) ->
    return unless confirm "Resend notification to #{recipient.email}?"
    $http.post('/secondary_form/notify_recipient', { recipient_email: recipient.email, missing_secondary_signature_id: missing_signature.missing_secondary_signature_id }).success((response) ->
      if response.status == 'success'
        alert 'The notification has been sent.'
      else
        alert response.message
    ).error(() ->
      alert 'There was a problem with your request.  Please try again later.'
    )

  $scope.set_selected_download_step = (file) ->
    $scope.selected_download_step = null
    for step in $scope.available_download_steps
      continue unless file.step_association_data
      if (step.id+'') == (file.step_association_data.step_id+'')
        $scope.selected_download_step = step
        return

  $scope.update_download_step = (file_being_edited, selected_download_step) ->
    $http.post('/my_documents/set_download_step_association', {
                                                            selected_download_step:    selected_download_step,
                                                            file_download:             file_being_edited
                                                          }).success(() ->
      $scope.load_file_downloads()
    ).
    error(() ->
      alert 'There was a problem with your request.  Please try again later.'
    )

  $scope.get_available_download_steps = (application) ->
    steps = []
    for group in application.step_groups
      for step in group.steps
        if step.type == 'Download'
          steps.push step
    steps

  $scope.close_modal = () ->
    $scope.modal_instance.dismiss 'cancel'

  $scope.open_document_management_modal = (fileDownload) ->
    $scope.file_being_edited = fileDownload
    $scope.set_selected_download_step(fileDownload)
    $scope.modal_instance = $modal.open
                      windowClass: 'modalFormContainer',
                      keyboard: false,
                      templateUrl: "/assets/willow/partials/admissions-student-document-modal.html",
                      scope: $scope,
                      size: 'lg',
                      backdrop: 'static'