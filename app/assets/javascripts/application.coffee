#= require jquery
#= require jquery_ujs
#= require js_stack/base/underscore/1.6.0
#= require js_stack/base/hamlcoffee
#= require js_stack/base/backbone
#= require js_stack/base/marionette
#= require js_stack/base/jsroutes
#= require js_stack/plugins/moment
#= require js_stack/plugins/backbone.paginator
#= require select2
#= require bootstrap

#= require_tree ./libs
#= require_tree ./config

#= require react_integration
#= require react_bundle
#= require backbone/app

#= require_tree ./backbone/lib/entities
#= require_tree ./backbone/lib/utilities
#= require_tree ./backbone/lib/views
#= require_tree ./backbone/lib/controllers
#= require_tree ./backbone/lib/components

#= require_tree ./backbone/entities
#= require_tree ./backbone/apps

window.unmountComponent = (node) ->
  React.unmountComponentAtNode(node)
