CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_provider = 'fog/aws'
      config.fog_credentials = {                          # required
        :provider               => 'AWS',
        :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],            # required
        :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],     # required
        :region                 => 'us-east-2',                        # optional, defaults to 'us-east-1'
        :host                   => 's3-us-east-2.amazonaws.com'
      }
      config.fog_directory  = ENV["AWS_BUCKET"]               # required
      config.storage = :fog
    end
  end
end
