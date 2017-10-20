# TODO: Complete Location class
require 'json'

module GoCLI
  class Location
    attr_accessor = :place_user, :des_user

    def initialize(opts={})
      @place_user = opts[:place_user]
      @des_user = opts[:des_user]
    end

    def self.load
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/locations.json")
      data = JSON.parse(file)
    end

  end
end



# Memasukan input dari user
# Input dari user akan di baca didalam json untuk mengambil value koordinat
# dan membandingkan masukan user dari View.Gojek ke dalam file json
# Jika tidak ada maka masuk ke tampilan review
#