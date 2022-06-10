class Admin::PagesController < ApplicationController
  before_action :set_admin_page, only: %i[ show edit update destroy ]

  # GET /admin/pages
  def index
    @admin_pages = Page.all
  end

  # GET /admin/pages/new
  def new
    @admin_page = Page.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @admin_page = Page.new(admin_page_params)

    if @admin_page.save
      redirect_to @admin_page, notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @admin_page.update(admin_page_params)
      redirect_to @admin_page, notice: "Page was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @admin_page.destroy
    redirect_to admin_pages_url, notice: "Page was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_page
      @admin_page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_page_params
      params.fetch(:admin_page, {})
    end
end
