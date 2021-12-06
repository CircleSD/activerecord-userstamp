require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  controller do
  end

  before(:each) { define_first_post }

  context 'when updating a Post' do
    it 'sets the correct updater' do
      request.session[:person_id] = @delynn.id
      if Rails.version.starts_with?('4.')
        post :update, id: @first_post.id, post: { title: 'Different' }
      else
        post :update, params: { id: @first_post.id, post: { title: 'Different' } }
      end

      expect(response.status).to eq(200)
      expect(controller.instance_variable_get(:@post).title).to eq('Different')
      expect(controller.instance_variable_get(:@post).updater).to eq(@delynn)
    end
  end

  context 'when handling multiple requests' do
    def simulate_second_request
      old_request_session = request.session[:person_id]
      request.session[:person_id] = @nicole.id

      if Rails.version.starts_with?('4.')
        post :update, id: @first_post.id, post: { title: 'Different Second'}
      else
        post :update, params: { id: @first_post.id, post: { title: 'Different Second'} }
      end
      expect(controller.instance_variable_get(:@post).updater).to eq(@nicole)
    ensure
      request.session[:person_id] = old_request_session
    end

    it 'sets the correct updater' do
      request.session[:person_id] = @delynn.id
      if Rails.version.starts_with?('4.')
        get :edit, id: @first_post.id
      else
        get :edit, params: { id: @first_post.id }
      end
      expect(response.status).to eq(200)

      simulate_second_request

      if Rails.version.starts_with?('4.')
        post :update, id: @first_post.id, post: { title: 'Different' }
      else
        post :update, params: { id: @first_post.id, post: { title: 'Different' } }
      end
      expect(response.status).to eq(200)
      expect(controller.instance_variable_get(:@post).title).to eq('Different')
      expect(controller.instance_variable_get(:@post).updater).to eq(@delynn)
    end
  end
end
