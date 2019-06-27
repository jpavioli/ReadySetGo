class AthletesController < ApplicationController

    before_action :current_athlete, only: [:show, :edit, :update, :destroy]
    before_action :athlete_authenticate, only: [:new, :create]
    before_action :athlete_user_authenticate, only: [:edit, :update, :destroy]

    def index
        @athletes = Athlete.all
    end

    def show
        @user = session[:user_id] == nil ? nil : User.find(session[:user_id])
    end

    def new
        @athlete = Athlete.new
        @states = [ 'AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]
    end

    def create
        @athlete = Athlete.new(athlete_params)
        if @athlete.valid?
            @athlete.save
            redirect_to @athlete
        else
            flash[:error] = @athlete.errors.full_messages
            redirect_to new_athlete_path
        end
    end

    def edit
        @states = [ 'AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]
    end

    def update
        athlete = Athlete.new(athlete_params)
        if athlete.valid?
          current_athlete
          @athlete.update(athlete_params)
          redirect_to @athlete
        else
          flash[:error] = athlete.errors.full_messages
          redirect_to edit_athlete_path
        end
    end

    def destroy
        @athlete.destroy
        redirect_to athletes_path
    end

    private

    def athlete_params
        params.require(:athlete).permit(:first_name, :last_name, :hometown, :state, :bio, :gender, :jersey_number, :age, :weight, :height, :team_id)
    end

    def current_athlete
        @athlete = Athlete.find(params[:id])
    end

end
