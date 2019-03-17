require_relative('../db/sql_runner.rb')



class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def films()
    sql = 'SELECT films.* FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1'
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def tickets()
    sql = 'SELECT customers.*, films.*, tickets.*
          FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          INNER JOIN films
          ON tickets.film_id = films.id
          WHERE customer_id = $1'
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    customer_tickets = tickets.map { |ticket| Ticket.new(ticket) }
    return customer_tickets.length()
  end

  def buying_tickets(film)
    left_funds = @funds - film.price
    return left_funds
  end

  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = 'UPDATE customers SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM customers'
    customer_hash = SqlRunner.run(sql)
    return customer_hash.map { |customer| Customer.new(customer) }
  end

  def self.delete_all()
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.find_by_id(customer)
    sql = 'SELECT * FROM customers WHERE id = $1'
    values = [customer.id]
    result = SqlRunner.run(sql, values).first
    return Customer.new(result)
  end

end
