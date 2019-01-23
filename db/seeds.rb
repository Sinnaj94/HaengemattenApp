# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.delete_all
Site.delete_all
Size.delete_all
User.delete_all
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

max = User.create(first_name: 'Max', last_name: 'Mustermann', email: 'max@mustermann.de', password: 'password', admin: true)
hank = User.create(first_name: 'Hank', last_name: 'Loose', email: 'hank@email.com', password: 'password', admin: false)
hakuna = User.create(first_name: 'Hakuna', last_name: 'Matata', email: 'ha@kuna.co.za', password: 'password', admin: false)
anna = User.create(first_name: 'Anna', last_name: 'Hatewe', email: 'anna@htw-berlin.de', password: 'password', admin: false)
sizes = Size.create(name: 'small', text: '2-3 m')
sizem = Size.create(name: 'medium', text: '4-5 m')
sizel = Size.create(name: 'large', text: '6+ m')
site1 = Site.create(name: 'Monbijoupark', description: 'ganz super chillig da', latitude: '52.523269', longitude: '13.395811', user_id: anna.id)
site2 = Site.create(name: 'Uni-Strand', description: 'mit Blick auf die Spree', latitude: '52.455040', longitude: '13.524629', user_id: anna.id)
site3 = Site.create(name: 'Autobahn', description: 'Mittelstreifen', latitude: '52.307034', longitude: '13.342271', user_id: max.id)
site4 = Site.create(name: 'Schöneweide', description: 'neben dem Penny', latitude: '52.459328', longitude: '13.536597', user_id: max.id)
site5 = Site.create(name: 'Garten', description: 'zuhause ist es am Schönsten', latitude: '52.491149', longitude: '13.580682', user_id: anna.id)
site6 = Site.create(name: 'Wuhlheide', description: 'im Sommer gibt es manchmal Live-Konzerte in der Kindl-Bühne gleich nebenan', latitude: '52.463587', longitude: '13.547146', user_id: max.id)
site7 = Site.create(name: 'unterm Fernsehturm', description: '', latitude: '52.519838', longitude: '13.408590', user_id: hank.id)
site8 = Site.create(name: 'Etosha 1', description: 'near Halali - good for spotting elephants', latitude: '-19.045351', longitude: '16.465364', user_id: hakuna.id)
site9 = Site.create(name: 'Tivoli', description: 'hier ist immer was los', latitude: '55.673833', longitude: '12.567627', user_id: hakuna.id)
site10 = Site.create(name: 'St. Lucia Beach', description: 'like Paradise', latitude: '-27.897552', longitude: '32.588765', user_id: hakuna.id)
site1.sizes << [sizem, sizel]
site2.sizes << [sizes]
site3.sizes << [sizes, sizem, sizel]
site4.sizes << [sizes, sizem]
site5.sizes << [sizes]
site6.sizes << [sizem, sizes, sizel]
site7.sizes << [sizes]
site8.sizes << [sizel]
site9.sizes << [sizem]
site10.sizes << [sizem, sizes, sizel]
site1.images.attach(io: File.open('lib/assets/images/1.jpg'), filename: '1.jpg', content_type: 'image/jpg')
site2.images.attach(io: File.open('lib/assets/images/2.jpg'), filename: '2.jpg', content_type: 'image/jpg')
site2.images.attach(io: File.open('lib/assets/images/2a.jpg'), filename: '2a.jpg', content_type: 'image/jpg')
site5.images.attach(io: File.open('lib/assets/images/5.png'), filename: '5.png', content_type: 'image/jpg')
site6.images.attach(io: File.open('lib/assets/images/6.jpg'), filename: '6.jpg', content_type: 'image/jpg')
site7.images.attach(io: File.open('lib/assets/images/7.jpg'), filename: '7.jpg', content_type: 'image/jpg')
site8.images.attach(io: File.open('lib/assets/images/8.jpg'), filename: '8.jpg', content_type: 'image/jpg')
site9.images.attach(io: File.open('lib/assets/images/9.jpg'), filename: '9.jpg', content_type: 'image/jpg')
site10.images.attach(io: File.open('lib/assets/images/10.jpg'), filename: '10.jpg', content_type: 'image/jpg')
site10.images.attach(io: File.open('lib/assets/images/10a.jpg'), filename: '10a.jpg', content_type: 'image/jpg')
site1.save(validate: false)
site2.save(validate: false)
site3.save(validate: false)
site4.save(validate: false)
site5.save(validate: false)
site6.save(validate: false)
site7.save(validate: false)
site8.save(validate: false)
site9.save(validate: false)
site10.save(validate: false)
Review.create(rating: 3, comment: 'schon okay ...', site_id: site1.id, user_id: max.id)
Review.create(rating: 4, comment: 'ganz zentral und trotzdem recht ruhig', site_id: site1.id, user_id: hank.id)
Review.create(rating: 5, comment: 'genial', site_id: site2.id, user_id: hank.id)
Review.create(rating: 4, comment: 'mit Mensa-Bar!', site_id: site2.id, user_id: max.id)
Review.create(rating: 2, comment: 'ziemlich sonnig und heiß', site_id: site2.id, user_id: anna.id)
Review.create(rating: 2, comment: 'Viel zu gefährlich! Wer nur auf so eine Idee kommt...', site_id: site2.id, user_id: anna.id)
Review.create(rating: 1, comment: 'Echt eklig da!', site_id: site4.id, user_id: anna.id)
Review.create(rating: 5, comment: 'Echt zu empfehlen.', site_id: site6.id, user_id: hank.id)
Review.create(rating: 4, comment: 'Coole Aussicht...', site_id: site7.id, user_id: hank.id)
Review.create(rating: 2, comment: 'Total überlaufen und voller Touris!', site_id: site7.id, user_id: max.id)
Review.create(rating: 4, comment: 'Great view!', site_id: site8.id, user_id: hakuna.id)
Review.create(rating: 3, comment: 'Too hot, but many animals to spot.', site_id: site8.id, user_id: hank.id)
Review.create(rating: 3, comment: 'Nice, but much too expensive.', site_id: site9.id, user_id: hakuna.id)
Review.create(rating: 5, comment: '', site_id: site10.id, user_id: hakuna.id)
Review.create(rating: 5, comment: 'Atemberaubend schön!', site_id: site10.id, user_id: anna.id)
Review.create(rating: 5, comment: '5 Sterne!', site_id: site10.id, user_id: hank.id)