class Product
  attr_accessor :id, :name, :quantity, :document_id

  def initialize(id:, name:, quantity:, document_id: nil)
    self.id = id
    self.name = name
    self.quantity = quantity
    self.document_id = document_id
  end

  def attributes
    { id: id, name: name, quantity: quantity }
  end
end
