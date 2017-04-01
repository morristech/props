module Api
  module V1
    class Base < Grape::API
      mount Api::V1::Props
      mount Api::V1::Users
      mount Api::V1::Rankings
      mount Api::V1::Sessions

      add_swagger_documentation base_path: '/api/v1',
                                api_version: 'v1',
                                hide_documentation_path: true
    end
  end
end
