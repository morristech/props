module Api
  module V1
    module Entities
      class Props < Grape::Entity
        present_collection true
        expose :items, as: 'props', using: Entities::Prop

        expose :meta

        private

        def meta
          options[:pagination]
        end
      end
    end
  end
end
