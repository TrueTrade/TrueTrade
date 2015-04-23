class CollageController < ApplicationController
  def index
    #    Graph 1 : top commodity graph
    @temp = top5commoditiesForACountry
    @topCommVol = @temp[0].values
    @topCommName = @temp[1]
  
    @data_doughnut =[
    {
        value: @topCommVol[0],
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: @topCommName[0]
    },
    {
        value: @topCommVol[1],
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: @topCommName[1]
    },
    {
        value: @topCommVol[2],
        color: "#FDB45C",
        highlight: "#FFC870",
        label: @topCommName[2]
    },
        {
        value: @topCommVol[3],
        color: "#46BFBD",
        highlight: "#A9ADAF",
        label: @topCommName[3]
    },
    {
        value: @topCommVol[4],
        color: "#FDB45C",
        highlight: "#0099FF",
        label: @topCommName[4]
    }
    ]
    @options_doughnut = {width: 600, height: 600}
 

    #    Graph 2 : top partner graph
    @temp1 = top5partnersForACountry
    @topPartnersVols = @temp1[0].values
    @topPartnerName = @temp1[1]
    @data_polar =[
    {
        value: @topPartnersVols[0],
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: @topPartnerName[0]
    },
    {
        value: @topPartnersVols[1],
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: @topPartnerName[1]
    },
    {
        value: @topPartnersVols[2],
        color: "#FDB45C",
        highlight: "#FFC870",
        label: @topPartnerName[2]
    },
        {
        value: @topPartnersVols[3],
        color: "#46BFBD",
        highlight: "#A9ADAF",
        label: @topPartnerName[3]
    },
    {
        value: @topPartnersVols[4],
        color: "#FDB45C",
        highlight: "#0099FF",
        label: @topPartnerName[4]
    }
    ]
    @options_polar = {width: 600, height: 600}
    

    
#      #    Graph 3 : commodity trend by year
#     @commodityTrendHash = commodityTrendForACountry[0]
#     @commName = commodityTrendForACountry[1]
#     @commodityTrendChart = LazyHighCharts::HighChart.new('graph') do |f|
#       f.title(:text => "Commodity trend by year " + Country.find(params[:country]).name + " from "+ params[:start_year] + " to "+ params[:end_year])
#       f.xAxis(:categories => @commodityTrendHash.keys)
#       f.series(:name => "Traded Value", :yAxis => 0, :data => @commodityTrendHash.values)
#        f.yAxis [{:title => {:text => "Traded Amount (in USD)", :margin => 70} }]
#        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
#        f.chart({:defaultSeriesType=>"column"})
#     end
    
    
  end
  
  
#**************************************************************************************
# Top 5 commodities for a given country
#**************************************************************************************

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

#**************************************************************************************
# Top 5 partner countries for a given country
#**************************************************************************************

  private
  def top5partnersForACountry
  @all_partners = Trade.where(exporter_code: params[:country], year: params[:start_year]..params[:end_year]).group(:importer_code).sum(:volume)
    @partners_list = {}     
    @all_partners.each do |importer_code, sum_volume|
      @partners_list[importer_code] = sum_volume
    end
    
    @partners_list_sorted = @partners_list.sort_by{ |importer_code, sum_volume| sum_volume }.reverse
    
    @top5PartnerArray = @partners_list_sorted.first 5
    @top5PartnerHash = Hash[*@top5PartnerArray.flatten]
  
    @top5PartnerHashKeys = @top5PartnerHash.keys
    @partnerNameList =[]
    @top5PartnerHashKeys.each do |partnerKey|
      @partnerNameList << Country.find(partnerKey).name
    end
    
    
    return @top5PartnerHash, @partnerNameList
    
  end
  
#**************************************************************************************
# Commodity trend for a given country (for given years)
#**************************************************************************************

  private
  def commodityTrendForACountry
    
    #     ---- need commodity code param ------
    @commodity_trend = Trade.where(exporter_code: params[:country], commodity_code: 24, year: params[:start_year]..params[:end_year] ).group(:year).sum(:volume)
    
    @commodity_trend_sorted = @commodity_trend.sort_by{ |year, sum_volume| year }
     #     ---- need commodity code param ------
    @commName = Commodity.find(24).name

    return @commodity_trend, @commName
    
  end
  
 
end
