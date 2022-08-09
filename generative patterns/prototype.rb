# https://medium.com/@dljerome/design-patterns-in-ruby-prototype-342cb26ea75
# Прототип — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации.

class Product
  # ...
  def _clone(product_definition)
    Product.new(
      self.product_definition_name(product_definition),
      self.properties,
      self.active?,
      self.category
    )
  end
end

product_prototype = Product.new
product_instance_a = product_prototype._clone("Telescope")
product_instance_b = product_prototype._clone("Light Saber")
