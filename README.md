# Props
[![](http://img.shields.io/codeclimate/github/netguru/props.svg?style=flat-square)](https://codeclimate.com/github/netguru/props)
[![](http://img.shields.io/codeclimate/coverage/github/netguru/props.svg?style=flat-square)](https://codeclimate.com/github/netguru/props)
[![](http://img.shields.io/gemnasium/netguru/props.svg?style=flat-square)](https://gemnasium.com/netguru/props)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/netguru/props/tree/master)

## General info

This app is called **PROPS**. The idea behind it is to express saying 'thank you!'
in a geeky way.

## Technologies

* Ruby on Rails 4.2
* Ruby 2.5.1
* Postgres
* React with [react_webpack_rails](https://github.com/netguru/react_webpack_rails)

## Setup

```bash
bin/setup
```

Install Node.js dependencies:
```bash
$ npm install
```

Generate react-bundle for the first time:
```bash
$ npm build
```

#### Slack application setup

1. Create slack application by going to [Your Apps](https://api.slack.com/apps).
2. Under **"OAuth & Permissions"** tab (`https://api.slack.com/apps/APP_ID/oauth`) add new redirect URL, looking like this: `https://YOUR_DOMAIN/auth/slack/callback`.
3. Under **"OAuth & Permissions"** tab (`https://api.slack.com/apps/APP_ID/oauth`) add following permission scopes:
  - `chat:write:bot`
  - `team:read`
  - `users.profile:read`
  - `users:read`
  - `users:read.email`
4. Under **"Slash Commands"** tab (`https://api.slack.com/apps/APP_ID/slack-commands`) add slash command of your liking, remembering to set following settings:
  - **"Request URL"**: `https://YOUR_DOMAIN/api/v1/slack_commands/kudos`.
  - **"Escape channels, users, and links sent to your app"** - YES (checkbox).
5. Under **"Basic Information"** tab - install app to your workspace.
6. Under **"Basic Information"** tab - read **Client ID**, **Client Secret** values available under **App Credentials** section and set them as `SLACK_CLIENT_ID`, `SLACK_CLIENT_SECRET` environment variables available to your Props application.
6. Under **"Basic Information"** tab - read **Verification Token** available under **App Credentials** section and add it to Props application database by running Rails command line (`rails c`) and executing following command:
```ruby
EasyTokens::Token.create(value: 'VERIFICATION_TOKEN', description: 'Slack command verification token')
```
7. In order to post Slack notifications about new Kudos and handle Slack reactions added to them, you need to set Slack channel for your organisation in Settings after signing into your Props application. If not set, default Slack channel is `general`.

## Development
* run rails server.
* run webpack in watch mode:
```bash
$ npm start
```

## Tests

We use RSpec 3 for testing backend and Mocha + Karma to test React components.
We are using Chrome launcher.

### Running components test:

* run `npm run test-dev` to run tests.
* run `npm run test-live` to run tests in watch mode.

## Notes

Please follow Ruby style guide available [here](https://github.com/bbatsov/ruby-style-guide).

## Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

If you add functionality to this application, create an alternative
implementation, or build an application that is similar, please contact
me and I’ll add a note to the README so that others can find your work.

## License

MIT. See [LICENSE](LICENSE).
