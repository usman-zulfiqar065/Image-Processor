class ImageProcessingJob < ApplicationJob
  queue_as :default

  def perform(image_container)
    ImageProcessingService.new(image_container).call!
  end
end
