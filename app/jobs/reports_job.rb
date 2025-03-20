# frozen_string_literal: true

class ReportsJob
  include Sidekiq::Job

  def perform(user_id, report_path)
    puts "Hello from report job"
    tasks = Task.accessible_to(user_id)
    content = ApplicationController.render(
      assigns: {
        tasks: tasks
      },
      template: "tasks/report/download",
      layout: "pdf"
    )
    pdf_blob = WickedPdf.new.pdf_from_string content
    FileUtils.mkdir_p(File.dirname(report_path.to_s)) unless File.directory?(File.dirname(report_path.to_s))
    File.open(report_path, "wb") do |f|
      f.write(pdf_blob)
    end
  end
end
