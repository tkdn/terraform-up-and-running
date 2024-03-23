require_relative './web-server'
require "test/unit"
require 'net/http'

class TestWebServer < Test::Unit::TestCase
  def initialize(test_method)
    super(test_method)
    @handlers = Handlers.new
  end

  def test_unit_hello
    s, ct, b = @handlers.handle("/")
    assert_equal(200, s)
    assert_equal('text/plain', ct)
    assert_equal('Hello, World', b)
  end

  def test_unit_api
    s, ct, b = @handlers.handle("/api")
    assert_equal(201, s)
    assert_equal('application/json', ct)
    assert_equal('{"foo": 1}', b)
  end

  def test_unit_404
    s, ct, b = @handlers.handle("/not-found")
    assert_equal(404, s)
    assert_equal('text/plain', ct)
    assert_equal('Not Found', b)
  end

  def test_integration_hello
    do_integration_test('/', lambda {|response|
      assert_equal(200, response.code.to_i)
      assert_equal('text/plain', response['Content-Type'])
      assert_equal('Hello, World', response.body)
    })
  end

  def test_integration_api
    do_integration_test('/api', lambda {|response|
      assert_equal(201, response.code.to_i)
      assert_equal('application/json', response['Content-Type'])
      assert_equal('{"foo": 1}', response.body)
    })
  end

  def test_integration_404
    do_integration_test('/not-found', lambda {|response|
      assert_equal(404, response.code.to_i)
      assert_equal('text/plain', response['Content-Type'])
      assert_equal('Not Found', response.body)
    })
  end

  def do_integration_test(path, check_response)
    port = 8000
    server = WEBrick::HTTPServer.new(Port: port)
    server.mount '/', WebServer

    begin
      thread = Thread.new do
        server.start
      end
      uri = URI("http://localhost:#{port}#{path}")
      response = Net::HTTP.get_response(uri)
      check_response.call(response)
    ensure
      server.shutdown
      thread.join
    end
  end
end
