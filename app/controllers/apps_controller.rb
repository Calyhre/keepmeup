class AppsController < ApplicationController
  def index
    @apps = App.order(:name).decorate
  end

  def update
    @app = App.find params[:id]
    @app.update_attributes app_params
    redirect_to root_path anchor: @app.name
  end

  private

  def app_params
    params.require(:app).permit(:ping_disabled, :maintenance)
  end
end
