class VisaSourcesController < ApplicationController

  force_ssl if Rails.env.production?

  before_filter :require_login

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
      update_visa_codes(@visa_source, params)
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
      update_visa_codes(@visa_source, params)
      redirect_to action: :index
    end
  end

  def destroy
    to_delete = VisaSource.find(params['id'])
    to_delete.destroy unless to_delete.visas.size > 0
    redirect_to action: :index
  end

  private

  def source_params
    params.require(:visa_source).permit(:name, :country, :url, :selector, :page_hash, :visa_required, :on_arrival, :description)
  end

  def update_visa_codes(visa_source, params)
    submitted_country_codes = params['visa_source']['visa_codes']
    visa_source.visa_codes = submitted_country_codes.select { |code| !code.blank? } unless submitted_country_codes.nil?
  end
end
