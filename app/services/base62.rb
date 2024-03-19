# frozen_string_literal: true

# Encoding system using 62 characters
# This code was implemented based on the implementation of steventen
# https://github.com/steventen/base62-rb
module Base62
  KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  KEYS_HASH = KEYS.each_char.with_index.to_h
  BASE = KEYS.length

  # Encodes base10 (decimal) number to base62 string.
  def self.encode(num)
    return '0' if num.zero?
    return nil if num.negative?

    str = ''
    while num.positive?
      str = KEYS[num % BASE] + str
      num /= BASE
    end
    str
  end
end
