class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = current_user.foods
  end

  def general_shoping_list
    @foods = Food.all
    @food_items = @foods.length
    @price_sum = Food.sum(:price)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(user: current_user)
    @food.assign_attributes(food_params)
    if @food.save
      redirect_to foods_path
      flash[:success] = 'Food was successfully created!'
    else
      flash.now[:error] = 'Could not create food, try again'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @food.update(food_params)
      flash[:success] = "Measurement unit received: #{params[:food]}"
      redirect_to food_url(@food), notice: 'Food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy action to delete a food item.
  def destroy
    if @food.destroy
      flash[:success] = 'Food was successfully deleted.'
    else
      flash[:error] = 'Could not delete food, try again'
    end
    redirect_to foods_url
  end

  private

  # Helper method to set the @food instance variable.
  def set_food
    @food = Food.find(params[:id])
  end

  # Strong parameters to whitelist the allowed attributes for food creation and updates.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
