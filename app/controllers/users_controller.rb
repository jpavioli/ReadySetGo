class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to competitions_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(session[:user_id])
    if @user.user_type == "Competition Manager"
      @competitions = Competition.all.select{|competition| competition.competition_manager_id == session[:user_id]}
      @events = Event.all.select{|event| event.competition.competition_manager_id == session[:user_id]}
      @teams = Team.all.select{|team| team.competition.competition_manager_id == session[:user_id]}
    elsif @user.user_type == "Event Manager"
      @competitions = Competition.all.select{|competition| competition.events.any?{|event| event.event_manager_id == session[:user_id]}}.uniq
      @events = Event.all.select{|event| event.event_manager_id == session[:user_id]}
      @teams = Team.all.select{|team| team.events.any?{|event| event.event_manager_id == session[:user_id]}}.uniq
    elsif @user.user_type == "Team Manager"
      @competitions = Competition.all.select{|competition| competition.teams.any?{|team| team.team_manager_id == session[:user_id]}}.uniq
      @events = Event.all.select{|event| event.teams.any?{|team| team.team_manager_id == session[:user_id]}}.uniq
      @teams = Team.all.select{|team| team.team_manager_id == session[:user_id]}
    end
  end

  def login
    @user = User.new
  end

  def session_login
    @user = User.find_by(username_param)
    if @user && @user.authenticate(password_param[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = ["Incorrect Username / Password"]
      redirect_to login_path
    end
  end

  def session_logoff
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :user_type)
  end

  def username_param
    params.permit(:username)
  end

  def password_param
    params.permit(:password)
  end

end
