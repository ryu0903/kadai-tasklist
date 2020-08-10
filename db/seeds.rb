(1..100).each do |number|
  Task.create(content: 'テスト' + number.to_s, status: 'テスト' + number.to_s)
end
