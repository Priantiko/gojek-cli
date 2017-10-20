# TODO: Complete Order class
require 'json'

module GoCLI
  class Order
    attr_accessor :des_user, :place_user, :timestamp, :price

    def initialize(opts = { })
      @des_user = opts[:des_user]
      @place_user = opts[:place_user]
      @timestamp = opts[:timestamp]
      @price = opts[:price]
    end

    def self.load_all
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      data = JSON.parse(file)

     #  arr = []
     #  data.each { |x| arr << Order.new(
     #    des_user: x['des_user'],
     #    place_user: x['place_user'],
     #    price: x['price']
     #  )}
     # print arr
     data
    end
    # # TODO: Add your validation method her

    def save!
      order_all = Order.load_all
      # order_all << 
      # TODO: Add validation before writing user data to file
       order = {des_user: @des_user, place_user: @place_user, timestamp: Time.new, price: @price}
       order_all << order
      File.open("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json", "w") do |f|
        f.write JSON.generate(order_all)
      end
    end
  end
end

