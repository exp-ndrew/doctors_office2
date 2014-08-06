class Patient

  attr_accessor :name, :date_of_birth, :insurance_id

  def initialize(name, date_of_birth, insurance_id)
    @name = name
    @date_of_birth = date_of_birth
    @insurance_id = insurance_id
  end

end
