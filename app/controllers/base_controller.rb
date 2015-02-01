class BaseController < ApplicationController
  
  def index
    set_meta(title: "Myapp Admin")
  end
end
