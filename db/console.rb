require('pry')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../models/screening.rb')


Ticket.delete_all()
Customer.delete_all()
Film.delete_all()
Screening.delete_all()

customer1 = Customer.new({ 'name' => 'Jacob', 'funds' => 20 })
customer1.save()

customer2 = Customer.new({ 'name' => 'Abigail', 'funds' => 35 })
customer2.save()

customer3 = Customer.new({ 'name' => 'William', 'funds' => 30 })
customer3.save()

customer4 = Customer.new({ 'name' => 'Joseph', 'funds' => 15 })
customer4.save()

customer5 = Customer.new({ 'name' => 'Ryan', 'funds' => 25 })
customer5.save()


film1 = Film.new({ 'title' => 'Arrival', 'price' => 7 })
film1.save()

film2 = Film.new({ 'title' => 'Star Wars: The Last Jedi', 'price' => 9})
film2.save()

film3 = Film.new({ 'title' => 'Trainspotting', 'price' => 10})
film3.save()


screening1 = Screening.new({ 'film_id' => film1.id, 'film_time' => '17:45:00' })
screening1.save()

screening2 = Screening.new({ 'film_id' => film1.id, 'film_time' => '18:45:00' })
screening2.save()

screening3 = Screening.new({ 'film_id' => film3.id, 'film_time' => '20:40:00' })
screening3.save()

screening4 = Screening.new({ 'film_id' => film3.id, 'film_time' => '22:30:00' })
screening4.save()

screening5 = Screening.new({ 'film_id' => film2.id, 'film_time' => '16:00:00' })
screening5.save()



ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id })
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id, 'screening_id' => screening1.id })
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id, 'screening_id' => screening2.id })
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film3.id, 'screening_id' => screening4.id })
ticket4.save()

ticket5 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film3.id, 'screening_id' => screening4.id })
ticket5.save()

ticket6 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id, 'screening_id' => screening4.id})
ticket6.save()

ticket7 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening5.id })
ticket7.save()

ticket8 = Ticket.new({ 'customer_id' => customer5.id, 'film_id' => film3.id, 'screening_id' => screening3.id })
ticket8.save()


customer3.name = 'Guillermo'
customer3.update()

film1.price = 10
film1.update()

screening3.film_time = '19:45:00'
screening3.update()

# ticket4.film_id = film1.id
# ticket4.update()


binding.pry
nil
