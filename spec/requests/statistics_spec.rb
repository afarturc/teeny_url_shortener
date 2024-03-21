require 'rails_helper'

RSpec.describe 'Statistics', type: :request do
  describe 'GET #clicks_last_30_days' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link_id) { create(:link, user:).id }

      context 'when clicks are found' do
        before do
          create(:click, link_id:)
        end

        it 'returns clicks count for the past 30 days' do
          get link_clicks_last_30_days_path(link_id), as: :json
          expect(response).to be_successful
          expect(JSON.parse(response.body)).not_to be_empty
        end
      end

      context 'when clicks are not found' do
        it 'returns nil' do
          get link_clicks_last_30_days_path(link_id), as: :json
          expect(response).to be_successful
          expect(response.body).to eq('null')
        end
      end
    end

    context 'when logged out' do
      let!(:link_id) { create(:link).id }

      it 'redirects to login' do
        get link_clicks_last_30_days_path(link_id)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end

  describe 'GET #clicks_most_popular_hours' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link_id) { create(:link, user:).id }

      context 'when clicks are found' do
        before do
          create(:click, link_id:)
        end

        it 'returns clicks count for most popular hours of the day' do
          get link_clicks_most_popular_hours_path(link_id), as: :json
          expect(response).to be_successful
          expect(JSON.parse(response.body)).not_to be_empty
        end
      end

      context 'when clicks are not found' do
        it 'returns nil' do
          get link_clicks_most_popular_hours_path(link_id), as: :json
          expect(response).to be_successful
          expect(response.body).to eq('null')
        end
      end
    end

    context 'when logged out' do
      let!(:link_id) { create(:link).id }

      it 'redirects to login' do
        get link_clicks_most_popular_hours_path(link_id)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end

  describe 'GET #clicks_most_popular_days_of_week' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link_id) { create(:link, user:).id }

      context 'when clicks are found' do
        before do
          create(:click, link_id:)
        end

        it 'returns clicks count for most popular days of the week' do
          get link_clicks_most_popular_days_of_week_path(link_id), as: :json
          expect(response).to be_successful
          expect(JSON.parse(response.body)).not_to be_empty
        end
      end

      context 'when clicks are not found' do
        it 'returns nil' do
          get link_clicks_most_popular_days_of_week_path(link_id), as: :json
          expect(response).to be_successful
          expect(response.body).to eq('null')
        end
      end
    end

    context 'when logged out' do
      let!(:link_id) { create(:link).id }

      it 'redirects to login' do
        get link_clicks_most_popular_days_of_week_path(link_id)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end

  describe 'GET #clicks_most_popular_languages' do
    context 'when logged in' do
      include_context 'with logged user'

      let!(:link_id) { create(:link, user:).id }

      context 'when clicks are found' do
        before do
          create(:click, link_id:)
        end

        it 'returns clicks count for most popular languages' do
          get link_clicks_most_popular_languages_path(link_id), as: :json
          expect(response).to be_successful
          expect(JSON.parse(response.body)).not_to be_empty
        end
      end

      context 'when clicks are not found' do
        it 'returns nil' do
          get link_clicks_most_popular_languages_path(link_id), as: :json
          expect(response).to be_successful
          expect(response.body).to eq('null')
        end
      end
    end

    context 'when logged out' do
      let!(:link_id) { create(:link).id }

      it 'redirects to login' do
        get link_clicks_most_popular_languages_path(link_id)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end
end
