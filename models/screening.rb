class Screening
 def initialize(options)
   @time (option) = ['time']
   @film_id(option)['film_id'].to_i
   @ticket_id(option)['ticket_id'].to_i
   @number_of_tickets (options) ['number_of_tickets'].to_i
 end


 def save
   sql = "INSERT INTO films (title, film_id, ticket_id, number_of_tickets) VALUES ($1, $2, $3, $4) RETURNING id"
   values = [@title, @film_id, @ticket_id, @number_of_tickets]
   film = SqlRunner.run(sql, values).first
   @id = screening['id'].to_i
 end

 def self.all
   sql = "SELECT * FROM screenings"
   screenings =  SqlRunner.run(sql)
   result = screenings.map {|screening| Screening.new (film)}
   return result
 end

end
