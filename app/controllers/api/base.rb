module Api
  class Base < Grape::API
    content_type :json, 'application/json'
    default_format :json

    mount Api::V1::Base
  end
end
