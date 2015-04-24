class CommoditiesController < ApplicationController
  def new
  @commodity = Commodity.new
  end

  def index
    @commodities = Commodity.all
  end

  def show
    @commodity = Commodity.find(params[:id])
    commodity_details_OCY1Y2
    
    @displayTableExports = []
    @commodity_exports.each do |year, volume|
      @displayTableExports << [year , volume]
    end
    
    @displayTableImports = []
    @commodity_imports.each do |year, volume|
    @displayTableImports << [year , volume]
    end
    
   
    @data = {
      labels: @displayTableExports.map { |row| row[0]} ,
      datasets: [
        {
          label: "My First dataset",
          fillColor: "rgba(31,181,172,0.2)",
          strokeColor: "rgba(31,181,172,1)",
          pointColor: "rgba(31,181,172,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(31,181,172,1)",
          data: @displayTableExports.map { |row| row[1]/10000}
          },
        {
          label: "My Second dataset",
          fillColor: "rgba(250,133,100,0.2)",
          strokeColor: "rgba(250,133,100,1)",
          pointColor: "rgba(250,133,100,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(250,133,100,1)",
          data: @displayTableImports.map { |row| row[1]/10000}
          }
        ]
      }
    @options = {width: 1100, height: 500}
    
  end

  def year
    @commodity = Commodity.find(params[:id])
    commodity_details_OY
    
#*******************************
#     Top 5 exporter countries chart
#*******************************
    @topCountryVol = @top5ExportersHash.values
    @topCountryName = @EcountriesNameList
  
    @data_doughnutE =[
    {
        value: @topCountryVol[0],
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: @topCountryName[0]
    },
    {
        value: @topCountryVol[1],
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: @topCountryName[1]
    },
    {
        value: @topCountryVol[2],
        color: "#FDB45C",
        highlight: "#FFC870",
        label: @topCountryName[2]
    },
        {
        value: @topCountryVol[3],
        color: "#46BFBD",
        highlight: "#A9ADAF",
        label: @topCountryName[3]
    },
    {
        value: @topCountryVol[4],
        color: "#FDB45C",
        highlight: "#0099FF",
        label: @topCountryName[4]
    }
    ]
    @options_doughnutE = {width: 400, height: 400} 
    
    
    
    
#*******************************
    #     Top 5 importers countries chart
