class SessionsController < ApplicationController
  def new
  end

  def create
    redirect_to new_import_path
  end
end
