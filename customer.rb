require_relative 'sql_runner.rb'
require_relative 'ticket.rb'

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(info)
    @id = info['id'].to_i if ['id']
    @name = info['name']
    @funds = info['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
        VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    result = SqlRunner.run(sql, "save_customer", values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM customers;'
    values = []
    SqlRunner.run(sql, "del_all_customers", values)
    return "All customer records deleted."
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_customer", values)
    return "Customer record deleted."
  end

  def self.list_all()
    sql = "SELECT * FROM customers;"
    values = []
    result = SqlRunner.run(sql, "list_all", values)
    return result.map {|person| Customer.new(person)}
  end

  def find_tickets()
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN films ON tickets.film_id = films.id WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, "find_tickets", values)
    return tickets.map {|tick| Ticket.new(tick)}
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, "find_customer", values)
    return result[0]
  end

  def update()
    sql = "UPDATE customers SET (name, funds) =
    ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, "update_customer", values)
    return "Update successful."
  end

  def count_tickets()
    sql = "SELECT tickets COUNT FROM tickets WHERE
    customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, "count_tickets", values)
    return result[0].length
  end



end
