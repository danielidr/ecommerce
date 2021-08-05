# Diagrama de modelos:

![Models Diagram](https://drive.google.com/file/d/18rjQiJGw0pMsg8xah7jWfh5vOfTLy3x3/view?usp=sharing)

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