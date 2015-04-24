class CountriesController < ApplicationController
  def new
    @country = Country.new
  end
 
  def index
    @countries = Country.all.sort
  end

  def show
#     if params[:details] == 'partner'
#       #partner details show
#     else
      #country details show
      @country = Country.find(params[:id])
      @countryCommoditiesIE = country_details_C
      @countryOnlyE = @countryCommoditiesIE[0]
      @countryOnlyI = @countryCommoditiesIE[1]
      @countryOnlyECommsKeys = @countryOnlyE.keys
      @countryOnlyICommsKeys = @countryOnlyI.keys
      @uniqueCommodities = @countryOnlyECommsKeys|@countryOnlyICommsKeys
      @displayTableValues = []
      @uniqueCommodities.each do |commodity_code|
        if @countryOnlyE[commodity_code] != nil  
           @exportValue = @countryOnlyE[commodity_code]
        else
          @exportValue = 0
        end

        if @countryOnlyI[commodity_code] != nil  
        @importValue = @countryOnlyI[commodity_code]
        else
          @importValue = 0
        end

        @displayTableValues << [Commodity.find(commodity_code).name, @exportValue, @importValue]
      end
      @displayTableValues.sort! { |a,b| a[2] <=> b[2] }
      @data = {
        labels: @displayTableValues.map { |row| row[0].truncate(25, separator: /\s/)} ,
        datasets: [
          {
            label: "My First dataset",
            fillColor: "rgba(31,181,172,0.2)",
            strokeColor: "rgba(31,181,172,1)",
            pointColor: "rgba(31,181,172,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(31,181,172,1)",
            data: @displayTableValues.map { |row| row[1]/10000}
            },
          {
            label: "My Second dataset",
            fillColor: "rgba(250,133,100,0.2)",
            strokeColor: "rgba(250,133,100,1)",
            pointColor: "rgba(250,133,100,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(250,133,100,1)",
            data: @displayTableValues.map { |row| row[2]/10000}
            }
          ]
        }
      @options = {width: 1100, height: 500}
#     end
  end
  

  def year
      @country = Country.find(params[:id])
      country_year_details_CY
      @CYOnlyE = @country_year_exports
      @CYOnlyI = @country_year_imports
      @CYOnlyECommsKeys = @CYOnlyE.keys
      @CYOnlyICommsKeys = @CYOnlyI.keys
      @CYuniqueCommodities = @CYOnlyECommsKeys|@CYOnlyICommsKeys
      @CYdisplayTableValues = []
      @CYuniqueCommodities.each do |commodity_code|
        if @CYOnlyE[commodity_code] != nil  
           @exportValue = @CYOnlyE[commodity_code]
        else
          @exportValue = 0
        end

        if @CYOnlyI[commodity_code] != nil  
          @importValue = @CYOnlyI[commodity_code]
        else
          @importValue = 0
        end

        @CYdisplayTableValues << [Commodity.find(commodity_code).name, @exportValue, @importValue]
      end
      @CYdisplayTableValues.sort! { |a,b| a[2] <=> b[2] }
      @CYdata = {
        labels: @CYdisplayTableValues.map { |row| row[0].truncate(25, separator: /\s/)} ,
        datasets: [
          {
            label: "My First dataset",
            fillColor: "rgba(31,181,172,0.2)",
            strokeColor: "rgba(31,181,172,1)",
            pointColor: "rgba(31,181,172,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(31,181,172,1)",
            data: @CYdisplayTableValues.map { |row| row[1]/10000}
            },
          {
            label: "My Second dataset",
            fillColor: "rgba(250,133,100,0.2)",
            strokeColor: "rgba(250,133,100,1)",
            pointColor: "rgba(250,133,100,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(250,133,100,1)",
            data: @CYdisplayTableValues.map { |row| row[2]/10000}
            }
          ]
        }
      @CYoptions = {width: 1100, height: 500}  
  end
  
  def range
      @country = Country.find(params[:id])
      country_year_details_CY1Y2
      @CCOnlyE = @country_y1y2_exports
      @CCOnlyI = @country_y1y2_imports
      @CCOnlyECommsKeys = @CCOnlyE.keys
      @CCOnlyICommsKeys = @CCOnlyI.keys
      @CCuniqueCommodities = @CCOnlyECommsKeys|@CCOnlyICommsKeys
      @CCdisplayTableValues = []
      @CCuniqueCommodities.each do |commodity_code|
        if @CCOnlyE[commodity_code] != nil  
           @exportValue = @CCOnlyE[commodity_code]
        else
          @exportValue = 0
        end

        if @CCOnlyI[commodity_code] != nil  
          @importValue = @CCOnlyI[commodity_code]
        else
          @importValue = 0
        end

        @CCdisplayTableValues << [Commodity.find(commodity_code).name, @exportValue, @importValue]
      end
      @CCdisplayTableValues.sort! { |a,b| a[2] <=> b[2] }
      @CYYdata = {
        labels: @CCdisplayTableValues.map { |row| row[0].truncate(25, separator: /\s/)} ,
        datasets: [
          {
            label: "My First dataset",
            fillColor: "rgba(31,181,172,0.2)",
            strokeColor: "rgba(31,181,172,1)",
            pointColor: "rgba(31,181,172,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(31,181,172,1)",
            data: @CCdisplayTableValues.map { |row| row[1]/10000}
            },
          {
            label: "My Second dataset",
            fillColor: "rgba(250,133,100,0.2)",
            strokeColor: "rgba(250,133,100,1)",
            pointColor: "rgba(250,133,100,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(250,133,100,1)",
            data: @CCdisplayTableValues.map { |row| row[2]/10000}
            }
          ]
        }
      @CYYoptions = {width: 1100, height: 500}  
  end
  
  def partner
      @country = Country.find(params[:id])
      country_partner_details_C1C2
      @CCOnlyE = @country_exports_toPartner
      @CCOnlyI = @country_imports_fromPartner
      @CCOnlyECommsKeys = @CCOnlyE.keys
      @CCOnlyICommsKeys = @CCOnlyI.keys
      @CCuniqueCommodities = @CCOnlyECommsKeys|@CCOnlyICommsKeys
      @CCdisplayTableValues = []
      @CCuniqueCommodities.each do |commodity_code|
        if @CCOnlyE[commodity_code] != nil  
           @exportValue = @CCOnlyE[commodity_code]
        else
          @exportValue = 0
        end

        if @CCOnlyI[commodity_code] != nil  
          @importValue = @CCOnlyI[commodity_code]
        else
          @importValue = 0
        end

        @CCdisplayTableValues << [commodity_code, @exportValue, @importValue]
      end
     
      @CCdata = {
        labels: @CCdisplayTableValues.map { |row| row[0]} ,
        datasets: [
          {
            label: "My First dataset",
            fillColor: "rgba(31,181,172,0.2)",
            strokeColor: "rgba(31,181,172,1)",
            pointColor: "rgba(31,181,172,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(31,181,172,1)",
            data: @CCdisplayTableValues.map { |row| row[1]/10000}
            },
          {
            label: "My Second dataset",
            fillColor: "rgba(250,133,100,0.2)",
            strokeColor: "rgba(250,133,100,1)",
            pointColor: "rgba(250,133,100,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(250,133,100,1)",
            data: @CCdisplayTableValues.map { |row| row[2]/10000}
            }
          ]
        }
      @CCoptions = {width: 1100, height: 500}  
    
  end
  
  def partner_year
  end
  
  def partner_range
  end
  
  def edit
    @country = Country.find(params[:id])
  end
  
  def map
    @test = "hi"
  end

  def update
    @country = Country.find(params[:id])
    if @country.update_attributes(country_params)
      redirect_to(:action => 'show', :id => @country.code)
    else 
    render('index')
    end
  end

  def create 
    @country= Country.new(country_params)
   if @country.update_attributes(country_params)
     redirect_to(:action => 'show', :id => @country.code)
   else 
     render('index')
   end 
  end

  def delete
    @countries = Country.find(params[:id])
  end

  def destroy 
    Country.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

