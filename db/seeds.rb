# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Settings Begin
filesPath = "/home/action/workspace/CSV/"
fileDelete = false
# Settings End
require 'csv'

@commodities = Commodity.all
itemList = CSV.read(filesPath + "ItemList.csv", :headers => true)
if @commodities.size <96
  Commodity.delete_all
  itemList.each do |item|
    Commodity.create( name: item["Name"], code: item["Code"] )
  end
end
puts "Commodities Done"

@countries = Country.all

countryList = CSV.read(filesPath+"/CountryList.csv", :headers => true)
if @countries.size <250
  Country.delete_all
  countryList.each do |country|
    Country.create( name: country["Name"], code: country["Code"])
  end
end
puts "Countries Done"

fileList = Dir.entries(filesPath)
fileList.delete("..")
fileList.delete(".")
fileList.delete("CountryList.csv")
fileList.delete("ItemList.csv")
fileList = fileList.sort
fileCount = fileList.size
doneCount = 1
fileList.each do |file|
  trades = CSV.read(filesPath+file, :headers => true)
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
  fileDelete ? (File.delete(filesPath+file)) : (nil)
  doneCount = doneCount + 1
end
puts "Done"

