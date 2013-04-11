class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  def show
    @user = current_user
  end
end
