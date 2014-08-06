require 'pg'
require 'rspec'
require 'spec_helper'
require 'patient'

describe Patient do
  it 'is initialized with name, dob and insurance id' do
    patient = Patient.new("Billy", '1995-08-06', 1)
    expect(patient).to be_an_instance_of Patient
  end

  it 'saves a patient to the database on .save method' do
    patient = Patient.new("Billy", '1995-08-06', 1)
    patient.save
    expect(Patient.all).to eq [patient]
  end

  it 'is the same patient if he/she has the same name' do
    patient1 = Patient.new("Billy", '1995-08-06', 1)
    patient2 = Patient.new("Billy", '1995-08-06', 1)
    expect(patient2).to eq patient1
  end

  describe ".all" do
    it 'returns all patients on .all' do
      patient1 = Patient.new("Billy", '1995-08-06', 1)
      patient2 = Patient.new("Bobby", '1996-08-06', 2)
      patient1.save
      patient2.save
      expect(Patient.all).to eq [patient1, patient2]
    end
  end
end
