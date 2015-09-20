class PropSearch < Searchlight::Search
  search_on -> { Prop.with_includes.ordered }

  searches :user_id, :propser_id, :show_upvote_status_for_user_id, :after

  def search_user_id
    search.where(prop_receivers: { user_id: user_id })
  end

  def search_after
    search.where('props.created_at >= ?', after)
  end

  def search_show_upvote_status_for_user_id
    search
      .select("props.*, (SELECT 1 FROM upvotes WHERE
              upvotes.user_id = #{show_upvote_status_for_user_id}
              AND upvotes.prop_id = props.id LIMIT 1)
              AS user_has_upvoted")
  end

  def search_propser_id
    search.where propser_id: propser_id
  end
end
