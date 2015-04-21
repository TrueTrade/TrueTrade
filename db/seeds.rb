# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
itemList = CSV.read("./CSV/ItemList.csv", :headers => true)
itemList.each do |item|
  Commodity.create( name: item["Name"], code: item["Code"] )
end

puts "Commodities Done"

countryList = CSV.read("./CSV/CountryList.csv", :headers => true)
countryList.each do |country|
  Country.create( name: country["Name"], code: country["Code"])
end
puts "Countries Done"

fileList = Dir.entries("./CSV")
fileList.delete("..")
fileList.delete(".")
fileList.delete("CountryList.csv")
fileList.delete("ItemList.csv")
fileList = fileList.sort

fileList.each do |file|
  trades = CSV.read("./CSV/"+file, :headers => true)
  if trades.length() > 1
    puts "Starting file " + file
    trades.each do |trade|
      if countryList["Code"].include?(trade["Reporter Code"]) && countryList["Code"].include?(trade["Partner Code"]) && trade["Trade Flow"] == "Export"
        Trade.create( year: trade["Year"], exporter_code: trade["Reporter Code"], importer_code: trade["Partner Code"], commodity_code: trade["Commodity Code"],volume: trade["Trade Value (US$)"] )
      end
    end
   #puts "Finished file " + file
  else
    puts "Skipping file " + file 
  end
end
puts "Done"


