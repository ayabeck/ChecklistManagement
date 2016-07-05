class ChecklistTemplatesController < ApplicationController
  before_action :set_checklist_template, only: [:show, :edit, :update, :destroy]

  # GET /checklist_templates
  # GET /checklist_templates.json
  def index
    @checklist_templates = ChecklistTemplate.all
  end

  # GET /checklist_templates/1
  # GET /checklist_templates/1.json
  def show
  end

  # GET /checklist_templates/new
  def new
    @checklist_template = ChecklistTemplate.new
  end

  # GET /checklist_templates/1/edit
  def edit
  end

  # POST /checklist_templates
  # POST /checklist_templates.json
  def create
    @checklist_template = ChecklistTemplate.new(checklist_template_params)

    respond_to do |format|
      if @checklist_template.save
        format.html { redirect_to @checklist_template, notice: 'Checklist template was successfully created.' }
        format.json { render :show, status: :created, location: @checklist_template }
      else
        format.html { render :new }
        format.json { render json: @checklist_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklist_templates/1
  # PATCH/PUT /checklist_templates/1.json
  def update
    respond_to do |format|
      if @checklist_template.update(checklist_template_params)
        format.html { redirect_to @checklist_template, notice: 'Checklist template was successfully updated.' }
        format.json { render :show, status: :ok, location: @checklist_template }
      else
        format.html { render :edit }
        format.json { render json: @checklist_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_templates/1
  # DELETE /checklist_templates/1.json
  def destroy
    @checklist_template.destroy
    respond_to do |format|
      format.html { redirect_to checklist_templates_url, notice: 'Checklist template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist_template
      @checklist_template = ChecklistTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_template_params
      params.require(:checklist_template).permit(:title, :description, :checklists_count, :creator, :updater)
    end
end
