require 'doctor'

class Patient

  attr_accessor :name, :date_of_birth, :insurance_id, :id

  def initialize(name, date_of_birth, insurance_id, id=nil)
    @name = name
    @date_of_birth = date_of_birth
    @insurance_id = insurance_id
    @id = id
  end

  def save
    from_db = DB.exec("INSERT INTO patient (name, date_of_birth, insurance_id) VALUES ('#{@name}', '#{@date_of_birth}', #{@insurance_id}) RETURNING id")
    @id = from_db.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def assign_to(doctor_name)
    doctor = Doctor.search_by_doctor_name(doctor_name)
    DB.exec("INSERT INTO doctor_patient (doctor_id, patient_id) VALUES (#{doctor.id}, #{@id});")
  end

  def doctors
    found = []
    providers = DB.exec("SELECT * FROM doctor_patient WHERE patient_id = '#{@id}';")
    providers.each do |provider|
      provider_id = provider['doctor_id']
      matches_in_doctor_table = DB.exec("SELECT * FROM doctor WHERE id = '#{provider_id}'")
      matches_in_doctor_table.each do |match|
        name = match["name"]
        insurance_id = match["insurance_id"].to_i
        specialty_id = match["specialty_id"].to_i
        id = match["id"].to_i
        found << Doctor.new(name, insurance_id, specialty_id, id)
      end
    end
    found
  end

  def self.all
    from_db = DB.exec("SELECT * FROM patient")
    patients = []
    from_db.each do |patient|
      name = patient["name"]
      date_of_birth = patient["date_of_birth"]
      insurance_id = patient["insurance_id"].to_i
      id = patient["id"].to_i
      patients << Patient.new(name, date_of_birth, insurance_id, id)
    end
    patients
  end

  def self.search_by_patient_name(patient_name)
    Patient.all.find { |patient| patient.name == patient_name }
  end
end
