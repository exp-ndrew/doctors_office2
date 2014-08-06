class Patient

  attr_accessor :name, :date_of_birth, :insurance_id

  def initialize(name, date_of_birth, insurance_id)
    @name = name
    @date_of_birth = date_of_birth
    @insurance_id = insurance_id
  end

  def save
    DB.exec("INSERT INTO patient (name, date_of_birth, insurance_id) VALUES ('#{@name}', '#{@date_of_birth}', #{@insurance_id})")
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

  def self.all
    from_db = DB.exec("SELECT * FROM patient")
    patients = []
    from_db.each do |patient|
      name = patient["name"]
      date_of_birth = patient["date_of_birth"]
      insurance_id = patient["insurance_id"].to_i
      patients << Patient.new(name, date_of_birth, insurance_id)
    end
    patients
  end

end
