if Rails.env.development?

  Dir.glob( File.expand_path("../../../app/{api}", __FILE__)+'/**/*.rb' ).each do |file|
    require file
  end
  # api_reloader = ActiveSupport::FileUpdateChecker.new(api_files) do
  #   Rails.application.reload_routes!
  # end
  # ActionDispatch::Callbacks.to_prepare do
  #   api_reloader.execute_if_updated
  # end
end