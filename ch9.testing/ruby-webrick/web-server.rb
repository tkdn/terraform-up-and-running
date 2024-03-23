require 'webrick'

class WebServer < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    handler = Handlers.new
    status, ct, body = handler.handle(request.path)
    response.status = status
    response['Content-Type'] = ct
    response.body = body
  end
end

class Handlers
  def handle(path)
    case path
    when "/"
      [200, 'text/plain', 'Hello, World']
    when "/api"
      [201, 'application/json', '{"foo": 1}']
    else
      [404, 'text/plain', 'Not Found']
    end
  end
end
