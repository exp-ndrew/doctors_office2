require 'pg'
require 'rspec'
require 'spec_helper'
require 'patient'
require 'doctor'
require 'specialty'

describe 'Specialty' do

  it 'initializes a specialty object with a name' do
    specialty = Specialty.new("Pediatrics")
    expect(specialty).to be_an_instance_of Specialty
  end

  it 'saves to the database on .save' do
    specialty = Specialty.new("Pediatrics")
    specialty.save
    expect(Specialty.all).to eq [specialty]
  end

  describe '.all' do
    it 'returns all specialties in the table on .all' do
      specialty1 = Specialty.new("Pediatrics")
      specialty2 = Specialty.new("Podiatry")
      specialty1.save
      specialty2.save
      expect(Specialty.all).to eq [specialty1, specialty2]
    end
  end

  it 'should be the same object with the same name' do
    specialty1 = Specialty.new("Pediatrics")
    specialty2 = Specialty.new("Pediatrics")
    specialty1.save
    specialty2.save
    expect(specialty1).to eq specialty2
  end
end

