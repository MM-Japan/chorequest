class GardensController < ApplicationController
  before_action :set_user

  def show
    @users = current_user.household.users
    pink = ["pink1.png", 'pink2.png', 'pink1.png', 'pink3.png']
    sunflower = ["flower1.png", "flower2.png", "flower1.png", "flower3.png"]

    @array = [pink, sunflower].sample

    if @array == pink
      @inventory_image = "pink1.png"
    elsif @array == sunflower
      @inventory_image = "flower1.png"
    else
      @inventory_image = "bud1.png"
    end
  end

  def water

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('community_garden_frame', partial: 'gardens/community_garden')
      end
    end
  end


  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
