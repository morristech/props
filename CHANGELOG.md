# Change Log
All notable changes to this project will be documented in this file.

# 0.14.0 - 2015-10-09

## Added

* [Skylight](https://www.skylight.io/) monitoring

## Fixed

* Email digest are sent properly now, there was an issue with date comparison
* There is also a rake task creating subscriptions for new users

# 0.14.0 - 2015-09-20

## Changed

* `konf` gem has been removed and replaced with `app_konfig`. You should
  configure `secrets.yml` instead of `sec_config.yml`

## Added

* Weekly/Daily email digests about received props
* React components

## Fixed

* long names on user card are no longer displayed outside the box

# 0.13.0 - 2015-04-09
## Added

* Ability to archive users
* Only active users are displayed
* Rails bumped to 4.2.1
* Lots of gems were updated to their latest versions

## Deleted

* Props do not longer have user_id column. This was a leftover after introducing
  multiprops feature

# 0.12.0 - 2015-01-17
## Added

* API endpoint for checking the `hero_of_the_week` returning user with the most
  props over the current week. thanks [@jacobi007](https://github.com/jacobi007)!
* Code style checking is done via `rubocop-guard`, please follow the guideline
  and fix any issues mentioned by rubocop

## Fixed

* All the code-style issues mentioned by rubocop were fixed and project has 0
  warnings currently - I would like to keep it this way:)

## Removed

* Checking domain is now done ONLY via omniauth - it will check your Google Apps
  domain set in `config.yml` under `domain_name` key

# 0.11.0 - 2014-12-22
# Added

* Rails bumped to 4.2 stable

# 0.10.0 - 2014-12-16
## Fixed
* Validation errors fixed - adding multiprops functionality earlier caused some
  serious validation gaps.

## Added
* Rails bumped to 4.2.rc3
* Overall gems update
* Pagination on props records

# 0.9.0 - 2014-12-05
## Added
* NewRelic monitoring
* Added API with tokens
* Ability to add a prop for multiple users at once
* Bigger avatars of prop receivers in form. Select list contains user names and
  thumbnails

# 0.8.0 - 2014-11-06
## Added
* Ability to upvote props
  * thanks [@sufleR](https://github.com/sufleR) for checking into SQL query!
* Ability to see prop rating

## Changed
* `slack-notifier` gem was updated and instead of using `team` and `token`
  variables, we now use `webhook_url`. See more here https://github.com/stevenosloan/slack-notifier/blob/master/docs/upgrade-from-0.6.1.md
* Configuration is done by overriding `config/sec_config.yml` file.
  `dotenv-rails` isn't used anymore
* Upgrade to RSpec 3
* Rails updated to 4.2.0.beta4
* UI changes
  * thanks [@dawidw](https://github.com/dawidw)!

## Fixed
* Few missing bootstrap classes were added to keep layout compatible with grid
  * thanks [@Luk4z](https://github.com/Luk4z)!

# 0.7.0 - 2014-10-28
## Added
* Brand new readme
* This changelog
* Filtering users on users page
* More intuitive selecting users in props form
* Instant redirection to app when user is signed in
* Ajax loader
* When form is synced - opacity wrapper is added

## Fixed
* Errors are displayed on form
* Proper prop escaping

# 0.6.0 - 2014-10-17
## Added
* Rails 4.2 Beta
* Ruby 2.1.3
* Show gravatars on users list
* Friendly date displayed on prop element
* Slack integration

## Fixed
* Update `netguru_theme` - no issues with assets
* We use `konf` gem for handling app configuration

## Removed
* We don't use Rails Secrets anymore

# 0.5.0 - 2014-09-16
## Added
* Netguru bootstrap theme
* Nice logo

## Fixed
* Assets cleanup

# 0.4.0 - 2014-08-31
## Added
* Marionette version 2.1
* Listing users as thumbnails

# 0.3.0 - 2014-08-27
## Added
* Nice form for adding props
* Validating email domain
* Sample database configuration

# 0.2.0 - 2014-07-08
## Added
* Adding props

# 0.1.0 - 2014-06-19
## Added
* Basic backend
* Basic frontend
* Signing in via Google
