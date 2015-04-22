class CollageController < ApplicationController
  def index
    @top5 = first5countries
    @topcommoditiesForACountry = top5commoditiesForACountry[0]
    @topCommName = top5commoditiesForACountry[1]
     @top5CommChart = LazyHighCharts::HighChart.new('graph') do |f|
       f.title(:text => "Top 5 commodies traded for " + Country.find(params[:country]).name + " from "+ params[:start_year] + " to "+ params[:end_year])
#    f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
       f.xAxis(:categories => @topCommName)

#   f.series(:name => "GDP in Billions", :yAxis => 0, :data => [1520, 5068, 4985, 3339, 2656])
       f.series(:name => "Exports", :yAxis => 0, :data => @topcommoditiesForACountry.values)
#   f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  f.yAxis [
    {:title => {:text => "Traded Amount (in USD)", :margin => 70} }
#     {:title => {:text => "Population in Millions"}, :opposite => true},
  ]

  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  f.chart({:defaultSeriesType=>"column"})
     end
   # 
  end
  
  private
  def first5countries
    @countries = Country.select(:name).limit(5)
    @countries_list = []       
    @countries.each do |country|
      @countries_list.push(country.name)
    end
    return @countries_list
    
  end
  
#   Trade.where(importer_code: 4, year:1996..1997).group(:commodity_code).sum(:volume)
  private
  def top5commoditiesForACountry
    @all_commodities = Trade.where(exporter_code: params[:country], year: params[:start_year]..params[:end_year]).group(:commodity_code).sum(:volume)
    @commodities_list = {}     
    @all_commodities.each do |commodity_code, sum_volume|
      @commodities_list[commodity_code] = sum_volume
    end
    
    @commodities_list_sorted = @commodities_list.sort_by{ |commodity_code, sum_volume| sum_volume }.reverse
    
    @top5CommArray = @commodities_list_sorted.first 5
    @top5CommHash = Hash[*@top5CommArray.flatten]
  
    @top5CommHashKeys = @top5CommHash.keys
    @commNameList =[]
    @top5CommHashKeys.each do |commKey|
      @commNameList << Commodity.find(commKey).name
    end
    
    
    return @top5CommHash, @commNameList
    
  end
  
  #  Trade.where(importer_code: 4, year:1996..1997).group(:commodity_code).sum(:volume)

  
end
