require_relative("../db/sql_runner.rb")

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize( params )
  @id = params['id'].to_i
  @name = params['name']
  @funds = params['funds'].to_i
end

end
