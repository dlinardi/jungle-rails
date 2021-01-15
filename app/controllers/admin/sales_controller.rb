class Admin::SalesController < ApplicationController
  
  def index
    @sales = Sale.all
  end

  def new
  end

  def delete
  end

end
