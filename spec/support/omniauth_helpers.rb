module OmniauthHelpers
  def create_auth(email: 'aaa@bbb.cc',
                  token: 'valid_token',
                  team_id: 'team_id',
                  team_name: 'team_name',
                  small_avatar: 'slack.com/sample_small_avatar_192.png',
                  big_avatar: 'slack.com/sample_avatar.png',
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
        'image' => small_avatar,
      },
      'extra' => {
        'user_info' => {
          'user' => {
            'profile' => {
              'image_512' => big_avatar,
            },
          },
        },
      },
      'credentials' => { 'token' => token },
    }
  end

  def users_list_array(users_number: 1,
                       email: 'aaa@bbb.cc',
                       id: 'slack_id',
                       name: 'mention',
                       real_name: 'John Doe',
                       big_avatar: 'slack.com/sample_avatar.png',
                       is_admin: false,
                       is_bot: false)
    users_list_array = []
    users_number.times do |i|
      i = i.to_s
      users_list_array <<
        {
          'id' => id + i,
          'name' => name + i,
          'deleted' => false,
          'real_name' => real_name + i,
          'profile' =>
          {
            'email' => i + email,
            'image_512' => i + big_avatar,
          },
          'is_admin' => is_admin,
          'is_bot' => is_bot,
        }
    end
    users_list_array
  end
end
