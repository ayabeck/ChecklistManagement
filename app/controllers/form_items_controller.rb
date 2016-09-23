class FormItemsController < ApplicationController
  before_action :set_form_item, only: [:edit, :update, :destroy]
  before_action :set_template,  only: [:new, :create]

  # GET /form_items/new
  def new
    @form_item = FormItem.new
  end

  # GET /form_items/1/edit
  def edit
    @template = @form_item.template
  end

  # POST /form_items
  # POST /form_items.json
  def create
    @form_item = FormItem.new(form_item_params)
    @form_item.set_parent(@template)

    respond_to do |format|
      if @form_item.save
        format.html { redirect_to @template, notice: 'Form item was successfully created.' }
        format.json { render :show, status: :created, location: @form_item }
      else
        format.html { render :new }
        format.json { render json: @form_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_items/1
  # PATCH/PUT /form_items/1.json
  def update
    @template = @form_item.template
    respond_to do |format|
      if @form_item.update(form_item_params)
        format.html { redirect_to @template, notice: 'Form item was successfully updated.' }
        format.json { render :show, status: :ok, location: @form_item }
      else
        format.html { render :edit }
        format.json { render json: @form_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_items/1
  # DELETE /form_items/1.json
  def destroy
    template = @form_item.template
    @form_item.destroy
    respond_to do |format|
      format.html { redirect_to template, notice: 'Form item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_item
      @form_item = form_item_class.find(params[:id])
    end
    def set_template
      @template = Template.find(params[:template_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_item_params
      params.require(type.underscore.to_sym).permit(:type, :order, :label, :value)
    end

    # Utility
    def form_item_class
      type.constantize
    end
    def type
      params[:type] || "FormItem"
    end
end
