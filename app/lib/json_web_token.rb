# app/lib/json_web_token.rb
class JsonWebToken
    SECRET_KEY = Rails.application.secret_key_base

    def self.encode(payload, exp = 15.minutes.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new(decoded)
    rescue JWT::ExpiredSignature
        raise 'Token has expired'
    rescue
        nil
    end

    def self.generate_refresh_token
        SecureRandom.hex(64)
    end
end
