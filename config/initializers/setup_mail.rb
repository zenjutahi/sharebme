ActionMailer::Base.smtp_settings = { 
 :address              => "smtp.sendgrid.net", 
 :port                 => 587, 
 :domain               => "gmail.com", 
 :user_name            => "sharebmeapp", 
 :password             => "secret", 
 :authentication       => "plain", 
 :enable_starttls_auto => true
}