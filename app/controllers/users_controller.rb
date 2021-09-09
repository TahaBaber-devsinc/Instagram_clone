class UsersController < ApplicationController
  def index
    @users = User.all
    @u = User.last
  end
end
