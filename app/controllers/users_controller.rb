class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :new, :create]
  def index
    if not user_signed_in?
      redirect_to new_user_registration_path
    else
      @user = current_user
      @importable_packs = @user.importable_packs
      @imported_packs = @user.imported_packs.populated.uniq.to_a
      @imported_packs.each do |pack|
        pack.imported = true
      end
      render :show
    end
  end

  def update
    @user = current_user
    change = params[:change].to_sym
    if params[:pack_id].present? and params[:change].present?
      @mission_pack = MissionPack.find(params[:pack_id])
      if change == :add and @user.importable_packs.include? @mission_pack
        @user.imported_packs << @mission_pack
        @mission_pack.imported = true
      elsif change == :remove and @user.imported_packs.include? @mission_pack
        @user.imported_packs.delete(@user.imported_packs.find(params[:pack_id]))
        @mission_pack.imported = false
      end
      respond_to do |format|
        format.html { render :update }
        format.js { render :update, layout: false }
      end
    else
      render :nothing
    end
  end

  def show
    @user = current_user
  end
end
