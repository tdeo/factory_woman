require 'spec_helper'
require 'factory_woman/version'

describe FactoryWoman do
  it 'has a version number' do
    expect(FactoryWoman::VERSION).not_to be nil
  end

  it 'creates a dependency successfully' do
    FactoryWoman.create(:blog)
    expect(User.count).to eq 1
    expect(Blog.count).to eq 1
    expect(Blog.first.user_id).to eq User.first.id
  end

  it 'creates the dependency with a specific id if it\'s specified' do
    FactoryWoman.create(:blog, user_id: 12)
    expect(User.count).to eq 1
    expect(Blog.count).to eq 1
    expect(Blog.first.user_id).to eq 12
    expect(User.first.id).to eq 12
  end

  it 'works on several dependencies' do
    article = FactoryWoman.create(:article)
    expect(Article.count).to eq 1
    expect(Blog.count).to eq 1
    expect(User.count).to eq 2 # 1 author of the article, 1 owner of the blog
    expect(User.exists?(id: Blog.first.user_id)).to eq true
    expect(User.exists?(id: article.author_id)).to eq true
    expect(Article.first.blog_id).to eq Blog.first.id
  end

  it 'works if foreign key is passed as an alias' do
    user = FactoryWoman.create(:user)
    FactoryWoman.create(:blog, user_alias_id: user.id)
    expect(Blog.count).to eq 1
    expect(User.count).to eq 1
    expect(Blog.first.user_id).to eq user.id
  end
end
