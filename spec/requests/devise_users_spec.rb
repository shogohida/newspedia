require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe 'POST #create' do
    context 'parameters are valid' do
      it 'is valid' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 200
        # 302?
      end

      it 'makes create action succeed' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'redirects to homepage' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'parameters are invalid' do
      it 'is valid' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'makes create action fail' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'shows error messages' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end
end
