require_relative('../db/sql_runner.rb')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def screenings()
#  SELECT COUNT (screenings.film_id) film_time FROM screenings
#  INNER JOIN tickets
#  ON tickets.screening_id = screenings.id
#  INNER JOIN films
#  ON tickets.film_id = films.id
#  WHERE films.title = 'Trainspotting'
#  GROUP BY screenings.film_time
#  ORDER BY screenings.film_time DESC
    sql = 'SELECT film_time FROM screenings
          INNER JOIN tickets
          ON tickets.screening_id = screenings.id
          INNER JOIN films
          ON tickets.film_id = films.id
          WHERE films.title = $1'
    values = [@title]
    film_times = SqlRunner.run(sql, values)
    num_film_played = film_times.map { |time| Screening.new(time) }
    return num_film_played.length()
  end


  def customers()
    sql = 'SELECT customers.*
          FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1'
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = 'UPDATE films SET price = $1 WHERE id = $2'
    values = [@price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM films WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM films'
    film_hash = SqlRunner.run(sql)
    return film_hash.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def self.find_by_id(film)
    sql = 'SELECT * FROM films WHERE id = $1'
    values = [film.id]
    result = SqlRunner.run(sql, values).first
    return Film.new(result)
  end

  def self.customers_watching_a_movie(film)
    customers_in_movie = film.customers.count()
    return customers_in_movie
  end

end
