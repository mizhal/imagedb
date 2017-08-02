class CategoryHierarchiesController < ApplicationController
  before_action :set_category_hierarchy, only: [:show, :edit, :update, :destroy]

  # GET /category_hierarchies
  # GET /category_hierarchies.json
  def index
    @category_hierarchies = CategoryHierarchy.all
  end

  # GET /category_hierarchies/1
  # GET /category_hierarchies/1.json
  def show
  end

  # GET /category_hierarchies/new
  def new
    @category_hierarchy = CategoryHierarchy.new
  end

  # GET /category_hierarchies/1/edit
  def edit
  end

  # POST /category_hierarchies
  # POST /category_hierarchies.json
  def create
    @category_hierarchy = CategoryHierarchy.new(category_hierarchy_params)

    respond_to do |format|
      if @category_hierarchy.save
        format.html { redirect_to @category_hierarchy, notice: 'Category hierarchy was successfully created.' }
        format.json { render :show, status: :created, location: @category_hierarchy }
      else
        format.html { render :new }
        format.json { render json: @category_hierarchy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_hierarchies/1
  # PATCH/PUT /category_hierarchies/1.json
  def update
    respond_to do |format|
      if @category_hierarchy.update(category_hierarchy_params)
        format.html { redirect_to @category_hierarchy, notice: 'Category hierarchy was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_hierarchy }
      else
        format.html { render :edit }
        format.json { render json: @category_hierarchy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_hierarchies/1
  # DELETE /category_hierarchies/1.json
  def destroy
    @category_hierarchy.destroy
    respond_to do |format|
      format.html { redirect_to category_hierarchies_url, notice: 'Category hierarchy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_hierarchy
      @category_hierarchy = CategoryHierarchy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_hierarchy_params
      params.require(:category_hierarchy).permit(:category1_id, :category2_id)
    end
end
