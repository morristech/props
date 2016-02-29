@Props = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on 'before:start', (options) ->
    App.environment = options.environment
    App.current_user = App.request 'current_user:entity'
    @propsCount = App.request 'props:total'

  App.addRegions
    mainRegion:    '#main-region'

  App.addInitializer ->
    RWR.renderComponent('AnnouncementComponent',
      propsCount: @propsCount,
      document.getElementById('announcements-region'))

  App.rootRoute = ''

  App.reqres.setHandler 'default:region', -> App.mainRegion

  App.on 'start', ->
    @startHistory()

    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
