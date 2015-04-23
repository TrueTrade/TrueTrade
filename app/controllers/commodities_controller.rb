class CommoditiesController < ApplicationController
  def new
  @commodity = Commodity.new
  end

  def index
    @commodities = Commodity.all
  end

  def show
    @commodity = Commodity.find(params[:id])
 
    @commoditiesIE = commodity_details
    @commodityOnlyE = @commoditiesIE[0]
    @commodityOnlyI = @commoditiesIE[1]
  
    @displayTableExports = []
    @commodityOnlyE.each do |year, volume|
      @displayTableExports << [year , volume]
    end
    
    @displayTableImports = []
    @commodityOnlyI.each do |year, volume|
      @displayTableImports << [year , volume]
    end
    
   
    @data = {
      labels: @displayTableExports.map { |row| row[0]} ,
      datasets: [
        {
          label: "My First dataset",
          fillColor: "rgba(220,220,220,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: @displayTableExports.map { |row| row[1]/10000}
          },
        {
          label: "My Second dataset",
          fillColor: "rgba(151,187,205,0.2)",
          strokeColor: "rgba(151,187,205,1)",
          pointColor: "rgba(151,187,205,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(151,187,205,1)",
          data: @displayTableImports.map { |row| row[1]/10000}
          }
        ]
      }
    @options = {width: 1200, height: 1200}
    
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
  def commodity_details
    if params[:country_code] == nil
      @country_code = 842
    else 
      @country_code = params[:id]
    end
    
    if params[:start_year] == nil
      @start_year = 1996    
    else
      @start_year = params[:start_year]
    end
    
    if params[:end_year] == nil
      @end_year = 2012    
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
   
    return @commodity_exports, @commodity_imports
  end
  
  
end

class DashboardController < ApplicationController   
	set_tab :dashboard 
end
