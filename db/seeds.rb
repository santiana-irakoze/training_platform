require 'faker'
require 'open-uri'

puts 'Cleaning database...'
Questions.destroy_all
Tests.destroy_all
Answers.destroy_all
Users.destroy_all

puts "creating test 1"
test = Test.create!(name: 'Test de Culture Générale')

# Questions pour test 1
question1 = test.questions.create!(content: 'Quelle est la capitale de la France ?', answer: 'Paris')
question1.choices.create!(content: 'Paris', correct: true)
question1.choices.create!(content: 'Londres')
question1.choices.create!(content: 'Berlin')
question1.choices.create!(content: 'Madrid')

question2 = test.questions.create!(content: 'Quel est le plus grand océan du monde ?', answer: 'Océan Pacifique')
question2.choices.create!(content: 'Océan Atlantique')
question2.choices.create!(content: 'Océan Indien')
question2.choices.create!(content: 'Océan Pacifique', correct: true)
question2.choices.create!(content: 'Mer Méditerranée')

question3 = test.questions.create!(content: 'Quelle est la formule chimique de l’eau ?', answer: 'H2O')
question3.choices.create!(content: 'H2O', correct: true)
question3.choices.create!(content: 'CO2')
question3.choices.create!(content: 'O2')
question3.choices.create!(content: 'H2SO4')

puts "creating test 2"
test2 = Test.create!(name: 'Test de Mathématiques')

# Créer des questions pour ce test
question4 = test2.questions.create!(content: 'Combien font 5 + 3 ?', answer: '8')
question4.choices.create!(content: '8', correct: true)
question4.choices.create!(content: '7')
question4.choices.create!(content: '9')
question4.choices.create!(content: '10')

question5 = test2.questions.create!(content: 'Quel est le carré de 4 ?', answer: '16')
question5.choices.create!(content: '16', correct: true)
question5.choices.create!(content: '14')
question5.choices.create!(content: '12')
question5.choices.create!(content: '18')
