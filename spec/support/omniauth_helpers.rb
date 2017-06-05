module OmniauthHelpers
  def create_auth(email: 'aaa@bbb.cc',
                  token: 'valid_token',
                  team_id: 'team_id',
                  team_name: 'team_name',
                  avatar: 'slack.com/sample_avatar.png',
                  is_admin: false)
    {
      'provider' => 'slack',
      'uid' => 'auth_uid',
      'info' => {
        'name' => 'Tod tod',
        'nickname' => 'tod',
        'email' => email,
        'team_id' => team_id,
        'team' => team_name,
        'is_admin' => is_admin,
      },
      'extra' => {
        'user_info' => {
          'user' => {
            'profile' => {
              'image_512' => avatar,
            },
          },
        },
      },
      'credentials' => { 'token' => token },
    }
  end
end
