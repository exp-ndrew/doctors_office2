class Doctor

  attr_accessor :name, :insurance_id, :specialty_id

  def initialize(name, insurance_id, specialty_id)
    @name = name
    @insurance_id = insurance_id
    @specialty_id = specialty_id
  end

  def save
    DB.exec("INSERT INTO doctor (name, insurance_id, specialty_id) VALUES ('#{@name}', #{@insurance_id}, #{@specialty_id})")
  end

  def self.all
    from_db = DB.exec("SELECT * FROM doctor")
    doctors = []
    from_db.each do |doctor|

      name = doctor["name"]
      insurance_id = doctor["insurance_id"].to_i
      specialty_id = doctor["specialty_id"].to_i

      doctors << Doctor.new(name, insurance_id, specialty_id)
    end
    doctors
  end

  def ==(another_doctor)
    self.name = another_doctor
  end
end
