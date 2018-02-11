class HomeController < ApplicationController
  skip_before_action :authenticate, only: [:index, :onboard]

  before_action :redirect_to_repos, if: :signed_in?

  def index
    @home = Home.new(current_user)
  end

  def onboard
    if !params[:user][:email].present?
      redirect_to root_url, flash: { whitelisted: 'Email must be present.' }
    else
      Resque.enqueue(WaitlistJob, params[:user])
      redirect_to root_url, flash: { whitelisted: 'You have been added to the list!' }
    end
  end

  private

  def redirect_to_repos
    redirect_to repos_path
  end
end
