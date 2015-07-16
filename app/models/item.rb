class Item < Sequel::Model
  many_to_one :list
  plugin :validation_helpers

  set_allowed_columns :name, :complete

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
