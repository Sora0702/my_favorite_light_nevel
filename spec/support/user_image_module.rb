module UserImageModule
  def user_image
    visit profile_edit_path
    attach_file "#{Rails.root}/spec/fixtures/files/test_image.jpg"
    click_on '更新する'
  end
end
