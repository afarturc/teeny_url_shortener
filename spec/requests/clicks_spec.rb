require 'rails_helper'

RSpec.describe 'Clicks', type: :request do
  describe 'GET #redirect' do
    let!(:link) { create(:link) }

    context 'when valid request' do
      it 'redirects to the original url and creates click' do
        user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
        accept_language = 'en-US,en;q=0.9'

        get redirect_path(short_url: link.short_url),
            headers: { 'User-Agent': user_agent, 'HTTP_ACCEPT_LANGUAGE': accept_language }

        aggregate_failures do
          expect(response).to redirect_to(link.original_url)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
          expect(link.reload.clicks.count).to eq(1)
        end
      end
    end

    context 'when invalid request' do
      it 'redirects to root' do
        get redirect_path(short_url: link.short_url)

        aggregate_failures do
          expect(response).to redirect_to(root_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq('text/html; charset=utf-8')
        end
      end
    end
  end
end
