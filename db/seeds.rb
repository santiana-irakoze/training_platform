puts "Cleaning database..."
# Delete in the correct order to handle foreign key constraints
Response.destroy_all
Question.destroy_all
Test.destroy_all
User.destroy_all

Questions = []

puts "Creating test 1"

test1 = Test.create!(Name: "Capitals of the world", status: "available", score: nil, duration: 2, date: nil, format: "Multiple Choice")

puts "Creating questions for test 1"

Questions << Question.create!(
  content: "What is the capital of France?",
  answer: "Paris",
  options: ["London", "Paris", "Rome"],
  test_id: test1.id
)

Questions << Question.create!(
  content: "What is the capital of Japan?",
  answer: "Tokyo",
  options: ["Seoul", "Beijing", "Tokyo"],
  test_id: test1.id
)

Questions << Question.create!(
  content: "What is the capital of Italy?",
  answer: "Rome",
  options: ["Milan", "Venice", "Rome"],
  test_id: test1.id
)

Questions << Question.create!(
  content: "What is the capital of Burundi?",
  answer: "Bujumbura",
  options: ["Bujumbura", "Kigali", "Kampala"],
  test_id: test1.id
)

Questions << Question.create!(
  content: "What is the capital of Germany?",
  answer: "Berlin",
  options: ["Munich", "Hamburg", "Berlin"],
  test_id: test1.id
)

puts "Creating test 2"

test2 = Test.create!(Name: "Maths game", status: "available", score: nil, duration: 1, date: nil, format: "Written")

puts "Creating questions for test 2"

Questions << Question.create!(
  content: "What is 2 + 2?",
  answer: "4",
  test_id: test2.id
)
Questions << Question.create!(
  content: "What is the square of 4?",
  answer: "16",
  test_id: test2.id
)

puts "Creating test 3"

test3 = Test.create!(Name: "Random Test", status: "available", score: nil, date: nil, format: "Written")

# Randomquestions from other tests
Questions.sample(3).each do |question|
  Question.create!(
    content: question.content,
    answer: question.answer,
    options: question.options,
    test_id: test3.id
  )
end

puts "Seeding completed successfully!"
