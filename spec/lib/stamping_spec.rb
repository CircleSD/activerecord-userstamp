require 'rails_helper'

RSpec.describe 'Stamping', type: :model do
  before(:each) do
    reset_to_defaults
    User.stamper = @zeus
    Person.stamper = @delynn
  end

  context 'when creating a Person' do
    context 'when the stamper is an object' do
      it 'sets the correct creator and updater' do
        expect(User.stamper).to eq(@zeus.id)

        person = Person.create(:name => "David")
        expect(person.creator_id).to eq(@zeus.id)
        expect(person.updater_id).to eq(@zeus.id)
        expect(person.creator).to eq(@zeus)
        expect(person.updater).to eq(@zeus)
      end
    end

    context 'when the stamper is an ID' do
      it 'sets the correct creator and updater' do
        User.stamper = @nicole.id
        expect(User.stamper).to eq(@nicole.id)

        person = Person.create(:name => "Daniel")
        expect(person.creator_id).to eq(@hera.id)
        expect(person.updater_id).to eq(@hera.id)
        expect(person.creator).to eq(@hera)
        expect(person.updater).to eq(@hera)
      end
    end
  end

  context 'when creating a Post' do
    context 'when the stamper is an object' do
      it 'sets the correct creator and updater' do
        expect(Person.stamper).to eq(@delynn.id)

        post = Post.create(:title => "Test Post - 1")
        expect(post.creator_id).to eq(@delynn.id)
        expect(post.updater_id).to eq(@delynn.id)
        expect(post.creator).to eq(@delynn)
        expect(post.updater).to eq(@delynn)
      end
    end

    context 'when the stamper is an ID' do
      it 'sets the correct creator and updater' do
        Person.stamper = @nicole.id
        expect(Person.stamper).to eq(@nicole.id)

        post = Post.create(:title => "Test Post - 2")
        expect(post.creator_id).to eq(@nicole.id)
        expect(post.updater_id).to eq(@nicole.id)
        expect(post.creator).to eq(@nicole)
        expect(post.updater).to eq(@nicole)
      end
    end
  end

  context 'when updating a Person' do
    context 'when the stamper is an object' do
      it 'sets the correct updater' do
        User.stamper = @hera
        expect(User.stamper).to eq(@hera.id)

        @delynn.name << " Berry"
        @delynn.save
        @delynn.reload
        expect(@delynn.creator).to eq(@zeus)
        expect(@delynn.updater).to eq(@hera)
        expect(@delynn.creator_id).to eq(@zeus.id)
        expect(@delynn.updater_id).to eq(@hera.id)
      end
    end
  end

  context 'when the stamper is an ID' do
    it 'sets the correct updater' do
      User.stamper = @hera.id
      expect(User.stamper).to eq(@hera.id)

      @delynn.name << " Berry"
      @delynn.save
      @delynn.reload
      expect(@delynn.creator_id).to eq(@zeus.id)
      expect(@delynn.updater_id).to eq(@hera.id)
      expect(@delynn.creator).to eq(@zeus)
      expect(@delynn.updater).to eq(@hera)
    end
  end

  context 'when updating a Post' do
    context 'when the stamper is an ID' do
      it 'sets the correct updater' do
        Person.stamper = @nicole.id
        expect(Person.stamper).to eq(@nicole.id)

        @first_post.title << " - Updated"
        @first_post.save
        @first_post.reload
        expect(@first_post.creator_id).to eq(@delynn.id)
        expect(@first_post.updater_id).to eq(@nicole.id)
        expect(@first_post.creator).to eq(@delynn)
        expect(@first_post.updater).to eq(@nicole)
      end
    end

    context 'when the stamper is an object' do
      it 'sets the correct updater' do
        Person.stamper = @nicole
        expect(Person.stamper).to eq(@nicole.id)

        @first_post.title << " - Updated"
        @first_post.save
        @first_post.reload
        expect(@first_post.creator_id).to eq(@delynn.id)
        expect(@first_post.updater_id).to eq(@nicole.id)
        expect(@first_post.creator).to eq(@delynn)
        expect(@first_post.updater).to eq(@nicole)
      end
    end
  end

  context 'when destroying a Post' do
    context 'when the stamper is an ID' do
      it 'sets the deleter' do
        expect(@first_post.deleted_at).to be_nil

        Person.stamper = @nicole.id
        expect(Person.stamper).to eq(@nicole.id)

        @first_post.destroy
        @first_post.save
        @first_post.reload

        expect(@first_post.deleted_at).to be_present
        expect(@first_post.deleter_id).to eq(@nicole.id)
      end
    end
  end

  context 'when no deleter column is present' do
    it 'does not create a deleter relation' do
      @comment = Comment.create
      expect(@comment.respond_to?('creator')).to eq(true)
      expect(@comment.respond_to?('updater')).to eq(true)
      expect(@comment.respond_to?('deleter')).to eq(false)
    end
  end

  context 'when a deleter column is present' do
    it 'creates a deleter relation' do
      expect(@first_post.respond_to?('creator')).to eq(true)
      expect(@first_post.respond_to?('updater')).to eq(true)
      expect(@first_post.respond_to?('deleter')).to eq(true)
    end
  end

  context 'when the deleter attribute is explicitly set' do
    it 'creates a deleter relation' do
      @foo = Foo.create
      expect(@foo.respond_to?('creator')).to eq(true)
      expect(@foo.respond_to?('updater')).to eq(true)
      expect(@foo.respond_to?('deleter')).to eq(true)
    end
  end
end