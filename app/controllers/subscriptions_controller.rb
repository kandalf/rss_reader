class SubscriptionsController < ApplicationController
  def index
    @subscription = Subscription.new
    @subscriptions = Subscription.all
  end

  def create
    @subscription = Subscription.new(params[:subscription])

    if @subscription.save
      if request.xhr?
        render :json => @subscription
      else
        redirect_to root_path
      end
    else
      render :json => @subscription.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    subscription = Subscription.find(params[:id])

    subscription.destroy

    render :json => subscription
  end

  def show
    @subscription = Subscription.find(params[:id])
    render :partial => "articles", :locals => {:subscription => @subscription, :layout => false} if request.xhr?
  end

  def refresh
    @subscription = Subscription.find(params[:subscription_id])
    render :json => @subscription.fetch_articles if request.xhr?
  end
end
