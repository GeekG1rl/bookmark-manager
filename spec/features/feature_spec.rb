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
    expect(link.tags.map(&:name)).to include 'education'
  end
end

feature 'filter by tags' do
  before(:each) do
    Link.create(title: "Google", url: "http://google.com/", tags: [Tag.first_or_create(name: 'education')])
    Link.create(title: "Gymbox", url: "http://gymbox.com/", tags: [Tag.first_or_create(name: 'gym')])
    Link.create(title: "Facebook", url: "http://facebook.com/", tags: [Tag.first_or_create(name: 'bubbles')])
  end

    scenario 'filter bubbles' do
      visit '/tags/bubbles'

      expect(page.status_code).to eq 200
      within 'ul#links' do 
      expect(page).not_to have_content('Google')
      expect(page).to_not have_content('Gymbox')
      expect(page).to have_content('Facebook')
      expect(page).to have_content('bubbles')
    end
  end
end





















