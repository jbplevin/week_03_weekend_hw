require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( params )
    @id = params['id'].to_i
    @title = params['title']
    @price = params['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
           VALUES ($1, $2)
           RETURNING id"
    values = [@title, @price]
    film_hash = SqlRunner.run(sql, values)[0]
    @id = film_hash['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_hashes = SqlRunner.run(sql)
    return map_items(film_hashes)
  end

  def update()
    sql = "UPPDATE films
           SET (@title, @price) = ($1, $2)
           WHERE @id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
    return "Film #{@id} updated."
  end

  def delete()
    sql = "DELETE FROM films WHERE @id = $1"
    SqlRunner.run(sql, [@id])

  end

  def delete_all()
    sql = "DELETE * FROM films"
    SqlRunner.run(sql)
  end

end
