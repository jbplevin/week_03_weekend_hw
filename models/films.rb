require_relative("../db/sql_runner.rb")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize( params )
    @id = params['id'].to_i
    @title = params['title']
    @price = params['price'].to_i
  end

end
