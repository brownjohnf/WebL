WebL
====

Basic weblog based on Rails 3.1 with roles for authors next to admins. Feel free to take a look at a running blog of the current version [here][3].

[3]: http://www.web-l.nl

Progress
========
The basics seems to be mostly covered on the back end. [CanCan][1] is used to distinguish between guests, registered users, authors and admins. For admins there is an admin namespace where users and posts can be edited. There is also an index of comments which might help when removing spammy comments in bulk. 

Redcarpet is used to provide markdown in posts. It is the only option for formatting available, but those inclined can easily change this as everything is passed through the markdown helper function in the application helper.

[1]: http://github.com/ryanb/cancan

Lay-out
=======
No significant lay-out has been created. Some basics with Twitter's [bootstrap][2] have been introduced so that there is at least something to look at.

[2]: http://twitter.github.com/bootstrap/

Installation
============
Installing the app is fairly trivial, just copy this repository and it will probably work after running `bundle install`, `rake db:migrate`, `rake assets:precompile` and `rails server`. 

In development you might want to exclude the production group in bundler (otherwise it will require mysql2). If you do not work on a mac, make sure to remove autotest-fsevents from the Gemfile. (That gem only works on macs)

Don't forget to generate and change the session_secret in app_config.yml if you want to use this in production. The current one is unsafe for obvious reasons. As usual database settings go into database.yml.

WebL does not create an admin user by default. You can use the rails console to do this:

````ruby
u = User.new(:name => "Admin", :password => "secret", :password_confirmation => "secret", :email => "webmaster@yourweblog.com")
u.roles = ['admin']
u.save
````
