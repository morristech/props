@Props.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormLayout extends App.Views.Layout
    template: "form/form"

    tagName: "form"
    attributes: ->
      "data-type": @getFormDataType()

    regions:
      formContentRegion: "#form-content-region"

    ui:
      buttonContainer: "ul.inline-list"

    triggers:
      "submit"                            : "form:submit"
      "click [data-form-button='cancel']"  : "form:cancel"

    modelEvents:
      "change:_errors"   : "changeErrors"
      "sync:start"      :  "syncStart"
      "sync:stop"        :  "syncStop"

    initialize: ->
      { @config, @buttons } = @options

    serializeData: ->
      footer: @config.footer
      buttons: @buttons?.toJSON() ? false

    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    focusFirstInput: ->
      @$(":text:visible:enabled:first").focus()

    getFormDataType: ->
      if @model.isNew() then "new" else "edit"

    changeErrors: (model, errors, options) ->
      if @config.errors
        if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    removeErrors: ->
      @$('.form-group').removeClass('has-error')
      @$('.help-block.error').remove()

    addErrors: (errors = {}) ->
      for name, array of errors
        @addError name, array[0]

    addError: (name, error) ->
      $el = @$("[name='#{name}']:first")
      $parent = $el.parents('.form-group')
      $parent.addClass('has-error')
      $sm = $('<span>').addClass('help-block error').text(error)
      lastSibling = $parent.children(':last')
      lastSibling.after $sm

    disableButtons: (state) ->
      buttonElements = this.el.getElementsByClassName('form-button')
      _(buttonElements).each (button) ->
        button.disabled = state

    syncStart: (model) ->
      @disableButtons(true)
      @addOpacityWrapper() if @config.syncing

    syncStop: (model) ->
      @disableButtons(false)
      @addOpacityWrapper(false) if @config.syncing

    onDestroy: ->
      @disableButtons(false)
      @addOpacityWrapper(false) if @config.syncing
