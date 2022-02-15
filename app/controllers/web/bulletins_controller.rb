# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy]

    # GET /bulletins or /bulletins.json
    def index
      @bulletins = Bulletin.all
    end

    # GET /bulletins/1 or /bulletins/1.json
    def show; end

    # GET /bulletins/new
    def new
      @bulletin = Bulletin.new
    end

    # GET /bulletins/1/edit
    def edit; end

    # POST /bulletins or /bulletins.json
    def create
      @bulletin = Bulletin.new(bulletin_params)

      respond_to do |format|
        if @bulletin.save
          format.html { redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully created.' }
          format.json { render :show, status: :created, location: @bulletin }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @bulletin.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /bulletins/1 or /bulletins/1.json
    def update
      respond_to do |format|
        if @bulletin.update(bulletin_params)
          format.html { redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.' }
          format.json { render :show, status: :ok, location: @bulletin }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @bulletin.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /bulletins/1 or /bulletins/1.json
    def destroy
      @bulletin.destroy

      redirect_to root_url, notice: 'Bulletin was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bulletin_params
      params.require(:bulletin).permit(:body)
    end
  end
end
