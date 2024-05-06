require 'rails_helper'

RSpec.describe ImageProcessingService do
  let(:image_container) { double('ImageContainer') }
  let(:original_image) { instance_double('ActiveStorage::Blob', key: 'image_key') }
  let(:service) { described_class.new(image_container) }

  before do
    allow(image_container).to receive(:original_image).and_return(original_image)
    allow(image_container).to receive(:hocr_data).and_return(nil)
    allow(service).to receive(:perform_ocr)
    allow(service).to receive(:mark_image_with_boxes)
  end

  describe '#call!' do
    context 'when hocr_data is blank' do

      it 'calls perform_ocr' do
        expect(service).to receive(:perform_ocr)
        service.call!
      end

      it 'calls mark_image_with_boxes' do
        expect(service).to receive(:mark_image_with_boxes)
        service.call!
      end
    end

    context 'when hocr_data is present' do
      before do
        allow(image_container).to receive(:hocr_data).and_return([{ 'word' => 'example', 'x_start' => 0, 'y_start' => 0, 'x_end' => 100, 'y_end' => 100 }])
      end

      it 'does not call perform_ocr' do
        expect(service).not_to receive(:perform_ocr)
        service.call!
      end

      it 'calls mark_image_with_boxes' do
        expect(service).to receive(:mark_image_with_boxes)
        service.call!
      end
    end
  end
end
