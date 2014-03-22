class VisaSourcesController < ApplicationController

  force_ssl if Rails.env.production?

  before_filter :authorize

  def index

  end

  def new
    @visa_source = VisaSource.new
  end

  def edit
    @visa_source = VisaSource.find(params[:id])
  end

  def create
    @visa_source = VisaSource.create(source_params)
    if @visa_source.invalid?
      flash[:errors] = @visa_source.errors.messages
      render :new
    else
      redirect_to action: :index
    end
  end

  def update
    @visa_source = VisaSource.find(params['id'])
    @visa_source.update(source_params)
    if @visa_source.invalid?
      flash[:errors] = @visa_source.errors.messages
      render :edit
    else
      @visa_source.visa_codes = params['visa_source']['visa_codes'].select {|code| !code.blank?}
      redirect_to action: :index
    end
  end

  def destroy
    to_delete = VisaSource.find(params['id'])
    to_delete.delete unless to_delete.visas.size > 0
    redirect_to action: :index
  end

  private

  def source_params
    params.require(:visa_source).permit(:name, :country, :url, :last_modified, :etag, :visa_required, :on_arrival, :description)
  end
end
