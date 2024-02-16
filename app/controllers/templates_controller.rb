class TemplatesController < ApplicationController
  def index
    if request.get?
      @medics = mocks[:medics]

      return
    end
    start = Time.now

    @medics = template_params[:medics]
    filename = template_params[:filename] + ".pdf"
    filepath = "./tmp/#{filename}"

    html = render_to_string('templates/index', :formats => [:html], layout: false)
    system("php ./lib/php/main.php '#{filename}' '#{html}'".strip)

    if File.exists?(filepath)
      data = File.read(filepath)
      send_data data, type: 'application/pdf', filename: filename
      File.delete(filepath)
    else
      render plain: "There was an error", status: :bad_request
    end

    puts ""
    puts "Completed in: #{Time.now - start}s"
    puts ""
  end

  def betterdoc
    return if request.get?
    start = Time.now

    filename = template_params[:filename] + ".pdf"
    filepath = "./tmp/#{filename}"

    html = render_to_string('templates/betterdoc', :formats => [:html], layout: false)
    # exec("php ./lib/php/main.php '#{filename}' '#{html}'".strip)
    system("php ./lib/php/main.php '#{filename}' '#{html}'".strip)

    if File.exists?(filepath)
      data = File.read(filepath)
      send_data data, type: 'application/pdf', filename: filename
      File.delete(filepath)
    else
      render plain: "There was an error", status: :bad_request
    end

    puts ""
    puts "Completed in: #{Time.now - start}s"
    puts ""
  end

  private

  def template_params
    params.require(:template).permit(
      :filename,
      medics: [:title, :address, :specialty, :distance, :patient_feedback]
    )
  end

  def mocks
    return {
      medics: [
        {
          title: "Dr. med. Mohamed Hashemian",
          address: "53113 Bonn",
          specialty: "Anästhesiologie",
          distance: "32 km",
        },
        {
          title: "Andreas Gebauer",
          address: "45699 Herten, Westf",
          specialty: "Anästhesiologie",
          distance: "101 km",
        },
        {
          title: "Volker Hambloch",
          address: "50679 Köln",
          specialty: "Orthopädie",
          distance: "5 km",
          patient_feedback: "7,6/10",
        },
      ]
    }
  end
end
