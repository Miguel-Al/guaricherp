class PrincipalController < ApplicationController
  def index
    @nombre =  current_user.username
  end
end

