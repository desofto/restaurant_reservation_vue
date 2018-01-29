# frozen_string_literal: true

module API
  module Auth
    extend ActiveSupport::Concern

    included do
      helpers do
        AUTHENTICITY_TOKEN_LENGTH = 32

        def session
          env['rack.session']
        end

        def verified_request?
          !protect_against_forgery? || request.head? ||
            valid_authenticity_token?(session, request.headers['X-Csrf-Token']) ||
            valid_authenticity_token?(session, request.headers['X-CSRF-Token'])
        end

        def protect_against_forgery?
          allow_forgery_protection = Rails.configuration.action_controller.allow_forgery_protection
          allow_forgery_protection.nil? || allow_forgery_protection
        end

        def valid_authenticity_token?(session, encoded_masked_token)
          if encoded_masked_token.nil? || encoded_masked_token.empty? || !encoded_masked_token.is_a?(String)
            return false
          end

          begin
            masked_token = Base64.strict_decode64(encoded_masked_token)
          rescue ArgumentError # encoded_masked_token is invalid Base64
            return false
          end

          # See if it's actually a masked token or not. In order to
          # deploy this code, we should be able to handle any unmasked
          # tokens that we've issued without error.

          if masked_token.length == AUTHENTICITY_TOKEN_LENGTH
            # This is actually an unmasked token. This is expected if
            # you have just upgraded to masked tokens, but should stop
            # happening shortly after installing this gem
            compare_with_real_token masked_token, session

          elsif masked_token.length == AUTHENTICITY_TOKEN_LENGTH * 2
            # Split the token into the one-time pad and the encrypted
            # value and decrypt it
            one_time_pad = masked_token[0...AUTHENTICITY_TOKEN_LENGTH]
            encrypted_csrf_token = masked_token[AUTHENTICITY_TOKEN_LENGTH..-1]
            csrf_token = xor_byte_strings(one_time_pad, encrypted_csrf_token)

            compare_with_real_token csrf_token, session

          else
            false # Token is malformed
          end
        end

        def compare_with_real_token(token, session)
          ActiveSupport::SecurityUtils.secure_compare(token, real_csrf_token(session))
        end

        def real_csrf_token(session)
          session[:_csrf_token] ||= SecureRandom.base64(AUTHENTICITY_TOKEN_LENGTH)
          Base64.strict_decode64(session[:_csrf_token])
        end

        def xor_byte_strings(s1, s2)
          s2_bytes = s2.bytes
          s1.each_byte.with_index { |c1, i| s2_bytes[i] ^= c1 }
          s2_bytes.pack('C*')
        end
      end
    end
  end
end
