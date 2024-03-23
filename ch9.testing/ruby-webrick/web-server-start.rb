require_relative './web-server'

server = WEBrick::HTTPServer.new Port: 8000
server.mount '/', WebServer

trap 'INT' do server.shutdown end
server.start
