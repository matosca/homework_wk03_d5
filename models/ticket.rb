require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require_relative('./film.rb')
require_relative('./screening.rb')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id'
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = 'UPDATE tickets SET film_id = $1 WHERE id = $2'
    values = [@film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.limited_tickets_for_film(film, customer)
    if customer.buying_tickets(film) && film.screenings >=2
    return "Sold Out"
    else
    return "Enjoy movie"
  end
  end

  def self.all()
    sql = 'SELECT * FROM tickets'
    ticket_hash = SqlRunner.run(sql)
    return ticket_hash.map { |ticket| Ticket.new(ticket) }
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def self.find_by_id(ticket)
    sql = 'SELECT * FROM tickets WHERE id = $1'
    values = [ticket.id]
    result = SqlRunner.run(sql, values).first
    return Ticket.new(result)
  end

end
