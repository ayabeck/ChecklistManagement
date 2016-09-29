class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy, :save]
  before_action :set_template,  only: [:new, :create]

  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.all
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
    @form_items = FormItem.where(checklist_id: @checklist.id)
  end

  # GET /templates/1/checklists/new
  def new
    @checklist = Checklist.new
    @checklist.title = @template.title
  end

  # GET /checklists/1/edit
  def edit
  end

  # POST /templates/1/checklists
  # POST /templates/1/checklists.json
  def create
    @checklist = Checklist.new(checklist_params)
    @checklist.template_id = @template.id
    FormItem.batch_copy(@template, @checklist)

    respond_to do |format|
      if @checklist.save
        format.html { redirect_to @checklist, notice: 'Checklist was successfully created.' }
        format.json { render :show, status: :created, location: @checklist }
      else
        format.html { render :new }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklists/1
  # PATCH/PUT /checklists/1.json
  def update
    respond_to do |format|
      if @checklist.update(checklist_params)
        format.html { redirect_to @checklist, notice: 'Checklist was successfully updated.' }
        format.json { render :show, status: :ok, location: @checklist }
      else
        format.html { render :edit }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklists/1
  # DELETE /checklists/1.json
  def destroy
    @checklist.destroy
    respond_to do |format|
      format.html { redirect_to checklists_url, notice: 'Checklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /checklists/1/save
  def save
    ActiveRecord::Base.transaction do
      @checklist.update_forms!(params[:form])
      redirect_to @checklist, notice: 'Checklist was successfully saved.'
    end
  rescue => e
    redirect_to @checklist, notice: e.message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
    end
    def set_template
      @template = Template.find(params[:template_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params.require(:checklist).permit(:title, :checker, :start_at, :due_at, :submitter, :submit_at)
    end
end
