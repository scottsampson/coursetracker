# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Coursetracker::Application.initialize!

COURSE_ANSWERS = {
  '0' => 'Need to learn',
  '1' => 'Already know'
}

EXERCISE_ANSWERS = {
  '0' => 'Not finished',
  '1' => 'Finished'
}