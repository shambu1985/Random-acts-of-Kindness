class CategoriesController < ApplicationController
  def index #/categories
    @public_categories = Category.where(public: true)
    user = User.where(id: params[:user_id])
    if user.any?
      @public_categories -= user[0].subscribed_categories({json: false})
    end
    render json:{list: @public_categories}
  end

  # /categories/:id
  def show
    @category = Category.find(params[:id])
    @tasks = @category.tasks
    render json: @tasks
  end

  #/users/:user_id/categories/:id/subscribe
  def subscribe
    args = {}
    args[:category_id] = params[:id]
    args[:amount] = params[:amount].to_i || 1
    args[:period] = params[:period].to_i || 4
    User.find(params[:user_id]).subscribe(args)
    render json: {status: "success"}
  end

end
