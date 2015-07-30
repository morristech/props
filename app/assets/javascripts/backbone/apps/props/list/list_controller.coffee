@Props.module 'PropsApp.List', (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { props, show_header } = options
      props ||= App.request 'prop:entities'

      @layout = @getLayoutView()

      @listenTo App.vent, 'prop:created', (prop) ->
        props.add prop

      @listenTo @layout, 'show', ->
        @headerRegion() if show_header
        @propsRegion props

      @show @layout,
        loading:
          entities: props

    getLayoutView: ->
      new List.Layout

    propsRegion: (props) ->
      React.render(React.createElement(PropsListComponent,
       props: props
      ), $('.props-region')[0])

    getHeaderView: ->
      users = App.request 'user:entities'
      view = new List.Header

      @listenTo view, 'show', ->
        @formRegion view.form_region, users

      @listenTo App.vent, 'prop:created', (prop) ->
        @formRegion view.form_region, users

      view

    getFormView: (users) ->
      prop = App.request 'new:prop:entity'

      @listenTo prop, 'created', (model) ->
        App.vent.trigger 'prop:created', model

      new List.Form
        model: prop
        users: users

    formRegion: (region, users) ->
      view = @getFormView users
      form_view = App.request 'form:component', view

      @show form_view,
        region: region
        loading:
          entities: users

    headerRegion: ->
      view = @getHeaderView()
      @show view,
        region: @layout.header_region
