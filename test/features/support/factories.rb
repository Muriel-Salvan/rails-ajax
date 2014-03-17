# TODO (factory_girl_rails): Remove this require when not needed anymore
require 'factory_girl'

FactoryGirl.define do

  factory :user do
    email                 'test@x-aeon.com'
    password              'testtest'
    password_confirmation 'testtest'
  end

end
