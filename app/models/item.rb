class Item < Sequel::Model
  many_to_one :list
  plugin :validation_helpers

  def validate
    super
    validates_presence [:name]
  end

  def before_create
    self.complete = false
  end
end
