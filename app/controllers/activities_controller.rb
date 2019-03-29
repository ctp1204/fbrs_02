class ActivitiesController < ApplicationController
  def index
    @activities = Activity.newest.by_activity_following(current_user.following).paginate page: params[:page],
      per_page: Settings.per_page
  end
end
