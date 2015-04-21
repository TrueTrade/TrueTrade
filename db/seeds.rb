# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'


itemList = CSV.read("/home/ahuja/Desktop/CSV/ItemList.csv", :headers => true)
itemList.each do |item|
  Commodity.create( name: item["Name"], code: item["Code"] )
end

puts "Commodities Done"

countryList = CSV.read("/home/ahuja/Desktop/CSV/CountryList.csv", :headers => true)
countryList.each do |country|
  Country.create( name: country["Name"], code: country["Code"])
end
puts "Countries Done"

fileList = Dir.entries("/home/ahuja/Desktop/CSV")
fileList.delete("..")
fileList.delete(".")
fileList.delete("CountryList.csv")
fileList.delete("ItemList.csv")
fileList = fileList.sort
fileCount = fileList.size
doneCount = 1
fileList.each do |file|
  trades = CSV.read("/home/ahuja/Desktop/CSV/"+file, :headers => true)
columns = [ :year, :exporter_code, :importer_code, :commodity_code, :volume ]
  if trades.length() > 1
    values = []
    puts "Starting file " + file
    trades.each do |trade|
      if countryList["Code"].include?(trade["Reporter Code"]) && countryList["Code"].include?(trade["Partner Code"]) && trade["Trade Flow"] == "Export"
	values.push [trade["Year"],trade["Reporter Code"], trade["Partner Code"],trade["Commodity Code"],trade["Trade Value (US$)"]]
      end
    end
Trade.import columns, values, :validate => false
   #puts "Finished file " + file
  else
    puts "Skipping file " + file 
  end
  puts "Finished " + doneCount.to_s + "/"+ fileCount.to_s + " files"
  doneCount = doneCount + 1
end
puts "Done"

