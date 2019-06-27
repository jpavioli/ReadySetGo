class CompetitionsController < ApplicationController

    before_action :current_competition, only: [:show, :edit, :update, :destroy, :stats]
    before_action :competition_authenticate, only: [:new, :create]
    before_action :competition_user_authinticate, only: [:edit, :update, :destroy]

    def index
        @competitions = Competition.all
    end

    def show
      @user = session[:user_id] == nil ? nil : User.find(session[:user_id]) 
    end

    def new
        @competition = Competition.new
        @competition_managers = User.select {|user| user.user_type == "Competition Manager"}
    end

    def create
        @competition = Competition.new(competition_params)
        if @competition.valid?
            @competition.save
            redirect_to @competition
        else
            flash[:error] = @competition.errors.full_messages
            redirect_to new_competition_path
        end
    end

    def edit
      @competition_managers = User.select {|user| user.user_type == "Competition Manager"}
    end

    def update
        competition = Competition.new(competition_params)
        if competition.valid?
          current_competition
          @competition.update(competition_params)
          redirect_to @competition
        else
            flash[:error] = competition.errors.full_messages
            redirect_to edit_competition_path
        end
    end

    def destroy
        @competition.destroy
        redirect_to competitions_path
    end

    def stats
      render :'/competitions/stats.html.erb'
    end

    private

    def competition_params
        params.require(:competition).permit(:name, :description, :location, :datetime, :status, :competition_manager_id)
    end

    def current_competition
        @competition = Competition.find(params[:id])
    end
end
