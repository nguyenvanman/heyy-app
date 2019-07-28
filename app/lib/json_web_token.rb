require 'jwt'

class JsonWebToken
    HMAC_SECRET = ENV['SECRET_KEY']
  
    def self.encode(payload, exp = 72.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, HMAC_SECRET)
    end
  
    def self.decode(token)
        body = JWT.decode(token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
        raise ExceptionHandler::ExpiredSignature, e.message
    end
end