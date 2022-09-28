class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@new_comment)
      redirect_to @event,
        notice: I18n.t('controllers.comments.created')
    else
      render 'events/show',
        status: :unprocessable_entity,
        alert: I18n.t('controllers.comments.error')
    end
  end

  def destroy
    authorize @comment

    if @comment.destroy!
      redirect_to @event, notice: I18n.t('controllers.comments.destroyed')
    else
      redirect_to @event, alert:  I18n.t('controllers.comments.error')
    end
  end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_comment
      @comment = @event.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :user_name)
    end

    def notify_subscribers(comment)
      emails =
      (
        comment.event.subscriptions.map(&:user_email) +
        [comment.event.user.email] -
        [comment.user&.email]
      ).uniq

      emails.each do |email|
        EventMailer.comment(comment, email).deliver_later
      end
    end
end
