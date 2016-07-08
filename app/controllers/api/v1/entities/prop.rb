module Api
  module V1
    module Entities
      class Prop < Grape::Entity
        include ActionView::Helpers::SanitizeHelper

        expose :id
        expose :users, using: Entities::UserBase
        expose :propser, using: Entities::UserBase
        expose :body
        expose :created_at
        expose :upvotes_count
        expose :is_upvote_possible
        expose :is_undo_upvote_possible

        private

        def is_upvote_possible
          object.propser_id != current_user.id && !user_has_upvoted?
        end

        def is_undo_upvote_possible
          object.propser_id != current_user.id && user_has_upvoted?
        end

        def user_has_upvoted?
          if object.respond_to?(:user_has_upvoted?)
            object.user_has_upvoted
          else
            object.upvotes.exists?(user_id: current_user.id)
          end
        end

        def current_user
          options[:current_user]
        end
      end
    end
  end
end
