# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < AdminController
      before_action :set_category, except: %i[create new index]

      def index
        @categories = Category.order(id: :desc).page params[:page]
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)
        if @category.save
          redirect_to admin_categories_url, notice: t('.category_created')
        else
          render :new, alert: @category.errors.full_messages
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_url, notice: t('.category_updated')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          redirect_to admin_categories_url, notice: t('.category_destroyed')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
