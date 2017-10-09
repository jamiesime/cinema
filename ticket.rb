require_relative 'sql_runner'

class Ticket

  attr_accessor :film_id, :customer_id
  attr_reader :id

  def initialize(info)
    @id = info['id'].to_i if ['id']
    @customer_id = info['customer_id']
    @film_id = info['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
        VALUES ($1, $2) RETURNING id;"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, "save_booking", values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets;'
    values = []
    SqlRunner.run(sql, "del_all_tickets", values)
    return "All ticket records deleted."
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_ticket", values)
    return "Ticket record deleted."
  end

  def self.list_all()
    sql = "SELECT * FROM tickets;"
    values = []
    result = SqlRunner.run(sql, "list_all", values)
    return result.map {|ticket| Ticket.new(ticket)}
  end

  def find_customers()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    result = SqlRunner.run(sql, "find_customers", values)
    return result[0]
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, "find_booking", values)
    return result[0]
  end

  def update()
    sql = "UPDATE tickets SET (film_id, customer_id) =
    ($1, $2) WHERE id = $3"
    values = [@film_id, @customer_id, @id]
    SqlRunner.run(sql, "update_booking", values)
    return "Update successful."
  end

end
