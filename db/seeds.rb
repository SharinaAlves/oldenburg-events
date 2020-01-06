puts "delete"

Category.delete_all

puts "create"

Category.create(name: "Alle Veranstaltungen", image: "category-img/allevents.jpeg")
Category.create(name: "Nachtleben", image: "category-img/party.jpeg")
Category.create(name: "Filme", image: "category-img/cinema.jpeg")
Category.create(name: "Märkte", image: "category-img/market.jpeg")
Category.create(name: "Vorträge", image: "category-img/speech.jpeg")
Category.create(name: "Ausstellungen", image: "category-img/exhibition.jpeg")
Category.create(name: "Bühne", image: "category-img/theater.jpeg")
Category.create(name: "Konzerte", image: "category-img/concert.jpeg")

puts "done"
