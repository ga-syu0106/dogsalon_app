class Pet < ApplicationRecord
  belongs_to :customer
  has_many :bookings, dependent: :destroy
  has_many_attached :images
  
  enum gender: {オス: 1, メス:2}

  enum breed: {チワワ:1, ダックス:2, ヨークシャーテリア:3, パピヨン:4, ポメラニアン:5,
    マルチーズ:6, トイプードル:7, シー・ズー:8, キャバリア:9, Mシュナウザー:10, パグ:11,
    ビーグル:12, フレンチブルドッグ:13, 柴犬:14, コッカースパニエル:15, ボーダーコリー:16,
    その他:999}


end
