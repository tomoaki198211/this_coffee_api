class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #unpermitted対策
  wrap_parameters format: []

  def guest_sign_in
    @resource = User.guest
    @token = @resource.create_token
    @resource.save!
    render_create_success
  end

  def guest_admin_sign_in
    @resource = User.guest_admin
    @token = @resource.create_token
    @resource.save!
    render_create_success
  end
end
