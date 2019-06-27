class EventsController < ApplicationController

    before_action :current_event, only: [:show, :edit, :update, :destroy]
    before_action :event_authenticate, only: [:new, :create]
    before_action :event_user_authenticate, only: [:edit, :update, :destroy]

    def index
        @events = Event.all
    end
    def new
        @event = Event.new
        @event_managers = User.select {|user| user.user_type == "Event Manager" || user.user_type == "Competition Manager" }
    end

    def show
        @user = session[:user_id] == nil ? nil : User.find(session[:user_id])
    end

    def create
        @event = Event.new(event_params)
        if @event.valid?
            @event.save
            redirect_to @event
        else
            flash[:error] = @event.errors.full_messages
            redirect_to new_event_path
        end
    end

    def edit
      @event_managers = User.select {|user| user.user_type == "Event Manager" || user.user_type == "Competition Manager" }
    end

    def update
        event = Event.new(event_params)
        if event.valid?
          current_event
          @event.update(event_params)
          redirect_to @event
        else
          flash[:error] = event.errors.full_messages
          redirect_to edit_event_path
        end
    end

    def destroy
        @event.destroy
        redirect_to events_path
    end

    private

    def event_params
        params.require(:event).permit(:title, :description, :score_type, :competition_id, :event_manager_id)
    end

    def current_event
        @event = Event.find(params[:id])
    end
end
