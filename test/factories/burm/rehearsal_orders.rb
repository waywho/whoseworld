FactoryBot.define do
  factory :burm_rehearsal_order, class: 'BURM::RehearsalOrder' do
    burm_musical { nil }
    burm_song { nil }
    block_group { 1 }
    order { 1 }
    start_at { "2025-03-23 13:58:52" }
    end_at { "2025-03-23 13:58:52" }
  end
end
