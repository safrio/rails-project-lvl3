# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy]
    before_action :authenticate_user!, except: :index

    def index
      @bulletins = Bulletin.order(id: :desc)
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
        Rails.logger.debug { "@bulletin.errors: #{@bulletin.errors.full_messages}" } if @bulletin.errors.present?
        render :new, alert: @bulletin.errors.full_messages
      end
    end

    # PATCH/PUT /bulletins/1 or /bulletins/1.json
    def update
      if @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /bulletins/1 or /bulletins/1.json
    def destroy
      @bulletin.destroy

      redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
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
