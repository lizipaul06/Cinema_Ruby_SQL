require_relative("../db/sql_runner.rb")

class Film

attr_accessor :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    films =  SqlRunner.run(sql)
    result = films.map {|film| Film.new (film)}
    return result
  end

  def update
    sql = "UPDATE films SET (title, price ) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    return  SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    return SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customers =  SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new (customer)}
    return result
  end

  # def number_of_tickets()
  #   sql = "SELECT COUNT (tickets.customer_id) FROM tickets INNER JOIN customers ON customers.id = tickets.customer_id WHERE customers.id = $1"
  #   values = [@id]
  #   result =  SqlRunner.run(sql, values)
  #   sum = result[0]["count"].to_i
  # end

  def number_of_customers()
    sql = "SELECT COUNT (*) FROM tickets INNER JOIN screenings ON tickets.screening_id = screenings.id WHERE film_id = $1"
    values = [@id]
    result =  SqlRunner.run(sql, values)
    sum = result[0]["count"].to_i
  end



def most_pop_screening
   sql = "SELECT screenings.time FROM screenings INNER JOIN tickets
   ON tickets.screening_id = screenings.id WHERE tickets.film_id = $1
   GROUP BY screenings.time
   ORDER BY COUNT(*) DESC LIMIT 1"
   values = [@id]
   screenings =  SqlRunner.run(sql, values)
     result = screenings.map {|screening| screening["time"] }
 end
end
