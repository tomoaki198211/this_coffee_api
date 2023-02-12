class CoffeeAggregation
  include ActiveModel::Model

  attr_accessor :coffee_id, :store_id, :category_id,
                :property_id, :coffee_name, :size, :price, :note
  validates :coffee_id, :store_id, :category_id, :property_id, :coffee_name, presence: true

  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def save
    coffee_property = CoffeeProperty.new(name: coffee_name,store_id: store_id,
                                         size: size, price: price, note: note)
    coffee_property.save!
    coffee = Coffee.new(coffee_property_id: coffee_property.id, category_id: category_id)
    coffee.save!
  end

  def update
    run_callbacks :save do
      coffee_property = CoffeeProperty.find_by(id: property_id)
      coffee_property.update!(name: coffee_name,store_id: store_id,
                            size: size, price: price, note: note)
      coffee = Coffee.find_by(id:coffee_id)
      coffee.update!(coffee_property_id: property_id, category_id: category_id)
    end
  end
end
