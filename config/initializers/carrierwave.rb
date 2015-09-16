# to see all options:
#    https://github.com/carrierwaveuploader/carrierwave/blob/master/lib/carrierwave/uploader/configuration.rb
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Setting.aws.access_key_id,
    aws_secret_access_key: Setting.aws.secret_access_key,
    region:                Setting.carrierwave.region,
    path_style:            true
  }
  config.fog_directory  = Setting.carrierwave.bucket
  config.asset_host     = lambda{ |file| "//#{Setting.carrierwave.host}" }
  config.fog_public     = true
  config.storage        = :fog
end
