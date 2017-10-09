require 'pry'
require_relative 'customer'
require_relative 'film'
require_relative 'ticket'

Ticket.delete_all() if (Ticket)
Customer.delete_all() if (Customer)
Film.delete_all() if (Film)


customer1 = Customer.new({
  'name' => 'Roberto',
  'funds' => 50
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Caroline',
  'funds' => 100
  })
customer2.save()

film1 = Film.new({
  'title' => 'It Follows',
  'price' => 10
  })
film1.save()

film2 = Film.new({
  'title' => 'Drive',
  'price' => 8
  })
film2.save()

booking1 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film1.id()
  })
booking1.save()

booking2 = Ticket.new({
  'customer_id' => customer2.id(),
  'film_id' => film1.id()
  })
booking2.save()

booking3 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film2.id()
  })
booking3.save()

customer1.buy_ticket(film2)

binding.pry
nil
