require_relative("../db/sql_runner.rb")

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( params )
    @id = params['id'].to_i
    @customer_id = params['customer_id'].to_i
    @film_id = params['film_id'].to_i
  end
end
