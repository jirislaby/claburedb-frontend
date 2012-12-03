class UsersController < ApplicationController
	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  # Show user's details
  def show
    @user = User.find(params[:id])

    # Replace password characters with asterisks
    @user.password[0..@user.password.length] = "*"*@user.password.length

    # Get 5 most recent errors by user
    @errors = User.find(params[:id]).errors.limit(50).order("timestamp_enter DESC")

    # replace empty error url with "-"
    @errors.each do |error|
      if error.url == nil
        error.url = "-"
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render :json => @users_errors}
      #format.json { render :json => @user}

    end
  end




end
