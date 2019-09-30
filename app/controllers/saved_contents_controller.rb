class SavedContentsController < ApplicationController
  before_action :authorize_request, :get_current_user

  def create
    saved_content = @current_user.saved_contents.create!(saved_content_params)
    render json: { message: :created, saved_content: SavedContentSerializer.new(saved_content) }, status: :created
  end

  def index
    saved_contents = @current_user.saved_contents
    render json: { message: :ok, saved_contents: saved_contents.map { |c| SavedContentSerializer.new(c) } }
  end

  def saved_content_params
    params.require(%i[type content])
    params[:content_type] = params[:type]
    params.permit(:content_type, :content)
  end
end
