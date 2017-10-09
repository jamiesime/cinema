require_relative 'sql_runner.rb'
require_relative 'ticket.rb'
require_relative 'film.rb'

class Screening

  attr_accessor :film, :start_time, :tickets_sold
  attr_reader :id

  def initialize(info)
    @id = info['id'].to_i if ['id']
    @film = info['film']
    @start_time = info['start_time']
    @tickets_sold = info['tickets_sold']
  end

  def save()
    sql = "INSERT INTO screenings (start_time, film, tickets_sold)
        VALUES ($1, $2, $3) RETURNING id;"
    values = [@start_time, @film, @tickets_sold]
    result = SqlRunner.run(sql, "save_screening", values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM screenings;'
    values = []
    SqlRunner.run(sql, "del_all_screenings", values)
    return "All screening records deleted."
  end




end
