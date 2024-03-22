require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'GET #index' do
    let(:user_agent) do
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    end
    let(:accept_language) { 'en-US,en;q=0.9' }

    context 'when logged in' do
      include_context 'with logged user'

      before do
        5.times { create(:link, user:) }
        create(:link)
      end

      it 'returns existing short links' do
        get root_path, headers: { 'User-Agent': user_agent, 'HTTP_ACCEPT_LANGUAGE': accept_language }

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
        get root_path, headers: { 'User-Agent': user_agent, 'HTTP_ACCEPT_LANGUAGE': accept_language }

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

  describe 'GET #edit' do
  end

  describe 'PATCH #update' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link) { create(:link, user:) }

      context 'when params are valid' do
        let(:link_params) do
          {
            link: {
              name: FFaker::Lorem.word,
              description: FFaker::Lorem.sentence
            }
          }
        end

        it 'updates a link and redirects' do
          aggregate_failures do
            expect { patch link_path(link, link_params) }.not_to change(Link, :count)
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(root_path)
          end
        end
      end

      context 'when params are invalid' do
        let(:invalid_params) do
          {
            link: {
              original_url: nil
            }
          }
        end
        let(:validation_errors) { ["Original url can't be blank"] }

        it 'does not update a book' do
          aggregate_failures do
            expect { patch link_path(link, invalid_params) }.not_to change(Link, :count)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(flash[:alert]).to eq(validation_errors)
          end
        end
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
