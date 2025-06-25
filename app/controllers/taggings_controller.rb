class TaggingsController < ApplicationController
  before_action :set_taggable, only: [ :create, :destroy ]

  def create
    @tag = Tag.find_or_create_by(title: params[:tag][:title]) do |tag|
      tag.color = params[:tag][:color] || "#3b82f6"
    end

    @tagging = Tagging.new(
      tag: @tag,
      taggable_type: params[:tagging][:taggable_type],
      taggable_id: params[:tagging][:taggable_id]
    )

    if @tagging.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
              "#{@tagging.taggable_type.downcase}_tags_#{@tagging.taggable_id}",
              partial: "shared/tags/tag",
              locals: { tag: @tag, taggable: @tagging.taggable }
            ),
            turbo_stream.replace(
              "#{@tagging.taggable_type.downcase}_#{@tagging.taggable_id}_tag_form",
              partial: "shared/tags/form",
              locals: { taggable: @tagging.taggable }
            ),
            turbo_stream.replace(
              "#{@tagging.taggable_type.downcase}_#{@tagging.taggable_id}_tag_button",
              partial: "shared/tags/button",
              locals: { taggable: @tagging.taggable }
            )
          ]
        end
        format.html { redirect_back fallback_location: root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "#{@tagging.taggable_type.downcase}_#{@tagging.taggable_id}_tag_errors",
            partial: "shared/errors",
            locals: { errors: @tagging.errors }
          )
        end
        format.html { redirect_back fallback_location: root_path }
      end
    end
  end

  def destroy
    @tagging = Tagging.find(params[:id])
    @tag = @tagging.tag
    @taggable = @tagging.taggable

    if @tagging.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove("tag_badge_#{@taggable.id}_#{@tag.id}")
        end
        format.html { redirect_back fallback_location: root_path, notice: "Tag removida com sucesso." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash", locals: { alert: "Não foi possível remover a tag." })
        end
        format.html { redirect_back fallback_location: root_path, alert: "Não foi possível remover a tag." }
      end
    end
  end

  private

  def set_taggable
    @taggable = if params[:taggable_type].present?
                  params[:taggable_type].constantize.find(params[:taggable_id])
    elsif params[:tagging]
                  params[:tagging][:taggable_type].constantize.find(params[:tagging][:taggable_id])
    elsif @tagging
                  @tagging.taggable
    end
  end

  def tagging_params
    params.require(:tagging).permit(:tag_id, :taggable_id, :taggable_type)
  end
end
