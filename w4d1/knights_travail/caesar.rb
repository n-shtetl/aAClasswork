def caesar_cipher(str, shift)
  sent_arr = str.split
  alphabet = ('a'..'z').to_a
  sent_arr.each do |word|
    word.each_char.with_index |char, i|
      if alphabet.include
end