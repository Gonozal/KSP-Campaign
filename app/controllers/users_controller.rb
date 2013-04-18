class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :new, :create]
  def index
    if not user_signed_in?
      redirect_to new_user_registration_path
    else
      @user = current_user
      render :show
    end
  end

  def show
    @user = current_user
  end
end
