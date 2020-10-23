class PingController < ApplicationController
  def ping
    render json: 'pong', status: :ok
  end
end
