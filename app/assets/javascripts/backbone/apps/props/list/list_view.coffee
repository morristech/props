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
      selectedUsers = @users.filter (user) ->
        _.include e.val, String(user.get('id'))
      return if !selectedUsers?
      @ui.selectedUsers.html('')

      _.each selectedUsers.reverse(), (u) =>
        @ui.selectedUsers.append(@userBigTemplate(u))

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

    userBigTemplate: (user) ->
      "<img class='praised-person-avatar' src='" + user.get('avatar_url') + "'/>"

  class List.Header extends App.Views.Layout
    template: 'props/list/templates/header'
    className: 'jumbotron clearfix'
    regions:
      'form_region' : '.form-region'

  class List.Prop extends App.Views.ItemView
    template: 'props/list/templates/prop'
    tagName: 'li'
    className: 'list-group-item props-list-item'
    modelEvents:
      'change' : 'render'
    ui:
      propArea: '.prop-area'

    serializeData: ->
      _.extend super,
        created_at: moment(@model.get('created_at')).fromNow()

    onRender: ->
      React.render(React.createElement(PropComponent,
        prop: @model
      ), @ui.propArea[0])

  class List.EmptyView extends App.Views.ItemView
    template: 'props/list/templates/empty'

  class List.Props extends App.Views.CompositeView
    template: 'props/list/templates/props'
    childView: List.Prop
    childViewContainer: '.props-list'
    className: 'list-group'
    emptyView: List.EmptyView
    events:
      'click [data-page]' : 'pageSelected'
    ui:
      paginationRegion: '.pagination-region'

    initialize: (options) ->
      @listenTo @, 'add:child', @showPagination

    currentPage: ->
      @collection.state.currentPage

    showPagination: ->
      React.render(React.createElement(PaginationComponent,
        currentPage: @collection.state.currentPage
        hasNextPage: @collection.hasNextPage()
        hasPreviousPage: @collection.hasPreviousPage()
        onNextPageClick: @getNextPage.bind(this)
        onPrevPageClick: @getPreviousPage.bind(this)
      ), @ui.paginationRegion[0])

    getNextPage: (e) ->
      e.preventDefault()
      @collection.getNextPage()

    getPreviousPage: (e) ->
      e.preventDefault()
      @collection.getPreviousPage()
