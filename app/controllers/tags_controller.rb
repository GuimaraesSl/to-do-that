class TagsController < ApplicationController
  def index
    @tags = Tag.all
    respond_to do |format|
      format.html
      format.json { render json: @tags }
    end
  end

  def create
    @tag = Tag.find_or_initialize_by(title: tag_params[:title])
    @tag.color ||= format("#%06x", rand(0..0xffffff))

    if @tag.save
      respond_to do |format|
        format.json { render json: @tag, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy if @tag.taggings.empty?
    head :no_content
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  private

  def tag_params
    params.require(:tag).permit(:title, :color)
  end
end
