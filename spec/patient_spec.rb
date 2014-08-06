require 'pg'
require 'rspec'
require 'spec_helper'
require 'patient'

describe Patient do
  it 'is initialized with name, dob and insurance id' do
    patient = Patient.new("Billy", '1995-08-06', 1)
    expect(patient).to be_an_instance_of Patient
  end
end
