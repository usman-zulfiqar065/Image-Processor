class ImageProcessingService
  require 'rtesseract'
  require 'rmagick'

  BORDER_COLOR = 'red'.freeze
  OPACITY = 0
  STROKE_WIDTH = 1

  def initialize(image_container, query = '')
    @image_container = image_container
    @query = query.downcase
    @image_path = ActiveStorage::Blob.service.path_for(@image_container.original_image.key)
  end

  def call!
    perform_ocr if @image_container.hocr_data.blank?
    mark_image_with_boxes
  end

  private

  def perform_ocr
    tesseract = RTesseract.new(@image_path)
    data = tesseract.to_box.to_json
    @image_container.update(hocr_data: data)
  end

  def mark_image_with_boxes
    rmagick_image = Magick::Image.read(@image_path).first
    hocr_data.each do |box|
      x1, y1, x2, y2 = box.values_at('x_start', 'y_start', 'x_end', 'y_end')
      rectangle = Magick::Draw.new
      rectangle.stroke(BORDER_COLOR)
      rectangle.fill_opacity(OPACITY)
      rectangle.stroke_width(STROKE_WIDTH)
      rectangle.rectangle(x1, y1, x2, y2)
      rectangle.draw(rmagick_image)
    end
    processed_image_blob = rmagick_image.to_blob
    @image_container.processed_image.attach(io: StringIO.new(processed_image_blob),
                                            filename: "processed_#{Time.now.to_i}.png")
  end

  def hocr_data
    data = JSON.parse(@image_container.hocr_data)

    data = data.select { |hash| hash['word'].downcase == @query } if @query.present?

    data
  end
end
