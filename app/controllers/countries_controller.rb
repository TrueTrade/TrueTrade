class CountriesController < ApplicationController
  def new
    @country = Country.new
  end

  
  
  def index
    @countries = Country.all
    
   @chart = LazyHighCharts::HighChart.new('graph') do |f|
  f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
  f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
  f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  f.yAxis [
    {:title => {:text => "GDP in Billions", :margin => 70} },
    {:title => {:text => "Population in Millions"}, :opposite => true},
  ]

  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  f.chart({:defaultSeriesType=>"column"})
end
    
    
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
