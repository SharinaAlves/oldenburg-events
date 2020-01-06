puts "delete"

Category.delete_all

puts "create"

Category.create(name: "Alle Veranstaltungen", image: "category-img/allevents.jpg")
Category.create(name: "Nachtleben", image: "category-img/party.jpg")
Category.create(name: "Filme", image: "category-img/cinema.jpg")
Category.create(name: "Märkte", image: "category-img/market.jpg")
Category.create(name: "Vorträge", image: "category-img/speech.jpg")
Category.create(name: "Ausstellungen", image: "category-img/exhibition.jpg")
Category.create(name: "Bühne", image: "category-img/theater.jpg")
Category.create(name: "Konzerte", image: "category-img/concert.jpg")

puts "done"
