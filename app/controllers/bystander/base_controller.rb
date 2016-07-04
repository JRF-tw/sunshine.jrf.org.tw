class Bystander::BaseController < ApplicationController
  layout 'bystander'
  include CrudConcern

  before_action :authenticate_bystander!
end
