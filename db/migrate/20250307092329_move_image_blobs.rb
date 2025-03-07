class MoveImageBlobs < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def up
    ActiveRecord::Base.transaction do
      Site.find_each do |site|
        %i[logo logo_for_dark logo_with_tag logo_with_tag_for_dark].each do |atta|
          if site.send(atta)&.attached?
            image = Image.find_or_create_by!(imageable: site, kind: atta.to_s)
            site.send("#{atta}_attachment").update!(record: image, name: "image")
          end
        end
      end

      BURM::Musical.find_each do |musical|
        if musical.image&.attached?
          image = Image.find_or_create_by!(imageable: musical, kind: "image")
          musical.image_attachment.update!(record: image)
        end
      end

      Page.find_each do |page|
        if page.feature_image&.attached?
          image = Image.find_or_create_by!(imageable: page, kind: "feature_image")
          page.feature_image_attachment.update!(record: image, name: "image")
        end
      end

      Gallery.find_each do |gallery|
        gallery.images_attachments.find_each do |image|
          new_image = Image.create!(imageable: gallery, kind: "image")
          image.update!(record: new_image, name: "image")
        end
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Image.find_each do |image|
        image.image_attachment.update!(record: image.imageable, name: image.kind)
        image.destroy!
      end
    end
  end
end
