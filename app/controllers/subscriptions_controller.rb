class SubscriptionsController < ApplicationController
  def index
  end

  def create
    @subscription = Subscription.new(params[:subscription])

    if @subscription.save
      render :json => @subscription
    else
      render :json => @subscription.errors, :status => :unprocessable_entity
    end
  end
end