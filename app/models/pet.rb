class Pet < ApplicationRecord
  belongs_to :customer
  has_many :bookings
  has_one_attached :pet_image
  attr_accessor :image

  enum gender: {オス: 1, メス:2}

  enum breed: {チワワ:1, ダックス:2, ヨークシャーテリア:3, パピヨン:4, ポメラニアン:5,
    マルチーズ:6, トイプードル:7, シー・ズー:8, キャバリア:9, Mシュナウザー:10, パグ:11,
    ビーグル:12, フレンチブルドッグ:13, 柴犬:14, コッカースパニエル:15, ボーダーコリー:16,
    その他:999}

    def parse_base64(image)
      if image.present? || rex_image(image) == ''
        content_type = create_extension(image)
        contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
        decoded_data = Base64.decode64(contents)
        filename = Time.zone.now.to_s + '.' + content_type
        File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
          f.write(decoded_data)
        end
      end
      attach_image(filename)
    end
  
    private
  
    def create_extension(image)
      content_type = rex_image(image)
      content_type[%r/\b(?!.*\/).*/]
    end
  
    def rex_image(image)
      image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
    end
  
    def attach_image(filename)
      book_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
      FileUtils.rm("#{Rails.root}/tmp/#{filename}")
    end

end
