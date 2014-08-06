class Doctor

  attr_accessor :name, :insurance_id, :specialty_id, :id

  def initialize(name, insurance_id, specialty_id, id=nil)
    @name = name
    @insurance_id = insurance_id
    @specialty_id = specialty_id
    @id = id
  end

  def save
    from_db = DB.exec("INSERT INTO doctor (name, insurance_id, specialty_id) VALUES ('#{@name}', #{@insurance_id}, #{@specialty_id}) RETURNING id;")
    @id = from_db.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def assign_to(patient_name)
    patient = Patient.search_by_patient_name(patient_name)
    DB.exec("INSERT INTO doctor_patient (doctor_id, patient_id) VALUES (#{@id}, #{patient.id});")
  end

  def patients
    found = []
    patients = DB.exec("SELECT * FROM doctor_patient WHERE doctor_id = '#{@id}';")
    patients.each do |patient|
      patient_id = patient['patient_id']
      matches_in_patient_table = DB.exec("SELECT * FROM patient WHERE id = '#{patient_id}'")
      matches_in_patient_table.each do |match|
        name = match["name"]
        date_of_birth = match["date_of_birth"].to_i
        insurance_id = match["insurance_id"].to_i
        id = match["id"].to_i
        found << Patient.new(name, date_of_birth, insurance_id, id)
      end
    end
    found
  end

  def self.all
    from_db = DB.exec("SELECT * FROM doctor")
    doctors = []
    from_db.each do |doctor|
      name = doctor["name"]
      insurance_id = doctor["insurance_id"].to_i
      specialty_id = doctor["specialty_id"].to_i
      id = doctor["id"].to_i
      doctors << Doctor.new(name, insurance_id, specialty_id, id)
    end
    doctors
  end

  def self.search_by_doctor_name(doctor_name)
    Doctor.all.find { |doctor| doctor.name == doctor_name}
  end
end
