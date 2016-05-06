require 'tilt/erb'

feature 'links on web page' do
  scenario 'check if link is bookmarked' do
    Link.create(title: "Gymbox", url: "http://gymbox.com/")
    visit ('/links')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content "Gymbox"
    end
  end
end

feature 'create new links' do
  scenario 'create new links' do
    visit '/links/new'
    fill_in "title", with: "Makers"
    fill_in "url", with: "http://www.makersacademy.com/"
    click_button 'submit'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content 'Makers'
    end
  end
end

feature 'add single tag to a link' do
  scenario 'add tag' do
    visit '/links/new'
    fill_in "title", with: "Makers"
    fill_in "url", with: "http://www.makersacademy.com/"
    fill_in "tags", with: "education"
    click_button 'submit'
    link = Link.first
    p link
    expect(link.tags.map(&:name)).to include 'education'
  end
end




