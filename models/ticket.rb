require_relative("../db/sql_runner.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @customer_id = params['customer_id'].to_i
    @film_id = params['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ($1, $2)
           RETURNING id"
    values = [@customer_id, @film_id]
    ticket_hash = SqlRunner.run(sql, values)[0]
    @id = ticket_hash['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_hashes = SqlRunner.run(sql)
    return map_items(ticket_hashes)
  end

  def update()
    sql = "UPPDATE tickets
           SET (@customer_id, @film_id) = ($1, $2)
           WHERE @id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
    return "Ticket #{@id} updated."
  end

  def delete()
    sql = "DELETE FROM tickets WHERE @id = $1"
    SqlRunner.run(sql, [@id])

  end

  def delete_all()
    sql = "DELETE * FROM tickets"
    SqlRunner.run(sql)
  end


end
