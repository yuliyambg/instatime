# README

This application is a platform for sharing event images.
Allows not logged in users to see public events with their images.
Allows logged in users to create events and upload one or several images for each event at the same time.
Users can select to make the event public or private.
Images that pertain to a private event can't be seen from other users.
User can delete event with the pertaining images.

## Getting Started
To get started with the app, clone the repo and then install the needed gems:

`cd instatime`

`bundle install`

Next, migrate the database:

`rake db:migrate`

Paperclip gem was used, as an easy file attachment library for ActiveRecord.
ImageMagick must be installed and Paperclip must have access to it.
If you're on Mac OS X, you'll want to run the following with Homebrew:

`brew install imagemagick`
If you are on Ubuntu or Windows, pls refer to https://github.com/thoughtbot/paperclip#image-processor

Then run the app in a local server:

`rails server`

### Notation: Devise gem was used as authentication solution.
For more information about Devise Gem, https://github.com/heartcombo/devise

## Functionalities

- **Register** : App doesnt require signup in order to see public events images.

- **Login** :  User can login with email and password. Devise gem was used as authentication solution.

- **New Event** : Logged in users can create new events and attach one or multiple images, user can select to make event the public or private

- **Delete Event** : Logged in user can delete own events & pertaining images

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

All source code is available under the MIT License.


