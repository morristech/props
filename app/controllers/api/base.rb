module Api
  class Base < Grape::API
    use Grape::Middleware::Globals
    use GrapeLogging::Middleware::RequestLogger,
        instrumentation_key: 'grape',
        include: [GrapeLogging::Loggers::Response.new,
                  GrapeLogging::Loggers::FilterParameters.new]

    content_type :json, 'application/json'
    default_format :json

    mount Api::V1::Base
  end
end
