class Employees::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @employee = Employee.find_for_facebook_oauth(request.env["omniauth.auth"], current_employee)

    if @employee.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    end
  end
end