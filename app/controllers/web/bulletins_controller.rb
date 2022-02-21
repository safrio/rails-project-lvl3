# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, except: %i[create new index]
    before_action :authenticate_user!, except: %i[index show]

    def index
      @bulletins = Bulletin.published.order(id: :desc)
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def edit; end

    def create
      @bulletin = current_user.bulletins.new(bulletin_params)
      if @bulletin.save
        redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully created.'
      else
        render :new, alert: @bulletin.errors.full_messages
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      @bulletin.archive!

      redirect_to profile_url, notice: 'Bulletin was successfully archieved.'
    end

    def moderate
      @bulletin.moderate!

      redirect_to profile_url, notice: 'Bulletin was successfully archieved.'
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
