class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @event = Event.new
  end

  def index
    @events = Event.public_events
  end

  def show
    @event = Event.where(id: params[:id]).last

    if !@event
      redirect_to events_path
      return
    end

    if current_user.id == @event.user_id || @event.is_public
      @event
    else
      redirect_to events_path
    end

  end

  def create
    @event = Event.new(permit_event)
    @event.user_id = current_user.id
    if params[:images]
      params[:images].each { |image|
        @event.images.build(image: image)
      }
    end
    if @event.save
      flash[:success] = "Success!"
      redirect_to event_path(@event)
    else
      flash[:error] = @event.errors.full_messages
      redirect_to new_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event and @event.user == current_user
      @event.destroy
      flash[:success] = "Event with id = #{@event.id} deleted."
      redirect_to events_my_events_path
    else
      redirect_to events_my_events_path
    end
  end

  def my_events
    if current_user
      @events = current_user.events
    else
      redirect_to events_path
    end
  end

  private

  def permit_event
    params.require(:event).permit(:images, :description, :is_public)
  end
end
