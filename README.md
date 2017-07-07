# Connecting Researchers

## Technologies Used -
1. HTML
2. CSS
3. Ruby
4. Github
5. Heroku

Create folders and files using 'sinatra new connectingresearchers -va' to create basic files in preset format.

## Approach taken for html

1. Keep login and logout button in layout.erb file, so that it will appear on all pages.
2. Wrote basic layout of HTML page like DOCTYPE, html, head, body, and script tags.
3. Draw basic layout on notebook - how I want my pages to route and what tables I need.
4. Links were added to link css file.

## Approach taken for ruby

1. Home page is showing login button (for those who have account) and create an account for new users.
2. After login, user can see their profile and logout button will be present at the top if they want to logout.
3. For new user, after they click, create an account, they have to fill a form and click submit button to submit their details and then login page will appear to login into your account. If they already have account, app won't allow them to create a new account with same email address.
4. After login for any user - 
a. They can add publications in publication section.
b. They can edit their profile (all columns in their profile).
c. They can delete their profile.
d. They can search for other's publications by selecting research field and proving keyword for their search. By clicking on search button, they will be routed to other page showing all matched results with the name of the author of that publication.
e. User who is searching can click on publication link to read whole publication and can also click on author name to visit their profile.
5. User can logout any time using logout button at the top right hand side corner.

### Using ActiveRecord:
1. For using Active record to connect ruby code to database, we need to create db_config.rb.
2. Require active record in new file and write code to make it work.
3. In models folder, we have all .rb files in which we define class name that will work with Active record and active record will push all data in database in different tables (as per the class I use).
4. Active record also help to read the table columns in database and then we can use that to write ruby code.
5. I have to require db_config file and all model files in main.rb
6. I have to require sinatra and sinatra/reloader to connect it to server.

## Approach taken for CSS

1. Important step was to clear the float in element that occurs after element on which I applied float.
2. All other steps like border, text-align, background-color, color, font-size, font-family, margin, padding, text-decoration in CSS was to beautify the HTML page.
 
### Installation Instructions 

1. Create a folder to store all files of the project in the computer (local).
2. In terminal, initialize git in that folder by ‘git init’.
3. Go to GitHub account and create a new repository.
4. In terminal, to connect local to git repository - ‘git remote add origin url’
   Url in above line is the url of new repository created in GitHub account. Copy and paste that url in terminal command instead of writing word ‘url’.
5. In local, files were added to staging and commit changes e.g. ‘git add -A’, ‘git commit -m 'connecting researchers’.
6. Files were pushed from local to my remote repository on Github e.g. ‘git push origin master’.
7. Next step was hosting the app on heroku- 

### Hosting App on heroku
1. In GEM file, type all gems that I use for my project.
2. For first time, do gem install bundler, then enter the bundler command in our terminal to build a Gemfile.lock file.
3. Whenever new gem is used in app, type bundler in terminal.
4. In db_config.rb, change the ActiveRecord::Base.establish_connection line to look like below:
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
5. Comment out require sinatra/reloader line. Also make sure not to have any binding.pry in code, that can pause execution in production server.
6. Type 'heroku login' in terminal - that will ask for username and password.
7. Take a dump: pg_dump -Fc --no-acl --no-owner -h localhost -U <saloni> <connectingresearchers> > db.dump
8. Restore the dump on production: heroku pg:backups:restore '<URL_to_database_on_github>' DATABASE_URL
URL_to_database_on_github - click on db.dump file and then right click on download button to copy link address.
9. If any change has been made in app files, do all git steps again.
10. Type 'heroku create' in terminal.
11. Type 'git push heroku master' in terminal.
12. Type 'heroku open' to open website.

## Unsolved Problem
1. I want to use API to send personalised message to author of publication to seek their help in understanding their work, but unable to do it because Sendgrid people didn't authorise me access to their service.





