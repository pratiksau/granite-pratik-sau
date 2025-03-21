# frozen_string_literal: true

class Tasks::ReportsController < ApplicationController
  def create
    ReportsJob.perform_async(current_user.id, report_path.to_s)
    render_notice(t("in_progress", action: "Report generation"))
  end

  def download
    if File.exist?(report_path.to_s)
      send_file(
        report_path,
        type: "application/pdf",
        filename: pdf_file_name,
        disposition: "attachment"
      )
    else
      render_error(t("not_found", entity: "report"), :not_found)
    end
  end

  private

    def report_path
      @_report_path ||= Rails.root.join("tmp/#{pdf_file_name}")
    end

    def pdf_file_name
      "granite_task_report.pdf"
    end
end
