# Diagrama de modelos:

![GitHub Logo](/app/assets/images/Desafio_e-commerce.jpg)

# Crear productos en el catalogo:

## 1.- Crear producto
```ruby
    p = Product.create(name: "Adidas Superstart", description: "The old school sneakers", stock: 13, price: 60, sku: "ASS090")
```

## 2.- Crear variación
```ruby
    v = Variation.create(size: "42", color: "black")
```

## 3.- Asignarle la variación al producto y el stock de la variación
```ruby
    ProductsVariation.create(product_id: p.id, variation_id: v.id, stock: 5)
```

## 4.- Para ver una variación del productos o si no hay stock

###     Implementar método en el modelo product:

Este método busca todas las variantes del producto y si consigue al menos uno con stock lo retorna, si no tiene variantes entonces retorna "The product doesnt have any variants" y si tiene variantes sin stock entonces retorna "Out of stock".

```ruby
    def show_variant
        if not products_variations.blank?
            products_variations.each do |products_variation|
                if products_variation.stock > 0
                return products_variation
                end
            end
        else
            return "The product doesnt have any variants"
        end
        "Out of stock"
    end
```

###     Utilizar método:

```ruby
    p.show_variant
```

# Modelo OrderItem:

Se reemplaza el atributo product_id que hacia referencia a la tabla producto y en su lugar se crea products_variation_id que hace referencia a la tabla products_variation, y en donde a su vez contiene el product_id, para poder mostrar las variantes de los productos en las ordenes y en caso que un cliente quiera cambiar una orden por la talla o el color, saber cual fue el que compró.

```ruby
class OrderItem < ApplicationRecord
  belongs_to :products_variation
  belongs_to :order
end

class ProductsVariation < ApplicationRecord
  belongs_to :product
  belongs_to :variation
  has_many :order_items
  has_many :orders, through: :order_items
end

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products_variations, through: :order_items
  has_many :payments
end
```

