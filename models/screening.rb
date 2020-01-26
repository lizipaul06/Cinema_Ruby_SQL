require_relative("../db/sql_runner.rb")

class Screening

  attr_accessor :time, :film_id, :number_of_tickets, :id

 def initialize(options)
   @id = options['id'].to_i if options ['id']
   @time = options['time']
   @film_id = options['film_id'].to_i
   @number_of_tickets = options['number_of_tickets'].to_i
 end

 def save
   sql = "INSERT INTO screenings (time, film_id, number_of_tickets) VALUES ($1, $2, $3) RETURNING id"
   values = [@time, @film_id, @number_of_tickets]
   screening = SqlRunner.run(sql, values).first
   @id = screening['id'].to_i
 end

 def self.all
   sql = "SELECT * FROM screenings"
   screenings =  SqlRunner.run(sql)
   result = screenings.map {|screening| Screening.new (screening)}
   return result
 end

 

end
