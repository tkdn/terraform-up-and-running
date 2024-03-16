require_relative './web-server'
require "test/unit"

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
end
