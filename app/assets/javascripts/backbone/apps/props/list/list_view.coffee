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

    initialize: (options) ->
      @users ||= options.users

    onShow: ->
      @renderSelectItems @users
      @ui.input.on 'change', @onSelectChange

    onSelectChange: (e) =>
      avatars = e.val.reverse().map (id) => @users.get(id).get('avatar_url');

      React.render(React.createElement(SelectedUsersComponent,
        avatars: avatars
      ), @ui.selectedUsers[0])

    renderSelectItems: (users) ->
      users_data = users.map (user) ->
        { id: user.get('id'), text: user.get('name' ), avatar_url: user.get('avatar_url')}

      @ui.input.select2
        placeholder: 'Who do you want to prop?'
        allowClear: true
        dropdownAutoWidth: true
        multiple: true
        data: users_data
        width: 'resolve'
        formatResult: @userSmallTemplate

    userSmallTemplate: (user) ->
      "<img class='user-small-face' src='" + user.avatar_url + "'/>" + user.text

  class List.Header extends App.Views.Layout
    template: 'props/list/templates/header'
    className: 'jumbotron clearfix'
    regions:
      'form_region' : '.form-region'
