class StatusReportsController < ApplicationController
  # GET /status_reports
  # GET /status_reports.json
  def index
    @status_reports = StatusReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @status_reports }
    end
  end

  # GET /status_reports/1
  # GET /status_reports/1.json
  def show
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status_report }
    end
  end

  # GET /status_reports/new
  # GET /status_reports/new.json
  def new
    @status_report = StatusReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status_report }
    end
  end

  # GET /status_reports/1/edit
  def edit
    @status_report = StatusReport.find(params[:id])
  end

  # POST /status_reports
  # POST /status_reports.json
  def create
    params[:status_report].merge!(:user_id => current_user.id, :project_id => current_project.id)
    @status_report = StatusReport.new(params[:status_report])

    respond_to do |format|
      if @status_report.save
        format.html { redirect_to @status_report, notice: 'Status report was successfully created.' }
        format.json { render json: @status_report, status: :created, location: @status_report }
      else
        format.html { render action: "new" }
        format.json { render json: @status_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status_reports/1
  # PUT /status_reports/1.json
  def update
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      if @status_report.update_attributes(params[:status_report])
        format.html { redirect_to @status_report, notice: 'Status report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_reports/1
  # DELETE /status_reports/1.json
  def destroy
    @status_report = StatusReport.find(params[:id])
    @status_report.destroy

    respond_to do |format|
      format.html { redirect_to status_reports_url }
      format.json { head :no_content }
    end
  end
end
