class TemplatesController < ApplicationController
  def index
    start = Time.now
    @medics = [
      {
        title: "Dr. med. Mohamed Hashemian",
        adresse: "53113 Bonn",
        fachgebiet: "Anästhesiologie",
        entfernung: "32 km",
      },
      {
        title: "Andreas Gebauer",
        adresse: "45699 Herten, Westf",
        fachgebiet: "Anästhesiologie",
        entfernung: "101 km",
      },
      {
        title: "Volker Hambloch",
        adresse: "50679 Köln",
        fachgebiet: "Orthopädie",
        entfernung: "5 km",
        patientenfeedback: "7,6/10",
      },
    ]

    return if request.format.html?

    filename = request.query_parameters[:filename] + ".pdf"
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
end
