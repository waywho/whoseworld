class Admin::ContentsController < ApplicationController
  include Imageable

  def delete_image
    purge_image(params[:image_id])
    head :no_content
  end

  def content_params
      params.require(:content).permit(:image_id)
  end
end
