@Props.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Prop extends Entities.Model
    defaults:
      user: {}
      propser: {}
      body: ''
      props_count:
        received: 0
        given: 0
    urlRoot: ->
      '/api/v1/props'

    upvote: ->
      $.post "/api/v1/props/#{@get('id')}/upvotes", (data) =>
        @set data

  class Entities.Props extends Entities.Collection
    model: Entities.Prop
    comparator: (model) ->
      - moment(model.get('created_at')).format('X')
    url: ->
      '/api/v1/props'

    parseRecords: (resp) ->
      resp.props

    parseState: (resp, queryParams, state, options) ->
      {
        currentPage: resp.meta.current_page
        totalRecords: resp.meta.total_count
        totalPages: resp.meta.total_pages
      }

  API =
    getProps: (filters = {}) ->
      props = new Entities.Props
      props.queryParams = filters
      props.fetch()
      props

    newProp: ->
      new Entities.Prop

    getPropsCount: ->
      props_count = $.ajax '/api/v1/props/total', async: false
      props_count.responseText

  App.reqres.setHandler 'prop:entities', (filters) ->
    API.getProps filters

  App.reqres.setHandler 'new:prop:entity', ->
    API.newProp()

  App.reqres.setHandler 'props:total', ->
    API.getPropsCount()
