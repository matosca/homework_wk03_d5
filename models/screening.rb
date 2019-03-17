require_relative('../db/sql_runner.rb')


class Screening

  attr_reader :id
  attr_accessor :film_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @film_time = options['film_time']
  end

  def save()
    sql = 'INSERT INTO screenings (film_id, film_time) VALUES ($1, $2) RETURNING id'
    values = [@film_id, @film_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = 'UPDATE screenings SET film_time = $1 WHERE id = $2'
    values = [@film_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM screenings WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM screenings'
    screening_hash = SqlRunner.run(sql)
    return screening_hash.map { |screening| Screening.new(screening) }
  end

  def self.delete_all()
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end

  def self.find_by_id(screening)
    sql = 'SELECT * FROM screenings WHERE id = $1'
    values = [screening.id]
    result = SqlRunner.run(sql, values).first
    return Screening.new(result)
  end

end
