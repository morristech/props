module Api
  module V1
    module Entities
      class UserFull < UserBase
        expose :props_count

        private

        def props_count
          {
            given: user_props_repository.given.count,
            received: user_props_repository.received.count,
          }
        end

        def user_props_repository
          UserPropsRepository.new(object)
        end
      end
    end
  end
end
