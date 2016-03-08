@Props.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.User extends Entities.Model
    defaults:
      name: ''
      email: ''
    urlRoot: '/api/v1/users'

  class Entities.Users extends Entities.Collection
    model: Entities.User
    url: '/api/v1/users'

  API =
    getCurrentUser: ->
      @current_user ||= new Entities.User gon.current_user

    getUsers: ->
      users = new Entities.Users
      users.fetch()
      users

    getUser: (id) ->
      user = new Entities.User
        id: id
      user.fetch()
      user

  App.reqres.setHandler 'current_user:entity', ->
    API.getCurrentUser()

  App.reqres.setHandler 'user:entities', ->
    API.getUsers()

  App.reqres.setHandler 'user:entity', (id) ->
    API.getUser id
