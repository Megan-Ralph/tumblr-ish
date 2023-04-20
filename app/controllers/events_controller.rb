class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @commentable = @event
    @comment = @commentable.comments.build
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :start_date, :end_date, :user_id).merge(user: current_user)
  end
end
