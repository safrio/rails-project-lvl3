# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, except: %i[create new index]

    def index
      @categories = Category.order(:name).map(&:name)
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.order(id: :desc).page params[:page]
    end

    def show; end

    def new
      authorize Bulletin
      @bulletin = Bulletin.new
    end

    def edit
      authorize @bulletin
    end

    def create
      authorize Bulletin
      @bulletin = current_user.bulletins.new(bulletin_params)
      if @bulletin.save
        redirect_to bulletin_url(@bulletin), notice: t('.bulletin_created')
      else
        render :new, alert: @bulletin.errors.full_messages
      end
    end

    def update
      authorize @bulletin
      if @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: t('.bulletin_updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      authorize @bulletin
      @bulletin.archive!

      redirect_to profile_url, notice: t('.bulletin_archieved')
    end

    def moderate
      authorize @bulletin
      @bulletin.moderate!

      redirect_to profile_url, notice: t('.bulletin_moderated')
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :user_id, :title, :description, :image)
    end
  end
end
