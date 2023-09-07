# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"




puts "Cleaning up database..."
Organization.destroy_all
Event.destroy_all
Article.destroy_all
puts "Database cleaned"

file_resto = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688379265/resto_z5tci7.jpg")
resto_du_coeur = Organization.new(
  name: "Resto du coeur",
  category: "humanitaire",
  email: "resto@lewagon.fr",
  password: "password",
  address: "21 Rue Dabray, 06000 Nice",
  phone_number: "0493800367",
  description: "Leur but est 'd’aider et d’apporter une assistance bénévole aux personnes démunies, notamment dans le domaine alimentaire par l’accès à des repas gratuits, et par la participation à leur insertion sociale et économique, ainsi qu’à toute action contre la pauvreté sous toutes ses formes'."
)
resto_du_coeur.photo.attach(io: file_resto, filename: "resto.png", content_type: "image/png")
resto_du_coeur.save

file_collecte = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688638852/Banque-alimentaire_guayh8.jpg")
collecte = Event.new(
  address: "606, Bd du mercantour, 06200 Nice",
  title: "Collecte de denrées alimentaires",
  description: "Dans le cadre de la collecte de denrées alimentaire, RDV avec l’association des Restos du coeur le mercredi 12 juillet de 14h00-18h00 à Carrefour Lingostiére pour animer la récolte de produits de 1ère nécessité (alimentaire, hygiène etc...).",
  start_time: "2023-07-12",
  organization: resto_du_coeur
)
collecte.photo.attach(io: file_collecte, filename: "collecte.png", content_type: "image/png")
collecte.save

file_distribution = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688638852/distribution-alimentaire_pqrvyt.jpg")
distribution = Event.new(
  address: "21 Rue Dabray, 06000 Nice",
  title: "Distributions de denrées alimentaires",
  description: "Distribution de denrées alimentaires et hygiéniques pour des personnes dans le besoin, organisée par les Restos du Cœur dans ses locaux, le mercredi 12 juillet, de 17h à 19h",
  start_time: "2023-07-12",
  organization: resto_du_coeur
)
distribution.photo.attach(io: file_distribution, filename: "distribution.png", content_type: "image/png")
distribution.save

#############################################################

file_wwf = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688044356/development/cjbom2rc64up83k32mclsrj2si24.jpg")
wwf = Organization.new(
  name: "WWF",
  category: "ecologie",
  email: "wwf@lewagon.fr",
  password: "password",
  address: "35/37, rue Baudin, 93310 Le Pré-Saint-Gervais",
  phone_number: "0171864060",
  description: "Arrêter la dégradation de l'environnement dans le monde et construire un avenir où les êtres humains pourront vivre en harmonie avec la nature."
)
wwf.photo.attach(io: file_wwf, filename: "wwf.png", content_type: "image/png")
wwf.save

file_nettoyage = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688654633/plage_tybb4w.jpg")
nettoyage = Event.new(
  address: "13 Prom. des Anglais, 06000 Nice",
  title: "Nettoyage de la plage",
  description: "Dans le cadre d'Initiatives Océanes, RDV avec l’association Surfrider Foundation Europe le dimanche 2 juillet de 10h30-12h30 pour une action de nettoyage de la plage de la Promenade des Anglais.",
  start_time: "2023-09-09",
  organization: wwf
)
nettoyage.photo.attach(io: file_nettoyage, filename: "nettoyage.png", content_type: "image/png")
nettoyage.save

article1 = Article.create!(
  title: "Changement de date",
  content: "Chers participants, nous vous informons qu'en raison des prévisions météorologiques à venir, nous changeons la date de notre nettoyage de la plage.<br/> Celle-ci aura désormais lieu le 12 juillet au lieu du 5 juillet. Le lieu reste toutefois inchangé. N'oubliez pas les précautions expliquées dans notre premier article !<br/> Veuillez également vous munir d'eau en raison des fortes chaleurs, surtout si vous venez avec des enfants ou des personnes vulnérables.<br/> Nous vous remercions de votre compréhension et espérons vous voir le jour de la collecte !",
  event: nettoyage
)

article2 = Article.create!(
  title: "Précautions à prendre avant l'événement",
  content: "Chers participants, afin de passer un nettoyage de la plage en toute sécurité, nous vous conseillons de prendre quelques précautions :<br/> - Veuillez vous munir de chaussures fermées et de gants de nettoyage afin d'éviter tout contact avec des débris dangereux, tout comme des aiguilles ou des morceaux de verre coupants.<br/> - N'ouvrez jamais de contenants comme les bouteilles, jarres, boîtes, etc..., car les contenus peuvent être nocifs à votre santé.<br/> - Triez les déchets que vous trouverez sur place et ramenez-les aux endroits indiqués à cet effet par les organisateurs.<br/> Sur ce, bonne préparation et à bientôt !",
  event: nettoyage
)

