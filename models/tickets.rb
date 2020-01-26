require_relative("../db/sql_runner")


class Ticket

  attr_accessor :id, :customer_id, :screening_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id, screening_id, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @screening_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tickets"
    tickets =  SqlRunner.run(sql)
    result = tickets.map {|ticket| Ticket.new (ticket)}
    return result
  end

  def update
    sql = "UPDATE tickets SET (customer_id, screening_id, film_id) = ($1, $2, $3) WHERE id = $3"
    values = [@customer_id, @screening_id, @film_id, @id]
    return  SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    return SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql, values)
  end

end
