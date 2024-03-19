# frozen_string_literal: true

# Controller for links requests
class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_links, only: %i[index]
  before_action :set_link, only: %i[destroy]

  def index; end

  def new
    @link = Link.new
  end

  def create
    @result = CreateLink.new(link_params, current_user.id).perform

    if @result.success?
      respond_to do |format|
        format.turbo_stream
        format.json { render json: { link: @result.link }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = @result.errors
          render :new, status: :unprocessable_entity
        end
        format.json { render json: { errors: @result.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    result = DestroyLink.new(@link).perform

    if result.success?
      respond_to do |format|
        format.turbo_stream
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def set_links
    @links = current_user.links.order(created_at: :desc)
  end

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:name, :description, :original_url)
  end
end
