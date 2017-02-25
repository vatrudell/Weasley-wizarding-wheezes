class Admin::BaseController < ApplicationController
  before_action :current_admin

  def current_admin
    render file: 'app/views/errors/not_found.html.erb' unless current_admin?
  end
end
