class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    login
    @admin_users = Admin::User.all
    @admin_users.each do |user|
     user.photo = Admin::Photo.find_by( imageable_id: user.id,imageable_type: "user")
    end
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    login
    render view_for_user
  end

 
  # GET /admin/users/new
  def new
    login
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
    login
    @admin_user.photo = Admin::Photo.find_by( imageable_id: @admin_user.id,imageable_type: "user")

  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = Admin::User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      @admin_user.modifydate = Time.now
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:email, :password,:name,:title,:role, :createdate, :modifydate)
    end
  protected
  def show_user_name_mode
    params[:showname].present?
  end
  def view_for_user
    show_user_name_mode ? "show_name" : "show"
  end
end
