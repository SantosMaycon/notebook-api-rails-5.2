namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
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
  end

  private
  def show_spinner(msg)
    spinner = TTY::Spinner.new(":spinner #{msg}", format: :bouncing_ball)
    spinner.auto_spin
    yield
    spinner.success('(successful)')
  end
end
