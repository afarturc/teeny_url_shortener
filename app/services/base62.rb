# frozen_string_literal: true

# Encoding system using 62 characters
# This code was implemented based on the implementation of steventen
# https://github.com/steventen/base62-rb
module Base62
  KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  KEYS_HASH = KEYS.each_char.with_index.each_with_object({}) do |(k, v), h|
    h[k] = v
  end
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

  # Decodes base62 string to a base10 (decimal) number.
  def self.decode(str)
    num = 0
    i = 0
    len = str.length - 1
    while i < str.length
      pow = BASE**(len - i)
      num += KEYS_HASH[str[i]] * pow
      i += 1
    end
    num
  end
end
