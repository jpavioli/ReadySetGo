class ScoresController < ApplicationController

    before_action :current_score, only: [:show, :edit, :update, :destroy]
    before_action :score_authenticate, only: [:new, :create]
    before_action :score_user_authenticate, only: [:edit, :update, :destroy]

    def index
      @scores = Score.all
    end

    def show
      @user = session[:user_id] == nil ? nil : User.find(session[:user_id])
    end

    def event_scores
      @event = Event.all.find(params[:id])
    end

    def team_scores
      @team = Team.all.find(params[:id])
    end

    def competition_scores
      @competition = Competition.all.find(params[:id])
    end

    def new
      @score = Score.new
    end

    def create
      @score = Score.new(score_params)
      if @score.valid?
          @score.save
          redirect_to @score
      else
          flash[:error] = @score.errors.full_messages
          redirect_to new_score_path
      end
    end

    def edit
    end

    def update
      score = Score.new(score_params)
      if score.valid?
        current_score
        @score.update(score_params)
        redirect_to @score
      else
        flash[:error] = score.errors.full_messages
        redirect_to edit_score_path
      end
    end

    def destroy
      @score.destroy
      redirect_to score_path
    end

    private

    def score_params
      params.require(:score).permit(:score, :event_id, :team_id)
    end

    def current_score
      @score = Score.find(params[:id])
    end
end
