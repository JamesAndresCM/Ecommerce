# Rails base
## Rename Project
* rails g rename:into NewName
* change title app in application-helper [title default](https://github.com/JamesAndresCM/base_rails_5/blob/5576fcdfa18ffdacde358bf1d2d01620652353c0/app/helpers/application_helper.rb#L10)
* change title [mailer](https://github.com/JamesAndresCM/base_rails_5/blob/ec116a3b08753836bc6770c0cc363321ff9603ac/app/views/mail_form/contact.erb#L1)
* change message and add email in [headers](https://github.com/JamesAndresCM/base_rails_5/blob/5576fcdfa18ffdacde358bf1d2d01620652353c0/app/models/main.rb#L9)
* change devise [email header](https://github.com/JamesAndresCM/base_rails_5/blob/bf04de0645a657d8d85a13907eaaa8277f5e9617/config/initializers/devise.rb#L21)
## Generate ssl certificate to devise omniauth
* `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
* run rails with ssl `rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'` 
* Add Your Keys (facebook and gmail) create file config/application.yml for env variables
* redis-server && bundle exec sidekiq -C config/sidekiq.yml
