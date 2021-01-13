class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_ADMIN_USER'], password: ENV['BASIC_AUTH_ADMIN_PASS']

  def show
  end
end
