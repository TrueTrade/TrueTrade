class CountriesController < ApplicationController
  def new
    @country = Country.new
  end

  
  
  def index
    @countries = Country.all.sort
  end

  def show
    if params[:details] == 'partner'
      #partner details show
    else
      #country details show
      @country = Country.find(params[:id])
      @countryCommoditiesIE = country_details
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
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: @displayTableValues.map { |row| row[1]/10000}
            },
          {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: @displayTableValues.map { |row| row[2]/10000}
            }
          ]
        }
      @options = {width: 1200, height: 1200}
    end
  end
  

  def edit
    @country = Country.find(params[:id])
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
  def country_details
    @country_commodities_exports = Trade.where(exporter_code: params[:id], year: 2012).group(:commodity_code).sum(:volume)
    @country_commodities_imports = Trade.where(importer_code: params[:id], year: 2012).group(:commodity_code).sum(:volume)
    return @country_commodities_exports, @country_commodities_imports
  end
  
end

#class DashboardController < ApplicationController   
#	set_tab :dashboard 
#end
