class InventoriesController < ApplicationController
  def index
    @inventories = current_user.inventories
    render 'index'
  end

  def new
    @new_inventory = Inventory.new
    render 'new'
  end
end
