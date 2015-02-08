Paperclip.options[:content_type_mapping] = {
    wotreplay: 'application/octet-stream'
}

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
