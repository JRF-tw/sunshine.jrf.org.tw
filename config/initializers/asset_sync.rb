AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.fog_directory = Setting.asset_sync.bucket
  config.fog_region = Setting.asset_sync.region
  config.aws_access_key_id = Setting.aws.access_key_id
  config.aws_secret_access_key = Setting.aws.secret_access_key
  # config.rackspace_username = Setting.asset_sync.rackspace_username
  # config.rackspace_api_key = Setting.asset_sync.rackspace_api_key
  # config.google_storage_access_key_id = Setting.asset_sync.google_storage_access_key_id
  # config.google_storage_secret_access_key = Setting.asset_sync.google_storage_secret_access_key
  
  # Don't delete files from the store
  config.existing_remote_files = "keep" # Existing pre-compiled assets on S3 will be kept
  # To delete existing remote files.
  #   config.existing_remote_files: "delete"
  # To ignore existing remote files and overwrite.
  #   config.existing_remote_files: "ignore"
  #
  # Automatically replace files with their equivalent gzip compressed version
  #   config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to 
  # upload instead of searching the assets directory.
  #   config.manifest = true
  #
  # Fail silently.  Useful for environments such as Heroku
  #   config.fail_silently = true
  #
  # For always upload files
  #   config.always_upload = ["application.css", "application.js"]
  # 
  # Ignored files. Useful if there are some files that are created dynamically on the server and you don't want to upload on deploy.
  #   config.ignored_files = []
  #
  # 
  config.enabled = true
  config.run_on_precompile = false
end