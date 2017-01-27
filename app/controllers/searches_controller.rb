class SearchesController < ApplicationController

  def index
    if Bar.search(params[:term])
      @bars = Bar.search(params[:term])
    else
      @bars = nil
    end
    @bar = Bar.new
  end

end
