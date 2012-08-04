# -*- coding: utf-8 -*-

# filter of gzip compress
class CompressFilter
  def filter(controller)
    controller.response['Content-Encoding'] = 'gzip'
    controller.response.body =
      ActiveSupport::Gzip.compress(controller.response.body)
  end
end
