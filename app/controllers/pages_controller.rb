class PagesController < ApplicationController

  def welcome
    @challenge = DBC::Challenge.find(1)
  end

end
