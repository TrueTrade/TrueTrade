class CommoditiesController < ApplicationController
  def new
  @commodity = Commodity.new
  end

  def index
    @commodities = Commodity.all
  end

  def show
    @commodity = Commodity.find(params[:id])
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
end

class DashboardController < ApplicationController   
	set_tab :dashboard 
end
