class TrimestersController < ApplicationController
before_action :set_trimester, only: [:show, :edit, :update]  
 def index
      @trimesters = Trimester.all
  end

  def show
  end
  
  def edit
  end

  def update
    if params[:trimester][:application_deadline].blank?
      render plain: "Application deadline is required", status: :bad_request
      return
    end

    begin
      deadline = Date.parse(params[:trimester][:application_deadline])
    rescue ArgumentError
      render plain: "Invalid date format", status: :bad_request
      return
    end

    if @trimester.update(application_deadline: deadline)
      redirect_to @trimester, notice: "Trimester updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: "Trimester not found", status: :not_found
  end
end