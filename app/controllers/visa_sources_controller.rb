class VisaSourcesController < ApplicationController

  def view

  end

  def add
    source = VisaSource.create(source_params)
    if source.invalid?
      flash[:errors] = source.errors.messages
    end
    render :view
  end

  def delete
    to_delete = VisaSource.find(params['id'])
    to_delete.delete unless to_delete.visas.size > 0
    redirect_to action: :view
  end

  private

  def source_params
    params.require(:visa_source).permit(:name, :country, :url, :last_modified, :etag, :visa_required, :on_arrival, :description)
  end
end
