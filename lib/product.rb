class Product
  attr_accessor :id, :name, :quantity

  def attributes
    { id: id, name: name, quantity: quantity }
  end
end
