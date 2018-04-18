class ApplicationController < ActionController::Base

  include Response
  include ExceptionHandler
  include ActionView::Layouts

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
