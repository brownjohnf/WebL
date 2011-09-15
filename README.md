WebL
====

Basic weblog based on Rails 3.1 with roles for authors next to admins. 

Progress
========
The basics seems to be mostly covered on the back end. [CanCan][1] is implemented to distinguish between guests, registered users, authors and admins. For admins there is an admin namespace where users and posts can be edited. There is also an index of comments which might help when removing spammy comments in bulk. 

Redcarpet is used to provide markdown in posts.

[1]: http://github.com/ryanb/cancan

Lay-out
=======
No significant lay-out has been created. Some basics with Twitter's [bootstrap][2] have been introduced so that there is at least some eye-candy to watch. 

[2]: http://twitter.github.com/bootstrap/

Installation
============
Installing the app is fairly trivial. Just copy this repository and rename app_config.yml.example to app_config.yml. Don't forget to generate and add a session_secret to this file. (You might use a nice SHA1 digest of some random number for example.)
