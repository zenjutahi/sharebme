# Load the Rails application.
require_relative 'application'

#Formatting DateTime to look like "20/01/2011 10:28PM" 
Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"

# Initialize the Rails application.
Rails.application.initialize!
