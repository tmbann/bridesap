class PurePose < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_one_attached :pure_pose_image
  attr_accessor :image

  def parse_base64(image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      contents = image.sub(%r/data:image\/.{3,},/, '')
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
    end
    attach_image(filename)
  end

  def pure_pose_image_url
    pure_pose_image.attached? ? url_for(pure_pose_image) : nil
  end

  private

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})/]
  end

  def attach_image(filename)
    pure_pose_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
