class TradesController < ApplicationController
  #before_action :authenticate_user! # Added by Laura for devise, to authenticate user 
  def new
  @trade = Trade.new
  end

  def index
    @trades = Trade.limit(150)
  end

  def show
    @trade = Trade.find(params[:id])
  end

  def edit
    @trade = Trade.find(params[:id])
  end

  def update
    @trade = Trade.find(params[:id])
    if @trade.update_attributes(trade_params)
       redirect_to(:action => 'show', :id => @trade.id)
    else 
    render('index')
    end
  end

  def create 
    @trade = Trade.new(trade_params)
   if @trade.update_attributes(trade_params)
      redirect_to(:action => 'show', :id => @trade.id)
   else 
     render('index')
   end 
  end

  def delete
     @trade = Trade.find(params[:id])
  end

  def destroy 
    Trade.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

private 
def trade_params
  params.require(:trade.permit(:id,:year,:exporter_code,:importer_code,:commodity_code,:volume))
end
end
