class ClicksController < ApplicationController
  before_action :click_params
  before_action :set_link

  def redirect
    result = CreateClick.new(@link.id, click_params).perform

    if result.success?
      respond_to do |format|
        format.html { redirect_to @link.original_url, allow_other_host: true }
        format.json { render json: { link: @link, click: result.click }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = result.errors
          redirect_to root_path
        end
        format.json { render json: { errors: result.errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def click_params
    user_agent = UserAgent.parse(request.user_agent)
    {
      device_ip: request.remote_ip,
      system: user_agent.os,
      browser: user_agent.browser,
      language: request.accept_language,
      platform: user_agent.platform
    }
  end

  def set_link
    @link = Link.find_by(short_url: params[:short_url])
  end
end
