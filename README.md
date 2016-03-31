Pinterest Clone project
=======================

Yet another Rails exercise, this time a basic Pinterest clone.  Users
can create and edit an account, log in and out, create and edit pins (with a 
picture,) delete pins, vote pins up and submit comments.  There is no function 
for following other users, that's outside the projects current scope.  Built 
over a two day period from 11-19 to 11-20 2015.  At a later date a basic suite 
of tests using the RSpec framework was added.

The application is currently deployed to Heroku and can be viewed at 
https://a-simple-pinterest-clone.herokuapp.com/

To get this up and running
--------------------------
_Note: This project was built in the Ruby development environment at https://c9.io/.
This simulates an IDE built on Unix.  This project should run properly on any *nix
machine (Linux, MacOS X, etc.) but getting this to work on Windows is difficult due 
to lack of support of the necessary tools.  If the user has any difficulties, I
recommend creating a Cloud9 account (seriously, it's awesome) and uploading the 
project there._

1. Clone the project.  
2. Make sure you have Ruby installed.  If not, get it [here](https://www.ruby-lang.org/en/downloads/). 
3. From the command line make sure you have bundler installed by entering "gem install bundler"
4. Navigate to the root folder of the project.
5. Run "bundle install" and rake db:migrate to set things up.  
6. Run "rails server" to get things running.  On Cloud9 run "rails s -b $IP -p $PORT"
7. Open your browser and navigate to "http://localhost:3000"  There you should see
the page.  If you are running this on Cloud9 the URL will be different, the terminal
will show you the correct URL.
8. When you're done, simply hit ctrl/cmd + c to quit the server.

Components used
---------------
* Ruby on Rails
* BCrypt
* Sass CSS
* Bootstrap
* CarrierWave
* Masonry
* RSpec
* FactoryGirl
* Shoulda Matchers

Still to do
-----------
* Implement persistent user sessions
* Expand commenting options to include editing and deletion
