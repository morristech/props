module Api
  module V1
    class Base < Grape::API
      mount Api::V1::Props
      mount Api::V1::Users
      mount Api::V1::Rankings
    end
  end
end
