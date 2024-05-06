class ImageContainersController < ApplicationController
  before_action :set_image_container, except: %i[index new create]

  def index
    @image_containers = ImageContainer.all
  end

  def show; end

  def new
    @image_container = ImageContainer.new
  end

  def create
    @image_container = ImageContainer.new(image_container_params)
    if @image_container.save
      ImageProcessingJob.perform_later(@image_container)
      redirect_to root_path, notice: 'Image uploaded successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @image_container.destroy
      redirect_to root_path, notice: 'Image Deleted Successfully'
    else
      render @image_container, status: :unprocessable_entity
    end
  end

  def download
    send_data @image_container.processed_image.download, type: 'image/png', disposition: 'attachment'
  end

  def search_word
    ImageProcessingService.new(@image_container, params[:query]).call!
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('processed-image', partial: 'processed_image', locals: { object: @image_container })
      end
    end
  end

  private

  def image_container_params
    params.require(:image_container).permit(:original_image)
  end

  def set_image_container
    @image_container = ImageContainer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to '/404'
  end
end
