@Props.module 'PropsApp.List', (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: 'props/list/templates/layout'
    regions:
      'props_region' : '.props-region'
      'header_region' : '.header-region'
    className: 'col-xs-12'

  class List.Form extends App.Views.ItemView
    template: 'props/list/templates/form'

    form:
      buttons:
        primary: 'Prop!'
        cancel: false

    ui:
      input: 'input'
      praisedPersonAvatar: '.praised-person-avatar'
      selectedUsers: '.selected-users'
      usersSelect: '.users-select'

    initialize: (options) ->
      @users ||= options.users

    onShow: ->
      @renderSelectItems @users
      @ui.input.on 'change', @onSelectChange

    onSelectChange: (ids) ->
      avatars = if !ids then [] else ids.split(',').reverse().map (id) =>
        @users.get(id).get('avatar_url')

      RWR.renderComponent('SelectedUsersComponent',
        avatars: avatars
      , @ui.selectedUsers[0])


    renderSelectItems: ->
      usersData = @users.map (user) ->
        { value: user.get('id'), label: user.get('name'), avatarUrl: user.get('avatar_url')}

      RWR.renderComponent('Select',
        options: usersData
        multi: true
        optionComponent: RWR.getComponent('UserOptionComponent');
        name: 'user_ids'
        placeholder: 'Whom do you want to give a prop to?'
        onChange: @onSelectChange.bind(this)
      , @ui.usersSelect[0])

    onDestroy: ->
      RWR.unmountComponent @ui.selectedUsers[0]
      RWR.unmountComponent @ui.usersSelect[0]

  class List.Header extends App.Views.Layout
    template: 'props/list/templates/header'
    className: 'jumbotron clearfix'
    regions:
      'form_region' : '.form-region'
