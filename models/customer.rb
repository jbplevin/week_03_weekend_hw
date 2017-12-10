require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @funds = params['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
           VALUES ($1, $2)
           RETURNING id"
    values = [@name, @funds]
    customer_hash = SqlRunner.run(sql, values)[0]
    @id = customer_hash['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_hashes = SqlRunner.run(sql)
    return map_items(customer_hashes)
  end

  def update()
    sql = "UPPDATE customers
           SET (@name, @funds) = ($1, $2)
           WHERE @id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
    return "Customer #{@id} updated."
  end

  def delete()
    sql = "DELETE FROM customers WHERE @id = $1"
    SqlRunner.run(sql, [@id])
  end

  def delete_all()
    sql = "DELETE * FROM customers"
    SqlRunner.run(sql)
  end

end
