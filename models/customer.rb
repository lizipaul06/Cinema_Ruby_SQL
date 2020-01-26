require_relative("../db/sql_runner")


class Customer

  attr_accessor :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) returning id"
    values = [@name, @funds]
    customer  = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers"
    customers =  SqlRunner.run(sql)
    result = customers.map {|customer| Customer.new (customer)}
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id= $3"
    values =[@name, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    return SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT * FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    films =  SqlRunner.run(sql, values)
    result = films.map {|film| Film.new (film)}
    return result
  end

# Show which films a customer has booked to see, and see which customers are coming to see one film.

 # def buy_tickets()
 #   sql = "SELECT SUM (films.price) FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
 #     values = [@id]
 #     result = SqlRunner.run(sql, values)
 #     remaining_budget = @funds - result[0]["sum"].to_i
 #   end
 #
 def buy_tickets(film, screening)
 return nil if @funds <= film.price
 return nil if screening.number_of_tickets <= 1
   @funds -= film.price
   screening.number_of_tickets -= 1
  newticket = Ticket.new({'customer_id' => @id , 'screening_id' => screening.id})
    newticket.save
    return @funds
   end


 def number_of_tickets()
   sql = "SELECT COUNT (tickets.customer_id) FROM tickets INNER JOIN customers ON customers.id = tickets.customer_id WHERE customers.id = $1"
   values = [@id]
   result =  SqlRunner.run(sql, values)
   sum = result[0]["count"].to_i
 end







end
