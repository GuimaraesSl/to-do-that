class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
