require('pry')
require_relative( 'models/customer')
require_relative( 'models/films')
require_relative( 'models/tickets')
require_relative('models/screening')


customer1 = Customer.new({'name' => 'Steve', 'funds' => 300})
customer2 = Customer.new({'name' => 'James', 'funds' => 150})
customer3 = Customer.new({'name' => 'Helen', 'funds' => 200})

customer1.save
customer2.save
customer3.save

customer1.name = 'Frank'
customer1.update

film1 = Film.new({'title' => 'Rocky Horror Show', 'price' => 10})
film2 = Film.new({'title' => 'Notting Hill', 'price' => 5})
film3 = Film.new({'title' => 'La La Land', 'price' => 16})

film1.save
film2.save
film3.save




# ticket1.customer_id = 3
# ticket1.update

screening1 = Screening.new({'time' => '18:00', 'film_id' => 1, 'number_of_tickets' => 5})
screening2 = Screening.new({'time' => '18:00', 'film_id' => 2, 'number_of_tickets' => 5})
screening3 = Screening.new({'time' => '20:00', 'film_id' => 3, 'number_of_tickets' => 10})
screening4 = Screening.new({'time' => '18:00', 'film_id' => 3, 'number_of_tickets' => 10})

screening1.save
screening2.save
screening3.save
screening4.save

ticket1 = Ticket.new({'customer_id' => 1 , 'screening_id' => 1, 'film_id' => 1})
ticket2 = Ticket.new({'customer_id' => 2, 'screening_id' => 2, 'film_id' => 2})
ticket3 = Ticket.new({'customer_id' => 3, 'screening_id' => 3, 'film_id' => 3})
ticket4 = Ticket.new({'customer_id' => 1 , 'screening_id' => 3, 'film_id' => 3})
ticket5 = Ticket.new({'customer_id' => 1 , 'screening_id' => 4, 'film_id' => 3})



ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

binding.pry

nil
