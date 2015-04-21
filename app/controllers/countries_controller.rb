class CountriesController < ApplicationController
  def new
    @country = Country.new
  end

  
  
  def index
    @countries = Country.all    
  end

  def show
    @country = Country.find(params[:id])
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
end

#class DashboardController < ApplicationController   
#	set_tab :dashboard 
#end
