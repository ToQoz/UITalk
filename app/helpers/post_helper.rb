module PostHelper
  def image_url_by_id(id)
    "/uploaded/#{id.to_s}.png"
  end
end