file_plantation = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688654633/arbre_bncvk1.webp")
plantation = Event.new(
  address: "2680 Rte de la Revere, 06360 Èze",
  title: "Plantation d'arbres au Parc de la Grande Corniche",
  description: "Dans le cadre de la reforestation du Parc Naturel Départemental de la Grande Corniche, une plantation d'arbres est organisée le dimanche 10 juillet de 9h à 12h",
  start_time: "2023-07-10",
  organization: wwf
)
plantation.photo.attach(io: file_plantation, filename: "plantation.png", content_type: "image/png")
plantation.save

file_jardin = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688640226/36239-potager-urbain-ouvre-sur-toit-hotel-parisien-recolter-propres-produits-saison_goebws.png")
jardin = Event.new(
  address: "11 Voie Romaine, 06000 Nice",
  title: "Plantation de légumes au Jardin Potager de la Voie Romaine",
  description: "En coordination avec l'association Pasteur Avenir Jeunesse (P@JE), une plantation de légumes et d'aromates est organisée le 11 juillet de 9h à 17h",
  start_time: "2023-07-11",
  organization: wwf
)
jardin.photo.attach(io: file_jardin, filename: "jardin.png", content_type: "image/png")
jardin.save

file_conference = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688640225/confe%CC%81rence_bvfiat.jpg")
conference = Event.new(
  address: "25 avenue François Mitterrand, 06300 Nice",
  title: "Conférence sur les enjeux climatiques",
  description: "En partenariat avec l'Université Saint-Jean d'Angély et ses professeurs, une conférence autour des enjeux climatiques aura lieu le 13 juillet de 18h à 20h dans l'Amphithéâtre 1.",
  start_time: "2023-07-13",
  organization: wwf
)
conference.photo.attach(io: file_conference, filename: "conference.png", content_type: "image/png")
conference.save

file_croix = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688379258/croix-rouge-300x300_iqw8mf.jpg")
croix_rouge = Organization.new(
  name: "Croix rouge",
  category: "humanitaire",
  email: "croixrouge@lewagon.fr",
  password: "password",
  address: "65 Av. Alfred Borriglione, 06100 Nice",
  phone_number: "0489144336",
  description: "Bénévoles, salariés, mettez vos compétences au service d'une grande idée. Avec vos dons nous sauvons des vies et nous aidons les personnes démunies."
)
croix_rouge.photo.attach(io: file_croix, filename: "croix.png", content_type: "image/png")
croix_rouge.save

file_soutien = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688638852/soutien-psyco_lblhdf.jpg")
soutien = Event.new(
  address: "Av. de la Vaugine, 83300 Draguignan",
  title: "Soutien psychologique et isolement social",
  description: "Dépression, troubles affectifs, anxiété, burn-out ou idées noires sont autant de difficultés auxquelles nous sommes nombreux à faire face. Alors que 50 % des absences au travail sont liées à la santé mentale, 1 personne sur 5 souffre de troubles mentaux dans sa vie. Nous organisons un atelier de groupe afin de discuter de ces sujets, et ce sans tabou.",
  start_time: "2023-09-05",
  organization: croix_rouge
)
soutien.photo.attach(io: file_soutien, filename: "soutien.png", content_type: "image/png")
soutien.save

file_integration_sociale = URI.open("https://res.cloudinary.com/dilp6xqmb/image/upload/v1688638852/situation-precaire_cah4qx.webp")
integration_sociale = Event.new(
  address: "50 Rue Ferrere, 33000 Bordeaux",
  title: "Intégration sociale des personnes en situation de précarité",
  description: "Nous le constatons chaque jour dans nos délégations, le travail ne protège plus de la précarité. Aujourd’hui, viennent s’ajouter aux personnes sans-abri trois nouvelles catégories de bénéficiaires ayant recours aux aides sociales : les jeunes, les personnes âgées et les travailleurs pauvres.",
  start_time: "2023-11-25",
  organization: croix_rouge
)
integration_sociale.photo.attach(io: file_integration_sociale, filename: "integration_sociale.png", content_type: "image/png")
integration_sociale.save

puts "finish"
