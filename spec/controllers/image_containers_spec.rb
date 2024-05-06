require 'rails_helper'

RSpec.describe ImageContainersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      image_container = ImageContainer.create!
      get :show, params: { id: image_container.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ImageContainer' do
        expect {
          post :create, params: { image_container: { original_image: fixture_file_upload('image.png', 'image/png') } }
        }.to change(ImageContainer, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { image_container: { original_image: fixture_file_upload('image.png', 'image/png') } }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested image_container' do
      image_container = ImageContainer.create!
      expect {
        delete :destroy, params: { id: image_container.to_param }
      }.to change(ImageContainer, :count).by(-1)
    end

    it 'redirects to the root path' do
      image_container = ImageContainer.create!
      delete :destroy, params: { id: image_container.to_param }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #download' do
    it 'sends the processed image as a download' do
      image_container = ImageContainer.create!
      get :download, params: { id: image_container.to_param }
      expect(response.headers['Content-Disposition']).to include('attachment')
    end
  end

  describe 'GET #search_word' do
    it 'updates the processed image via turbo stream' do
      image_container = ImageContainer.create!
      allow(ImageProcessingService).to receive(:new).and_return(instance_double('ImageProcessingService', call!: nil)) # Stubbing the ImageProcessingService
      get :search_word, params: { id: image_container.to_param, query: 'invoice' }, format: :turbo_stream
      expect(response).to have_http_status(:success)
      expect(response.body).to include('turbo-stream')
    end
  end
end
