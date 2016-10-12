class RoutesReloader
  def initialize(app)
    @app = app
    @routes_reloader = build_routes_reloader
  end

  def call(env)
    @routes_reloader.execute_if_updated
    @app.call(env)
  end

  private

  def build_routes_reloader
    ActiveSupport::FileUpdateChecker.new([], "config/routes" => "rb") do
      Rails.application.reload_routes!
    end
  end
end
