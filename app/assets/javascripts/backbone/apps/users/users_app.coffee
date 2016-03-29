@Props.module 'UsersApp', (UsersApp, App, Backbone, Marionette, $, _) ->
  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      'users/:id': 'show'
      'users':     'list'

    before: (route, params) ->
      RWR.unmountComponent(document.getElementById('main-region'))

  API =
    list: () ->
      new UsersApp.List.Controller

    show: (id, user) ->
      RWR.renderComponent('ReduxContainer', {userId: id}, document.getElementById('main-region'))

  App.addInitializer ->
    new UsersApp.Router
      controller: API

  App.vent.on 'user:clicked', (user) ->
    App.navigate "users/#{user.id}", trigger: true
