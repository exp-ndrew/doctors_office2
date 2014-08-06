class Specialty

  attr_accessor :specialty, :id

  def initialize(specialty, id=nil)
    @specialty = specialty
    @id = id
  end

  def save
    from_db = DB.exec("INSERT INTO specialty (specialty) VALUES ('#{@specialty}') RETURNING id")
    @id = from_db.first['id'].to_i
  end

  def ==(another_spec)
    self.specialty == another_spec.specialty
  end

  def self.all
    from_db = DB.exec("SELECT * FROM specialty")
    specialties = []
    from_db.each do |specialty|
      specialty = specialty["specialty"]
      id = specialty["id"].to_i
      specialties << Specialty.new(specialty, id)
    end
    specialties
  end

  def self.doctors(specialty)
    found = DB.exec("SELECT * FROM specialty WHERE specialty = '#{specialty}'")
    found.each { |sp| @the_id = sp['id'].to_i }
    doctors_with_specialty = DB.exec("SELECT * FROM doctor WHERE specialty_id = #{@the_id}")
    doctors_with_specialty_array = []
    doctors_with_specialty.each do |doctor|
      name = doctor['name']
      insurance_id = doctor['insurance_id'].to_i
      specialty_id = doctor['specialty_id'].to_i
      id = doctor['id'].to_i
      doctors_with_specialty_array << Doctor.new(name, insurance_id, specialty_id, id)
    end
    doctors_with_specialty_array
  end

end
