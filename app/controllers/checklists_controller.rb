class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy, :save, :apply, :withdraw]
  before_action :set_template,  only: [:new, :create]

  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.all
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
    @form_items = @checklist.form_items
  end

  # GET /templates/1/checklists/new
  def new
    @checklist = Checklist.new
    @checklist.init(@template)
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
    # REST 等で意図的に実施しない限り実行されないので処理はひとまず頑張らない
    return if @checklist.submit_at.present?

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
    # REST 等で意図的に実施しない限り実行されないので処理はひとまず頑張らない
    return if @checklist.submit_at.present?

    @checklist.destroy
    respond_to do |format|
      format.html { redirect_to checklists_url, notice: 'Checklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /checklists/1/save
  def save
    # REST 等で意図的に実施しない限り実行されないので処理はひとまず頑張らない
    return if @checklist.submit_at.present?

    @form_items = @checklist.form_items_adding(params[:form])

    ActiveRecord::Base.transaction do
      @form_items.each { |item| item.save! }
      @checklist.update_progression_rate!
      redirect_to @checklist, notice: 'Checklist was successfully saved.'
    end
  rescue => e
    flash.now[:error] = e.message
    render :show
  end

  # PUT /checklists/1/apply
  def apply
    # REST 等で意図的に実施しない限り実行されないので処理はひとまず頑張らない
    return if @checklist.submit_at.present?

    ActiveRecord::Base.transaction do
      @checklist.submitted!()
      redirect_to @checklist, notice: 'Checklist was successfully applied.'
    end
  rescue => e
    flash.now[:error] = e.message
    render :show
  end

  # PUT /checklists/1/withdraw
  def withdraw
    # REST 等で意図的に実施しない限り実行されないので処理はひとまず頑張らない
    return if @checklist.submit_at.blank?

    ActiveRecord::Base.transaction do
      @checklist.withdraw!
      redirect_to @checklist, notice: 'Checklist was successfully withdrawn.'
    end
  rescue => e
    flash.now[:error] = e.message
    render :show
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
