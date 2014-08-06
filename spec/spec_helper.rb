require 'rspec'
require 'pg'
#require 'doctor'

DB = PG.connect({:dbname => 'doctors_office_test'})


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
  end
end
