require 'pg'
require 'rspec'
require 'spec_helper'
require 'doctor'

describe Doctor do
  it 'is initialized with a name, insurance id and specialty id' do
    doctor = Doctor.new("Tom", 1, 1)
    expect(doctor).to be_an_instance_of Doctor
  end

  it 'writes to the database on save method' do
    doctor = Doctor.new("Tom", 1, 1)
    doctor.save
    expect(Doctor.all).to eq [doctor]
  end

  it 'returns the doctors id' do
    doctor = Doctor.new("Tom", 1, 1)
    doctor.save
    expect(Doctor.all[0].id).to eq doctor.id
  end

  it 'is the same doctor if he/she has the same name' do
    doctor1 = Doctor.new("Tom", 1, 1)
    doctor2 = Doctor.new("Tom", 1, 1)
    expect(doctor1).to eq doctor2
  end

  describe "#assign_to" do
    it 'assigns a patient to a doctor' do
      patient = Patient.new("Billy", '1995-08-06', 1)
      patient.save
      doctor = Doctor.new("Tom", 2, 2)
      doctor.save
      doctor.assign_to("Billy")
      expect(doctor.patients).to eq [patient]
    end
  end

  describe ".all" do
    it 'returns all doctors on Doctor.all method' do
      doctor1 = Doctor.new("Tom", 1, 1)
      doctor2 = Doctor.new("Susan", 2, 2)
      doctor1.save
      doctor2.save
      expect(Doctor.all).to eq [doctor1, doctor2]
    end
  end

  describe '.search_by_doctor_name' do
    it 'should return a doctor object for a given name' do
      doctor1 = Doctor.new("Tom", 1, 1)
      doctor2 = Doctor.new("Susan", 2, 2)
      doctor1.save
      doctor2.save
      expect(Doctor.search_by_doctor_name("Susan")).to eq doctor2
    end
  end
end
