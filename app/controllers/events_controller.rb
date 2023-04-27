class EventsController < ApplicationController
  before_action :authorise_user, only: [:edit, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def show
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
  end

  def update
    if current_user.admin? && @event.user != current_user
      @event.edited_by_admin = true
      @event.edited_by = current_user.id
      @event.edited_at = DateTime.now
    end

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to root_path, alert: "Deleted"
  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorise_user
    @event = Event.find(params[:id])

    unless current_user.admin? || @event.user == current_user
      flash[:alert] = "You are not authorised to perform this action."
      redirect_to root_path
    end
  end

  def event_params
    params.require(:event).permit(:title, :body, :start_date, :end_date, :edited_by_admin, :edited_by, :edited_at, :user_id).merge(user: current_user)
  end
end
