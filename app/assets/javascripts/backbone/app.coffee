@Props = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on 'before:start', (options) ->
    App.environment = options.environment
    App.current_user = App.request 'current_user:entity'
    @propsCount = App.request 'props:total'

  App.addRegions
    headerRegion: '#header-region'
    mainRegion:    '#main-region'

  App.addInitializer ->
    App.module('HeaderApp').start(App.current_user)

    RWR.renderComponent('AnnouncementComponent',
      propsCount: @propsCount,
      document.getElementById('announcements-region'))

  App.rootRoute = ''

  App.reqres.setHandler 'default:region', -> App.mainRegion

  App.on 'start', ->
    @startHistory()

    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
