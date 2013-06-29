Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1387543604794608', 'b07f7b83bf465e673951085a9408500e'
end