#*******************************
    
    @topCountryVolI = @top5ImportersHash.values
    @topCountryNameI = @IcountriesNameList
  
    @data_doughnutI =[
    {
        value: @topCountryVolI[0],
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: @topCountryNameI[0]
    },
    {
        value: @topCountryVolI[1],
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: @topCountryNameI[1]
    },
    {
        value: @topCountryVolI[2],
        color: "#FDB45C",
        highlight: "#FFC870",
        label: @topCountryNameI[2]
    },
        {
        value: @topCountryVolI[3],
        color: "#46BFBD",
        highlight: "#A9ADAF",
        label: @topCountryNameI[3]
    },
    {
        value: @topCountryVolI[4],
        color: "#FDB45C",
        highlight: "#0099FF",
        label: @topCountryNameI[4]
    }
    ]
    @options_doughnutI = {width: 400, height: 400} 
    
  end 
  
  def partner
    @commodity = Commodity.find(params[:id])
    commodity_details_OC1C2
    
    @data_oc1c2 = {
      labels: @commodityExports_OC1C2.keys,
      datasets: [
        {
          label: "My First dataset",
          fillColor: "rgba(31,181,172,0.2)",
          strokeColor: "rgba(31,181,172,1)",
          pointColor: "rgba(31,181,172,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(31,181,172,1)",
          data: @commodityExports_OC1C2.values
          },
        {
          label: "My Second dataset",
          fillColor: "rgba(250,133,100,0.2)",
          strokeColor: "rgba(250,133,100,1)",
          pointColor: "rgba(250,133,100,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(250,133,100,1)",
          data: @commodityImports_OC1C2.values
          }
        ]
      }
    @options_oc1c2 = {width: 600, height: 600}
    
  end
  
  
  
  def edit
    @commodity = Commodity.find(params[:id])
  end

  def update
    @commodity = Commodity.find(params[:id])
    if @commodity.update_attributes(commodity_params)
      redirect_to(:action => 'show', :id => @commodity.code)
    else 
    render('index')
    end
  end

  def create 
    @commodity = Commodity.new(commodity_params)
   if @commodity.update_attributes(commodity_params)
     redirect_to(:action => 'show', :id => @commodity.code)
   else 
     render('index')
   end 
  end

  def delete
    @commodity = Commodity.find(params[:id])
    @commodity.destroy
    redirect_to(:action => 'index')
  end

  def destroy 
    Commodity.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  private 
  def commodity_params
    params.require(:commodity).permit(:code, :name)
  end
  
  private 
  def commodity_details_O
       @trade_commodity_ALL = Trade.where(commodity_code: params[:id]).group(:year).sum(:volume)
  end
  
  private
  def commodity_details_OY
    @trade_countriesE = Trade.where(commodity_code: params[:id]).group(:exporter_code).sum(:volume)
    @trade_countriesI = Trade.where(commodity_code: params[:id]).group(:importer_code).sum(:volume)
    @ECountries_list = {}
    @trade_countriesE.each do |exporter_code, sum_volume|
      @ECountries_list[exporter_code] = sum_volume
    end
    @ECountries_list_sorted= @ECountries_list.sort_by{ |exporter_code, sum_volume| sum_volume }.reverse   
    @top5ExportersArray = @ECountries_list_sorted.first 5
    @top5ExportersHash = Hash[*@top5ExportersArray.flatten]
    @top5ExportersHashKeys = @top5ExportersHash.keys
    @EcountriesNameList =[]
    @top5ExportersHashKeys.each do |country_code|
      @EcountriesNameList << Country.find(country_code).name
    end

    @ICountries_list={}
     @trade_countriesI.each do |importer_code, sum_volume|
      @ICountries_list[importer_code] = sum_volume
    end 
    @ICountries_list_sorted= @ICountries_list.sort_by{ |importer_code, sum_volume| sum_volume }.reverse
    @top5ImportersArray = @ICountries_list_sorted.first 5
    @top5ImportersHash = Hash[*@top5ImportersArray.flatten]
    @top5ImportersHashKeys = @top5ImportersHash.keys
    @IcountriesNameList =[]
    @top5ImportersHashKeys.each do |country_code|
      @IcountriesNameList << Country.find(country_code).name
    end
  end

  private 
  def commodity_details_OC
    @commodityExports_country = Trade.where(commodity_code: params[:id], exporter_code: params[:exporter_code]).group(:year).sum(:volume)
    @commodityImports_country = Trade.where(commodity_code: params[:id], importer_code: params[:importer_code]).group(:year).sum(:volume)
  end
  
  private 
  def commodity_details_OCY
    @commodityExports_OCY = Trade.where(commodity_code: params[:id], exporter_code: params[:country_code], year: params[:year]).group(:year).sum(:volume).first 5
    @commodityImports_OCY = Trade.where(commodity_code: params[:id], importer_code: params[:country_code], year: params[:year]).group(:year).sum(:volume).first 5
  end
  
  
  private 
  def commodity_details_OC1C2
    @commodityExports_OC1C2 = Trade.where(commodity_code: params[:id], exporter_code: params[:exporter_code], importer_code: params[:importer_code]).group(:year).sum(:volume)
    @commodityImports_OC1C2 = Trade.where(commodity_code: params[:id], importer_code: params[:exporter_code],  exporter_code: params[:importer_code]).group(:year).sum(:volume)
  end
  
  private 
  def commodity_details_OCY1Y2
    if params[:country_code] == nil
      @country_code = 842
    else 
      @country_code = params[:country_code]
    end
    
    if params[:start_year] == nil
      @start_year = 1996    
    else
      @start_year = params[:start_year]
    end
    
    if params[:end_year] == nil
      @end_year = 2014    
    else
      @end_year = params[:end_year]  
    end
    
    if params[:id] == nil
      @commodity_code = 27    
    else
      @commodity_code = params[:id]
    end
    
    @commodity_exports = Trade.where(exporter_code: @country_code, year: @start_year..@end_year, commodity_code: @commodity_code).group(:year).sum(:volume)
    @commodity_imports = Trade.where(importer_code: @country_code, year: @start_year..@end_year, commodity_code: @commodity_code).group(:year).sum(:volume)
  
  end
  
  
end

class DashboardController < ApplicationController   
	set_tab :dashboard 
end
