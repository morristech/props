module Api
  module V1
    class Props < Grape::API
      include Api::V1::Defaults

      helpers do
        include Api::V1::Helpers

        def kaminari_params(collection)
          {
            current_page: collection.current_page,
            next_page: collection.next_page,
            prev_page: collection.prev_page,
            total_pages: collection.total_pages,
            total_count: collection.total_count,
          }
        end

        def props_params(params)
          params.merge(show_upvote_status_for_user_id: current_user.id)
        end

        def prop_params(params)
          params.merge(propser_id: current_user.id)
        end

        def props_repository
          PropsRepository.new
        end

        def upvotes_repository
          UpvotesRepository.new
        end

        def prop
          props_repository.find(params[:prop_id])
        end
      end

      before do
        authenticate_user!
      end

      resources :props do
        desc 'Return props match search params'
        params do
          optional :user_id, type: Integer
          optional :propser_id, type: Integer
          optional :show_upvote_status_for_user_id, type: Integer
        end
        get do
          prop_search = props_repository.search declared(props_params(params))
          paginated_result = prop_search.results.page(params[:page])
          present paginated_result,
                  with: Entities::Props,
                  pagination: kaminari_params(paginated_result),
                  current_user: current_user
        end

        desc 'Return props count'
        get :total do
          Prop.count
        end

        desc 'Create a new prop'
        params do
          requires :body, type: String
          requires :user_ids, type: String
          optional :propser_id, type: Integer
        end
        post do
          create_prop = ::Props::Create.new(props_repository, declared(prop_params(params))).call
          if create_prop.success?
            present create_prop.data, with: Entities::Prop, current_user: current_user
          else
            error!({ errors: create_prop.errors }, 422)
          end
        end

        namespace ':prop_id' do
          desc 'Upvote specific prop'
          params do
            requires :prop_id, type: Integer
          end
          post :upvotes do
            upvote_prop = ::Props::Upvote.new(
              prop: prop,
              user: current_user,
              upvotes_repository: upvotes_repository,
            ).call

            if upvote_prop.success?
              present upvote_prop.data, with: Entities::Prop, current_user: current_user
            else
              error!({ errors: upvote_prop.errors }, 422)
            end
          end
        end
      end
    end
  end
end
