class UserStocksController < ApplicationController
  
  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "#{@user_stock.stock.name} added to portfolio"
    redirect_to my_portfolio_path
  end
  
  def destroy
    stock = Stock.find(params[:id])
    stock_name_to_remove = stock.name
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:notice] = "#{stock_name_to_remove} no longer being tracked"
    redirect_to my_portfolio_path
  end
  
end
