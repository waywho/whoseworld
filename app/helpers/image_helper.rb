module ImageHelper
  def pinned_url_for(image)
    if image&.image&.attached?
      "https://ipfs.filebase.io/ipfs/#{image.cid}"
    end
  end
end
