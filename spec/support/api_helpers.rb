module ApiHelpers
  def sign_in(user)
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticate_user!) { true }
      allow(endpoint).to receive(:current_user) { user }
    end
  end

  def sign_out
    Grape::Endpoint.before_each nil
  end

  def json_response
    JSON.load(response.body)
  end
end
