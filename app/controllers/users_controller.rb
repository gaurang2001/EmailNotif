class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_new_user, only: :index
  before_action :check_admin, only: [:admin, :send_mail]

  # GET /
  # User Dashboard
  def index
    @total = User.count
    @message = current_user.admin ? "You are the admin." : "#{User.first.name} is the admin."
  end

  # GET /users/:id/my_account
  # Edit non-login related details
  def edit
    @gender = User.gender_mapping.invert
    @locations = User.locations
  end

  # PATCH/PUT /users/:id
  # Update personal user related details
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

  # GET /users/admin
  # Admin Dashboard to notify users
  # Only accessible by admin
  def admin
    @gender = User.gender_mapping.invert
    @age_groups = User.age_groups
    @locations = User.all.pluck(:location).uniq
  end

  # POST /users/send_mail
  # Send notifications to selected users
  # Only accessible by admin
  def send_mail
    name = ""
    users = []

    # Filter using criteria
    case params[:choice]

    when "All" # Notify all users
      users = User.all

    when "Filter" # Notify users based on criteria
      all_users = User.all
      genders = all_users.pluck(:gender).uniq
      ages = all_users.pluck(:age).uniq
      locations = all_users.pluck(:location).uniq

      # Gender
      if params[:gender].present?
        genders = [params[:gender].to_i]
      end

      # Age
      if params[:age].present? or params[:age_group].present?
        if params[:age].present?
          ages = [params[:age].to_i]
        else
          case params[:age_group].to_i
          when 1
            ages = ages.select{ |age| age < 11 }
          when 2
            ages = ages.select{ |age| age >= 11 and age < 18 }
          when 3
            ages = ages.select{ |age| age >= 18 and age < 25 }
          when 4
            ages = ages.select{ |age| age >= 25 and age <= 40 }
          else
            ages = ages.select{ |age| age > 40 }
          end
        end
      end

      # Location
      if params[:location].present?
        locations &= [params[:location]]
      end

    else # Notify single user
      name = params[:name]
    end

    if name.present?
      users << User.find_by(name: name)
    elsif !users.present?
      users = User.where(age: ages, location: locations, gender: genders)
    end

    # Call mailer
    content = { :subject => params[:subject], :body => params[:content] }
    users = users.reject{ |user| user.email == ENV["gmail_username"] }
    users.each do |user|
      NotifMailer.notification(user, content, User.find_admin).deliver
    end

    redirect_to admin_users_path, notice: "#{users.count} users notified"
  end

  private

  def my_account_params
    params.require(:user).permit(:name,:gender,:age,:location)
  end

  # New users need to fill personal details to complete registration
  def check_new_user
    if current_user.name.nil?
      redirect_to my_account_user_path(current_user.id), notice: "Fill in Details."
    end
  end

  # Admin gets notification privileges
  def check_admin
    redirect_to root_path, alert: "You are not authorised to access this page" unless current_user.admin
  end
end
