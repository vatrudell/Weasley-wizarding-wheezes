class Admin::OrdersController < Admin::BaseController
  def index
    # user = User.find_by(username: params[:session][:username])
    # if user.current_admin
      @orders = Order.all
    # else
    #   render:
    # end
    @status = Order.group(:status).count
  end
end
