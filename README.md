# EmailNotif

This is an authenticated platform where admin can send
 message to registered users via email. Collect 
 relevant information from users so that admin can 
 notify user based on certain criteria(eg location).The 
 user data can be stored in a database of your choice. 
 Admin can either choose to notify everyone at once or 
 based on certain filters on user data. 
 
The admin is the user with the first record in DB. 

### Filters used 
- Location: Only a certain number of Locations can be selected by the user, 
hence making it simpler to send mail based on location.
- Gender: Male or Female
- Age/ age group: Send mails to all users belonging to a particular age or 
an age group.

## Technical Specifications
This section defines the versions of Ruby and Rails used and 
instructions to setup the project on local.

#### Versions
- Ruby - 2.6.1
- RubyGems version - 3.0.1
- Rails - 6.0.3.3
- Rack version - 2.2.3
- Database - MySQL

#### Setup
1. Make sure you have RVM, Rails and MySQL installed on your system, if not, follow
these steps, otherwise, skip:
- To install RVM (Ruby version manager), (Make sure you're running commands as 
a login shell)
```
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -sSL https://get.rvm.io | bash -s stable
```
- To install MySQL server
```
sudo apt install mysql-server
```
- Rails Setup - Follow these steps one-by-one
```
rvm install 2.6.1
rvm use 2.6.1 --default
gem install bundler:2.1.4
gem install rails -v 6.0.3.3
sudo apt install libmysqld-dev
gem install mysql2
```
- NodeJS for webpacker gem
```
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
```

2. Clone the repository using git
```
git clone https://github.com/gaurang2001/EmailNotif.git
```
or download the zip file from the repository

3. Install gems
```
bundle install
bundle exec rails webpacker:install
```

4. Create database
```
rake db:create
```

5. Migrate the migrations to the database
```
rake db:migrate
```

6. Setup environment variables
- Modify `~/.bashrc` file and add these lines to the bottom:
```
# SQL
export SQL_USERNAME=<your_mysql_username>
export SQL_PASSWORD=<your_mysql_password>

# EmailNotif
export gmail_username=<your_gmail_id>
export gmail_password=<your_gmail_password>
```
- Run your `~/.bashrc` file by executing
```
. ~/.bashrc
```
- Restart terminal

7. Run the server
```
rails server
```

8. Open http://localhost:3000 on your browser and you're good to go!!

## Email Protocol used
**SMTP (Simple Mail Transfer Protocol)**- 
 This is the standard protocol for sending emails 
 over the Internet. This is a protocol which is 
 used by a Mail Transfer Agent to deliver emails to a 
 recipient’s email server. This is a protocol which 
 defines mail sending and cannot be used for mail receiving.
 Since this application is used to send mails and not receive any,
 I found it the most suitable to use. _*ActionMailer*_ of Ruby on Rails 
 handles the load of sending mails at the backend.

