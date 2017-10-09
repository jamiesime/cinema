require_relative 'sql_runner'

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(info)
    @id = info['id'].to_i if ['id']
    @title = info['title']
    @price = info['price']
  end

  def save()
    sql = "INSERT INTO films (title, price)
        VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    result = SqlRunner.run(sql, "save_film", values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM films;'
    values = []
    SqlRunner.run(sql, "del_all_films", values)
    return "All film records deleted."
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_film", values)
    return "Film record deleted."
  end

  def self.list_all()
    sql = "SELECT * FROM films;"
    values = []
    result = SqlRunner.run(sql, "list_all", values)
    return result.map {|movie| Film.new(movie)}
  end

  def find_customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
     WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, "find_customers", values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, "find_film", values)
    return result[0]
  end

  def update()
    sql = "UPDATE films SET (title, price) =
    ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, "update_film", values)
    return "Update successful."
  end


end
