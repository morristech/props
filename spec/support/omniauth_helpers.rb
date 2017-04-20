module OmniauthHelpers
  def create_auth(email: 'aaa@bbb.cc',
                  token: 'valid_token',
                  team_id: 'team_id',
                  team_name: 'team_name')
    {
      'provider' => 'slack',
      'uid' => 'auth_uid',
      'info' => {
        'name' => 'Tod tod',
        'nickname' => 'tod',
        'email' => email,
        'team_id' => team_id,
        'team' => team_name,
      },
      'credentials' => { 'token' => token },
    }
  end
end
