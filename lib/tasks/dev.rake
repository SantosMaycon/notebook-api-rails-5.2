namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    show_spinner('Reset the DB ...') do
      %x(rails db:drop:_unsafe db:create db:migrate)
    end    

    show_spinner('Creating data for the kind of contact ...') do
     Kind.create!([{description: 'Família'},{description: 'Comercial'},{description: 'Conhecido'}]) 
    end

    show_spinner('Creating data for the contact table ...') do
      15.times do
        Contact.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          birthdate: Faker::Date.between(from: 75.year.ago, to: 20.year.ago),
          kind: Kind.all.sample
          )
      end
    end

    show_spinner('Creating random number for the association a contact ...') do
      Contact.all.each do |contact|
        Random.rand(3).times do
          contact.phones << Phone.create!(number: Faker::PhoneNumber.cell_phone)
        end
        contact.save!
      end
    end

    show_spinner('Creating random address for contatct ...') do
      Contact.all.each do |contact|
        address = Faker::Address.full_address.split(',')
        Address.create!(street: address[0], city: address[1], contact: contact)
      end
    end
  end

  private
  def show_spinner(msg)
    spinner = TTY::Spinner.new(":spinner #{msg}", format: :bouncing_ball)
    spinner.auto_spin
    yield
    spinner.success('(successful)')
  end
end
