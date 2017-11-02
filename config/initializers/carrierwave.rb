CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {                          # required
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJHFIJAKXM6SOQD3A ',            # required
    :aws_secret_access_key  => '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',     # required
    :region                 => 'us-east-2',                        # optional, defaults to 'us-east-1'
    :host                   => 's3-us-east-2.amazonaws.com'
  }
  config.fog_directory  = 'teenserv'               # required

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
end
