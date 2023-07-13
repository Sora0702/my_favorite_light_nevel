FactoryBot.define do
  factory :book do
    title { "test_title" }
    author { "test_author" }
    isbn { 1234 }
    url { "https://www.google.com" }
    image_url { "https://1.bp.blogspot.com/-tVeC6En4e_E/X96mhDTzJNI/AAAAAAABdBo/jlD_jvZvMuk3qUcNjA_XORrA4w3lhPkdQCNcBGAsYHQ/s1048/onepiece01_luffy.png" }
  end
end
