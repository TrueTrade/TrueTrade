# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
itemList = CSV.read("./CSV/ItemList.csv", :headers => true)
itemList.each do |code, name|
  Commodity.create( name: name, code: code )
end
puts "Commodities Done"

countryList = CSV.read("./CSV/CountryList.csv", :headers => true)
countryList.each do |code, name|
  Country.create( name: name, code: code)
end
puts "Countries Done"

fileList = Dir.entries("./CSV")
fileList.delete("..")
fileList.delete(".")
fileList.delete("CountryList.csv")
fileList.delete("ItemCodes.csv")


#Trade_List.each do |year, exporter_code, importer_code, commodity_code,volume|
#  Trade.create( year: year, exporter_code: exporter_code, importer_code: importer_code, commodity_code: commodity_code,volume: volume )
#end
