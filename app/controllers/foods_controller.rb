class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  # Index action to display a list of food items.
  def index
    @foods = Food.includes(:user).all
  end

  # Show action to display details of a specific food item.
  def show; end

  # Custom action to generate a general shopping list summary.
  def general_shopping_list
    @foods = Food.all
    @food_items = @foods.length
    @price_sum = Food.sum(:price)
  end

  # New action to render a form for creating a new food item.
  def new
    @food = Food.new
  end

  # Edit action to render a form for editing a food item.
  def edit; end

  # Create action to create a new food item.
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to food_url(@food), notice: 'Food was successfully created!' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # Update action to update an existing food item.
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # Destroy action to delete a food item.
  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
    end
  end

  private

  # Helper method to set the @food instance variable.
  def set_food
    @food = Food.find(params[:id])
  end

  # Strong parameters to whitelist the allowed attributes for food creation and updates.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
