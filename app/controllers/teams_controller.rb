class TeamsController < ApplicationController

    before_action :current_team, only: [:show, :edit, :update, :destroy]
    before_action :team_authenticate, only: [:new, :create]
    before_action :team_user_authenticate, only: [:edit, :update, :destroy]

    def index
      @teams = Team.all
    end

    def show
      @user = session[:user_id] == nil ? nil : User.find(session[:user_id])
    end

    def new
      @team = Team.new
      @team_managers = User.select {|user| user.user_type == "Team Manager" || user.user_type == "Competition Manager" }
    end

    def create
      @team = Team.new(team_params)
      if @team.valid?
        @team.save
        redirect_to @team
      else
        flash[:error] = @team.errors.full_messages
        redirect_to new_team_path
      end
    end

    def edit
      @team_managers = User.select {|user| user.user_type == "Team Manager" || user.user_type == "Competition Manager" }
    end

    def update
      team = Team.new(team_params)
      if team.valid?
        current_team
        @team.update(team_params)
        redirect_to @team
      else
        flash[:error] = team.errors.full_messages
        redirect_to edit_team_path
      end
    end

    def destroy
      @team.destroy
      redirect_to teams_path
    end

    private

    def team_params
      params.require(:team).permit(:name, :location, :sponsor, :team_type, :mascot,:team_manager_id, :competition_id)
    end

    def current_team
      @team = Team.find(params[:id])
    end

end