private 
def country_params
  params.require(:country.permit(:code, :name))
end
  # code insert  
  
  private 
  def country_details_C
    @year = 2012
    @country_commodities_exports = Trade.where(exporter_code: params[:id], year: @year).group(:commodity_code).sum(:volume)
    @country_commodities_imports = Trade.where(importer_code: params[:id], year: @year).group(:commodity_code).sum(:volume)
    return @country_commodities_exports, @country_commodities_imports
  end
  
  private 
  def country_year_details_CY
    @country_year_exports = Trade.where(exporter_code: params[:id], year: params[:year]).group(:commodity_code).sum(:volume)
    @country_year_imports = Trade.where(importer_code: params[:id], year: params[:year]).group(:commodity_code).sum(:volume)
#     return @country_exports_toPartner, @country_imports_fromPartner
  end
  
  private 
  def country_year_details_CY1Y2
    @country_y1y2_exports = Trade.where(exporter_code: params[:id], year: params[:start_year]..params[:end_year]).group(:commodity_code).sum(:volume)
    @country_y1y2_imports = Trade.where(importer_code: params[:id], year: params[:start_year]..params[:end_year]).group(:commodity_code).sum(:volume)
#     return @country_exports_toPartner, @country_imports_fromPartner
  end
  
  private 
  def country_partner_details_C1C2
    @country_exports_toPartner = Trade.where(exporter_code: params[:id], importer_code: params[:partner_code]).group(:year).sum(:volume)
    @country_imports_fromPartner = Trade.where(importer_code: params[:id], exporter_code: params[:partner_code]).group(:year).sum(:volume)
#     return @country_exports_toPartner, @country_imports_fromPartner
  end
  
  private 
  def country_partner_details_C1C2Y
    @country_exports_toPartner_year = Trade.where(exporter_code: params[:id], importer_code: params[:partner_code], year: params[:year])
    @country_imports_fromPartner_year = Trade.where(importer_code: params[:id], exporter_code: params[:partner_code],  year: params[:year])
#     return @country_exports_toPartner, @country_imports_fromPartner
  end
  
  private 
  def country_partner_details_C1C2Y1Y2
    @country_exports_toPartner_Y1Y2 = Trade.where(exporter_code: params[:id], importer_code: params[:partner_code], year: params[:start_year]..params[:start_year])
    @country_imports_fromPartner_Y1Y2 = Trade.where(importer_code: params[:id], exporter_code: params[:partner_code],  year: params[:start_year]..params[:start_year])
#     return @country_exports_toPartner, @country_imports_fromPartner
  end
  

  
  
  
end

#class DashboardController < ApplicationController   
#	set_tab :dashboard 
#end
