class Admin::BaseController < ApplicationController
  before_action :current_admin
  before_action :set_status

  def current_admin
    render file: 'app/views/errors/not_found.html.erb' unless current_admin?
  end

  def set_status
    @status =Order.group(:status).count
  end
end
