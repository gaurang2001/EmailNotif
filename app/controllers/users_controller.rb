class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_new_user, only: :index

  def index
    @total = User.count
    @message = current_user.admin ? "You are the admin." : "#{User.first.name} is the admin."
  end

  def edit
    @gender = User.gender_mapping.invert
  end

  def update
    respond_to do |format|
      if current_user.update(my_account_params)
        format.html { redirect_to my_account_user_path(current_user.id), notice: "Successfully updated details." }
        format.json
      else
        format.html { redirect_to my_account_user_path(current_user.id), notice: "Error." }
        format.json
      end
    end
  end

  private

  def my_account_params
    params.require(:user).permit(:name,:gender,:age,:location)
  end

  def check_new_user
    if current_user.name.nil?
      redirect_to my_account_user_path(current_user.id), notice: "Fill in Details."
    end
  end

end
