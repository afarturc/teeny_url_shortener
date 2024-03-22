require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'GET #index' do
    context 'when logged in' do
      include_context 'with logged user'

      before do
        5.times { create(:link, user:) }
        create(:link)
      end

      it 'returns existing short links' do
        get root_path

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('text/html; charset=utf-8')
          expect(response.body).to include(*Link.where(user_id: user.id).pluck(:short_url))
          expect(response.body).not_to include(*Link.where.not(user_id: user.id).pluck(:short_url))
        end
      end
    end

    context 'when logged out' do
      it 'redirects to login' do
        get root_path

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end

  describe 'GET #new' do
    context 'when user logged in' do
      include_context 'with logged user'

      it 'shows new link form' do
        get new_link_path

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('text/html; charset=utf-8')
          expect(response.body).to include('Shorten URL')
        end
      end
    end

    context 'when user logged out' do
      it 'redirects to login' do
        get new_link_path

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe 'GET #create' do
    context 'when logged in' do
      include_context 'with logged user'

      context 'when params are valid' do
        let(:link_params) do
          {
            link: {
              original_url: FFaker::Internet.http_url
            }
          }
        end

        it 'creates a new link' do
          aggregate_failures do
            expect { post links_path(link_params), as: :json }.to change(Link, :count).by(1)
            expect(response).to have_http_status(:created)
          end
        end
      end

      context 'when params are missing' do
        let(:missing_params) do
          {
            link: {
              name: FFaker::Name.name
            }
          }
        end

        it 'does not create a new link' do
          aggregate_failures do
            expect { post links_path(missing_params) }.not_to change(Link, :count)
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end

  context 'when user logged out' do
    it 'redirects to login' do
      aggregate_failures do
        expect { post links_path, as: :json }.not_to change(Link, :count)
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link) { create(:link) }

      it 'deletes link' do
        aggregate_failures do
          expect { delete link_path(link.id), as: :json }.to change(Link, :count).by(-1)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when logged out' do
      let!(:link) { create(:link) }

      it 'redirects to login' do
        aggregate_failures do
          expect { delete link_path(link.id), as: :json }.not_to change(Link, :count)
          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)['error']).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
end
