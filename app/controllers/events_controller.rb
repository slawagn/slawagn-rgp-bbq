class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, only: %i[show edit update destroy]
  after_action  :verify_authorized

  def index
    authorize Event
    @events = Event.all
  end

  def show
    if params[:pincode].present?
      cookies.permanent["event_#{@event.id}_pincode"] = params[:pincode]
    end

    unless policy(@event).show?
      skip_authorization
      render 'password_form' and return
    end

    authorize @event

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    authorize Event
    @event = current_user.events.build
  end

  def edit
    authorize @event
  end

  def create
    authorize Event

    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  def pundit_user
    EventPolicy::UserWithPincode.new(current_user, cookies.permanent["event_#{@event&.id}_pincode"])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_event_for_current_user
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
