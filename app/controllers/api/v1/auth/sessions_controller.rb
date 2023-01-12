class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #unpermitted　対策
  wrap_parameters format: []
end
