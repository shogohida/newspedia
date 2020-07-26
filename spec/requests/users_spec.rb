describe UsersController, type: :request do
  describe 'GET #index' do
    before do
      FactoryBot.create :test1
      FactoryBot.create :test2
    end

    it 'has a successful request' do
      get users_url
      expect(response.status).to eq 200
    end

    it 'shows usernames' do
      get users_url
      expect(response.body).to include "test1"
      expect(response.body).to include "test2"
    end
  end

  describe 'POST #create' do
    context 'valid parameters' do
      it 'has a successful request' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'is registered as a user' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'redirects' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'invalid parameters' do
      it 'has a successful request' do
        post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'is not registered as a user' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      it 'shows an error message' do
        post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end
