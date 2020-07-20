namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    spinner = TTY::Spinner.new(":spinner Creating data for the contact table ...", format: :bouncing_ball)
    spinner.auto_spin
    15.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 75.year.ago, to: 20.year.from_now)
      )
    end
    spinner.success('(successful)')
  end
end
