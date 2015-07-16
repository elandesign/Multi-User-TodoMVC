class List < Sequel::Model
  one_to_many :items
  plugin :validation_helpers

  set_allowed_columns :name

  def validate
    super
    validates_presence [:name]
  end

  def to_hash
    values
  end

  def to_json
    to_hash.to_json
  end
end
