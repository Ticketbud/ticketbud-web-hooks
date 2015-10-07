require 'sinatra'
require 'haml'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/mydb")

class Transaction < ActiveRecord::Base
end

get "/" do
  @transactions = Transaction.all
  haml :index
end

post "/add_transaction" do
  request.body.rewind
  json = JSON.parse(request.body.read)

  if json["tickets"]
    puts json["tickets"]

    json["tickets"].each do |ticket|
      Transaction.create({
        first_name: ticket['first_name'],
        last_name: ticket['last_name'],
        email: ticket['email']
      })
    end
    status "200"
    body "OK"
  else
    status "400"
    body "Missing Tickets in Payload"
  end

end
