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
end
