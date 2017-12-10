require_relative("./models/tickets.rb")
require_relative("./models/films.rb")
require_relative("./models/customers.rb")
require("pry-byebug")

Customer.delete_all
Ticket.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Alex',
  'funds' => '1000'
  })
customer1.save

binding.pry
nil
