class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end
  
  def show
    @template = Template.find(params[:id])
  end
  
  def new
    @template = Template.new
  end
  
  def create
    @template = Template.new(params[:template])
    if @template.save
      flash[:notice] = "Successfully created template."
      redirect_to @template
    else
      render :action => 'new'
    end
  end
  
  def edit
    @template = Template.find(params[:id])
  end
  
  def update
    @template = Template.find(params[:id])
    if @template.update_attributes(params[:template])
      flash[:notice] = "Successfully updated template."
      redirect_to @template
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    flash[:notice] = "Successfully destroyed template."
    redirect_to templates_url
  end
end
