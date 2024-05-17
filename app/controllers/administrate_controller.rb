# frozen_string_literal: true

class AdministrateController < ApplicationController
  layout "administrate"
  before_action :authenticate_admin!
end
