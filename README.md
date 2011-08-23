WebL
====

Basic weblog based on Rails 3.1 with roles for authors next to admins. 

Progress
========
The basics seems to be mostly covered on the back end. CanCan (http://github.com/ryanb/cancan) is implemented to distinguish between guests, registered users, authors and admins. For admins there is an admin namespace where users and posts can be edited. There is also an index of comments which might help when removing spammy comments in bulk. 

Redcarpet is used to provide markdown in posts

However, no lay-out of any kind has been developed. Feel free to reuse the code nonetheless.