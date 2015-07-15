class List < Sequel::Model
  one_to_many :items
  plugin :validation_helpers

  def validate
    super
    validates_presence [:name]
  end
end
